From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 03:04:15 -0500
Subject: [RFC 3/3] perf tool: arm-ccn: add a supplemental strerror function
Message-ID: <20171024030415.9baa5157e506892a757bf8c7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the Arm CCN driver as an example of how to try to improve
upon its existing dmesg error output, and duplicate error string
generation logic in the perf tool.

EXAMPLE 1:  Problem:  The perf tool doesn't specify to which event its
generic message applies. 

BEFORE THIS PATCH:

# ./oldperf record -e armv8_pmuv3/mem_access/,armv8_pmuv3/l2d_cache/,ccn/cycles/ true
Error:
PMU Hardware doesn't support sampling/overflow-interrupts.
# 

Adding a '-v' after the record yields the same result.  Adding a -vv
shows perf_event_attr listings, but no names of events:

# ./oldperf record -vv -e armv8_pmuv3/mem_access/,armv8_pmuv3/l2d_cache/,ccn/cycles/ true
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             112
  config                           0x13
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid 21416  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid 21416  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 21416  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 21416  cpu 3  group_fd -1  flags 0x8 = 8
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             112
  config                           0x16
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  freq                             1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 21416  cpu 0  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 21416  cpu 1  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 21416  cpu 2  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 21416  cpu 3  group_fd -1  flags 0x8 = 12
------------------------------------------------------------
perf_event_attr:
  type                             8
  size                             112
  config                           0xff00
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  freq                             1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -95
Error:
PMU Hardware doesn't support sampling/overflow-interrupts.
# 

Note that the Arm CCN driver already emits its errors to dmesg, so this is what
things would look like if the user had executed 'dmesg -w &" prior to
invocation:

# ./oldperf record -e armv8_pmuv3/mem_access/,armv8_pmuv3/l2d_cache/,ccn/cycles/ true
Error:
PMU Hardware doesn't support sampling/overflow-interrupts.
# [ 9343.375331] arm-ccn e8000000.ccn: Sampling not supported!

In that case, can the user clearly see it's the CCN event that doesn't
support sampling.

AFTER THIS PATCH:

The perf tool has been modified to say which event doesn't support sampling:

# ./newperf record -e armv8_pmuv3/mem_access/,armv8_pmuv3/l2d_cache/,ccn/cycles/ true
Error:
ccn/cycles/: Sampling not supported, try 'perf stat'
PMU Hardware doesn't support sampling/overflow-interrupts.
#

EXAMPLE 2:  Problem:  stat output contains "<not supported>" for events without
explanation.

BEFORE THIS PATCH:

# ./oldperf stat -v -e ccn/cycles/ku sleep 1
Warning:
ccn/cycles/ku event is not supported by the kernel.
failed to read counter ccn/cycles/ku

 Performance counter stats for 'system wide':

   <not supported>      ccn/cycles/ku                                               

       1.002756731 seconds time elapsed

Meanwhile, dmesg contains:

[15815.248985] arm-ccn e8000000.ccn: Can't exclude execution levels!

AFTER THIS PATCH:

The tool itself tells the user the event can't exclude execution
levels, rather than the user having to refer to dmesg:

# ./newperf stat -v -e ccn/cycles/ku sleep 1
Warning:
ccn/cycles/ku event is not supported by the kernel.
Error:
ccn/cycles/ku: Can't exclude execution levels!
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ccn/cycles/ku).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?
failed to read counter ccn/cycles/ku

 Performance counter stats for 'system wide':

   <not supported>      ccn/cycles/ku                                               

       1.002935620 seconds time elapsed

EXAMPLE 3:  Problem:  stat output contains "<not supported>" for events without
detailed explanation, to the point where the tool refers the user the driver's
output in dmesg.

BEFORE THIS PATCH:

Without -v, we just get '<not supported>' as the count.  Turning on '-v' we are
explained that it's not supported 'by the kernel' and that something 'failed to
read counter':

