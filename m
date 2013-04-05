From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Apr 2013 18:11:59 -0300
Subject: [PATCH v2 4/5] ARM: mvebu: Add support for NOR flash device on
 Openblocks AX3 board
In-Reply-To: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365196320-15084-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Plat'home Openblocks AX3 has a 128 MiB NOR flash device connected
to the Device Bus. This commit adds the device tree node to support this device.

The SoC supports a flexible and dynamic decoding window allocation scheme;
but since this feature is still not implemented we need to specify the window
base address in the device tree node itself.
This base address has been selected in a completely arbitrary fashion.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 3818a82..53ad2a6 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -139,5 +139,34 @@
 		usb at d0051000 {
 			status = "okay";
 		};
+
+		device-bus at d0010400 {
+			status = "okay";
+			ranges = <0 0 0xf0000000 0x8000000>; /* CS0 @addr 0xf000000, size 0x8000000 */
+
+			/* CS0, 128 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x8000000>;
+				bank-width = <2>;
+
+				/* Device Bus parameters are required */
+
+				/* Read parameters */
+				devbus,dev-width    = <1>;
+				devbus,turn-off-ps  = <60000>;
+				devbus,badr-skew-ps = <0>;
+				devbus,acc-first-ps = <124000>;
+				devbus,acc-next-ps  = <248000>;
+				devbus,rd-setup-ps  = <0>;
+				devbus,rd-hold-ps   = <0>;
+
+				/* Write parameters */
+				devbus,sync-enable = <0>;
+				devbus,wr-high-ps  = <60000>;
+				devbus,wr-low-ps   = <60000>;
+				devbus,ale-wr-ps   = <60000>;
+			};
+		};
 	};
 };
-- 
1.8.1.5
