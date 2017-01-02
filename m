From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  2 Jan 2017 23:03:43 +0000
Subject: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to 8K DMA buffer
In-Reply-To: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Unlike the A64 user manual reports, the third MMC controller on the
A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
This does not affect the other two controllers, so introduce a new
DT compatible string to let the driver use different settings for that
particular device. This will also help to enable the high-speed transfer
modes of that controller later.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
 drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 55cdd80..3d9170f 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -14,6 +14,7 @@ Required properties:
    * "allwinner,sun7i-a20-mmc"
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-mmc"
+   * "allwinner,sun50i-a64-emmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 1e156e8..165486bc 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1097,12 +1097,19 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.can_calibrate = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.clk_delays = sun50i_mmc_clk_delays,
+	.can_calibrate = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.8.2
