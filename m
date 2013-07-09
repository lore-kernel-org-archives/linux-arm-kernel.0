From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 13:26:54 +0900
Subject: [PATCH] ARM: shmobile: Add SMSC ethernet chip to KZM9D DT reference
Message-ID: <20130709042654.13658.20164.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for the SMSC ethernet controller found
on the KZM9D board to the KZM9D DT Reference code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of renesas-next-20130704v2 and
 [PATCH] ARM: shmobile: KZM9D DT reference implementation

 arch/arm/boot/dts/emev2-kzm9d-reference.dts |   31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- 0002/arch/arm/boot/dts/emev2-kzm9d-reference.dts
+++ work/arch/arm/boot/dts/emev2-kzm9d-reference.dts	2013-07-09 13:06:47.000000000 +0900
@@ -23,4 +23,35 @@
 	chosen {
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
 	};
+
+	reg_1p8v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3p3v: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	lan9220 at 20000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x20000000 0x10000>;
+		phy-mode = "mii";
+		interrupt-parent = <&gpio0>;
+		interrupts = <1 1>;	/* active high */
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
 };
