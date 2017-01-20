From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 16:56:40 +0100
Subject: [PATCH 3/6] rtc: sun6i: Disable the build as a module
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Message-ID: <de1e4b4eda6307b664c40d6c4502058f6bb88c60.1484927680.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have to provide the clock very early on, the RTC driver cannot be
built as a module. Make sure that won't happen.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/Kconfig     |  2 +-
 drivers/rtc/rtc-sun6i.c | 17 +----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c93c5a8fba32..53e35c138ff3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1434,7 +1434,7 @@ config RTC_DRV_SUN4V
 	  based RTC on SUN4V systems.
 
 config RTC_DRV_SUN6I
-	tristate "Allwinner A31 RTC"
+	bool "Allwinner A31 RTC"
 	default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
 	depends on ARCH_SUNXI
 	help
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 872d18609183..edd5627da10f 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -554,15 +554,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun6i_rtc_remove(struct platform_device *pdev)
-{
-	struct sun6i_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(chip->rtc);
-
-	return 0;
-}
-
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
@@ -571,15 +562,9 @@ MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
 
 static struct platform_driver sun6i_rtc_driver = {
 	.probe		= sun6i_rtc_probe,
-	.remove		= sun6i_rtc_remove,
 	.driver		= {
 		.name		= "sun6i-rtc",
 		.of_match_table = sun6i_rtc_dt_ids,
 	},
 };
-
-module_platform_driver(sun6i_rtc_driver);
-
-MODULE_DESCRIPTION("sun6i RTC driver");
-MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun6i_rtc_driver);
-- 
git-series 0.8.11
