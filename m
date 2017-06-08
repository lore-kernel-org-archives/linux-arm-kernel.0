From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jun 2017 18:51:25 +0200
Subject: [PATCH 4/4] arm64: dts: marvell: armada-3720-db: Add vqmmc regulator
 for SD slot
In-Reply-To: <20170608165125.27630-1-gregory.clement@free-electrons.com>
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
Message-ID: <20170608165125.27630-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding this regulator, the SD cards are usable at higher speed
protocols such as SDR104.

This patch was tested with an SD HC card compatible with UHS-I.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index eab3bc7e6382..9df0f06ce607 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -80,6 +80,20 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&exp_usb3_vbus>;
 	};
+
+	vcc_sd_reg1: regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vcc_sd1";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpiosb 23 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
 };
 
 /* Gigabit module on CON19(V2.0)/CON21(V1.4) */
@@ -164,6 +178,7 @@
 	cd-gpios = <&gpiosb 2 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	marvell,pad-type = "sd";
+	vqmmc-supply = <&vcc_sd_reg1>;
 	status = "okay";
 };
 
-- 
2.11.0
