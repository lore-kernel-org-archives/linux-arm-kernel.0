From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jan 2017 11:41:46 +0100
Subject: [PATCH v2 1/7] rtc: sun6i: Disable the build as a module
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ad6de80f5065d8aa1ac7babca05e5f19b6038820.1485168100.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have to provide the clock very early on, the RTC driver cannot be
built as a module. Make sure that won't happen.

Cc: stable at vger.kernel.org
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/Kconfig     | 2 +-
 drivers/rtc/rtc-sun6i.c | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

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
index c169a2cd4727..a6136cb99851 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -439,9 +439,4 @@ static struct platform_driver sun6i_rtc_driver = {
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
