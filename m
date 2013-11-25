From: rogerq@ti.com (Roger Quadros)
Date: Mon, 25 Nov 2013 15:55:45 +0200
Subject: [PATCH] ARM: dts: omap3-beagle: Fix USB host on beagle boards (for
 3.13)
Message-ID: <1385387745-7162-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beagle (rev. C4) and Beagle-XM (all revs) need VAUX2 1.8V supply
for the USB PHY.

As the generic PHY driver can't handle more than one supply
at the moment, we configure this supply to be always on.
This will cause a very small power impact if the USB host subsystem
is not in use, about 76.86 micro-W + LDO power.

Older Beagle boards (prior to C4) don't have VAUX2 connected anywhere,
so there won't be any functional impact on those boards other than
some additional LDO power consumption.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 8 ++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 31a632f..b39918e 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -215,3 +215,11 @@
 &usbhsehci {
 	phys = <0 &hsusb2_phy>;
 };
+
+&vaux2 {
+	regulator-name = "usb_1v8";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fa532aa..9764556 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -178,3 +178,11 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&vaux2 {
+	regulator-name = "vdd_ehci";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
-- 
1.8.3.2
