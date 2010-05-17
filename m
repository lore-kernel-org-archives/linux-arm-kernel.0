From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 17 May 2010 18:58:12 +0800
Subject: [PATCH] ARM: pxa: support more i2c devices on PXA95x
Message-ID: <mailman.455.1274095282.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In PXA95x, I2C #2 & #3 devices are added. Add IRQ and clock support of these
two I2C devices.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/devices.c                  |   39 ++++++++++++++++++++++++++
 arch/arm/mach-pxa/devices.h                  |    2 +
 arch/arm/mach-pxa/include/mach/irqs.h        |    2 +
 arch/arm/mach-pxa/include/mach/mfp-pxa930.h  |    6 ++++
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    4 ++
 arch/arm/mach-pxa/pxa3xx.c                   |    2 +-
 arch/arm/mach-pxa/pxa930.c                   |   15 +++++++++-
 arch/arm/mach-pxa/saarb.c                    |    3 ++
 drivers/i2c/busses/i2c-pxa.c                 |    1 +
 9 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 8e10db1..ee4a252 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -321,6 +321,45 @@ struct platform_device pxa3xx_device_i2c_power = {
 };
 #endif

+static struct resource pxa95x_resources_i2c2[] = {
+	{
+		.start	= 0x40401680,
+		.end	= 0x404016e3,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_I2C2,
+		.end	= IRQ_I2C2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* pxa95x_device_i2c2 doesn't co-exist with pxa3xx_device_i2c_power */
+struct platform_device pxa95x_device_i2c2 = {
+	.name		= "pxa95x-i2c",
+	.id		= 1,
+	.resource	= pxa95x_resources_i2c2,
+	.num_resources	= ARRAY_SIZE(pxa95x_resources_i2c2),
+};
+
+static struct resource pxa95x_resources_i2c3[] = {
+	{
+		.start	= 0x40801680,
+		.end	= 0x408016e3,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_I2C3,
+		.end	= IRQ_I2C3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa95x_device_i2c3 = {
+	.name		= "pxa95x-i2c",
+	.id		= 2,
+	.resource	= pxa95x_resources_i2c3,
+	.num_resources	= ARRAY_SIZE(pxa95x_resources_i2c3),
+};
+
 static struct resource pxai2s_resources[] = {
 	{
 		.start	= 0x40400000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 93817d9..2fe1b70 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -34,6 +34,8 @@ extern struct platform_device pxa27x_device_pwm1;

 extern struct platform_device pxa3xx_device_nand;
 extern struct platform_device pxa3xx_device_i2c_power;
+extern struct platform_device pxa95x_device_i2c2;
+extern struct platform_device pxa95x_device_i2c3;

 extern struct platform_device pxa3xx_device_gcu;

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index 010c205..c4785b8 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -102,7 +102,9 @@
 #endif

 #ifdef CONFIG_CPU_PXA950
+#define IRQ_I2C3	PXA_IRQ(61)	/* I2C #3 */
 #define IRQ_GC500	PXA_IRQ(70)	/* Graphics Controller (PXA950) */
+#define IRQ_I2C2	PXA_IRQ(78)	/* I2C #2 */
 #endif

 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
index 04f7c97..60c50c0 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
@@ -108,6 +108,12 @@
 #define GPIO97_CI2C_SCL		MFP_CFG_LPM(GPIO97, AF3, PULL_HIGH)
 #define GPIO98_CI2C_SDA		MFP_CFG_LPM(GPIO98, AF3, PULL_HIGH)

+#define GPIO98_CI2C_SCL		MFP_CFG_LPM(GPIO98, AF1, PULL_HIGH)
+#define GPIO99_CI2C_SDA		MFP_CFG_LPM(GPIO99, AF1, PULL_HIGH)
+
+#define GPIO98_HS2_I2C_SCL	MFP_CFG_LPM(GPIO98, AF2, PULL_HIGH)
+#define GPIO99_HS2_I2C_SDA	MFP_CFG_LPM(GPIO99, AF2, PULL_HIGH)
+
 /* QCI */
 #define GPIO63_CI_DD_9		MFP_CFG_LPM(GPIO63, AF1, PULL_LOW)
 #define GPIO64_CI_DD_8		MFP_CFG_LPM(GPIO64, AF1, PULL_LOW)
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
index e91d63c..a606021 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
@@ -211,4 +211,8 @@
 #define CKEN_PXA300_GCU		42	/* Graphics controller clock enable */
 #define CKEN_PXA320_GCU		7	/* Graphics controller clock enable */

+/* Note: I2C2/I2C3 is used in PXA95x */
+#define CKEN_I2C2	87	/* I2C2 clock enable */
+#define CKEN_I2C3	88	/* I2C3 clock enable */
+
 #endif /* __ASM_ARCH_PXA3XX_REGS_H */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f544e58..2c6e909 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -580,7 +580,7 @@ void __init pxa3xx_init_irq(void)
 	value |= (1 << 6);
 	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));

-	pxa_init_irq(56, pxa3xx_set_wake);
+	pxa_init_irq(96, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
 	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index 7d29dd3..560dbfb 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -18,6 +18,8 @@

 #include <mach/pxa930.h>

+#include "clock.h"
+
 static struct mfp_addr_map pxa930_mfp_addr_map[] __initdata = {

 	MFP_ADDR(GPIO0, 0x02e0),
@@ -190,6 +192,14 @@ static struct mfp_addr_map pxa935_mfp_addr_map[]
__initdata = {
 	MFP_ADDR_END,
 };

+static DEFINE_PXA3_CKEN(pxa95x_i2c2, I2C2, 32842000, 0);
+static DEFINE_PXA3_CKEN(pxa95x_i2c3, I2C3, 32842000, 0);
+
+static struct clk_lookup pxa95x_clkregs[] = {
+	INIT_CLKREG(&clk_pxa95x_i2c2, "pxa95x-i2c.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_i2c3, "pxa95x-i2c.2", NULL),
+};
+
 static int __init pxa930_init(void)
 {
 	if (cpu_is_pxa930() || cpu_is_pxa935() || cpu_is_pxa950()) {
@@ -197,9 +207,12 @@ static int __init pxa930_init(void)
 		mfp_init_addr(pxa930_mfp_addr_map);
 	}

-	if (cpu_is_pxa935())
+	if (cpu_is_pxa935() || cpu_is_pxa950())
 		mfp_init_addr(pxa935_mfp_addr_map);

+	if (cpu_is_pxa950())
+		clkdev_add_table(pxa95x_clkregs, ARRAY_SIZE(pxa95x_clkregs));
+
 	return 0;
 }

diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index 20438a7..bb90ff1 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -38,6 +38,9 @@ static mfp_cfg_t saarb_mfp_cfg[] __initdata = {
 	GPIO73_CI2C_SCL,
 	GPIO74_CI2C_SDA,

+	GPIO98_HS2_I2C_SCL,
+	GPIO99_HS2_I2C_SDA,
+
 	/* PMIC */
 	PMIC_INT_GPIO83,
 };
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 14d249f..ffac1d6 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -49,6 +49,7 @@

 static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "pxa2xx-i2c",		REG_SHIFT_1 },
+	{ "pxa95x-i2c",		REG_SHIFT_1 },
 	{ "pxa3xx-pwri2c",	REG_SHIFT_0 },
 	{ },
 };
-- 
1.5.6.5
