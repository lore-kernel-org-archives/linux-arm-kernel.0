From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 15 Apr 2011 18:05:27 +0800
Subject: [PATCH 3/3] ARM: pxa: enable 1wire controller
In-Reply-To: <1302861927-6845-2-git-send-email-haojian.zhuang@marvell.com>
References: <2011041501>
	<1302861927-6845-1-git-send-email-haojian.zhuang@marvell.com>
	<1302861927-6845-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1302861927-6845-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support 1wire controller in both PXA3xx and PXA95x. Enable it in saarb
platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/devices.c                 |   12 ++++++++++++
 arch/arm/mach-pxa/devices.h                 |    1 +
 arch/arm/mach-pxa/include/mach/mfp-pxa930.h |    1 +
 arch/arm/mach-pxa/pxa3xx.c                  |    2 ++
 arch/arm/mach-pxa/pxa95x.c                  |    2 ++
 arch/arm/mach-pxa/saarb.c                   |   20 ++++++++++++++++++++
 6 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..451caa0 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1067,3 +1067,15 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
 	pd->dev.platform_data = info;
 	platform_device_add(pd);
 }
+
+static struct resource pxa3xx_resource_w1[] = {
+	{0x41b00000,	0x41b00013,	"ds1wm-mem", IORESOURCE_MEM,},
+	{IRQ_1WIRE,	IRQ_1WIRE,	"ds1wm-irq", IORESOURCE_IRQ,},
+};
+
+struct platform_device pxa3xx_device_w1 = {
+	.name		= "pxa3xx-w1",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa3xx_resource_w1),
+	.resource	= pxa3xx_resource_w1,
+};
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 2fd5a8b..3625e62 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -36,6 +36,7 @@ extern struct platform_device pxa27x_device_pwm1;
 
 extern struct platform_device pxa3xx_device_nand;
 extern struct platform_device pxa3xx_device_i2c_power;
+extern struct platform_device pxa3xx_device_w1;
 
 extern struct platform_device pxa3xx_device_gcu;
 
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
index 04f7c97..18bcb5d 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
@@ -493,6 +493,7 @@
 #define DF_ADDR2_CLK13MOUTDMD	MFP_CFG(DF_ADDR2, AF3)
 
 /* 1 wire */
+#define GPIO16_OW_DQ_IN		MFP_CFG(GPIO16, AF3)
 #define GPIO95_OW_DQ_IN		MFP_CFG(GPIO95, AF5)
 
 #endif /* __ASM_ARCH_MFP_PXA9xx_H */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 8dd1073..6f87659 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -57,6 +57,7 @@ static DEFINE_PXA3_CKEN(pxa3xx_pwm0, PWM0, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_pwm1, PWM1, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_mmc1, MMC1, 19500000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_mmc2, MMC2, 19500000, 0);
+static DEFINE_PXA3_CKEN(pxa3xx_w1, 1WIRE, 13000000, 0);
 
 static DEFINE_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
 static DEFINE_CK(pxa3xx_smemc, SMC, &clk_pxa3xx_smemc_ops);
@@ -89,6 +90,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_pxa3xx_w1, "pxa3xx-w1", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 23b229b..1477eef 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -214,6 +214,7 @@ static DEFINE_PXA3_CKEN(pxa95x_ssp3, SSP3, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_ssp4, SSP4, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_pwm0, PWM0, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_pwm1, PWM1, 13000000, 0);
+static DEFINE_PXA3_CKEN(pxa95x_w1, 1WIRE, 13000000, 0);
 
 static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
@@ -232,6 +233,7 @@ static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_ssp4, "pxa27x-ssp.3", NULL),
 	INIT_CLKREG(&clk_pxa95x_pwm0, "pxa27x-pwm.0", NULL),
 	INIT_CLKREG(&clk_pxa95x_pwm1, "pxa27x-pwm.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_w1, "pxa3xx-w1", NULL),
 };
 
 void __init pxa95x_init_irq(void)
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index f98ff38..e9b252d 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -12,9 +12,11 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/mfd/88pm860x.h>
+#include <linux/mfd/ds1wm.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -26,9 +28,14 @@
 #include <mach/gpio.h>
 
 #include "generic.h"
+#include "devices.h"
 
 #define SAARB_NR_IRQS	(IRQ_BOARD_START + 40)
 
+static mfp_cfg_t saarb_pin_config[] __initdata = {
+	GPIO16_OW_DQ_IN,
+};
+
 static struct pm860x_touch_pdata saarb_touch = {
 	.gpadc_prebias	= 1,
 	.slot_cycle	= 1,
@@ -95,11 +102,24 @@ static struct i2c_board_info saarb_i2c_info[] = {
 	},
 };
 
+static struct ds1wm_driver_data saarb_1wire_data = {
+	.active_high	= 1,
+};
+
+static struct platform_device *saarb_devices[] __initdata = {
+	&pxa3xx_device_w1,
+};
+
 static void __init saarb_init(void)
 {
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(saarb_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(saarb_i2c_info));
+
+	platform_device_add_data(&pxa3xx_device_w1, &saarb_1wire_data,
+				 sizeof(struct ds1wm_driver_data));
+	platform_add_devices(ARRAY_AND_SIZE(saarb_devices));
 }
 
 MACHINE_START(SAARB, "PXA955 Handheld Platform (aka SAARB)")
-- 
1.5.6.5
