From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 26 Sep 2018 21:31:02 +0200
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: document Broadcom Northstar pin
 mux controller
Message-ID: <20180926193103.21241-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Northstar has mux controller just like Northstar Plus and Northstar2.
It's a bit different though (different registers & pins) so it requires
its own binding.

It's needed to allow other block bindings specify required mux setup.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
V2: Use "cru_gpio_control"
    Add more functions & groups
    Include Florian's Reviewed-by
V3: Use 3 different bindings as available pins depend on the chipset.
    Strings match Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
---
 .../bindings/pinctrl/brcm,bcm4708-pinmux.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
new file mode 100644
index 000000000000..af906f196e8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
@@ -0,0 +1,42 @@
+Broadcom Northstar pins mux controller
+
+Some of Northstar SoCs's pins can be used for various purposes thanks to the mux
+controller. This binding allows describing mux controller and listing available
+functions. They can be referenced later by other bindings to let system
+configure controller correctly.
+
+A list of pins varies across chipsets so few bindings are available.
+
+Required properties:
+- compatible: must be one of:
+	"brcm,bcm4708-pinmux"
+	"brcm,bcm4709-pinmux"
+	"brcm,bcm53012-pinmux"
+- reg: iomem address range of CRU (Central Resource Unit) pin registers
+- reg-names: "cru_gpio_control" - the only needed & supported reg right now
+
+Functions and their groups available for all chipsets:
+- "spi": "spi_grp"
+- "i2c": "i2c_grp"
+- "pwm": "pwm0_grp", "pwm1_grp", "pwm2_grp", "pwm3_grp"
+- "uart1": "uart1_grp"
+
+Additionally available on BCM4709 and BCM53012:
+- "mdio": "mdio_grp"
+- "uart2": "uart2_grp"
+- "sdio": "sdio_pwr_grp", "sdio_1p8v_grp"
+
+For documentation of subnodes see:
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	pinctrl at 1800c1c0 {
+		compatible = "brcm,bcm4708-pinmux";
+		reg = <0x1800c1c0 0x24>;
+		reg-names = "cru_gpio_control";
+
+		spi {
+			function = "spi";
+			groups = "spi_grp";
+		};
+	};
-- 
2.13.7
