From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:11 +0100
Subject: [PATCH 16/39] arm/imx/audmux-v1: use SoC-prefixed names
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Makefile    |    1 -
 arch/arm/plat-mxc/audmux-v1.c |   14 ++++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 7322bca..5d28dbf 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -14,6 +14,5 @@ obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
-CFLAGS_audmux-v1.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 CFLAGS_audmux-v2.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
index da6387d..b62917c 100644
--- a/arch/arm/plat-mxc/audmux-v1.c
+++ b/arch/arm/plat-mxc/audmux-v1.c
@@ -50,8 +50,18 @@ EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
 
 static int mxc_audmux_v1_init(void)
 {
-	if (cpu_is_mx27() || cpu_is_mx21())
-		audmux_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
+#ifdef CONFIG_MACH_MX21
+	if (cpu_is_mx21())
+		audmux_base = MX21_IO_ADDRESS(MX21_AUDMUX_BASE_ADDR);
+	else
+#endif
+#ifdef CONFIG_MACH_MX27
+	if (cpu_is_mx27())
+		audmux_base = MX27_IO_ADDRESS(MX27_AUDMUX_BASE_ADDR);
+	else
+#endif
+		(void)0;
+	
 	return 0;
 }
 
-- 
1.6.6.2
