From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Aug 2017 15:57:41 +0200
Subject: [PATCH] arm64: dts: marvell: armada-3720-db: Add vmmc regulator for
 SD slot
Message-ID: <20170829135741.4263-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding this regulator, a proper reset is done during boot. Without
this, the UHS failed to be detected after a warm reboot when the SD card
remained in the slot, then it fallback to an HS.

Note that the vmcc is supported by the xenon driver only with the
following fix: "mmc: sdhci-xenon: add set_power callback".

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 9df0f06ce607..e6e0f38ce6e1 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -94,6 +94,16 @@
 			  3300000 0x0>;
 		enable-active-high;
 	};
+
+	vcc_sd_reg2: regulator-vmcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sd2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 /* Gigabit module on CON19(V2.0)/CON21(V1.4) */
@@ -179,6 +189,7 @@
 	bus-width = <4>;
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vcc_sd_reg1>;
+	vmmc-supply = <&vcc_sd_reg2>;
 	status = "okay";
 };
 
-- 
2.14.1
