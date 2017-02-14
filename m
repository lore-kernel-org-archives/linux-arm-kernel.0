From: andrei-tiberiu.breana@nxp.com (Tiberiu Breana)
Date: Tue, 14 Feb 2017 11:01:13 +0200
Subject: [PATCH 2/2] Add AXI address filter support for MMDC profiling
In-Reply-To: <1487062873-27641-1-git-send-email-andrei-tiberiu.breana@nxp.com>
References: <1487062873-27641-1-git-send-email-andrei-tiberiu.breana@nxp.com>
Message-ID: <1487062873-27641-3-git-send-email-andrei-tiberiu.breana@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for an extra config parameter for perf commands:
axi_id, which will be written in the MMDC's MADPCR1 register,
to filter memory usage profiling (see i.MX6 reference manual,
chapter 44.7 MMDC Profiling for AXI id usage).

Signed-off-by: Tiberiu Breana <andrei-tiberiu.breana@nxp.com>
---
 arch/arm/mach-imx/mmdc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 89a926f..7826289 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright 2017 NXP
  * Copyright 2011,2016 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
@@ -47,6 +48,7 @@
 #define PROFILE_SEL		0x10
 
 #define MMDC_MADPCR0	0x410
+#define MMDC_MADPCR1	0x414
 #define MMDC_MADPSR0	0x418
 #define MMDC_MADPSR1	0x41C
 #define MMDC_MADPSR2	0x420
@@ -57,6 +59,7 @@
 #define MMDC_NUM_COUNTERS	6
 
 #define MMDC_FLAG_PROFILE_SEL	0x1
+#define MMDC_PRF_AXI_ID_CLEAR	0x0
 
 #define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
 
@@ -161,8 +164,11 @@ static struct attribute_group mmdc_pmu_events_attr_group = {
 };
 
 PMU_FORMAT_ATTR(event, "config:0-63");
+PMU_FORMAT_ATTR(axi_id, "config1:0-63");
+
 static struct attribute *mmdc_pmu_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_axi_id.attr,
 	NULL,
 };
 
@@ -345,6 +351,14 @@ static void mmdc_pmu_event_start(struct perf_event *event, int flags)
 
 	writel(DBG_RST, reg);
 
+	/*
+	 * Write the AXI id parameter to MADPCR1.
+	 */
+	val = event->attr.config1;
+	reg = mmdc_base + MMDC_MADPCR1;
+	writel(val, reg);
+
+	reg = mmdc_base + MMDC_MADPCR0;
 	val = DBG_EN;
 	if (pmu_mmdc->devtype_data->flags & MMDC_FLAG_PROFILE_SEL)
 		val |= PROFILE_SEL;
@@ -382,6 +396,10 @@ static void mmdc_pmu_event_stop(struct perf_event *event, int flags)
 	reg = mmdc_base + MMDC_MADPCR0;
 
 	writel(PRF_FRZ, reg);
+
+	reg = mmdc_base + MMDC_MADPCR1;
+	writel(MMDC_PRF_AXI_ID_CLEAR, reg);
+
 	mmdc_pmu_event_update(event);
 }
 
-- 
2.7.4
