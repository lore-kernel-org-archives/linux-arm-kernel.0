From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 28 Jun 2017 20:43:10 -0500
Subject: [PATCH] perf tools: Add ARM Statistical Profiling Extensions (SPE)
 support
In-Reply-To: <20170628201638.01204c14719514217433e82d@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
 <20170628201638.01204c14719514217433e82d@arm.com>
Message-ID: <20170628204310.b45fd92458a2fba810a7520b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'perf record' and 'perf report --dump-raw-trace' supported in this
release.

Example usage:

taskset -c 2 ./perf record -C 2 -c 1024 -e arm_spe_0/ts_enable=1,pa_enable=1/ \
		dd if=/dev/zero of=/dev/null count=10000

perf report --dump-raw-trace

Note that the perf.data file is portable, so the report can be run on another
architecture host if necessary.

Output will contain raw SPE data and its textual representation, such as:

0xc7d0 [0x30]: PERF_RECORD_AUXTRACE size: 0x82f70  offset: 0  ref: 0x1e947e88189  idx: 0  tid: -1  cpu: 2
.
. ... ARM SPE data: size 536432 bytes
.  00000000:  4a 01                                           B COND
.  00000002:  b1 00 00 00 00 00 00 00 80                      TGT 0 el0 ns=1
.  0000000b:  42 42                                           RETIRED NOT-TAKEN
.  0000000d:  b0 20 41 c0 ad ff ff 00 80                      PC ffffadc04120 el0 ns=1
.  00000016:  98 00 00                                        LAT 0 TOT
.  00000019:  71 80 3e f7 46 e9 01 00 00                      TS 2101429616256
.  00000022:  49 01                                           ST
.  00000024:  b2 50 bd ba 73 00 80 ff ff                      VA ffff800073babd50
.  0000002d:  b3 50 bd ba f3 00 00 00 80                      PA f3babd50 ns=1
.  00000036:  9a 00 00                                        LAT 0 XLAT
.  00000039:  42 16                                           RETIRED L1D-ACCESS TLB-ACCESS
.  0000003b:  b0 8c b4 1e 08 00 00 ff ff                      PC ff0000081eb48c el3 ns=1
.  00000044:  98 00 00                                        LAT 0 TOT
.  00000047:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
.  00000050:  48 00                                           INSN-OTHER
.  00000052:  42 02                                           RETIRED
.  00000054:  b0 58 54 1f 08 00 00 ff ff                      PC ff0000081f5458 el3 ns=1
.  0000005d:  98 00 00                                        LAT 0 TOT
.  00000060:  71 cc 44 f7 46 e9 01 00 00                      TS 2101429617868
...

Other release notes:

- applies to acme's perf/{core,urgent} branches, likely elsewhere

- Record requires Will's SPE driver, currently undergoing upstream review

- the intel-bts implementation was used as a starting point; its
  min/default/max buffer sizes and power of 2 pages granularity need to be
  revisited for ARM SPE

- not been tested on platforms with multiple SPE clusters/domains

- snapshot support (record -S), and conversion to native perf events
  (e.g., via 'perf inject --itrace'), are still in development

- technically both cs-etm and spe can be used simultaneously, however
  disabled for simplicity in this release

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c   |  20 +-
 tools/perf/arch/arm/util/pmu.c        |   3 +
 tools/perf/arch/arm64/util/Build      |   3 +-
 tools/perf/arch/arm64/util/arm-spe.c  | 210 ++++++++++++++++
 tools/perf/util/Build                 |   2 +
 tools/perf/util/arm-spe-pkt-decoder.c | 448 ++++++++++++++++++++++++++++++++++
 tools/perf/util/arm-spe-pkt-decoder.h |  52 ++++
 tools/perf/util/arm-spe.c             | 318 ++++++++++++++++++++++++
 tools/perf/util/arm-spe.h             |  39 +++
 tools/perf/util/auxtrace.c            |   3 +
 tools/perf/util/auxtrace.h            |   1 +
 11 files changed, 1095 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/arm-spe.c
 create mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
 create mode 100644 tools/perf/util/arm-spe-pkt-decoder.h
 create mode 100644 tools/perf/util/arm-spe.c
 create mode 100644 tools/perf/util/arm-spe.h

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 8edf2cb71564..ec071609e8ac 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -22,29 +22,43 @@
 #include "../../util/evlist.h"
 #include "../../util/pmu.h"
 #include "cs-etm.h"
