From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:55 +0900
Subject: [PATCH 07/14] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <9e8b48b61aeb2eb9a02e81021bfb8d89ea4645a4.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Copy the device nodes from KZM9D reference into the KZM9D
device tree file. This will allow us to use a single DTS
file regarless of kernel configuration. In case of legacy
C board code the device nodes may or may not be used, but
in the multiplatform case all the DT device nodes are used.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index f92e812..861aa7d 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
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
-- 
1.8.4
