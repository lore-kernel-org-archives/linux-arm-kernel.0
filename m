From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Tue, 17 Jan 2012 01:10:53 +0800
Subject: [PATCH] mx53_loco: add DA9053 PMIC support
In-Reply-To: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>
References: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>
Message-ID: <1326733853-13956-2-git-send-email-paul.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Add DA9052 PMIC support for Freescale QuickStart Loco board.
The model of PMIC on QuickStart Loco board is "da9053-aa".

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx53_loco.c   |  128 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/irqs.h |   10 +++-
 2 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index fd8b524..61dd8c9 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,10 +23,21 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/mfd/da9052/da9052.h>
+#include <linux/mfd/da9052/pdata.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/irqs.h>
+#include <mach/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -45,6 +56,32 @@
 #define LOCO_SD1_CD			IMX_GPIO_NR(3, 13)
 #define LOCO_ACCEL_EN			IMX_GPIO_NR(6, 14)
 
+#define DA9052_LDO1_VOLT_UPPER			1800
+#define DA9052_LDO1_VOLT_LOWER			600
+#define DA9052_LDO1_VOLT_STEP			50
+#define DA9052_LDO2_VOLT_UPPER			1800
+#define DA9052_LDO2_VOLT_LOWER			600
+#define DA9052_LDO2_VOLT_STEP			25
+#define DA9052_LDO34_VOLT_UPPER			3300
+#define DA9052_LDO34_VOLT_LOWER			1725
+#define DA9052_LDO34_VOLT_STEP			25
+#define DA9052_LDO567810_VOLT_UPPER		3600
+#define DA9052_LDO567810_VOLT_LOWER		1200
+#define DA9052_LDO567810_VOLT_STEP		50
+#define DA9052_LDO9_VOLT_STEP			50
+#define DA9052_LDO9_VOLT_LOWER			1250
+#define DA9052_LDO9_VOLT_UPPER			3650
+/* Buck Config Validation Macros */
+#define DA9052_BUCK_CORE_PRO_VOLT_UPPER		2075
+#define DA9052_BUCK_CORE_PRO_VOLT_LOWER		500
+#define DA9052_BUCK_CORE_PRO_STEP		25
+#define DA9052_BUCK_MEM_VOLT_UPPER		2500
+#define DA9052_BUCK_MEM_VOLT_LOWER		925
+#define DA9052_BUCK_MEM_STEP			25
+#define DA9052_BUCK_PERI_VOLT_UPPER		2500
+#define DA9052_BUCK_PERI_VOLT_LOWER		925
+#define DA9052_BUCK_PERI_STEP			25
+
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	/* FEC */
 	MX53_PAD_FEC_MDC__FEC_MDC,
@@ -227,6 +264,93 @@ static const struct esdhc_platform_data mx53_loco_sd3_data __initconst = {
 	.wp_type = ESDHC_WP_GPIO,
 };
 
