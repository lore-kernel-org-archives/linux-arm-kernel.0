From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 23 Jun 2013 12:32:28 +0400
Subject: [PATCH v2 2/3] ARM: imx: Using proper clocks for RTC driver
In-Reply-To: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
References: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371976349-18679-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX RTC driver requires 32k clock for time function and optional
clock for module itself. This patch fixes these clock names for the
driver and adds missing definitions.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx1.c  | 2 +-
 arch/arm/mach-imx/clk-imx21.c | 3 ++-
 arch/arm/mach-imx/clk-imx27.c | 3 ++-
 arch/arm/mach-imx/clk-imx31.c | 3 ++-
 arch/arm/mach-imx/clk-imx35.c | 2 ++
 drivers/rtc/rtc-mxc.c         | 2 +-
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 15f9d22..b001a8d 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -106,7 +106,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[dummy], "ahb", "imx1-fb.0");
 	clk_register_clkdev(clk[hclk], "mshc", NULL);
 	clk_register_clkdev(clk[per3], "ssi", NULL);
-	clk_register_clkdev(clk[clk32], NULL, "imx1-rtc.0");
+	clk_register_clkdev(clk[clk32], "rtc", "imx1-rtc");
 	clk_register_clkdev(clk[clko], "clko", NULL);
 
 	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index d7ed660..a88f331 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -172,7 +172,8 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[emma_gate], "emma", NULL);
 	clk_register_clkdev(clk[slcdc_gate], "slcdc", NULL);
 	clk_register_clkdev(clk[gpio_gate], "gpio", NULL);
-	clk_register_clkdev(clk[rtc_gate], "rtc", NULL);
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[csi_hclk_gate], "csi", NULL);
 	clk_register_clkdev(clk[ssi1_gate], "ssi1", NULL);
 	clk_register_clkdev(clk[ssi2_gate], "ssi2", NULL);
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index c3cfa41..f1c01c4 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -283,7 +283,8 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
 	clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);
 	clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
-	clk_register_clkdev(clk[rtc_ipg_gate], NULL, "imx21-rtc");
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_ipg_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
 	clk_register_clkdev(clk[cpu_div], NULL, "cpufreq-cpu0.0");
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index b5b65f3..3f2676d 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -134,7 +134,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
 	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[rtc_gate], NULL, "imx21-rtc");
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
 	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
 	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 2193c83..2e5af91 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -258,6 +258,8 @@ int __init mx35_clocks_init(void)
 	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
 	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 
 	clk_prepare_enable(clk[spba_gate]);
 	clk_prepare_enable(clk[gpio1_gate]);
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 90b0222..b4da99c 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -317,7 +317,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
 
-	pdata->clk_rtc = devm_clk_get(&pdev->dev, NULL);
+	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
 	if (IS_ERR(pdata->clk_rtc)) {
 		dev_err(&pdev->dev, "Unable to get clock!\n");
 		return PTR_ERR(pdata->clk_rtc);
-- 
1.8.1.5
