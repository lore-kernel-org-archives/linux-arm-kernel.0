From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 29 Jun 2013 12:40:43 +0400
Subject: [PATCH v3 3/5] ARM: imx: Using proper clocks for RTC driver
In-Reply-To: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372495244-21215-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX RTC driver requires 32k clock for time function and optional
clock for module itself. This patch fixes these clock names for the
driver and adds missing definitions.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx31.c | 3 ++-
 arch/arm/mach-imx/clk-imx35.c | 2 ++
 drivers/rtc/rtc-mxc.c         | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

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
index f333581..80c6f1f 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -343,7 +343,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
 
-	pdata->clk_rtc = devm_clk_get(&pdev->dev, NULL);
+	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
 	if (IS_ERR(pdata->clk_rtc)) {
 		dev_err(&pdev->dev, "Unable to get clock!\n");
 		return PTR_ERR(pdata->clk_rtc);
-- 
1.8.1.5
