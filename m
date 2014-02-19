From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 19 Feb 2014 12:17:03 +0000
Subject: [PATCH 2/2] drivers: cci: Export CCI PMU revision
In-Reply-To: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
References: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1392812223-29274-3-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The event numbering changed between revision r0 and r1 of the CCI
PMU. Expose this to userspace to allow tooling to handle the
differences in event numbers.

Suggested-by: Drew Richardson <Drew.Richardson@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 drivers/bus/arm-cci.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index da485ae..5a86da9 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -31,7 +31,6 @@
 
 #define DRIVER_NAME		"CCI-400"
 #define DRIVER_NAME_PMU		DRIVER_NAME " PMU"
-#define PMU_NAME		"CCI_400"
 
 #define CCI_PORT_CTRL		0x0
 #define CCI_CTRL_STATUS		0xc
@@ -162,6 +161,15 @@ static struct pmu_port_event_ranges port_event_range[] = {
 	},
 };
 
+/*
+ * Export different PMU names for the different revisions so userspace knows
+ * because the event ids are different
+ */
+static char *const pmu_names[] = {
+	[CCI_REV_R0] = "CCI_400",
+	[CCI_REV_R1] = "CCI_400_r1",
+};
+
 struct cci_pmu_drv_data {
 	void __iomem *base;
 	struct arm_pmu *cci_pmu;
@@ -520,7 +528,7 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 static int cci_pmu_init(struct arm_pmu *cci_pmu, struct platform_device *pdev)
 {
 	*cci_pmu = (struct arm_pmu){
-		.name             = PMU_NAME,
+		.name		  = pmu_names[probe_cci_revision()],
 		.max_period       = (1LLU << 32) - 1,
 		.get_hw_events    = pmu_get_hw_events,
 		.get_event_idx    = pmu_get_event_idx,
-- 
1.7.10.4
