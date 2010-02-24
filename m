From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:12 +0100
Subject: [PATCH 17/39] arm/imx/audmux-v2: use SoC-prefixed names
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Makefile    |    1 -
 arch/arm/plat-mxc/audmux-v2.c |    9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 5d28dbf..f9c604a 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -15,4 +15,3 @@ obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
-CFLAGS_audmux-v2.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index b06954a..d983cd6 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -190,7 +190,10 @@ static int mxc_audmux_v2_init(void)
 {
 	int ret;
 
-	if (cpu_is_mx35()) {
+	if (cpu_is_mx31())
+		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
+
+	else if (cpu_is_mx35()) {
 		audmux_clk = clk_get(NULL, "audmux");
 		if (IS_ERR(audmux_clk)) {
 			ret = PTR_ERR(audmux_clk);
@@ -198,11 +201,9 @@ static int mxc_audmux_v2_init(void)
 					ret);
 			return ret;
 		}
+		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
 	}
 
-	if (cpu_is_mx31() || cpu_is_mx35())
-		audmux_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
-
 	audmux_debugfs_init();
 
 	return 0;
-- 
1.6.6.2