+#define DA9052_LDO(max, min, rname, suspend_mv) \
+{\
+	.constraints = {\
+		.name		= (rname), \
+		.max_uV		= (max) * 1000,\
+		.min_uV		= (min) * 1000,\
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE\
+		|REGULATOR_CHANGE_STATUS | REGULATOR_CHANGE_MODE,\
+		.valid_modes_mask = REGULATOR_MODE_NORMAL,\
+		.state_mem = { \
+			.uV = suspend_mv * 1000, \
+			.mode = REGULATOR_MODE_NORMAL, \
+			.enabled = (0 == suspend_mv) ? 0 : 1, \
+			.disabled = 0, \
+		}, \
+	},\
+}
+
+/* currently the suspend_mv here takes no effects for DA9053
+preset-voltage have to be done in the latest stage during
+suspend*/
+static struct regulator_init_data da9052_regulators_init[] = {
+	/* BUCKS */
+	DA9052_LDO(DA9052_BUCK_CORE_PRO_VOLT_UPPER,
+		   DA9052_BUCK_CORE_PRO_VOLT_LOWER, "DA9052_BUCK_CORE", 850),
+	DA9052_LDO(DA9052_BUCK_CORE_PRO_VOLT_UPPER,
+		   DA9052_BUCK_CORE_PRO_VOLT_LOWER, "DA9052_BUCK_PRO", 950),
+	DA9052_LDO(DA9052_BUCK_MEM_VOLT_UPPER,
+		   DA9052_BUCK_MEM_VOLT_LOWER, "DA9052_BUCK_MEM", 1500),
+	DA9052_LDO(DA9052_BUCK_PERI_VOLT_UPPER,
+		   DA9052_BUCK_PERI_VOLT_LOWER, "DA9052_BUCK_PERI", 2500),
+	DA9052_LDO(DA9052_LDO1_VOLT_UPPER,
+		   DA9052_LDO1_VOLT_LOWER, "DA9052_LDO1", 1300),
+	DA9052_LDO(DA9052_LDO2_VOLT_UPPER,
+		   DA9052_LDO2_VOLT_LOWER, "DA9052_LDO2", 1300),
+	DA9052_LDO(DA9052_LDO34_VOLT_UPPER,
+		   DA9052_LDO34_VOLT_LOWER, "DA9052_LDO3", 3300),
+	DA9052_LDO(DA9052_LDO34_VOLT_UPPER,
+		   DA9052_LDO34_VOLT_LOWER, "DA9052_LDO4", 2775),
+	DA9052_LDO(DA9052_LDO567810_VOLT_UPPER,
+		   DA9052_LDO567810_VOLT_LOWER, "DA9052_LDO5", 1300),
+	DA9052_LDO(DA9052_LDO567810_VOLT_UPPER,
+		   DA9052_LDO567810_VOLT_LOWER, "DA9052_LDO6", 1200),
+	DA9052_LDO(DA9052_LDO567810_VOLT_UPPER,
+		   DA9052_LDO567810_VOLT_LOWER, "DA9052_LDO7", 2750),
+	DA9052_LDO(DA9052_LDO567810_VOLT_UPPER,
+		   DA9052_LDO567810_VOLT_LOWER, "DA9052_LDO8", 1800),
+	DA9052_LDO(DA9052_LDO9_VOLT_UPPER,
+		   DA9052_LDO9_VOLT_LOWER, "DA9052_LDO9", 2500),
+	DA9052_LDO(DA9052_LDO567810_VOLT_UPPER,
+		   DA9052_LDO567810_VOLT_LOWER, "DA9052_LDO10", 1200),
+};
+
+#define MX53_LOCO_DA9052_IRQ			(6*32 + 11)	/* GPIO7_11 */
+
+static int __init loco_da9052_init(struct da9052 *da9052)
+{
+	/* Configuring for DA9052 interrupt servce */
+	/* s3c_gpio_setpull(DA9052_IRQ_PIN, S3C_GPIO_PULL_UP); */
+
+	/* Set interrupt as LOW LEVEL interrupt source */
+	irq_set_irq_type(gpio_to_irq(MX53_LOCO_DA9052_IRQ),
+			 IRQF_TRIGGER_LOW);
+	return 0;
+}
+
+static struct da9052_pdata __initdata da9052_plat = {
+	.init = loco_da9052_init,
+	.irq_base = MXC_PMIC_IRQ_START,
+	.regulators = {
+		&da9052_regulators_init[0],
+		&da9052_regulators_init[1],
+		&da9052_regulators_init[2],
+		&da9052_regulators_init[3],
+		&da9052_regulators_init[4],
+		&da9052_regulators_init[5],
+		&da9052_regulators_init[6],
+		&da9052_regulators_init[7],
+		&da9052_regulators_init[8],
+		&da9052_regulators_init[9],
+		&da9052_regulators_init[10],
+		&da9052_regulators_init[11],
+		&da9052_regulators_init[12],
+		&da9052_regulators_init[13],
+	},
+};
+
 static inline void mx53_loco_fec_reset(void)
 {
 	int ret;
@@ -273,6 +397,10 @@ static struct i2c_board_info mx53loco_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("mma8450", 0x1C),
 	},
+	{
+		I2C_BOARD_INFO("da9053-aa", 0x90 >> 1),
+		.platform_data = &da9052_plat,
+	},
 };
 
 static void __init mx53_loco_board_init(void)
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index fd9efb0..9fb56eb 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -53,7 +53,15 @@
 #endif
 /* REVISIT: Add IPU irqs on IMX51 */
 
-#define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
+#define MXC_PMIC_IRQ_START	(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
+
+#ifdef CONFIG_MACH_MX53_LOCO
+#define MXC_PMIC_IRQS 32
+#else
+#define MXC_PMIC_IRQS 0
+#endif
+
+#define NR_IRQS			(MXC_PMIC_IRQ_START + MXC_PMIC_IRQS)
 
 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
 
-- 
1.7.8.3
