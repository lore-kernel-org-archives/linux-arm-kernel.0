From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 14:43:20 +0000
Subject: [GIT PULL] Device Tree fixes for v3.9
In-Reply-To: <20130302005852.GA3106@gmail.com>
References: <CACRpkdai0PRbK-R_KfNqkkVuSNn97v9Za8Doq71Zb-xCHW+J1A@mail.gmail.com>
 <201303012319.28231.arnd@arndb.de> <20130302005852.GA3106@gmail.com>
Message-ID: <201303111443.21019.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 March 2013, Lee Jones wrote:
> > 
> > I'm still getting build errors even with those patches applied:
> > 
> > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> 
> These have been there since DT landed for the AB8500 - it's on my TODO
> to fix, but it's a really low priority.

I've come up with the trivial patch below. I'm trying hard to kill off all known
warnings, and will not take submissions introducing new ones if I see them.

Maybe Sam can just pick this up along with the other patch.

> > drivers/built-in.o: In function `ab8500_power_off':
> > /git/arm-soc/drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
> > /git/arm-soc/drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
> > make[2]: *** [vmlinux] Error 1
> 
> This has already been fixed.
> 
> https://patchwork.kernel.org/patch/2163301/

It hasn't made it into v3.9-rc2 or even linux-next yet. I guess it got lost
somewhere.

	Arnd

8<---------
Subject: mfd: ab8500: kill "reg" property from binding

The ab8500 device is a child of the prcmu device, which is a memory mapped
bus device, whose children are addressable using physical memory addresses,
not using mailboxes, so a mailbox number in the ab8500 node cannot be
parsed by DT. Nothing uses this number, since it was only introduced
as part of the failed attempt to clean up prcmu mailbox handling, and
we can simply remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
