From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:33:05 +0900
Subject: [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
Message-ID: <20131001103305.813.70296.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Copy the device nodes from KZM9D reference into the KZM9D
device tree file. This will allow us to use a single DTS
file regarless of kernel configuration. In case of legacy
C board code the device nodes may or may not be used, but
in the multiplatform case all the DT device nodes are used.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/emev2-kzm9d.dts |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/emev2-kzm9d.dts
+++ work/arch/arm/boot/dts/emev2-kzm9d.dts	2013-09-26 19:42:16.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the KZM9D board
  *
- * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2013 Renesas Solutions Corp.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -23,4 +23,35 @@
 	chosen {
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
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
