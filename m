From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 20 Sep 2018 17:56:56 +0200
Subject: [PATCH 0/4] ARM: dts: mvebu: updates and new board
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Thu, 26 Jul 2018 16:02:53 +1200")
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87bm8sjh6f.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> This series updates the armada-xp-98dx3236 SoC and related boards to use the
> new style dts bindings for nand.
>
> I've also added a new db-88f6820-amc board which is an Armada-385 based
> reference board from Marvell's switch team. It's a plugin card for either the
> db-dxbc2 or db-xc3-24g4 which can be used if you disable the internal CPU on
> those platforms.
>
> Chris Packham (4):
>   ARM: dts: mvebu: 98dx3236: Rename nand controller node
>   ARM: dts: mvebu: db-dxbc2: use new style nand binding
>   ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
>   ARM: dts: mvebu: Add device tree for db-88f6820-amc board

While applying this series mvebu/dt, I got few warning with "ARM: dts:
mvebu: 98dx3236: Rename nand controller node".

I fix them and also use the new partition binding, the diff is the
following:

iff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
index d87614057e3f..dc9ccce1d4a1 100644
--- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -102,9 +102,14 @@
                nand-ecc-strength = <4>;
                nand-ecc-step-size = <512>;
 
-               partition at user {
-                       reg = <0x00000000 0x40000000>;
-                       label = "user";
+               partitions {
+                       compatible = "fixed-partitions";
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       partition at 0 {
+                               reg = <0x00000000 0x40000000>;
+                               label = "user";
+                       };
                };
        };
 };
@@ -131,13 +136,18 @@
                spi-max-frequency = <50000000>;
                m25p,fast-read;
 
-               partition at u-boot {
-                       reg = <0x00000000 0x00100000>;
-                       label = "u-boot";
-               };
-               partition at u-boot-env {
-                       reg = <0x00100000 0x00040000>;
-                       label = "u-boot-env";
+               partitions {
+                       compatible = "fixed-partitions";
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       partition at 0 {
+                               reg = <0x00000000 0x00100000>;
+                               label = "u-boot";
+                       };
+                       partition at 100000 {
+                               reg = <0x00100000 0x00040000>;
+                               label = "u-boot-env";
+                       };
                };
        };
 };

I amended your patch with it, but if you don't agree with it, I can
still modify it, the branch is not immutable yet.

Thanks,

Gregory

>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/armada-385-db-88f6820-amc.dts    | 184 ++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi     |   2 +-
>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |  18 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |  18 +-
>  5 files changed, 208 insertions(+), 15 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
>
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
