From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Sep 2013 11:33:31 +0800
Subject: [PATCH 2/3] ARM: imx6q: clock and Kconfig update for PCIe support
In-Reply-To: <1380166412-13586-1-git-send-email-shawn.guo@linaro.org>
References: <1380166412-13586-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1380166412-13586-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Cross <xobs@kosagi.com>

Update imx6q clock initialization and Kconfig for PCIe support.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig     |    2 ++
 arch/arm/mach-imx/clk-imx6q.c |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 9f67338..f0896ec 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -801,6 +801,8 @@ config SOC_IMX6Q
 	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	select PINCTRL
 	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 0e7f3bc..b54d9bb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -622,6 +622,10 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	if (ret)
 		pr_warn("failed to set up CLKO: %d\n", ret);
 
+	/* All existing boards with PCIe use LVDS1 */
+	if (IS_ENABLED(CONFIG_PCI_IMX6))
+		clk_set_parent(clk[lvds1_sel], clk[sata_ref]);
+
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
 
-- 
1.7.9.5
