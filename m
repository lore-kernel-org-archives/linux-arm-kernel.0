From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 22:56:40 +0100
Subject: [PATCH 3/3] mfd: ab8500: kill "reg" property from binding
In-Reply-To: <1363298204-8014-1-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
Message-ID: <1363298204-8014-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ab8500 device is a child of the prcmu device, which is a memory mapped
bus device, whose children are addressable using physical memory addresses,
not using mailboxes, so a mailbox number in the ab8500 node cannot be
parsed by DT. Nothing uses this number, since it was only introduced
as part of the failed attempt to clean up prcmu mailbox handling, and
we can simply remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Please apply to MFD tree for 3.9


 Documentation/devicetree/bindings/mfd/ab8500.txt | 6 +-----
 arch/arm/boot/dts/dbx5x0.dtsi                    | 3 +--
 arch/arm/boot/dts/href.dtsi                      | 2 +-
 arch/arm/boot/dts/hrefv60plus.dts                | 2 +-
 arch/arm/boot/dts/snowball.dts                   | 2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index 13b707b..c3a14e0 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -13,9 +13,6 @@ Required parent device properties:
                                   4 = active high level-sensitive
                                   8 = active low level-sensitive
 
-Optional parent device properties:
-- reg                    : contains the PRCMU mailbox address for the AB8500 i2c port
-
 The AB8500 consists of a large and varied group of sub-devices:
 
 Device                     IRQ Names              Supply Names   Description
@@ -86,9 +83,8 @@ Non-standard child device properties:
    - stericsson,amic2-bias-vamic1           : Analoge Mic wishes to use a non-standard Vamic
    - stericsson,earpeice-cmv                : Earpeice voltage (only: 950 | 1100 | 1270 | 1580)
 
-ab8500 at 5 {
+ab8500 {
          compatible = "stericsson,ab8500";
-         reg = <5>; /* mailbox 5 is i2c */
          interrupts = <0 40 0x4>;
          interrupt-controller;
          #interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 69140ba..9de9309 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -319,9 +319,8 @@
 				};
 			};
 
-			ab8500 at 5 {
+			ab8500 {
 				compatible = "stericsson,ab8500";
-				reg = <5>; /* mailbox 5 is i2c */
 				interrupt-parent = <&intc>;
 				interrupts = <0 40 0x4>;
 				interrupt-controller;
diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index 592fb9d..379128e 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -221,7 +221,7 @@
 				};
 			};
 
-			ab8500 at 5 {
+			ab8500 {
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 55f4191..2b587a7 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -158,7 +158,7 @@
 				};
 			};
 
-			ab8500 at 5 {
+			ab8500 {
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 27f31a5..d3ec32f 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -298,7 +298,7 @@
 				};
 			};
 
-			ab8500 at 5 {
+			ab8500 {
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
-- 
1.8.1.2
