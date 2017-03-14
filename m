From: hotran@apm.com (Hoan Tran)
Date: Tue, 14 Mar 2017 11:06:52 -0700
Subject: [PATCH 2/2] perf: xgene: Add support for SoC PMU of next generation
 of X-Gene
In-Reply-To: <1489514812-19671-1-git-send-email-hotran@apm.com>
References: <1489514812-19671-1-git-send-email-hotran@apm.com>
Message-ID: <1489514812-19671-3-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SoC-wide (AKA uncore) Performance Monitoring
Unit in the next generation of X-Gene SoC.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/perf/xgene_pmu.c | 645 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 575 insertions(+), 70 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 35b5289..21c7e7f 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -35,10 +35,13 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define CSW_CSWCR                       0x0000
-#define  CSW_CSWCR_DUALMCB_MASK         BIT(0)
-#define MCBADDRMR                       0x0000
-#define  MCBADDRMR_DUALMCU_MODE_MASK    BIT(2)
+#define CSW_CSWCR			0x0000
+#define  CSW_CSWCR_DUALMCB_MASK		BIT(0)
+#define  CSW_CSWCR_MCB0_ROUTING(x)	(((x) & 0x0C) >> 2)
+#define  CSW_CSWCR_MCB1_ROUTING(x)	(((x) & 0x30) >> 4)
+
+#define MCBADDRMR			0x0000
+#define  MCBADDRMR_DUALMCU_MODE_MASK	BIT(2)
 
 #define PCPPMU_INTSTATUS_REG	0x000
 #define PCPPMU_INTMASK_REG	0x004
@@ -50,8 +53,17 @@
 #define  PCPPMU_INT_L3C		BIT(2)
 #define  PCPPMU_INT_IOB		BIT(3)
 
+#define  PCPPMU_V3_INTMASK	0x00FF33FF
+#define  PCPPMU_V3_INTENMASK	0xFFFFFFFF
+#define  PCPPMU_V3_INTCLRMASK	0xFF00CC00
+#define  PCPPMU_V3_INT_MCU	0x000000FF
+#define  PCPPMU_V3_INT_MCB	0x00000300
+#define  PCPPMU_V3_INT_L3C	0x00FF0000
+#define  PCPPMU_V3_INT_IOB	0x00003000
+
 #define PMU_MAX_COUNTERS	4
-#define PMU_CNT_MAX_PERIOD	0x100000000ULL
+#define PMU_CNT_MAX_PERIOD	0xFFFFFFFFULL
+#define PMU_V3_CNT_MAX_PERIOD	0xFFFFFFFFFFFFFFFFULL
 #define PMU_OVERFLOW_MASK	0xF
 #define PMU_PMCR_E		BIT(0)
 #define PMU_PMCR_P		BIT(1)
@@ -73,11 +85,26 @@
 #define PMU_PMOVSR		0xC80
 #define PMU_PMCR		0xE04
 
