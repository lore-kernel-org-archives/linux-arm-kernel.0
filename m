From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 31 May 2014 21:03:31 +0200
Subject: [PATCH v2 1/4] dt: bindings: mmc: Document the practice of using
 subnodes for slots
In-Reply-To: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following existing MMC host controller bindings use slot subnodes:

Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt

This commit documents this practice in the standard mmc bindings documentation.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..44c9e53 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -60,7 +60,31 @@ Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
-Example:
+
+Use of slot subnodes
+--------------------
+
+Some hosts have multiple MMC slots connected to a single MMC host, in this
+case each slot gets its own subnode representing the slot:
+
+Required host node properties when using slots:
+- #address-cells: should be one. The cell is the slot id.
+- #size-cells: should be zero.
+
+Required slot subnode properties:
+- reg: Must contain the MMC host slot number of the slot this subnode
+       describes. Slot numbers start at 0.
+
+Optional slot subnode properties:
+Any of the optional host node properties can be used inside a slot node too,
+if a property is specified at both the host and the slot level the slot
+level takes precedence.
+
+
+Examples
+--------
+
+Basic example:
 
 sdhci at ab000000 {
 	compatible = "sdhci";
@@ -74,3 +98,23 @@ sdhci at ab000000 {
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
 }
+
+Example with slot subnodes:
+
+mmc0: mmc at f0008000 {
+	compatible = "atmel,hsmci";
+	reg = <0xf0008000 0x600>;
+	interrupts = <12 4>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		cd-gpios = <&pioD 15 0>
+		cd-inverted;
+	};
+	slot at 1 {
+		reg = <1>;
+		bus-width = <4>;
+	};
+};
-- 
2.0.0
