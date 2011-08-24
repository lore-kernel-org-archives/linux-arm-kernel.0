From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:46:40 +0200
Subject: [PATCH 2/2] ARM i.MX audmux v2: remove unnecessary ifdefs
In-Reply-To: <1314168400-14889-1-git-send-email-s.hauer@pengutronix.de>
References: <1314168400-14889-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314168400-14889-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These were present to be able to compile this file on different
SoCs. They are not needed anymore.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/audmux-v2.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 175e364..8cced35 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -187,18 +187,11 @@ EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
 static int mxc_audmux_v2_init(void)
 {
 	int ret;
-#if defined(CONFIG_ARCH_MX5)
 	if (cpu_is_mx51()) {
 		audmux_base = MX51_IO_ADDRESS(MX51_AUDMUX_BASE_ADDR);
-		ret = 0;
-		return ret;
-	}
-#endif
-#if defined(CONFIG_ARCH_MX3)
-	if (cpu_is_mx31())
+	} else if (cpu_is_mx31()) {
 		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
-
-	else if (cpu_is_mx35()) {
+	} else if (cpu_is_mx35()) {
 		audmux_clk = clk_get(NULL, "audmux");
 		if (IS_ERR(audmux_clk)) {
 			ret = PTR_ERR(audmux_clk);
@@ -207,10 +200,7 @@ static int mxc_audmux_v2_init(void)
 			return ret;
 		}
 		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
-	}
-#endif
-#if defined(CONFIG_SOC_IMX25)
-	if (cpu_is_mx25()) {
+	} else if (cpu_is_mx25()) {
 		audmux_clk = clk_get(NULL, "audmux");
 		if (IS_ERR(audmux_clk)) {
 			ret = PTR_ERR(audmux_clk);
@@ -220,7 +210,7 @@ static int mxc_audmux_v2_init(void)
 		}
 		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
 	}
-#endif /* if defined(CONFIG_SOC_IMX25) */
+
 	audmux_debugfs_init();
 
 	return 0;
-- 
1.7.5.4
