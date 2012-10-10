From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Oct 2012 13:42:23 +0200
Subject: [PATCH 2/8] mfd: db8500: Provide cpufreq table as platform data
In-Reply-To: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349869349-8070-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The cpufreq table needs dynamically update due to what the PRCMU
firmware is supporting. The table is then provided through to the
mfd child device as platform data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/db8500-prcmu.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 00b8b0f..53c24c4 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -31,6 +31,7 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
+#include <linux/cpufreq.h>
 #include <asm/hardware/gic.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -3002,6 +3003,15 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
 	},
 };
 
+/* CPU FREQ table, may be changed due to if MAX_OPP is supported. */
+static struct cpufreq_frequency_table db8500_cpufreq_table[] = {
+	{ .frequency = 200000, .index = ARM_EXTCLK,},
+	{ .frequency = 400000, .index = ARM_50_OPP,},
+	{ .frequency = 800000, .index = ARM_100_OPP,},
+	{ .frequency = CPUFREQ_TABLE_END,}, /* To be used for MAX_OPP. */
+	{ .frequency = CPUFREQ_TABLE_END,},
+};
+
 static struct resource ab8500_resources[] = {
 	[0] = {
 		.start	= IRQ_DB8500_AB8500,
@@ -3020,6 +3030,8 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 	{
 		.name = "cpufreq-u8500",
 		.of_compatible = "stericsson,cpufreq-u8500",
+		.platform_data = &db8500_cpufreq_table,
+		.pdata_size = sizeof(db8500_cpufreq_table),
 	},
 	{
 		.name = "ab8500-core",
@@ -3030,6 +3042,14 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 	},
 };
 
+static void db8500_prcmu_update_cpufreq(void)
+{
+	if (prcmu_has_arm_maxopp()) {
+		db8500_cpufreq_table[3].frequency = 1000000;
+		db8500_cpufreq_table[3].index = ARM_MAX_OPP;
+	}
+}
+
 /**
  * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
  *
@@ -3074,6 +3094,8 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	if (cpu_is_u8500v20_or_later())
 		prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
+	db8500_prcmu_update_cpufreq();
+
 	err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
 			      ARRAY_SIZE(db8500_prcmu_devs), NULL, 0, NULL);
 	if (err) {
-- 
1.7.10