-#define to_pmu_dev(p)     container_of(p, struct xgene_pmu_dev, pmu)
-#define GET_CNTR(ev)      (ev->hw.idx)
-#define GET_EVENTID(ev)   (ev->hw.config & 0xFFULL)
-#define GET_AGENTID(ev)   (ev->hw.config_base & 0xFFFFFFFFUL)
-#define GET_AGENT1ID(ev)  ((ev->hw.config_base >> 32) & 0xFFFFFFFFUL)
+/* PMU registers for V3 */
+#define PMU_PMOVSCLR		0xC80
+#define PMU_PMOVSSET		0xCC0
+#define PMU_PMAUXR0		0xD80
+#define PMU_PMAUXR1		0xD84
+#define PMU_PMAUXR2		0xD88
+#define PMU_PMAUXR3		0xD8C
+
+/* Default PMU agent ID values for V3 */
+#define PCPPMU_V3_L3C_DEFAULT_AGENTID		0x0ULL
+#define PCPPMU_V3_IOB_DEFAULT_AGENTID		0x0ULL
+#define PCPPMU_V3_IOB_SLOW_DEFAULT_AGENTID	0x0ULL
+#define PCPPMU_V3_MCB_DEFAULT_AGENTID		0x100000000ULL
+#define PCPPMU_V3_MC_DEFAULT_AGENTID		0xFFFFFF00ULL
+
+#define to_pmu_dev(p)		container_of(p, struct xgene_pmu_dev, pmu)
+#define GET_CNTR(ev)		(ev->hw.idx)
+#define GET_EVENTID(ev)		(ev->hw.config & 0xFFULL)
+#define GET_AGENTID(ev)		(ev->hw.config_base & 0xFFFFFFFFUL)
+#define GET_AGENT1ID(ev)	((ev->hw.config_base >> 32) & 0xFFFFFFFFUL)
 
 struct hw_pmu_info {
 	u32 type;
@@ -92,6 +119,7 @@ struct xgene_pmu_dev {
 	u8 max_counters;
 	DECLARE_BITMAP(cntr_assign_mask, PMU_MAX_COUNTERS);
 	u64 max_period;
+	u64 default_agentid;
 	const struct attribute_group **attr_groups;
 	struct perf_event *pmu_counter_event[PMU_MAX_COUNTERS];
 };
@@ -102,6 +130,7 @@ struct xgene_pmu {
 	void __iomem *pcppmu_csr;
 	u32 mcb_active_mask;
 	u32 mc_active_mask;
+	u32 l3c_active_mask;
 	cpumask_t cpu;
 	raw_spinlock_t lock;
 	struct list_head l3cpmus;
@@ -125,11 +154,13 @@ struct xgene_pmu_data {
 enum xgene_pmu_version {
 	PCP_PMU_V1 = 1,
 	PCP_PMU_V2,
+	PCP_PMU_V3,
 };
 
 enum xgene_pmu_dev_type {
 	PMU_TYPE_L3C = 0,
 	PMU_TYPE_IOB,
+	PMU_TYPE_IOB_SLOW,
 	PMU_TYPE_MCB,
 	PMU_TYPE_MC,
 };
@@ -195,6 +226,60 @@ static ssize_t xgene_pmu_format_show(struct device *dev,
 	.attrs = mc_pmu_format_attrs,
 };
 
+static struct attribute *l3c_pmu_v3_format_attrs[] = {
+	XGENE_PMU_FORMAT_ATTR(l3c_eventid, "config:0-39"),
+	XGENE_PMU_FORMAT_ATTR(l3c_agentid, "config1:0-31"),
+	NULL,
+};
+
+static struct attribute *iob_pmu_v3_format_attrs[] = {
+	XGENE_PMU_FORMAT_ATTR(iob_eventid, "config:0-47"),
+	XGENE_PMU_FORMAT_ATTR(iob_agentid, "config1:0-63"),
+	NULL,
+};
+
+static struct attribute *iob_slow_pmu_v3_format_attrs[] = {
+	XGENE_PMU_FORMAT_ATTR(iob_slow_eventid, "config:0-16"),
+	XGENE_PMU_FORMAT_ATTR(iob_slow_agentid, "config1:0-63"),
+	NULL,
+};
+
+static struct attribute *mcb_pmu_v3_format_attrs[] = {
+	XGENE_PMU_FORMAT_ATTR(mcb_eventid, "config:0-35"),
+	XGENE_PMU_FORMAT_ATTR(mcb_agentid, "config1:0-63"),
+	NULL,
+};
+
+static struct attribute *mc_pmu_v3_format_attrs[] = {
+	XGENE_PMU_FORMAT_ATTR(mc_eventid, "config:0-44"),
+	XGENE_PMU_FORMAT_ATTR(mc_agentid, "config1:0-31"),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_v3_format_attr_group = {
+	.name = "format",
+	.attrs = l3c_pmu_v3_format_attrs,
+};
+
+static const struct attribute_group iob_pmu_v3_format_attr_group = {
+	.name = "format",
+	.attrs = iob_pmu_v3_format_attrs,
+};
+
+static const struct attribute_group iob_slow_pmu_v3_format_attr_group = {
+	.name = "format",
+	.attrs = iob_slow_pmu_v3_format_attrs,
+};
+
+static const struct attribute_group mcb_pmu_v3_format_attr_group = {
+	.name = "format",
+	.attrs = mcb_pmu_v3_format_attrs,
+};
+
+static const struct attribute_group mc_pmu_v3_format_attr_group = {
+	.name = "format",
+	.attrs = mc_pmu_v3_format_attrs,
+};
 /*
  * sysfs event attributes
  */
@@ -311,6 +396,219 @@ static ssize_t xgene_pmu_event_show(struct device *dev,
 	.attrs = mc_pmu_events_attrs,
 };
 
+static struct attribute *l3c_pmu_v3_events_attrs[] = {
+	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
+	XGENE_PMU_EVENT_ATTR(read-hit,				0x01),
+	XGENE_PMU_EVENT_ATTR(read-miss,				0x02),
+	XGENE_PMU_EVENT_ATTR(index-flush-eviction,		0x03),
+	XGENE_PMU_EVENT_ATTR(write-caused-replacement,		0x04),
+	XGENE_PMU_EVENT_ATTR(write-not-caused-replacement,	0x05),
+	XGENE_PMU_EVENT_ATTR(clean-eviction,			0x06),
+	XGENE_PMU_EVENT_ATTR(dirty-eviction,			0x07),
+	XGENE_PMU_EVENT_ATTR(reads,				0x08),
+	XGENE_PMU_EVENT_ATTR(writes,				0x09),
+	XGENE_PMU_EVENT_ATTR(requests,				0x0a),
+	XGENE_PMU_EVENT_ATTR(tq-bank-conflict-issue-stall,	0x0b),
+	XGENE_PMU_EVENT_ATTR(tq-full,				0x0c),
+	XGENE_PMU_EVENT_ATTR(ackq-full,				0x0d),
+	XGENE_PMU_EVENT_ATTR(wdb-full,				0x0e),
+	XGENE_PMU_EVENT_ATTR(odb-full,				0x10),
+	XGENE_PMU_EVENT_ATTR(wbq-full,				0x11),
+	XGENE_PMU_EVENT_ATTR(input-req-async-fifo-stall,	0x12),
+	XGENE_PMU_EVENT_ATTR(output-req-async-fifo-stall,	0x13),
+	XGENE_PMU_EVENT_ATTR(output-data-async-fifo-stall,	0x14),
+	XGENE_PMU_EVENT_ATTR(total-insertions,			0x15),
+	XGENE_PMU_EVENT_ATTR(sip-insertions-r-set,		0x16),
+	XGENE_PMU_EVENT_ATTR(sip-insertions-r-clear,		0x17),
+	XGENE_PMU_EVENT_ATTR(dip-insertions-r-set,		0x18),
+	XGENE_PMU_EVENT_ATTR(dip-insertions-r-clear,		0x19),
+	XGENE_PMU_EVENT_ATTR(dip-insertions-force-r-set,	0x1a),
+	XGENE_PMU_EVENT_ATTR(egressions,			0x1b),
+	XGENE_PMU_EVENT_ATTR(replacements,			0x1c),
+	XGENE_PMU_EVENT_ATTR(old-replacements,			0x1d),
+	XGENE_PMU_EVENT_ATTR(young-replacements,		0x1e),
+	XGENE_PMU_EVENT_ATTR(r-set-replacements,		0x1f),
+	XGENE_PMU_EVENT_ATTR(r-clear-replacements,		0x20),
+	XGENE_PMU_EVENT_ATTR(old-r-replacements,		0x21),
+	XGENE_PMU_EVENT_ATTR(old-nr-replacements,		0x22),
+	XGENE_PMU_EVENT_ATTR(young-r-replacements,		0x23),
+	XGENE_PMU_EVENT_ATTR(young-nr-replacements,		0x24),
+	XGENE_PMU_EVENT_ATTR(bloomfilter-clearings,		0x25),
+	XGENE_PMU_EVENT_ATTR(generation-flips,			0x26),
+	XGENE_PMU_EVENT_ATTR(vcc-droop-detected,		0x27),
+	NULL,
+};
+
+static struct attribute *iob_fast_pmu_v3_events_attrs[] = {
+	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
+	XGENE_PMU_EVENT_ATTR(PA-req-buf-alloc-all,		0x01),
+	XGENE_PMU_EVENT_ATTR(PA-req-buf-alloc-rd,		0x02),
+	XGENE_PMU_EVENT_ATTR(PA-req-buf-alloc-wr,		0x03),
+	XGENE_PMU_EVENT_ATTR(PA-all-CP-req,			0x04),
+	XGENE_PMU_EVENT_ATTR(PA-CP-blk-req,			0x05),
+	XGENE_PMU_EVENT_ATTR(PA-CP-ptl-req,			0x06),
+	XGENE_PMU_EVENT_ATTR(PA-CP-rd-req,			0x07),
+	XGENE_PMU_EVENT_ATTR(PA-CP-wr-req,			0x08),
+	XGENE_PMU_EVENT_ATTR(BA-all-req,			0x09),
+	XGENE_PMU_EVENT_ATTR(BA-rd-req,				0x0a),
+	XGENE_PMU_EVENT_ATTR(BA-wr-req,				0x0b),
+	XGENE_PMU_EVENT_ATTR(PA-rd-shared-req-issued,		0x10),
+	XGENE_PMU_EVENT_ATTR(PA-rd-exclusive-req-issued,	0x11),
+	XGENE_PMU_EVENT_ATTR(PA-wr-invalidate-req-issued-stashable, 0x12),
+	XGENE_PMU_EVENT_ATTR(PA-wr-invalidate-req-issued-nonstashable, 0x13),
+	XGENE_PMU_EVENT_ATTR(PA-wr-back-req-issued-stashable,	0x14),
+	XGENE_PMU_EVENT_ATTR(PA-wr-back-req-issued-nonstashable, 0x15),
+	XGENE_PMU_EVENT_ATTR(PA-ptl-wr-req,			0x16),
+	XGENE_PMU_EVENT_ATTR(PA-ptl-rd-req,			0x17),
+	XGENE_PMU_EVENT_ATTR(PA-wr-back-clean-data,		0x18),
+	XGENE_PMU_EVENT_ATTR(PA-wr-back-cancelled-on-SS,	0x1b),
+	XGENE_PMU_EVENT_ATTR(PA-barrier-occurrence,		0x1c),
+	XGENE_PMU_EVENT_ATTR(PA-barrier-cycles,			0x1d),
+	XGENE_PMU_EVENT_ATTR(PA-total-CP-snoops,		0x20),
+	XGENE_PMU_EVENT_ATTR(PA-rd-shared-snoop,		0x21),
+	XGENE_PMU_EVENT_ATTR(PA-rd-shared-snoop-hit,		0x22),
+	XGENE_PMU_EVENT_ATTR(PA-rd-exclusive-snoop,		0x23),
+	XGENE_PMU_EVENT_ATTR(PA-rd-exclusive-snoop-hit,		0x24),
+	XGENE_PMU_EVENT_ATTR(PA-rd-wr-invalid-snoop,		0x25),
+	XGENE_PMU_EVENT_ATTR(PA-rd-wr-invalid-snoop-hit,	0x26),
+	XGENE_PMU_EVENT_ATTR(PA-req-buffer-full,		0x28),
+	XGENE_PMU_EVENT_ATTR(Cswlf-outbound-req-fifo-full,	0x29),
+	XGENE_PMU_EVENT_ATTR(Cswlf-inbound-snoop-fifo-backpressure, 0x2a),
+	XGENE_PMU_EVENT_ATTR(Cswlf-outbound-lack-fifo-full,	0x2b),
+	XGENE_PMU_EVENT_ATTR(Cswlf-inbound-gack-fifo-backpressure, 0x2c),
+	XGENE_PMU_EVENT_ATTR(Cswlf-outbound-data-fifo-full,	0x2d),
+	XGENE_PMU_EVENT_ATTR(Cswlf-inbound-data-fifo-backpressure, 0x2e),
+	XGENE_PMU_EVENT_ATTR(Cswlf-inbound-req-backpressure,	0x2f),
+	NULL,
+};
+
+static struct attribute *iob_slow_pmu_v3_events_attrs[] = {
+	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
+	XGENE_PMU_EVENT_ATTR(PA-AXI0-rd-req,			0x01),
+	XGENE_PMU_EVENT_ATTR(PA-AXI0-wr-req,			0x02),
+	XGENE_PMU_EVENT_ATTR(PA-AXI1-rd-req,			0x03),
+	XGENE_PMU_EVENT_ATTR(PA-AXI1-wr-req,			0x04),
+	XGENE_PMU_EVENT_ATTR(BA-all-AXI-req,			0x07),
+	XGENE_PMU_EVENT_ATTR(BA-AXI-rd-req,			0x08),
+	XGENE_PMU_EVENT_ATTR(BA-AXI-wr-req,			0x09),
+	XGENE_PMU_EVENT_ATTR(BA-free-list-empty,		0x10),
+	NULL,
+};
+
+static struct attribute *mcb_pmu_v3_events_attrs[] = {
+	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
+	XGENE_PMU_EVENT_ATTR(req-receive,			0x01),
+	XGENE_PMU_EVENT_ATTR(rd-req-recv,			0x02),
+	XGENE_PMU_EVENT_ATTR(rd-req-recv-2,			0x03),
+	XGENE_PMU_EVENT_ATTR(wr-req-recv,			0x04),
+	XGENE_PMU_EVENT_ATTR(wr-req-recv-2,			0x05),
+	XGENE_PMU_EVENT_ATTR(rd-req-sent-to-mcu,		0x06),
+	XGENE_PMU_EVENT_ATTR(rd-req-sent-to-mcu-2,		0x07),
+	XGENE_PMU_EVENT_ATTR(rd-req-sent-to-spec-mcu,		0x08),
+	XGENE_PMU_EVENT_ATTR(rd-req-sent-to-spec-mcu-2,		0x09),
+	XGENE_PMU_EVENT_ATTR(glbl-ack-recv-for-rd-sent-to-spec-mcu, 0x0a),
+	XGENE_PMU_EVENT_ATTR(glbl-ack-go-recv-for-rd-sent-to-spec-mcu, 0x0b),
+	XGENE_PMU_EVENT_ATTR(glbl-ack-nogo-recv-for-rd-sent-to-spec-mcu, 0x0c),
+	XGENE_PMU_EVENT_ATTR(glbl-ack-go-recv-any-rd-req,	0x0d),
+	XGENE_PMU_EVENT_ATTR(glbl-ack-go-recv-any-rd-req-2,	0x0e),
+	XGENE_PMU_EVENT_ATTR(wr-req-sent-to-mcu,		0x0f),
+	XGENE_PMU_EVENT_ATTR(gack-recv,				0x10),
+	XGENE_PMU_EVENT_ATTR(rd-gack-recv,			0x11),
+	XGENE_PMU_EVENT_ATTR(wr-gack-recv,			0x12),
+	XGENE_PMU_EVENT_ATTR(cancel-rd-gack,			0x13),
+	XGENE_PMU_EVENT_ATTR(cancel-wr-gack,			0x14),
+	XGENE_PMU_EVENT_ATTR(mcb-csw-req-stall,			0x15),
+	XGENE_PMU_EVENT_ATTR(mcu-req-intf-blocked,		0x16),
+	XGENE_PMU_EVENT_ATTR(mcb-mcu-rd-intf-stall,		0x17),
+	XGENE_PMU_EVENT_ATTR(csw-rd-intf-blocked,		0x18),
+	XGENE_PMU_EVENT_ATTR(csw-local-ack-intf-blocked,	0x19),
+	XGENE_PMU_EVENT_ATTR(mcu-req-table-full,		0x1a),
+	XGENE_PMU_EVENT_ATTR(mcu-stat-table-full,		0x1b),
+	XGENE_PMU_EVENT_ATTR(mcu-wr-table-full,			0x1c),
+	XGENE_PMU_EVENT_ATTR(mcu-rdreceipt-resp,		0x1d),
+	XGENE_PMU_EVENT_ATTR(mcu-wrcomplete-resp,		0x1e),
+	XGENE_PMU_EVENT_ATTR(mcu-retryack-resp,			0x1f),
+	XGENE_PMU_EVENT_ATTR(mcu-pcrdgrant-resp,		0x20),
+	XGENE_PMU_EVENT_ATTR(mcu-req-from-lastload,		0x21),
+	XGENE_PMU_EVENT_ATTR(mcu-req-from-bypass,		0x22),
+	XGENE_PMU_EVENT_ATTR(volt-droop-detect,			0x23),
+	NULL,
+};
+
+static struct attribute *mc_pmu_v3_events_attrs[] = {
+	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
+	XGENE_PMU_EVENT_ATTR(pmu-act-sent,			0x01),
+	XGENE_PMU_EVENT_ATTR(pmu-pre-sent,			0x02),
+	XGENE_PMU_EVENT_ATTR(pmu-rd-sent,			0x03),
+	XGENE_PMU_EVENT_ATTR(pmu-rda-sent,			0x04),
+	XGENE_PMU_EVENT_ATTR(pmu-wr-sent,			0x05),
+	XGENE_PMU_EVENT_ATTR(pmu-wra-sent,			0x06),
+	XGENE_PMU_EVENT_ATTR(pmu-pd-entry-vld,			0x07),
+	XGENE_PMU_EVENT_ATTR(pmu-sref-entry-vld,		0x08),
+	XGENE_PMU_EVENT_ATTR(pmu-prea-sent,			0x09),
+	XGENE_PMU_EVENT_ATTR(pmu-ref-sent,			0x0a),
+	XGENE_PMU_EVENT_ATTR(pmu-rd-rda-sent,			0x0b),
+	XGENE_PMU_EVENT_ATTR(pmu-wr-wra-sent,			0x0c),
+	XGENE_PMU_EVENT_ATTR(pmu-raw-hazard,			0x0d),
+	XGENE_PMU_EVENT_ATTR(pmu-war-hazard,			0x0e),
+	XGENE_PMU_EVENT_ATTR(pmu-waw-hazard,			0x0f),
+	XGENE_PMU_EVENT_ATTR(pmu-rar-hazard,			0x10),
+	XGENE_PMU_EVENT_ATTR(pmu-raw-war-waw-hazard,		0x11),
+	XGENE_PMU_EVENT_ATTR(pmu-hprd-lprd-wr-req-vld,		0x12),
+	XGENE_PMU_EVENT_ATTR(pmu-lprd-req-vld,			0x13),
+	XGENE_PMU_EVENT_ATTR(pmu-hprd-req-vld,			0x14),
+	XGENE_PMU_EVENT_ATTR(pmu-hprd-lprd-req-vld,		0x15),
+	XGENE_PMU_EVENT_ATTR(pmu-wr-req-vld,			0x16),
+	XGENE_PMU_EVENT_ATTR(pmu-partial-wr-req-vld,		0x17),
+	XGENE_PMU_EVENT_ATTR(pmu-rd-retry,			0x18),
+	XGENE_PMU_EVENT_ATTR(pmu-wr-retry,			0x19),
+	XGENE_PMU_EVENT_ATTR(pmu-retry-gnt,			0x1a),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-change,			0x1b),
+	XGENE_PMU_EVENT_ATTR(pmu-dir-change,			0x1c),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-dir-change,		0x1d),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-active,			0x1e),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-idle,			0x1f),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-pd,			0x20),
+	XGENE_PMU_EVENT_ATTR(pmu-rank-sref,			0x21),
+	XGENE_PMU_EVENT_ATTR(pmu-queue-fill-gt-thresh,		0x22),
+	XGENE_PMU_EVENT_ATTR(pmu-queue-rds-gt-thresh,		0x23),
+	XGENE_PMU_EVENT_ATTR(pmu-queue-wrs-gt-thresh,		0x24),
+	XGENE_PMU_EVENT_ATTR(pmu-phy-updt-complt,		0x25),
+	XGENE_PMU_EVENT_ATTR(pmu-tz-fail,			0x26),
+	XGENE_PMU_EVENT_ATTR(pmu-dram-errc,			0x27),
+	XGENE_PMU_EVENT_ATTR(pmu-dram-errd,			0x28),
+	XGENE_PMU_EVENT_ATTR(pmu-rd-enq,			0x29),
+	XGENE_PMU_EVENT_ATTR(pmu-wr-enq,			0x2a),
+	XGENE_PMU_EVENT_ATTR(pmu-tmac-limit-reached,		0x2b),
+	XGENE_PMU_EVENT_ATTR(pmu-tmaw-tracker-full,		0x2c),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_v3_events_attr_group = {
+	.name = "events",
+	.attrs = l3c_pmu_v3_events_attrs,
+};
+
+static const struct attribute_group iob_fast_pmu_v3_events_attr_group = {
+	.name = "events",
+	.attrs = iob_fast_pmu_v3_events_attrs,
+};
+
+static const struct attribute_group iob_slow_pmu_v3_events_attr_group = {
+	.name = "events",
+	.attrs = iob_slow_pmu_v3_events_attrs,
+};
+
+static const struct attribute_group mcb_pmu_v3_events_attr_group = {
+	.name = "events",
+	.attrs = mcb_pmu_v3_events_attrs,
+};
+
+static const struct attribute_group mc_pmu_v3_events_attr_group = {
+	.name = "events",
+	.attrs = mc_pmu_v3_events_attrs,
+};
+
 /*
  * sysfs cpumask attributes
  */
