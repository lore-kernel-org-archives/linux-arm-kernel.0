From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 21 Feb 2012 17:04:56 +0800
Subject: [PATCH 7/7] ARM: mmp: enable rtc
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1329815096-6200-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sa1100 rtc driver on pxa910.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa910.h    |    1 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h |    1 +
 arch/arm/mach-mmp/pxa910.c                 |   27 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/ttc_dkb.c                |    1 +
 4 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 4de13ab..e2e1f1e 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -22,6 +22,7 @@ extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
 
 extern struct platform_device pxa910_device_gpio;
+extern struct platform_device pxa910_device_rtc;
 
 static inline int pxa910_add_uart(int id)
 {
diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h b/arch/arm/mach-mmp/include/mach/regs-apbc.h
index 1a96585..8a37fb0 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
@@ -57,6 +57,7 @@
 #define APBC_PXA910_SSP1	APBC_REG(0x01c)
 #define APBC_PXA910_SSP2	APBC_REG(0x020)
 #define APBC_PXA910_IPC		APBC_REG(0x024)
+#define APBC_PXA910_RTC		APBC_REG(0x028)
 #define APBC_PXA910_TWSI0	APBC_REG(0x02c)
 #define APBC_PXA910_KPC		APBC_REG(0x030)
 #define APBC_PXA910_TIMERS	APBC_REG(0x034)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 3241a25..d147265 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -92,6 +92,7 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
 static APBC_CLK(gpio, PXA910_GPIO, 0, 13000000);
+static APBC_CLK(rtc, PXA910_RTC, 8, 32768);
 
 static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(u2o, USB, 0x1b, 480000000);
@@ -109,6 +110,7 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
+	INIT_CLKREG(&clk_rtc, "pxa910-rtc", NULL),
 };
 
 static int __init pxa910_init(void)
@@ -183,3 +185,28 @@ struct platform_device pxa910_device_gpio = {
 	.num_resources	= ARRAY_SIZE(pxa910_resource_gpio),
 	.resource	= pxa910_resource_gpio,
 };
+
+static struct resource pxa910_resource_rtc[] = {
+	{
+		.start	= 0xd4010000,
+		.end	= 0xd401003f,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PXA910_RTC_INT,
+		.end	= IRQ_PXA910_RTC_INT,
+		.name	= "rtc 1Hz",
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= IRQ_PXA910_RTC_ALARM,
+		.end	= IRQ_PXA910_RTC_ALARM,
+		.name	= "rtc alarm",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa910_device_rtc = {
+	.name		= "pxa910-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa910_resource_rtc),
+	.resource	= pxa910_resource_rtc,
+};
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 5ac5d58..e72c709 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -124,6 +124,7 @@ static struct platform_device ttc_dkb_device_onenand = {
 
 static struct platform_device *ttc_dkb_devices[] = {
 	&pxa910_device_gpio,
+	&pxa910_device_rtc,
 	&ttc_dkb_device_onenand,
 };
 
-- 
1.7.0.4
