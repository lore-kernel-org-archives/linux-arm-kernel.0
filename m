From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 12 May 2014 18:47:59 +0200
Subject: [RFC PATCH 8/9] dt: deps: dts: kirkwood: dockstar: add dependency
 ehci -> usb power regulator
In-Reply-To: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1399913280-6915-9-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serves as an example how easy it is to fix an initialization order
if the order depends on the DT. No source code changes will be necessary.

If you look at the dependency graph for the dockstar, you will see that
there is no dependency between ehci and the usb power regulator. This
ends up with the fact that the regulator will be initialized after ehci.

Fix this by adding one dependency to the .dts.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/boot/dts/kirkwood-dockstar.dts | 4 ++++
 arch/arm/boot/dts/kirkwood.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index f31312e..0ca7456 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -106,3 +106,7 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&ehci {
+	dependencies = <&usb_power>;
+};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 6abf44d..54a1223 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -185,7 +185,7 @@
 			status = "okay";
 		};
 
-		ehci at 50000 {
+		ehci: ehci at 50000 {
 			compatible = "marvell,orion-ehci";
 			reg = <0x50000 0x1000>;
 			interrupts = <19>;
-- 
1.8.3.1
