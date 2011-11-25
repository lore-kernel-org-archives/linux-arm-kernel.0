From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 25 Nov 2011 17:56:25 +0000
Subject: [PATCH] ARM: S3C64xx: Power gate unused domains
Message-ID: <1322243785-849-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C64xx CPUs have power gating support with a series of software
controllable power domains in the SoC. To take full advantage of these
we should implement runtime PM support but since several of the IP blocks
have no in tree drivers (and at this point aren't likely to acquire such
drivers) we can get some benefit from the hardware much more easily if
we just turn those blocks off unconditionally. This will cut down on the
leakage these domains generate without interfering with active usage.

Do this for:
 - Domain G: 3D acceleration
 - Domain V: MFC
 - Domain I: JPEG and camera interface
 - Domain P: 2D acceleration, TV encoder and scaler

This is easy to reverse if any of these devices do acquire drivers in the
future or as part of out of tree patches for them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/pm.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index b375cd5..0868d13 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -89,6 +89,8 @@ static struct sleep_save misc_save[] = {
 
 	SAVE_ITEM(S3C64XX_SDMA_SEL),
 	SAVE_ITEM(S3C64XX_MODEM_MIFPCON),
+
+	SAVE_ITEM(S3C64XX_NORMAL_CFG),
 };
 
 void s3c_pm_configure_extint(void)
@@ -181,10 +183,23 @@ static void s3c64xx_pm_prepare(void)
 
 static int s3c64xx_pm_init(void)
 {
+	u32 val;
+
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
 	pm_uart_udivslot = 1;
 
+	/*
+	 * Unconditionally disable power domains that contain only
+	 * blocks which have no mainline driver support.
+	 */
+	val = __raw_readl(S3C64XX_NORMAL_CFG);
+	val &= ~(S3C64XX_NORMALCFG_DOMAIN_G_ON |
+		 S3C64XX_NORMALCFG_DOMAIN_V_ON |
+		 S3C64XX_NORMALCFG_DOMAIN_I_ON |
+		 S3C64XX_NORMALCFG_DOMAIN_P_ON);
+	__raw_writel(val, S3C64XX_NORMAL_CFG);
+
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 	gpio_request(S3C64XX_GPN(12), "DEBUG_LED0");
 	gpio_request(S3C64XX_GPN(13), "DEBUG_LED1");
-- 
1.7.7.3