# ./oldperf stat -v -e ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ sleep 1
Warning:
ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ event is not supported by the kernel.
failed to read counter ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/

 Performance counter stats for 'system wide':

   <not supported>      ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/                                   

       1.002947707 seconds time elapsed

Meanwhile, the kernel driver has written these messages to dmesg:

[16561.854700] arm-ccn e8000000.ccn: Can't exclude execution levels!
[16561.872725] arm-ccn e8000000.ccn: Invalid vc 5 for node/XP 3!

AFTER THIS PATCH:

A summary of all the driver's EINVAL condition possibilities are
presented to the user, with a note to see dmesg for details:

# ./newperf stat -v -e ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ sleep 1
Warning:
ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ event is not supported by the kernel.
Error:
ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/: Invalid MN / XP / node ID, or node type, or node/XP port / vc or event, or mixed PMU group. See dmesg for details
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?
failed to read counter ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/

 Performance counter stats for 'system wide':

   <not supported>      ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/                                   

       1.002920980 seconds time elapsed

In this case, setting vc=3 fixed the event specification:

# ./newperf stat -e ccn/xp_watchpoint,xp=3,vc=3,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ sleep 1

 Performance counter stats for 'system wide':

                 0      ccn/xp_watchpoint,xp=3,vc=3,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/                                   

       1.003270551 seconds time elapsed

Signed-off-by:  Kim Phillips <kim.phillips@arm.com>
---
Comments?  Is this really that much better than the existing dmesg that
the user is already being pointed to by the perf tool?

 tools/perf/arch/arm64/util/Build   |  1 +
 tools/perf/arch/arm64/util/evsel.c | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/evsel.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index b1ab72d2a42e..8dee4aa31a68 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,4 +1,5 @@
 libperf-y += header.o
+libperf-y     += evsel.o
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 
diff --git a/tools/perf/arch/arm64/util/evsel.c b/tools/perf/arch/arm64/util/evsel.c
new file mode 100644
index 000000000000..cb9ddd6523e3
--- /dev/null
+++ b/tools/perf/arch/arm64/util/evsel.c
@@ -0,0 +1,53 @@
+#include <string.h>
+
+#include <linux/perf_event.h>
+#include <linux/err.h>
+
+#include "../../util/evsel.h"
+
+#include "evsel.h"
+
+static int ccn_strerror(struct perf_evsel *evsel,
+			struct target *target __maybe_unused,
+			int err, char *msg, size_t size)
+{
+	const char *evname = perf_evsel__name(evsel);
+	struct perf_event_attr *attr = &evsel->attr;
+
+	switch (err) {
+	case EOPNOTSUPP:
+		if (attr->sample_period)
+			return scnprintf(msg, size, "%s: Sampling not supported, try 'perf stat'\n", evname);
+		if (target__has_task(target))
+			return scnprintf(msg, size, "%s: Can't provide per-task data!\n", evname);
+		break;
+	case EINVAL:
+		if ((attr->sample_type & PERF_SAMPLE_BRANCH_STACK) ||
+			attr->exclude_user ||
+			attr->exclude_kernel || attr->exclude_hv ||
+			attr->exclude_idle || attr->exclude_host ||
+			attr->exclude_guest)
+			return scnprintf(msg, size, "%s: Can't exclude execution levels!\n", evname);
+
+		return scnprintf(msg, size,
+	"%s: Invalid MN / XP / node ID, or node type, or node/XP port / vc or event, or mixed PMU group. See dmesg for details\n", evname);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int perf_evsel__suppl_strerror(struct perf_evsel *evsel,
+			       struct target *target __maybe_unused,
+			       int err, char *msg, size_t size)
+{
+
+	const char *evname = perf_evsel__name(evsel);
+
+	if (strstarts(evname, "ccn"))
+		return ccn_strerror(evsel, target, err, msg, size);
+
+	return 0;
+}
-- 
2.14.2
