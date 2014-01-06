From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:39:16 +0100
Subject: [PATCH 3/5] ARM: S3C24XX: add common reset function
In-Reply-To: <3105326.uFdOVLyXH8@phil>
References: <3105326.uFdOVLyXH8@phil>
Message-ID: <3212735.MOokUY2h0f@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function first tries to use a swrst-block if available, then
a watchdog-reset and at the end a soft_restart as last measure.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.c |   26 ++++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/common.h |    2 ++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index a7b1269..a3b1d98 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -587,3 +587,29 @@ struct platform_device s3c2410_device_dclk = {
 	.resource	= s3c2410_dclk_resource,
 };
 #endif
+
+/*
+ * Some S3C24XX-SoCs have a special software-reset register and
+ * all of them seem to support the watchdog reset.
+ */
+void s3c24xx_restart(enum reboot_mode mode, const char *cmd)
+{
+	if (mode == REBOOT_SOFT)
+		soft_restart(0);
+
+	if (s3c24xx_swrst_reset_available()) {
+		pr_debug("s3c24xx: trying swrst-reset\n");
+		s3c24xx_swrst_reset();
+		/* delay to allow the serial port to show the message */
+		mdelay(50);
+	}
+
+#ifdef CONFIG_SAMSUNG_WDT_RESET
+	pr_debug("s3c24xx: trying watchdog-reset\n");
+	samsung_wdt_reset();
+	mdelay(50);
+#endif
+
+	/* we'll take a jump through zero as a poor second */
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index caf1534..20829a8 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -147,4 +147,6 @@ static inline void s3c24xx_swrst_reset_init(void __iomem *base,
 					     bool is_s3c2412) {}
 #endif
 
+void s3c24xx_restart(enum reboot_mode mode, const char *cmd);
+
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
-- 
1.7.10.4
