From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:54 +0100
Subject: [PATCH 09/18] arm: mvebu: enable the SD card slot on Armada 370 DB
 board
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP DB evaluation board has one SD card slot, directly
connected to the SDIO IP of the SoC, so we add a device tree
description for it.

However, in the default configuration of the board, the SD card slot
is not usable: the connector plugged into CON40 must be changed
against a different one, provided with the board by the
manufacturer. Since such a manual modification of the hardware is
needed, we did not enable the SDIO interface by default, and left it
to the board user to modify the Device Tree if needed. Since this
board is really only an evaluation board for developers and not a
final product, it is not too bad.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 0004402..43ff156 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -59,5 +59,20 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+
+		mvsdio at d00d4000 {
+			pinctrl-0 = <&sdio_pins1>;
+			pinctrl-names = "default";
+			/*
+			 * This device is disabled by default, because
+			 * using the SD card connector requires
+			 * changing the default CON40 connector
+			 * "DB-88F6710_MPP_2xRGMII_DEVICE_Jumper" to a
+			 * different connector
+			 * "DB-88F6710_MPP_RGMII_SD_Jumper".
+			 */
+			status = "disabled";
+			/* No CD or WP GPIOs */
+		};
 	};
 };
-- 
1.7.9.5
