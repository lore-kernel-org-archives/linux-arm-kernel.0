From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Nov 2011 12:12:39 -0700
Subject: [PATCH v2 1/2] arm/dt: add basic usb nodes to tegra device trees
Message-ID: <1320433960-18173-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now they are a minimal binding. It needs to be amended with
vendor-specific settings for phy setup and link tuning, etc.

v2: Added bindings specification and phy_type properties

Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/usb/tegra-usb.txt          |   13 ++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts               |    4 +++
 arch/arm/boot/dts/tegra20.dtsi                     |   21 ++++++++++++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/tegra-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/tegra-usb.txt b/Documentation/devicetree/bindings/usb/tegra-usb.txt
new file mode 100644
index 0000000..035d63d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/tegra-usb.txt
@@ -0,0 +1,13 @@
+Tegra SOC USB controllers
+
+The device node for a USB controller that is part of a Tegra
+SOC is as described in the document "Open Firmware Recommended
+Practice : Universal Serial Bus" with the following modifications
+and additions :
+
+Required properties :
+ - compatible : Should be "nvidia,tegra20-ehci" for USB controllers
+   used in host mode.
+ - phy_type : Should be one of "ulpi" or "utmi".
+ - nvidia,vbus-gpio : If present, specifies a gpio that needs to be
+   activated for the bus to be powered.
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index a72299b..88c682a 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -29,4 +29,8 @@
 	sdhci at c8000600 {
 		support-8bit;
 	};
+
+	usb at c5000000 {
+		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
+	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 65d7e6a..795b921 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -143,5 +143,26 @@
 		reg = <0xc8000600 0x200>;
 		interrupts = < 63 >;
 	};
+
+	usb at c5000000 {
+		compatible = "nvidia,tegra20-ehci", "usb-ehci";
+		reg = <0xc5000000 0x4000>;
+		interrupts = < 52 >;
+		phy_type = "utmi";
+	};
+
+	usb at c5004000 {
+		compatible = "nvidia,tegra20-ehci", "usb-ehci";
+		reg = <0xc5004000 0x4000>;
+		interrupts = < 53 >;
+		phy_type = "ulpi";
+	};
+
+	usb at c5008000 {
+		compatible = "nvidia,tegra20-ehci", "usb-ehci";
+		reg = <0xc5008000 0x4000>;
+		interrupts = < 129 >;
+		phy_type = "utmi";
+	};
 };
 
-- 
1.7.4.1
