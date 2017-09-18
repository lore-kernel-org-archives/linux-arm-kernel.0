From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 18 Sep 2017 23:42:04 +0800
Subject: [PATCH] nvmem: sunxi-sid: add support for A64/H5's SID controller
Message-ID: <20170918154204.54427-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64/H5 SoCs come with a SID controller like the one in H3, but
without the silicon bug that makes the initial value at 0x200 wrong, so
the value at 0x200 can be directly read.

Add support for this kind of SID controller.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 drivers/nvmem/sunxi_sid.c                                       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index ef06d061913c..6ea0836939ee 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -5,6 +5,7 @@ Required properties:
   "allwinner,sun4i-a10-sid"
   "allwinner,sun7i-a20-sid"
   "allwinner,sun8i-h3-sid"
+  "allwinner,sun50i-a64-sid"
 
 - reg: Should contain registers location and length
 
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 0d6648be93b8..3c9fd4fb9207 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -199,10 +199,16 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
+static const struct sunxi_sid_cfg sun50i_a64_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.13.5
