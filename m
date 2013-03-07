From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:23 -0300
Subject: [PATCH 3/5] ARM: mvebu: Add support for NOR flash device on Armada
 XP-GP board
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1362660865-2755-4-git-send-email-ezequiel.garcia@free-electrons.com>
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
---
 arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..6972515 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -109,5 +109,17 @@
 				spi-max-frequency = <108000000>;
 			};
 		};
+
+		device-bus at d0010400 {
+			status = "okay";
+			ranges = <0 0 0xf0000000 0x01000000>; /* CS0 @addr 0xf000000, size 0x1000000 */
+
+			/* CS0, 16 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x01000000>;
+				bank-width = <2>;
+			};
+		};
 	};
 };
-- 
1.7.8.6