@@ -334,7 +632,7 @@ static ssize_t xgene_pmu_cpumask_show(struct device *dev,
 };
 
 /*
- * Per PMU device attribute groups
+ * Per PMU device attribute groups of PMU v1 and v2
  */
 static const struct attribute_group *l3c_pmu_attr_groups[] = {
 	&l3c_pmu_format_attr_group,
@@ -364,6 +662,44 @@ static ssize_t xgene_pmu_cpumask_show(struct device *dev,
 	NULL
 };
 
+/*
+ * Per PMU device attribute groups of PMU v3
+ */
+static const struct attribute_group *l3c_pmu_v3_attr_groups[] = {
+	&l3c_pmu_v3_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&l3c_pmu_v3_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *iob_fast_pmu_v3_attr_groups[] = {
+	&iob_pmu_v3_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&iob_fast_pmu_v3_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *iob_slow_pmu_v3_attr_groups[] = {
+	&iob_slow_pmu_v3_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&iob_slow_pmu_v3_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *mcb_pmu_v3_attr_groups[] = {
+	&mcb_pmu_v3_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&mcb_pmu_v3_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *mc_pmu_v3_attr_groups[] = {
+	&mc_pmu_v3_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&mc_pmu_v3_events_attr_group,
+	NULL
+};
+
 static int get_next_avail_cntr(struct xgene_pmu_dev *pmu_dev)
 {
 	int cntr;
@@ -384,23 +720,64 @@ static void clear_avail_cntr(struct xgene_pmu_dev *pmu_dev, int cntr)
 
 static inline void xgene_pmu_mask_int(struct xgene_pmu *xgene_pmu)
 {
-	writel(PCPPMU_INTENMASK, xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	if (xgene_pmu->version == PCP_PMU_V3) {
+		writel(PCPPMU_V3_INTENMASK,
+		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	} else {
+		writel(PCPPMU_INTENMASK,
+		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	}
 }
 
 static inline void xgene_pmu_unmask_int(struct xgene_pmu *xgene_pmu)
 {
-	writel(PCPPMU_INTCLRMASK, xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	if (xgene_pmu->version == PCP_PMU_V3) {
+		writel(PCPPMU_V3_INTCLRMASK,
+		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	} else {
+		writel(PCPPMU_INTCLRMASK,
+		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
+	}
 }
 
-static inline u32 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
+static inline u64 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
 {
-	return readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
+	u32 cnt_lo, cnt_hi, cnt_hi2;
+
+	if (pmu_dev->parent->version == PCP_PMU_V3) {
+		/*
+		 * v3 has 64-bit counter registers composed by 2 32-bit registers
+		 * This can be a problem if the counter increases and carries
+		 * out of bit [31] between 2 reads. The extra reads would help
+		 * to prevent this issue.
+		 */
+		while (1) {
+			cnt_hi = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + 4 + (8 * idx));
+			cnt_lo = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (8 * idx));
+			cnt_hi2 = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + 4 + (8 * idx));
+			if (cnt_hi == cnt_hi2)
+				return (((u64)cnt_hi << 32) | cnt_lo);
+		}
+	}
+
+	return ((u64)readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx)));
 }
 
 static inline void
-xgene_pmu_write_counter(struct xgene_pmu_dev *pmu_dev, int idx, u32 val)
+xgene_pmu_write_counter(struct xgene_pmu_dev *pmu_dev, int idx, u64 val)
 {
-	writel(val, pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
+	u32 cnt_lo, cnt_hi;
+
+	cnt_lo = val & 0xFFFFFFFF;
+	cnt_hi = val >> 32;
+
+	if (pmu_dev->parent->version == PCP_PMU_V3) {
+		/* v3 has 64-bit counter registers composed by 2 32-bit registers */
+		writel(cnt_lo, pmu_dev->inf->csr + PMU_PMEVCNTR0 + (8 * idx));
+		writel(cnt_hi, pmu_dev->inf->csr + PMU_PMEVCNTR0 + 4 + (8 * idx));
+	} else {
+		writel(cnt_lo, pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
+	}
 }
 
 static inline void
@@ -422,6 +799,18 @@ static inline u32 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
 }
 
 static inline void
+xgene_pmu_v3_write_agentmsk(struct xgene_pmu_dev *pmu_dev, u32 val)
+{
+	writel(val, pmu_dev->inf->csr + PMU_PMAUXR0);
+}
+
+static inline void
+xgene_pmu_v3_write_agent1msk(struct xgene_pmu_dev *pmu_dev, u32 val)
+{
+	writel(val, pmu_dev->inf->csr + PMU_PMAUXR1);
+}
+
+static inline void
 xgene_pmu_enable_counter(struct xgene_pmu_dev *pmu_dev, int idx)
 {
 	u32 val;
@@ -550,7 +939,10 @@ static int xgene_perf_event_init(struct perf_event *event)
 	 * by a request of an agent has the bit cleared.
 	 * By default, the event is counted for all agents.
 	 */
-	hw->config_base = event->attr.config1;
+	if (pmu_dev->parent->version == PCP_PMU_V3 && !event->attr.config1)
+		hw->config_base = pmu_dev->default_agentid;
+	else
+		hw->config_base = event->attr.config1;
 
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
@@ -569,14 +961,35 @@ static int xgene_perf_event_init(struct perf_event *event)
 	return 0;
 }
 
-static void xgene_perf_enable_event(struct perf_event *event)
+static void xgene_pmu_select_agent(struct perf_event *event)
 {
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
 
-	xgene_pmu_write_evttype(pmu_dev, GET_CNTR(event), GET_EVENTID(event));
 	xgene_pmu_write_agentmsk(pmu_dev, ~((u32)GET_AGENTID(event)));
 	if (pmu_dev->inf->type == PMU_TYPE_IOB)
 		xgene_pmu_write_agent1msk(pmu_dev, ~((u32)GET_AGENT1ID(event)));
+}
+
+static void xgene_pmu_v3_select_agent(struct perf_event *event)
+{
+	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+
+	xgene_pmu_v3_write_agentmsk(pmu_dev, (u32)GET_AGENTID(event));
+	if (pmu_dev->inf->type == PMU_TYPE_MCB ||
+	    pmu_dev->inf->type == PMU_TYPE_IOB ||
+	    pmu_dev->inf->type == PMU_TYPE_IOB_SLOW)
+		xgene_pmu_v3_write_agent1msk(pmu_dev, (u32)GET_AGENT1ID(event));
+}
+
+static void xgene_perf_enable_event(struct perf_event *event)
+{
+	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
+
+	xgene_pmu_write_evttype(pmu_dev, GET_CNTR(event), GET_EVENTID(event));
+	if (pmu_dev->parent->version == PCP_PMU_V3)
+		xgene_pmu_v3_select_agent(event);
+	else
+		xgene_pmu_select_agent(event);
 
 	xgene_pmu_enable_counter(pmu_dev, GET_CNTR(event));
 	xgene_pmu_enable_counter_int(pmu_dev, GET_CNTR(event));
@@ -595,7 +1008,7 @@ static void xgene_perf_event_set_period(struct perf_event *event)
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
 	struct hw_perf_event *hw = &event->hw;
 	/*
-	 * The X-Gene PMU counters have a period of 2^32. To account for the
+	 * The X-Gene PMU counters have a period of 2^32 or more. To account for the
 	 * possiblity of extreme interrupt latency we program for a period of
 	 * half that. Hopefully we can handle the interrupt before another 2^31
 	 * events occur and the counter overtakes its previous value.
@@ -603,7 +1016,7 @@ static void xgene_perf_event_set_period(struct perf_event *event)
 	u64 val = 1ULL << 31;
 
 	local64_set(&hw->prev_count, val);
-	xgene_pmu_write_counter(pmu_dev, hw->idx, (u32) val);
+	xgene_pmu_write_counter(pmu_dev, hw->idx, val);
 }
 
 static void xgene_perf_event_update(struct perf_event *event)
@@ -647,7 +1060,7 @@ static void xgene_perf_start(struct perf_event *event, int flags)
 		u64 prev_raw_count =  local64_read(&hw->prev_count);
 
 		xgene_pmu_write_counter(pmu_dev, GET_CNTR(event),
-					(u32) prev_raw_count);
+					prev_raw_count);
 	}
 
 	xgene_perf_enable_event(event);
@@ -713,7 +1126,10 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 {
 	struct xgene_pmu *xgene_pmu;
 
-	pmu_dev->max_period = PMU_CNT_MAX_PERIOD - 1;
+	if (pmu_dev->parent->version == PCP_PMU_V3)
+		pmu_dev->max_period = PMU_V3_CNT_MAX_PERIOD;
+	else
+		pmu_dev->max_period = PMU_CNT_MAX_PERIOD;
 	/* First version PMU supports only single event counter */
 	xgene_pmu = pmu_dev->parent;
 	if (xgene_pmu->version == PCP_PMU_V1)
@@ -758,20 +1174,48 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 
 	switch (pmu->inf->type) {
 	case PMU_TYPE_L3C:
-		pmu->attr_groups = l3c_pmu_attr_groups;
+		if (!(xgene_pmu->l3c_active_mask & pmu->inf->enable_mask))
+			goto dev_err;
+		if (xgene_pmu->version == PCP_PMU_V3) {
+			pmu->attr_groups = l3c_pmu_v3_attr_groups;
+			pmu->default_agentid = PCPPMU_V3_L3C_DEFAULT_AGENTID;
+		} else {
+			pmu->attr_groups = l3c_pmu_attr_groups;
+		}
 		break;
 	case PMU_TYPE_IOB:
-		pmu->attr_groups = iob_pmu_attr_groups;
+		if (xgene_pmu->version == PCP_PMU_V3) {
+			pmu->attr_groups = iob_fast_pmu_v3_attr_groups;
+			pmu->default_agentid = PCPPMU_V3_IOB_DEFAULT_AGENTID;
+		} else {
+			pmu->attr_groups = iob_pmu_attr_groups;
+		}
+		break;
+	case PMU_TYPE_IOB_SLOW:
+		if (xgene_pmu->version == PCP_PMU_V3) {
+			pmu->attr_groups = iob_slow_pmu_v3_attr_groups;
+			pmu->default_agentid = PCPPMU_V3_IOB_SLOW_DEFAULT_AGENTID;
+		}
 		break;
 	case PMU_TYPE_MCB:
 		if (!(xgene_pmu->mcb_active_mask & pmu->inf->enable_mask))
 			goto dev_err;
-		pmu->attr_groups = mcb_pmu_attr_groups;
+		if (xgene_pmu->version == PCP_PMU_V3) {
+			pmu->attr_groups = mcb_pmu_v3_attr_groups;
+			pmu->default_agentid = PCPPMU_V3_MCB_DEFAULT_AGENTID;
+		} else {
+			pmu->attr_groups = mcb_pmu_attr_groups;
+		}
 		break;
 	case PMU_TYPE_MC:
 		if (!(xgene_pmu->mc_active_mask & pmu->inf->enable_mask))
 			goto dev_err;
-		pmu->attr_groups = mc_pmu_attr_groups;
+		if (xgene_pmu->version == PCP_PMU_V3) {
+			pmu->attr_groups = mc_pmu_v3_attr_groups;
+			pmu->default_agentid = PCPPMU_V3_MC_DEFAULT_AGENTID;
+		} else {
+			pmu->attr_groups = mc_pmu_attr_groups;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -798,15 +1242,21 @@ static void _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
 	u32 pmovsr;
 	int idx;
 
-	pmovsr = readl(pmu_dev->inf->csr + PMU_PMOVSR) & PMU_OVERFLOW_MASK;
+	if (xgene_pmu->version == PCP_PMU_V3)
+		pmovsr = readl(pmu_dev->inf->csr + PMU_PMOVSSET) & PMU_OVERFLOW_MASK;
+	else
+		pmovsr = readl(pmu_dev->inf->csr + PMU_PMOVSR) & PMU_OVERFLOW_MASK;
+
 	if (!pmovsr)
 		return;
 
 	/* Clear interrupt flag */
 	if (xgene_pmu->version == PCP_PMU_V1)
 		writel(0x0, pmu_dev->inf->csr + PMU_PMOVSR);
-	else
+	else if (xgene_pmu->version == PCP_PMU_V2)
 		writel(pmovsr, pmu_dev->inf->csr + PMU_PMOVSR);
+	else
+		writel(pmovsr, pmu_dev->inf->csr + PMU_PMOVSCLR);
 
 	for (idx = 0; idx < PMU_MAX_COUNTERS; idx++) {
 		struct perf_event *event = pmu_dev->pmu_counter_event[idx];
@@ -822,6 +1272,7 @@ static void _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
 
 static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
 {
+	u32 intr_mcu, intr_mcb, intr_l3c, intr_iob;
 	struct xgene_pmu_dev_ctx *ctx;
 	struct xgene_pmu *xgene_pmu = dev_id;
 	unsigned long flags;
@@ -831,22 +1282,33 @@ static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
 
 	/* Get Interrupt PMU source */
 	val = readl(xgene_pmu->pcppmu_csr + PCPPMU_INTSTATUS_REG);
-	if (val & PCPPMU_INT_MCU) {
+	if (xgene_pmu->version == PCP_PMU_V3) {
+		intr_mcu = PCPPMU_V3_INT_MCU;
+		intr_mcb = PCPPMU_V3_INT_MCB;
+		intr_l3c = PCPPMU_V3_INT_L3C;
+		intr_iob = PCPPMU_V3_INT_IOB;
+	} else {
+		intr_mcu = PCPPMU_INT_MCU;
+		intr_mcb = PCPPMU_INT_MCB;
+		intr_l3c = PCPPMU_INT_L3C;
+		intr_iob = PCPPMU_INT_IOB;
+	}
+	if (val & intr_mcu) {
 		list_for_each_entry(ctx, &xgene_pmu->mcpmus, next) {
 			_xgene_pmu_isr(irq, ctx->pmu_dev);
 		}
 	}
-	if (val & PCPPMU_INT_MCB) {
+	if (val & intr_mcb) {
 		list_for_each_entry(ctx, &xgene_pmu->mcbpmus, next) {
 			_xgene_pmu_isr(irq, ctx->pmu_dev);
 		}
 	}
-	if (val & PCPPMU_INT_L3C) {
+	if (val & intr_l3c) {
 		list_for_each_entry(ctx, &xgene_pmu->l3cpmus, next) {
 			_xgene_pmu_isr(irq, ctx->pmu_dev);
 		}
 	}
-	if (val & PCPPMU_INT_IOB) {
+	if (val & intr_iob) {
 		list_for_each_entry(ctx, &xgene_pmu->iobpmus, next) {
 			_xgene_pmu_isr(irq, ctx->pmu_dev);
 		}
@@ -857,12 +1319,14 @@ static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int acpi_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
+static int acpi_pmu_probe_active_mcb_mcu_l3c(struct xgene_pmu *xgene_pmu,
 					 struct platform_device *pdev)
 {
 	void __iomem *csw_csr, *mcba_csr, *mcbb_csr;
 	struct resource *res;
 	unsigned int reg;
+	u32 mcb0routing;
+	u32 mcb1routing;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	csw_csr = devm_ioremap_resource(&pdev->dev, res);
@@ -871,41 +1335,66 @@ static int acpi_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
 		return PTR_ERR(csw_csr);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	mcba_csr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mcba_csr)) {
-		dev_err(&pdev->dev, "ioremap failed for MCBA CSR resource\n");
-		return PTR_ERR(mcba_csr);
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	mcbb_csr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mcbb_csr)) {
-		dev_err(&pdev->dev, "ioremap failed for MCBB CSR resource\n");
-		return PTR_ERR(mcbb_csr);
-	}
-
 	reg = readl(csw_csr + CSW_CSWCR);
-	if (reg & CSW_CSWCR_DUALMCB_MASK) {
-		/* Dual MCB active */
-		xgene_pmu->mcb_active_mask = 0x3;
-		/* Probe all active MC(s) */
-		reg = readl(mcbb_csr + CSW_CSWCR);
-		xgene_pmu->mc_active_mask =
-			(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0xF : 0x5;
+	if (xgene_pmu->version == PCP_PMU_V3) {
+		mcb0routing = CSW_CSWCR_MCB0_ROUTING(reg);
+		mcb1routing = CSW_CSWCR_MCB0_ROUTING(reg);
+		if (reg & CSW_CSWCR_DUALMCB_MASK) {
+			xgene_pmu->mcb_active_mask = 0x3;
+			xgene_pmu->l3c_active_mask = 0xFF;
+			if ((mcb0routing == 0x2) && (mcb1routing == 0x2))
+				xgene_pmu->mc_active_mask = 0xFF;
+			else if ((mcb0routing == 0x1) && (mcb1routing == 0x1))
+				xgene_pmu->mc_active_mask =  0x33;
+			else
+				xgene_pmu->mc_active_mask =  0x11;
+
+		} else {
+			xgene_pmu->mcb_active_mask = 0x1;
+			xgene_pmu->l3c_active_mask = 0x0F;
+			if ((mcb0routing == 0x2) && (mcb1routing == 0x0))
+				xgene_pmu->mc_active_mask = 0x0F;
+			else if ((mcb0routing == 0x1) && (mcb1routing == 0x0))
+				xgene_pmu->mc_active_mask =  0x03;
+			else
+				xgene_pmu->mc_active_mask =  0x01;
+		}
 	} else {
-		/* Single MCB active */
-		xgene_pmu->mcb_active_mask = 0x1;
-		/* Probe all active MC(s) */
-		reg = readl(mcba_csr + CSW_CSWCR);
-		xgene_pmu->mc_active_mask =
-			(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0x3 : 0x1;
-	}
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		mcba_csr = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mcba_csr)) {
+			dev_err(&pdev->dev, "ioremap failed for MCBA CSR resource\n");
+			return PTR_ERR(mcba_csr);
+		}
 
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+		mcbb_csr = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mcbb_csr)) {
+			dev_err(&pdev->dev, "ioremap failed for MCBB CSR resource\n");
+			return PTR_ERR(mcbb_csr);
+		}
+
+		xgene_pmu->l3c_active_mask = 0x1;
+		if (reg & CSW_CSWCR_DUALMCB_MASK) {
+			/* Dual MCB active */
+			xgene_pmu->mcb_active_mask = 0x3;
+			/* Probe all active MC(s) */
+			reg = readl(mcbb_csr + CSW_CSWCR);
+			xgene_pmu->mc_active_mask =
+				(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0xF : 0x5;
+		} else {
+			/* Single MCB active */
+			xgene_pmu->mcb_active_mask = 0x1;
+			/* Probe all active MC(s) */
+			reg = readl(mcba_csr + CSW_CSWCR);
+			xgene_pmu->mc_active_mask =
+				(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0x3 : 0x1;
+		}
+	}
 	return 0;
 }
 
-static int fdt_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
+static int fdt_pmu_probe_active_mcb_mcu_l3c(struct xgene_pmu *xgene_pmu,
 					struct platform_device *pdev)
 {
 	struct regmap *csw_map, *mcba_map, *mcbb_map;
@@ -930,6 +1419,7 @@ static int fdt_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
 		return PTR_ERR(mcbb_map);
 	}
 
+	xgene_pmu->l3c_active_mask = 0x1;
 	if (regmap_read(csw_map, CSW_CSWCR, &reg))
 		return -EINVAL;
 
@@ -958,8 +1448,8 @@ static int xgene_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
 					  struct platform_device *pdev)
 {
 	if (has_acpi_companion(&pdev->dev))
-		return acpi_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
-	return fdt_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
+		return acpi_pmu_probe_active_mcb_mcu_l3c(xgene_pmu, pdev);
+	return fdt_pmu_probe_active_mcb_mcu_l3c(xgene_pmu, pdev);
 }
 
 static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
@@ -969,6 +1459,8 @@ static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
 		return devm_kasprintf(dev, GFP_KERNEL, "l3c%d", id);
 	case PMU_TYPE_IOB:
 		return devm_kasprintf(dev, GFP_KERNEL, "iob%d", id);
+	case PMU_TYPE_IOB_SLOW:
+		return devm_kasprintf(dev, GFP_KERNEL, "iob-slow%d", id);
 	case PMU_TYPE_MCB:
 		return devm_kasprintf(dev, GFP_KERNEL, "mcb%d", id);
 	case PMU_TYPE_MC:
@@ -1059,13 +1551,19 @@ static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
 	if (acpi_bus_get_status(adev) || !adev->status.present)
 		return AE_OK;
 
-	if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
+	if ((!strcmp(acpi_device_hid(adev), "APMC0D5D")) ||
+	    (!strcmp(acpi_device_hid(adev), "APMC0D84")))
 		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
+	else if ((!strcmp(acpi_device_hid(adev), "APMC0D5E")) ||
+		 (!strcmp(acpi_device_hid(adev), "APMC0D85")))
 		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
+	else if (!strcmp(acpi_device_hid(adev), "APMC0D86"))
+		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB_SLOW);
+	else if ((!strcmp(acpi_device_hid(adev), "APMC0D5F")) ||
+		 (!strcmp(acpi_device_hid(adev), "APMC0D87")))
 		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
-	else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
+	else if ((!strcmp(acpi_device_hid(adev), "APMC0D60")) ||
+		 (!strcmp(acpi_device_hid(adev), "APMC0D88")))
 		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);
 	else
 		ctx = NULL;
@@ -1086,6 +1584,9 @@ static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
 	case PMU_TYPE_IOB:
 		list_add(&ctx->next, &xgene_pmu->iobpmus);
 		break;
+	case PMU_TYPE_IOB_SLOW:
+		list_add(&ctx->next, &xgene_pmu->iobpmus);
+		break;
 	case PMU_TYPE_MCB:
 		list_add(&ctx->next, &xgene_pmu->mcbpmus);
 		break;
@@ -1207,6 +1708,9 @@ static int fdt_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
 		case PMU_TYPE_IOB:
 			list_add(&ctx->next, &xgene_pmu->iobpmus);
 			break;
+		case PMU_TYPE_IOB_SLOW:
+			list_add(&ctx->next, &xgene_pmu->iobpmus);
+			break;
 		case PMU_TYPE_MCB:
 			list_add(&ctx->next, &xgene_pmu->mcbpmus);
 			break;
@@ -1245,6 +1749,7 @@ static int xgene_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
 static const struct acpi_device_id xgene_pmu_acpi_match[] = {
 	{"APMC0D5B", PCP_PMU_V1},
 	{"APMC0D5C", PCP_PMU_V2},
+	{"APMC0D83", PCP_PMU_V3},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
-- 
1.9.1
