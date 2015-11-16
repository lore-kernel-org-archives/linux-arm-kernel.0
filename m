From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Mon, 16 Nov 2015 14:06:51 -0500
Subject: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
In-Reply-To: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1447700814-5391-3-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently syscon has a fixed configuration of 32 bits for register and
values widths. In some cases, it would be desirable to be able to
customize the value width.

For example, certain boards (like the ones manufactured by Technologic
Systems) have a FPGA that is memory-mapped, but its registers are only
16-bit wide.

This patch adds an optional "bus-width" DT binding for syscon that
allows to change the width for the data bus (i.e. val_bits). If this
property is provided, it will also adjust the register stride to
bus-width / 8. If not provided, the default configuration is used.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
 drivers/mfd/syscon.c                             | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index fe8150b..4c9d187 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -13,6 +13,9 @@ Required properties:
 - compatible: Should contain "syscon".
 - reg: the register region can be accessed from syscon
 
+Optional property:
+- bus-width: width of the data bus. Can be <8>, <16>, <32>, or <64>.
+
 Examples:
 gpr: iomuxc-gpr at 020e0000 {
 	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 176bf0f..00b0995 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
+	u32 bus_width;
 	int ret;
 	struct regmap_config syscon_config = syscon_regmap_config;
 
@@ -69,6 +70,17 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	 else if (of_property_read_bool(np, "little-endian"))
 		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
 
+	 ret = of_property_read_u32(np, "bus-width", &bus_width);
+	 if (!ret) {
+		 /*
+		  * the property has been provided, regmap_init_mmio
+		  * will return an error if these values are invalid
+		  * so there is no need to check them here.
+		  */
+		 syscon_config.val_bits = bus_width;
+		 syscon_config.reg_stride = syscon_config.val_bits / 8;
+	 }
+
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
-- 
2.5.0
