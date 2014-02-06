From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 7 Feb 2014 00:58:30 +0300
Subject: [PATCH 2/2] ARM: shmobile: lager: add Ether DT support
In-Reply-To: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
References: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402070058.31405.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Lager board dependent part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7790-lager.dts |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree Source for the Lager board
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -76,12 +77,40 @@
 		renesas,function = "scif1";
 	};
 
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq0";
+		renesas,function = "intc";
+	};
+
 	mmc1_pins: mmc1 {
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
 	};
 };
 
+&ether {
+	pinctrl-0 = <&ether_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "ok";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&phy1_pins>;
+		pinctrl-names = "default";
+	};
+};
+
 &mmcif1 {
 	pinctrl-0 = <&mmc1_pins>;
 	pinctrl-names = "default";
