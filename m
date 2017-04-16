From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:27:08 +0200
Subject: [PATCH 18/29] arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI
 matching data
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-18-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to deal with ACPI enabled platforms suffering from the
HISILICON_ERRATUM_161010101, let's add the required OEM data that
allow the workaround to be enabled.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: dann frazier <dann.frazier@canonical.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 887f6d0..bf9e9d7 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -270,6 +270,29 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 {
 	return __hisi_161010101_read_reg(cntvct_el0);
 }
+
+static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
+	/*
+	 * Note that trailing spaces are required to properly match
+	 * the OEM table information.
+	 */
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP05   ",
+		.oem_revision	= 0,
+	},
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP06   ",
+		.oem_revision	= 0,
+	},
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP07   ",
+		.oem_revision	= 0,
+	},
+	{ /* Sentinel indicating the end of the OEM array */ },
+};
 #endif
 
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -347,6 +370,16 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
 		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
+	{
+		.match_type = ate_match_acpi_oem_info,
+		.id = hisi_161010101_oem_info,
+		.desc = "HiSilicon erratum 161010101",
+		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
+		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_set_next_event_tval_virt,
+	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
 	{
-- 
2.7.4
