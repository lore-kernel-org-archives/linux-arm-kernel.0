From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 16 Jun 2016 18:53:27 +0530
Subject: [PATCH V2 4/4] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxim Max77620 has one 32KHz clock output and the clock HW
IP used on this PMIC is same as what it is there in the MAX77686.

Add clock driver support for MAX77620 on the MAX77686 driver.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes from V1:
- Updated based on changes done in first patch.
---
 drivers/clk/Kconfig        |  7 ++++---
 drivers/clk/clk-max77686.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 6afad74..d75f4c5 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -32,10 +32,11 @@ config COMMON_CLK_WM831X
 source "drivers/clk/versatile/Kconfig"
 
 config COMMON_CLK_MAX77686
-	tristate "Clock driver for Maxim 77686/77802 MFD"
-	depends on MFD_MAX77686
+	tristate "Clock driver for Maxim 77686/77802/MAX77620 MFD"
+	depends on MFD_MAX77686 || MFD_MAX77620
 	---help---
-	  This driver supports Maxim 77686/77802 crystal oscillator clock.
+	  This driver supports Maxim 77686/77802/MAX77620 crystal oscillator
+	  clock.
 
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK808"
diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 9aba3a8..19f6208 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/max77620.h>
 #include <linux/mfd/max77686.h>
 #include <linux/mfd/max77686-private.h>
 #include <linux/clk-provider.h>
@@ -35,12 +36,14 @@
 
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/clock/maxim,max77802.h>
+#include <dt-bindings/clock/maxim,max77620.h>
 
 #define MAX77802_CLOCK_LOW_JITTER_SHIFT 0x3
 
 enum max77686_chip_name {
 	CHIP_MAX77686,
 	CHIP_MAX77802,
+	CHIP_MAX77620,
 };
 
 struct max77686_hw_clk_info {
@@ -97,6 +100,15 @@ max77686_hw_clk_info max77802_hw_clks_info[MAX77802_CLKS_NUM] = {
 	},
 };
 
+static const struct
+max77686_hw_clk_info max77620_hw_clks_info[MAX77620_CLKS_NUM] = {
+	[MAX77620_CLK_32K_OUT0] = {
+		.name = "32khz_out0",
+		.clk_reg = MAX77620_REG_CNFG1_32K,
+		.clk_enable_mask = MAX77620_CNFG1_32K_OUT0_EN,
+	},
+};
+
 static struct max77686_clk_init_data *to_max77686_clk_init_data(
 				struct clk_hw *hw)
 {
@@ -181,6 +193,11 @@ static int max77686_clk_probe(struct platform_device *pdev)
 		hw_clks = max77802_hw_clks_info;
 		break;
 
+	case CHIP_MAX77620:
+		num_clks = MAX77620_CLKS_NUM;
+		hw_clks = max77620_hw_clks_info;
+		break;
+
 	default:
 		dev_err(dev, "Unknown Chip ID\n");
 		return -EINVAL;
@@ -284,6 +301,7 @@ static int max77686_clk_remove(struct platform_device *pdev)
 static const struct platform_device_id max77686_clk_id[] = {
 	{ "max77686-clk", .driver_data = CHIP_MAX77686, },
 	{ "max77802-clk", .driver_data = CHIP_MAX77802, },
+	{ "max77620-clock", .driver_data = CHIP_MAX77620, },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, max77686_clk_id);
-- 
2.1.4
