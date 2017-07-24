From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 21:59:01 +0800
Subject: [PATCH v3 06/10] mmc: sunxi: Add support for A83T eMMC (MMC2)
In-Reply-To: <20170724135905.28855-1-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Message-ID: <20170724135905.28855-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third MMC controller (MMC2) on the Allwinner A83T SoC is slightly
different. It supports a wider 8-bit bus, has a dedicated controllable
reset pin for eMMC, and a "new timing mode" which is supposed to deliver
better signals and thus better performance.

Add a compatible for this one to use the new timing mode not found in the
other controllers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
 drivers/mmc/host/sunxi-mmc.c                        | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 7d53a799f140..63b57e2a10fb 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -12,6 +12,7 @@ Required properties:
    * "allwinner,sun4i-a10-mmc"
    * "allwinner,sun5i-a13-mmc"
    * "allwinner,sun7i-a20-mmc"
+   * "allwinner,sun8i-a83t-emmc"
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-emmc"
    * "allwinner,sun50i-a64-mmc"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 11587a69a1fd..de187ed77040 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1117,6 +1117,13 @@ static const struct sunxi_mmc_cfg sun7i_a20_cfg = {
 	.can_calibrate = false,
 };
 
+static const struct sunxi_mmc_cfg sun8i_a83t_emmc_cfg = {
+	.idma_des_size_bits = 16,
+	.clk_delays = sunxi_mmc_clk_delays,
+	.can_calibrate = false,
+	.has_timings_switch = true,
+};
+
 static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = sun9i_mmc_clk_delays,
@@ -1141,6 +1148,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-emmc", .data = &sun8i_a83t_emmc_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
-- 
2.13.3