+#include "arm-spe.h"
 
 struct auxtrace_record
 *auxtrace_record__init(struct perf_evlist *evlist, int *err)
 {
-	struct perf_pmu	*cs_etm_pmu;
+	struct perf_pmu	*cs_etm_pmu, *arm_spe_pmu;
 	struct perf_evsel *evsel;
-	bool found_etm = false;
+	bool found_etm = false, found_spe = false;
 
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
+	arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
 
 	if (evlist) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (cs_etm_pmu &&
 			    evsel->attr.type == cs_etm_pmu->type)
 				found_etm = true;
+			if (arm_spe_pmu &&
+			    evsel->attr.type == arm_spe_pmu->type)
+				found_spe = true;
 		}
 	}
 
+	if (found_etm && found_spe) {
+		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
 	if (found_etm)
 		return cs_etm_record_init(err);
 
+	if (found_spe)
+		return arm_spe_recording_init(err);
+
 	/*
-	 * Clear 'err' even if we haven't found a cs_etm event - that way perf
+	 * Clear 'err' even if we haven't found an event - that way perf
 	 * record can still be used even if tracers aren't present.  The NULL
 	 * return value will take care of telling the infrastructure HW tracing
 	 * isn't available.
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 98d67399a0d6..71fb8f13b40a 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -20,6 +20,7 @@
 #include <linux/perf_event.h>
 
 #include "cs-etm.h"
+#include "arm-spe.h"
 #include "../../util/pmu.h"
 
 struct perf_event_attr
@@ -31,6 +32,8 @@ struct perf_event_attr
 		pmu->selectable = true;
 		pmu->set_drv_config = cs_etm_set_drv_config;
 	}
+	if (!strcmp(pmu->name, ARM_SPE_PMU_NAME))
+		pmu->selectable = true;
 #endif
 	return NULL;
 }
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index cef6fb38d17e..f9969bb88ccb 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -3,4 +3,5 @@ libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 
 libperf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
-			      ../../arm/util/cs-etm.o
+			      ../../arm/util/cs-etm.o \
+			      arm-spe.o
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
new file mode 100644
index 000000000000..07172764881c
--- /dev/null
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -0,0 +1,210 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
+#include "../../util/pmu.h"
+#include "../../util/debug.h"
+#include "../../util/tsc.h"
+#include "../../util/auxtrace.h"
+#include "../../util/arm-spe.h"
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+#define KiB_MASK(x) (KiB(x) - 1)
+#define MiB_MASK(x) (MiB(x) - 1)
+
+struct arm_spe_recording {
+	struct auxtrace_record		itr;
+	struct perf_pmu			*arm_spe_pmu;
+	struct perf_evlist		*evlist;
+};
+
+static size_t
+arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	return ARM_SPE_AUXTRACE_PRIV_SIZE;
+}
+
+static int arm_spe_info_fill(struct auxtrace_record *itr,
+			       struct perf_session *session,
+			       struct auxtrace_info_event *auxtrace_info,
+			       size_t priv_size)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+
+	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
+	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+
+	return 0;
+}
+
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				       struct perf_evlist *evlist,
+				       struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
+	const struct cpu_map *cpus = evlist->cpus;
+	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	struct perf_evsel *tracking_evsel;
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->attr.type == arm_spe_pmu->type) {
+			if (arm_spe_evsel) {
+				pr_err("There may be only one " ARM_SPE_PMU_NAME " event\n");
+				return -EINVAL;
+			}
+			evsel->attr.freq = 0;
+			evsel->attr.sample_period = 1;
+			arm_spe_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	/* We are in full trace mode but '-m,xyz' wasn't specified */
+	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(4) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	}
+
+	/* Validate auxtrace_mmap_pages */
+	if (opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
+		size_t min_sz = KiB(8);
+
+		if (sz < min_sz || !is_power_of_2(sz)) {
+			pr_err("Invalid mmap size for ARM SPE: must be@least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	perf_evlist__to_front(evlist, arm_spe_evsel);
+
+	/*
+	 * In the case of per-cpu mmaps, we need the CPU on the
+	 * AUX event.
+	 */
+	if (!cpu_map__empty(cpus))
+		perf_evsel__set_sample_bit(arm_spe_evsel, CPU);
+
+	/* Add dummy event to keep tracking */
+	err = parse_events(evlist, "dummy:u", NULL);
+	if (err)
+		return err;
+
+	tracking_evsel = perf_evlist__last(evlist);
+	perf_evlist__set_tracking_event(evlist, tracking_evsel);
+
+	tracking_evsel->attr.freq = 0;
+	tracking_evsel->attr.sample_period = 1;
+
+	/* In per-cpu case, always need the time of mmap events etc */
+	if (!cpu_map__empty(cpus))
+		perf_evsel__set_sample_bit(tracking_evsel, TIME);
+
+	return 0;
+}
+
+static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	u64 ts;
+
+	asm volatile ("isb; mrs %0, cntvct_el0" : "=r" (ts));
+
+	return ts;
+}
+
+static void arm_spe_recording_free(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+
+       free(sper);
+}
+
+static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(sper->evlist, evsel) {
+		if (evsel->attr.type == sper->arm_spe_pmu->type)
+			return perf_evlist__enable_event_idx(sper->evlist,
+							     evsel, idx);
+	}
+	return -EINVAL;
+}
+
+struct auxtrace_record *arm_spe_recording_init(int *err)
+{
+	struct perf_pmu *arm_spe_pmu = perf_pmu__find(ARM_SPE_PMU_NAME);
+	struct arm_spe_recording *sper;
+
+	if (!arm_spe_pmu)
+		return NULL;
+
+	sper = zalloc(sizeof(struct arm_spe_recording));
+	if (!sper) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->itr.recording_options = arm_spe_recording_options;
+	sper->itr.info_priv_size = arm_spe_info_priv_size;
+	sper->itr.info_fill = arm_spe_info_fill;
+	sper->itr.free = arm_spe_recording_free;
+	sper->itr.reference = arm_spe_reference;
+	sper->itr.read_finish = arm_spe_read_finish;
+	sper->itr.alignment = 0;
+	return &sper->itr;
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79dea95a7f68..4ed31e88b8ee 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -82,6 +82,8 @@ libperf-$(CONFIG_AUXTRACE) += auxtrace.o
 libperf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
+libperf-$(CONFIG_AUXTRACE) += arm-spe.o
+libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
 libperf-y += parse-branch-options.o
 libperf-y += dump-insn.o
 libperf-y += parse-regs-options.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-pkt-decoder.c
new file mode 100644
index 000000000000..ca3813d5b91a
--- /dev/null
+++ b/tools/perf/util/arm-spe-pkt-decoder.c
@@ -0,0 +1,448 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+
+#include "arm-spe-pkt-decoder.h"
+
+#define BIT(n)		(1 << (n))
+
+#define BIT61		((uint64_t)1 << 61)
+#define BIT62		((uint64_t)1 << 62)
+#define BIT63		((uint64_t)1 << 63)
+
+#define NS_FLAG		BIT63
+#define EL_FLAG		(BIT62 | BIT61)
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define le16_to_cpu bswap_16
+#define le32_to_cpu bswap_32
+#define le64_to_cpu bswap_64
+#define memcpy_le64(d, s, n) do { \
+	memcpy((d), (s), (n));    \
+	*(d) = le64_to_cpu(*(d)); \
+} while (0)
+#else
+#define le16_to_cpu
+#define le32_to_cpu
+#define le64_to_cpu
+#define memcpy_le64 memcpy
+#endif
+
+static const char * const arm_spe_packet_name[] = {
+	[ARM_SPE_PAD]		= "PAD",
+	[ARM_SPE_END]		= "END",
+	[ARM_SPE_TIMESTAMP]	= "TS",
+	[ARM_SPE_ADDRESS]	= "ADDR",
+	[ARM_SPE_COUNTER]	= "LAT",
+	[ARM_SPE_CONTEXT]	= "CONTEXT",
+	[ARM_SPE_INSN_TYPE]	= "INSN-TYPE",
+	[ARM_SPE_EVENTS]	= "EVENTS",
+	[ARM_SPE_DATA_SOURCE]	= "DATA-SOURCE",
+};
+
+const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
+{
+	return arm_spe_packet_name[type];
+}
+
+/* return ARM SPE payload size from its encoding:
+ * 00 : byte
+ * 01 : halfword (2)
+ * 10 : word (4)
+ * 11 : doubleword (8)
+ */
+static int payloadlen(unsigned char byte)
+{
+	return 1 << ((byte & 0x30) >> 4);
+}
+
+static int arm_spe_get_pad(struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_PAD;
+	return 1;
+}
+
+static int arm_spe_get_alignment(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	unsigned int alignment = 1 << ((buf[0] & 0xf) + 1);
+
+	if (len < alignment)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_PAD;
+	return alignment - (((uint64_t)buf) & (alignment - 1));
+}
+
+static int arm_spe_get_end(struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_END;
+	return 1;
+}
+
+static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	if (len < 8)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_TIMESTAMP;
+	memcpy_le64(&packet->payload, buf + 1, 8);
+
+	return 1 + 8;
+}
+
+static int arm_spe_get_events(const unsigned char *buf, size_t len,
+			      struct arm_spe_pkt *packet)
+{
+	unsigned int events_len = payloadlen(buf[0]);
+
+	if (len < events_len)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_EVENTS;
+	packet->index = events_len;
+	switch (events_len) {
+	case 1: packet->payload = *(uint8_t *)(buf + 1); break;
+	case 2: packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1)); break;
+	case 4: packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1)); break;
+	case 8: packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1)); break;
+	default: return ARM_SPE_BAD_PACKET;
+	}
+
+	return 1 + events_len;
+}
+
+static int arm_spe_get_data_source(const unsigned char *buf,
+				   struct arm_spe_pkt *packet)
+{
+	int len = payloadlen(buf[0]);
+
+	packet->type = ARM_SPE_DATA_SOURCE;
+	if (len == 1)
+		packet->payload = buf[1];
+	else if (len == 2)
+		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
+
+	return 1 + len;
+}
+
+static int arm_spe_get_context(const unsigned char *buf, size_t len,
+			       struct arm_spe_pkt *packet)
+{
+	if (len < 4)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_CONTEXT;
+	packet->index = buf[0] & 0x3;
+	packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1));
+
+	return 1 + 4;
+}
+
+static int arm_spe_get_insn_type(const unsigned char *buf,
+				 struct arm_spe_pkt *packet)
+{
+	packet->type = ARM_SPE_INSN_TYPE;
+	packet->index = buf[0] & 0x3;
+	packet->payload = buf[1];
+
+	return 1 + 1;
+}
+
+static int arm_spe_get_counter(const unsigned char *buf, size_t len,
+			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
+{
+	if (len < 2)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_COUNTER;
+	if (ext_hdr)
+		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+	else
+		packet->index = buf[0] & 0x7;
+
+	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
+
+	return 1 + ext_hdr + 2;
+}
+
+static int arm_spe_get_addr(const unsigned char *buf, size_t len,
+			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
+{
+	if (len < 8)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	packet->type = ARM_SPE_ADDRESS;
+	if (ext_hdr)
+		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+	else
+		packet->index = buf[0] & 0x7;
+
+	memcpy_le64(&packet->payload, buf + 1, 8);
+
+	return 1 + ext_hdr + 8;
+}
+
+static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
+				 struct arm_spe_pkt *packet)
+{
+	unsigned int byte;
+
+	memset(packet, 0, sizeof(struct arm_spe_pkt));
+
+	if (!len)
+		return ARM_SPE_NEED_MORE_BYTES;
+
+	byte = buf[0];
+	if (byte == 0)
+		return arm_spe_get_pad(packet);
+	else if (byte == 1) /* no timestamp at end of record */
+		return arm_spe_get_end(packet);
+	else if (byte & 0xc0 /* 0y11000000 */) {
+		if (byte & 0x80) {
+			/* 0x38 is 0y00111000 */
+			if ((byte & 0x38) == 0x30) /* address packet (short) */
+				return arm_spe_get_addr(buf, len, 0, packet);
+			if ((byte & 0x38) == 0x18) /* counter packet (short) */
+				return arm_spe_get_counter(buf, len, 0, packet);
+		} else
+			if (byte == 0x71)
+				return arm_spe_get_timestamp(buf, len, packet);
+			else if ((byte & 0xf) == 0x2)
+				return arm_spe_get_events(buf, len, packet);
+			else if ((byte & 0xf) == 0x3)
+				return arm_spe_get_data_source(buf, packet);
+			else if ((byte & 0x3c) == 0x24)
+				return arm_spe_get_context(buf, len, packet);
+			else if ((byte & 0x3c) == 0x8)
+				return arm_spe_get_insn_type(buf, packet);
+	} else if ((byte & 0xe0) == 0x20 /* 0y00100000 */) {
+		/* 16-bit header */
+		byte = buf[1];
+		if (byte == 0)
+			return arm_spe_get_alignment(buf, len, packet);
+		else if ((byte & 0xf8) == 0xb0)
+			return arm_spe_get_addr(buf, len, 1, packet);
+		else if ((byte & 0xf8) == 0x98)
+			return arm_spe_get_counter(buf, len, 1, packet);
+	}
+
+	return ARM_SPE_BAD_PACKET;
+}
+
+int arm_spe_get_packet(const unsigned char *buf, size_t len,
+		       struct arm_spe_pkt *packet)
+{
+	int ret;
+
+	ret = arm_spe_do_get_packet(buf, len, packet);
+	if (ret > 0) {
+		while (ret < 1 && len > (size_t)ret && !buf[ret])
+			ret += 1;
+	}
+	return ret;
+}
+
+int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
+		     size_t buf_len)
+{
+	int ret, ns, el, index = packet->index;
+	unsigned long long payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+
+	switch (packet->type) {
+	case ARM_SPE_BAD:
+	case ARM_SPE_PAD:
+	case ARM_SPE_END:
+		return snprintf(buf, buf_len, "%s", name);
+	case ARM_SPE_EVENTS: {
+		size_t blen = buf_len;
+
+		ret = 0;
+		if (payload & 0x1) {
+			ret = snprintf(buf, buf_len, "EXCEPTION-GEN ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x2) {
+			ret = snprintf(buf, buf_len, "RETIRED ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x4) {
+			ret = snprintf(buf, buf_len, "L1D-ACCESS ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x8) {
+			ret = snprintf(buf, buf_len, "L1D-REFILL ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x10) {
+			ret = snprintf(buf, buf_len, "TLB-ACCESS ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x20) {
+			ret = snprintf(buf, buf_len, "TLB-REFILL ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x40) {
+			ret = snprintf(buf, buf_len, "NOT-TAKEN ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (payload & 0x80) {
+			ret = snprintf(buf, buf_len, "MISPRED ");
+			buf += ret;
+			blen -= ret;
+		}
+		if (index > 1) {
+			if (payload & 0x100) {
+				ret = snprintf(buf, buf_len, "LLC-ACCESS ");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x200) {
+				ret = snprintf(buf, buf_len, "LLC-REFILL ");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x400) {
+				ret = snprintf(buf, buf_len, "REMOTE-ACCESS ");
+				buf += ret;
+				blen -= ret;
+			}
+		}
+		if (ret < 0)
+			return ret;
+		blen -= ret;
+		return buf_len - blen;
+	}
+	case ARM_SPE_INSN_TYPE:
+		switch (index) {
+		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
+					"COND-SELECT" : "INSN-OTHER");
+		case 1:	{
+			size_t blen = buf_len;
+
+			if (payload & 0x1)
+				ret = snprintf(buf, buf_len, "ST");
+			else
+				ret = snprintf(buf, buf_len, "LD");
+			buf += ret;
+			blen -= ret;
+			if (payload & 0x2) {
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " AT");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x8) {
+					ret = snprintf(buf, buf_len, " EXCL");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x10) {
+					ret = snprintf(buf, buf_len, " AR");
+					buf += ret;
+					blen -= ret;
+				}
+			} else if (payload & 0x4) {
+				ret = snprintf(buf, buf_len, " SIMD-FP");
+				buf += ret;
+				blen -= ret;
+			}
+			if (ret < 0)
+				return ret;
+			blen -= ret;
+			return buf_len - blen;
+		}
+		case 2:	{
+			size_t blen = buf_len;
+
+			ret = snprintf(buf, buf_len, "B");
+			buf += ret;
+			blen -= ret;
+			if (payload & 0x1) {
+				ret = snprintf(buf, buf_len, " COND");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x2) {
+				ret = snprintf(buf, buf_len, " IND");
+				buf += ret;
+				blen -= ret;
+			}
+			if (ret < 0)
+				return ret;
+			blen -= ret;
+			return buf_len - blen;
+			}
+		default: return 0;
+		}
+	case ARM_SPE_DATA_SOURCE:
+	case ARM_SPE_TIMESTAMP:
+		return snprintf(buf, buf_len, "%s %lld", name, payload);
+	case ARM_SPE_ADDRESS:
+		switch (index) {
+		case 0:
+		case 1: ns = !!(packet->payload & NS_FLAG);
+			el = (packet->payload & EL_FLAG) >> 61;
+			payload &= ~(0xffULL << 56);
+			return snprintf(buf, buf_len, "%s %llx el%d ns=%d",
+				        (index == 1) ? "TGT" : "PC", payload, el, ns);
+		case 2:	return snprintf(buf, buf_len, "VA %llx", payload);
+		case 3:	ns = !!(packet->payload & NS_FLAG);
+			payload &= ~(0xffULL << 56);
+			return snprintf(buf, buf_len, "PA %llx ns=%d",
+					payload, ns);
+		default: return 0;
+		}
+	case ARM_SPE_CONTEXT:
+		return snprintf(buf, buf_len, "%s %lx el%d", name,
+				(unsigned long)payload, index + 1);
+	case ARM_SPE_COUNTER: {
+		size_t blen = buf_len;
+
+		ret = snprintf(buf, buf_len, "%s %d ", name,
+			       (unsigned short)payload);
+		buf += ret;
+		blen -= ret;
+		switch (index) {
+		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
+		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
+		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
+		default: ret = 0;
+		}
+		if (ret < 0)
+			return ret;
+		blen -= ret;
+		return buf_len - blen;
+	}
+	default:
+		break;
+	}
+
+	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
+			name, payload, packet->index);
+}
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-pkt-decoder.h
new file mode 100644
index 000000000000..793552d8696e
--- /dev/null
+++ b/tools/perf/util/arm-spe-pkt-decoder.h
@@ -0,0 +1,52 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
+#define INCLUDE__ARM_SPE_PKT_DECODER_H__
+
+#include <stddef.h>
+#include <stdint.h>
+
+#define ARM_SPE_PKT_DESC_MAX		256
+
+#define ARM_SPE_NEED_MORE_BYTES		-1
+#define ARM_SPE_BAD_PACKET		-2
+
+enum arm_spe_pkt_type {
+	ARM_SPE_BAD,
+	ARM_SPE_PAD,
+	ARM_SPE_END,
+	ARM_SPE_TIMESTAMP,
+	ARM_SPE_ADDRESS,
+	ARM_SPE_COUNTER,
+	ARM_SPE_CONTEXT,
+	ARM_SPE_INSN_TYPE,
+	ARM_SPE_EVENTS,
+	ARM_SPE_DATA_SOURCE,
+};
+
+struct arm_spe_pkt {
+	enum arm_spe_pkt_type	type;
+	unsigned char		index;
+	uint64_t		payload;
+};
+
+const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
+
+int arm_spe_get_packet(const unsigned char *buf, size_t len,
+			struct arm_spe_pkt *packet);
+
+int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
+#endif
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
new file mode 100644
index 000000000000..f3eccd73b54a
--- /dev/null
+++ b/tools/perf/util/arm-spe.c
@@ -0,0 +1,318 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <endian.h>
+#include <errno.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "cpumap.h"
+#include "color.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "session.h"
+#include "util.h"
+#include "thread.h"
+#include "debug.h"
+#include "auxtrace.h"
+#include "arm-spe.h"
+#include "arm-spe-pkt-decoder.h"
+
+struct arm_spe {
+	struct auxtrace			auxtrace;
+	struct auxtrace_queues		queues;
+	struct auxtrace_heap		heap;
+	u32				auxtrace_type;
+	struct perf_session		*session;
+	struct machine			*machine;
+	u32				pmu_type;
+};
+
+struct arm_spe_queue {
+	struct arm_spe		*spe;
+	unsigned int		queue_nr;
+	struct auxtrace_buffer	*buffer;
+	bool			on_heap;
+	bool			done;
+	pid_t			pid;
+	pid_t			tid;
+	int			cpu;
+};
+
+static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
+			   unsigned char *buf, size_t len)
+{
+	struct arm_spe_pkt packet;
+	size_t pos = 0;
+	int ret, pkt_len, i;
+	char desc[ARM_SPE_PKT_DESC_MAX];
+	const char *color = PERF_COLOR_BLUE;
+
+	color_fprintf(stdout, color,
+		      ". ... ARM SPE data: size %zu bytes\n",
+		      len);
+
+	while (len) {
+		ret = arm_spe_get_packet(buf, len, &packet);
+		if (ret > 0)
+			pkt_len = ret;
+		else
+			pkt_len = 1;
+		printf(".");
+		color_fprintf(stdout, color, "  %08x: ", pos);
+		for (i = 0; i < pkt_len; i++)
+			color_fprintf(stdout, color, " %02x", buf[i]);
+		for (; i < 16; i++)
+			color_fprintf(stdout, color, "   ");
+		if (ret > 0) {
+			ret = arm_spe_pkt_desc(&packet, desc,
+					       ARM_SPE_PKT_DESC_MAX);
+			if (ret > 0)
+				color_fprintf(stdout, color, " %s\n", desc);
+		} else {
+			color_fprintf(stdout, color, " Bad packet!\n");
+		}
+		pos += pkt_len;
+		buf += pkt_len;
+		len -= pkt_len;
+	}
+}
+
+static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
+				 size_t len)
+{
+	printf(".\n");
+	arm_spe_dump(spe, buf, len);
+}
+
+static struct arm_spe_queue *arm_spe_alloc_queue(struct arm_spe *spe,
+						     unsigned int queue_nr)
+{
+	struct arm_spe_queue *speq;
+
+	speq = zalloc(sizeof(struct arm_spe_queue));
+	if (!speq)
+		return NULL;
+
+	speq->spe = spe;
+	speq->queue_nr = queue_nr;
+	speq->pid = -1;
+	speq->tid = -1;
+	speq->cpu = -1;
+
+	return speq;
+}
+
+static int arm_spe_setup_queue(struct arm_spe *spe,
+				 struct auxtrace_queue *queue,
+				 unsigned int queue_nr)
+{
+	struct arm_spe_queue *speq = queue->priv;
+
+	if (list_empty(&queue->head))
+		return 0;
+
+	if (!speq) {
+		speq = arm_spe_alloc_queue(spe, queue_nr);
+		if (!speq)
+			return -ENOMEM;
+		queue->priv = speq;
+
+		if (queue->cpu != -1)
+			speq->cpu = queue->cpu;
+		speq->tid = queue->tid;
+	}
+
+	if (!speq->on_heap && !speq->buffer) {
+		int ret;
+
+		speq->buffer = auxtrace_buffer__next(queue, NULL);
+		if (!speq->buffer)
+			return 0;
+
+		ret = auxtrace_heap__add(&spe->heap, queue_nr,
+					 speq->buffer->reference);
+		if (ret)
+			return ret;
+		speq->on_heap = true;
+	}
+
+	return 0;
+}
+
+static int arm_spe_setup_queues(struct arm_spe *spe)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < spe->queues.nr_queues; i++) {
+		ret = arm_spe_setup_queue(spe, &spe->queues.queue_array[i],
+					    i);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static inline int arm_spe_update_queues(struct arm_spe *spe)
+{
+	if (spe->queues.new_data) {
+		spe->queues.new_data = false;
+		return arm_spe_setup_queues(spe);
+	}
+	return 0;
+}
+
+static int arm_spe_process_event(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused,
+				   struct perf_sample *sample __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int arm_spe_process_auxtrace_event(struct perf_session *session,
+					    union perf_event *event,
+					    struct perf_tool *tool __maybe_unused)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+	struct auxtrace_buffer *buffer;
+	off_t data_offset;
+	int fd = perf_data_file__fd(session->file);
+	int err;
+
+	if (perf_data_file__is_pipe(session->file)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	err = auxtrace_queues__add_event(&spe->queues, session, event,
+					 data_offset, &buffer);
+	if (err)
+		return err;
+
+	/* Dump here now we have copied a piped trace out of the pipe */
+	if (dump_trace) {
+		if (auxtrace_buffer__get_data(buffer, fd)) {
+			arm_spe_dump_event(spe, buffer->data,
+					     buffer->size);
+			auxtrace_buffer__put_data(buffer);
+		}
+	}
+
+	return 0;
+}
+
+static int arm_spe_flush(struct perf_session *session __maybe_unused,
+			   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void arm_spe_free_queue(void *priv)
+{
+	struct arm_spe_queue *speq = priv;
+
+	if (!speq)
+		return;
+	free(speq);
+}
+
+static void arm_spe_free_events(struct perf_session *session)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+	struct auxtrace_queues *queues = &spe->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		arm_spe_free_queue(queues->queue_array[i].priv);
+		queues->queue_array[i].priv = NULL;
+	}
+	auxtrace_queues__free(queues);
+}
+
+static void arm_spe_free(struct perf_session *session)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+
+	auxtrace_heap__free(&spe->heap);
+	arm_spe_free_events(session);
+	session->auxtrace = NULL;
+	free(spe);
+}
+
+static const char * const arm_spe_info_fmts[] = {
+	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+};
+
+static void arm_spe_print_info(u64 *arr)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+}
+
+int arm_spe_process_auxtrace_info(union perf_event *event,
+				    struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	size_t min_sz = sizeof(u64) * ARM_SPE_PMU_TYPE;
+	struct arm_spe *spe;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
+					min_sz)
+		return -EINVAL;
+
+	spe = zalloc(sizeof(struct arm_spe));
+	if (!spe)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&spe->queues);
+	if (err)
+		goto err_free;
+
+	spe->session = session;
+	spe->machine = &session->machines.host; /* No kvm support */
+	spe->auxtrace_type = auxtrace_info->type;
+	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+
+	spe->auxtrace.process_event = arm_spe_process_event;
+	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
+	spe->auxtrace.flush_events = arm_spe_flush;
+	spe->auxtrace.free_events = arm_spe_free_events;
+	spe->auxtrace.free = arm_spe_free;
+	session->auxtrace = &spe->auxtrace;
+
+	arm_spe_print_info(&auxtrace_info->priv[0]);
+
+	return 0;
+
+err_free:
+	free(spe);
+	return err;
+}
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
new file mode 100644
index 000000000000..afa4704c5e5e
--- /dev/null
+++ b/tools/perf/util/arm-spe.h
@@ -0,0 +1,39 @@
+/*
+ * ARM Statistical Profiling Extensions (SPE) support
+ * Copyright (c) 2017, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef INCLUDE__PERF_ARM_SPE_H__
+#define INCLUDE__PERF_ARM_SPE_H__
+
+#define ARM_SPE_PMU_NAME "arm_spe_0"
+
+enum {
+	ARM_SPE_PMU_TYPE,
+	ARM_SPE_PER_CPU_MMAPS,
+	ARM_SPE_AUXTRACE_PRIV_MAX,
+};
+
+#define ARM_SPE_AUXTRACE_PRIV_SIZE (ARM_SPE_AUXTRACE_PRIV_MAX * sizeof(u64))
+
+struct auxtrace_record;
+struct perf_tool;
+union perf_event;
+struct perf_session;
+
+struct auxtrace_record *arm_spe_recording_init(int *err);
+
+int arm_spe_process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session);
+
+#endif
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0daf63b9ee3e..f9ccc52a6c8f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -57,6 +57,7 @@
 
 #include "intel-pt.h"
 #include "intel-bts.h"
+#include "arm-spe.h"
 
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
@@ -903,6 +904,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return intel_pt_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_INTEL_BTS:
 		return intel_bts_process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_ARM_SPE:
+		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 9f0de72d58e2..db1479b2a428 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -43,6 +43,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_INTEL_PT,
 	PERF_AUXTRACE_INTEL_BTS,
 	PERF_AUXTRACE_CS_ETM,
+	PERF_AUXTRACE_ARM_SPE,
 };
 
 enum itrace_period_type {
-- 
2.11.0
