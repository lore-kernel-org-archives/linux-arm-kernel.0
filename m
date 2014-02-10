From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Feb 2014 22:54:40 +0100
Subject: [PATCH 1/5] ARM: omap2: cm-t35: Add regulators and clock for camera
 sensor
In-Reply-To: <1392069284-18024-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1392069284-18024-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1392069284-18024-2-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The camera sensor will soon require regulators and clocks. Register
fixed regulators for its VAA and VDD power supplies and a fixed rate
clock for its master clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/board-cm-t35.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8dd0ec8..018353d 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -16,6 +16,8 @@
  *
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -542,8 +544,22 @@ static struct isp_platform_data cm_t35_isp_pdata = {
 	.subdevs = cm_t35_isp_subdevs,
 };
 
+static struct regulator_consumer_supply cm_t35_camera_supplies[] = {
+	REGULATOR_SUPPLY("vaa", "3-005d"),
+	REGULATOR_SUPPLY("vdd", "3-005d"),
+};
+
 static void __init cm_t35_init_camera(void)
 {
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "mt9t001-clkin", NULL, CLK_IS_ROOT,
+				      48000000);
+	clk_register_clkdev(clk, NULL, "3-005d");
+
+	regulator_register_fixed(2, cm_t35_camera_supplies,
+				 ARRAY_SIZE(cm_t35_camera_supplies));
+
 	if (omap3_init_camera(&cm_t35_isp_pdata) < 0)
 		pr_warn("CM-T3x: Failed registering camera device!\n");
 }
-- 
1.8.3.2
