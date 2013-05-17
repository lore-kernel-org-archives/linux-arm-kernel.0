From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 17 May 2013 08:09:58 -0300
Subject: [PATCH 2/2] ARM: mvebu: Add support for NOR flash device on Armada
 XP-DB board
In-Reply-To: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1368788998-4672-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP Development Board (DB-78460-BP) has a NOR flash device
connected to the Device Bus. This commit adds the device tree node
to support this device.

This SoC supports a flexible and dynamic decoding window allocation
scheme; but since this feature is still not implemented we need
to specify the window base address in the device tree node itself.

This base address has been selected in a completely arbitrary fashion.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index d6cc8bf..864831a 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,6 +30,9 @@
 	};
 
 	soc {
+		ranges = <0          0 0xd0000000 0x100000	/* Internal registers 1MiB */
+			  0xf0000000 0 0xf0000000 0x1000000>;	/* Device Bus, NOR 16MiB   */
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -155,6 +158,35 @@
 					status = "okay";
 				};
 			};
+
+			devbus-bootcs at 10400 {
+				status = "okay";
+				ranges = <0 0xf0000000 0x1000000>;
+
+				/* Device Bus parameters are required */
+
+				/* Read parameters */
+				devbus,bus-width    = <8>;
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
+
+				/* NOR 16 MiB */
+				nor at 0 {
+					compatible = "cfi-flash";
+					reg = <0 0x1000000>;
+					bank-width = <2>;
+				};
+			};
 		};
 	};
 };
-- 
1.8.1.5
