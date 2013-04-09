From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  9 Apr 2013 17:26:19 -0300
Subject: [PATCH v6 3/5] ARM: mvebu: Add support for NOR flash device on Armada
 XP-GP board
In-Reply-To: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365539181-29242-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP Development Board DB-MV784MP-GP has a NOR flash device
connected to the Device Bus. This commit adds the device tree node
to support this device.

This SoC supports a flexible and dynamic decoding window allocation
scheme; but since this feature is still not implemented we need
to specify the window base address in the device tree node itself.

This base address has been selected in a completely arbitrary fashion.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..e57e9c7 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -109,5 +109,34 @@
 				spi-max-frequency = <108000000>;
 			};
 		};
+
+		devbus-bootcs at d0010400 {
+			status = "okay";
+			ranges = <0 0xf0000000 0x1000000>; /* @addr 0xf000000, size 0x1000000 */
+
+			/* Device Bus parameters are required */
+
+			/* Read parameters */
+			devbus,bus-width    = <8>;
+			devbus,turn-off-ps  = <60000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <124000>;
+			devbus,acc-next-ps  = <248000>;
+			devbus,rd-setup-ps  = <0>;
+			devbus,rd-hold-ps   = <0>;
+
+			/* Write parameters */
+			devbus,sync-enable = <0>;
+			devbus,wr-high-ps  = <60000>;
+			devbus,wr-low-ps   = <60000>;
+			devbus,ale-wr-ps   = <60000>;
+
+			/* NOR 16 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x1000000>;
+				bank-width = <2>;
+			};
+		};
 	};
 };
-- 
1.8.1.5
