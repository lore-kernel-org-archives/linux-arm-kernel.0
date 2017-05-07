From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:37:33 +0800
Subject: [PATCH v2] drm/rockchip: analogix_dp: add supports for regulators in
 edp IP
Message-ID: <20170507143733.11594-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found if eDP_AVDD_1V0 and eDP_AVDD_1V8 are not been power at
RK3288, once trying to enable the pclk clock, the kernel would dead.
This patch would try to enable them first.

The eDP_AVDD_1V8 is used for eDP phy, and the eDP_AVDD_1V0 are used
both for eDP phy and controller.

Change-Id: I4e8a34609d5b292d7da77385ff15bebbf258090c
Signed-off-by: Randy Li <ayaka@soulik.info>
Signed-off-by: Randy Li <randy.li@rock-chips.com>
---
 .../display/rockchip/analogix_dp-rockchip.txt      |  4 ++
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 52 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
index 47665a1..0dbbfb3 100644
--- a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
@@ -34,6 +34,10 @@ Optional property for different chips:
 - clock-names: from common clock binding:
 	       Required elements: "grf"
 
+- vcc-supply: Regulator for eDP_AVDD_1V0.
+
+- vccio-supply: Regulator for eDP_AVDD_1V8.
+
 For the below properties, please refer to Analogix DP binding document:
  * Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
 - phys (required)
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index d8fa7a9..2dad625 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -17,6 +17,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
 
@@ -70,6 +71,8 @@ struct rockchip_dp_device {
 	struct clk               *grfclk;
 	struct regmap            *grf;
 	struct reset_control     *rst;
+	struct regulator         *vcc_supply;
+	struct regulator         *vccio_supply;
 
 	struct work_struct	 psr_work;
 	spinlock_t		 psr_lock;
@@ -146,6 +149,24 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 
 	cancel_work_sync(&dp->psr_work);
 
+	if (!IS_ERR(dp->vcc_supply)) {
+		ret = regulator_enable(dp->vcc_supply);
+		if (ret) {
+			dev_err(dp->dev,
+				"failed to enable vcc regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!IS_ERR(dp->vccio_supply)) {
+		ret = regulator_enable(dp->vccio_supply);
+		if (ret) {
+			dev_err(dp->dev,
+				"failed to enable vccio regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
 		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
@@ -168,6 +189,11 @@ static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 
 	clk_disable_unprepare(dp->pclk);
 
+	if (!IS_ERR(dp->vccio_supply))
+		regulator_disable(dp->vccio_supply);
+	if (!IS_ERR(dp->vcc_supply))
+		regulator_disable(dp->vcc_supply);
+
 	return 0;
 }
 
@@ -323,6 +349,32 @@ static int rockchip_dp_init(struct rockchip_dp_device *dp)
 		return PTR_ERR(dp->rst);
 	}
 
+	dp->vcc_supply = devm_regulator_get_optional(dev, "vcc");
+	dp->vccio_supply = devm_regulator_get_optional(dev, "vccio");
+
+	if (IS_ERR(dp->vcc_supply)) {
+		dev_err(dev, "failed to get vcc regulator: %ld\n",
+			PTR_ERR(dp->vcc_supply));
+	} else {
+		ret = regulator_enable(dp->vcc_supply);
+		if (ret) {
+			dev_err(dev,
+				"failed to enable vcc regulator: %d\n", ret);
+			return ret;
+		}
+	}
+	if (IS_ERR(dp->vccio_supply)) {
+		dev_err(dev, "failed to get vccio regulator: %ld\n",
+			PTR_ERR(dp->vccio_supply));
+	} else {
+		ret = regulator_enable(dp->vccio_supply);
+		if (ret) {
+			dev_err(dev,
+				"failed to enable vccio regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
 		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
-- 
2.9.3
