From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 30 Aug 2017 15:55:52 +0530
Subject: [net-next PATCHv6 1/2] dt-bindings: net: Add DT bindings for
 Socionext Netsec
In-Reply-To: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
References: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <1504088752-6204-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for Device-Tree bindings for the
Socionext NetSec Controller driver.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../devicetree/bindings/net/socionext-netsec.txt   | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/socionext-netsec.txt

diff --git a/Documentation/devicetree/bindings/net/socionext-netsec.txt b/Documentation/devicetree/bindings/net/socionext-netsec.txt
new file mode 100644
index 0000000..12d596c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socionext-netsec.txt
@@ -0,0 +1,46 @@
+* Socionext NetSec Ethernet Controller IP
+
+Required properties:
+- compatible: Should be "socionext,netsecv5"
+- reg: Address and length of the register sets, the first is the main
+	registers, then the rdlar and tdlar regions for the SoC
+- interrupts: Should contain ethernet controller interrupt
+- clocks: phandle to any clocks to be switched by runtime_pm
+- phy-mode: See ethernet.txt file in the same directory
+- max-speed: See ethernet.txt file in the same directory
+- max-frame-size: See ethernet.txt file in the same directory, if 9000 or
+	above jumbo frames are enabled
+- local-mac-address: See ethernet.txt file in the same directory
+- phy-handle: phandle to select child phy
+
+Optional properties:
+- use-jumbo: Boolean property to suggest if jumbo packets should be used or not
+
+For the child phy
+
+- compatible "ethernet-phy-ieee802.3-c22" is needed
+- device_type "ethernet-phy"
+- reg: phy address
+
+
+Example:
+	eth0: ethernet {
+		compatible = "socionext,netsecv5";
+		reg = <0 0x31600000 0x10000>, <0 0x31618000 0x4000>, <0 0x3161c000 0x4000>;
+		interrupts = <0 163 0x4>;
+		clocks = <&clk_alw_0_8>;
+		phy-mode = "rgmii";
+		max-speed = <1000>;
+		max-frame-size = <9000>;
+		local-mac-address = [ a4 17 31 00 00 ed ];
+		phy-handle = <&ethphy0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 1 {
+			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
-- 
2.7.4
