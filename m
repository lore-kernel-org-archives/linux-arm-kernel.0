From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 16:16:30 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.12
Message-ID: <20130814201630.GH13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's the DT changes for v3.12 that didn't accompany driver conversions
(MBus, mv643xx_eth, clocksource, irqchip, msi/pci, etc).  I've attached
the conflict resolution below.  The small conflict in the binding
documentation is against arm-soc/for-next as well.  The rest is against
mvebu/boards.

thx,

Jason.

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.12

for you to fetch changes up to 1bacc35f45fe867e862c84f6be697ec8ef52ec7a:

  ARM: mvebu: Fix the Armada 370/XP timer compatible strings (2013-08-13 19:24:02 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.12

 - kirkwood
    - add ZyXEL NSA310 board, fan for ReadyNAS Duo v2

 - mvebu
    - add ReadyNAS 102 board

 - misc dts updates and changes.

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Add support for another ZyXEL NSA310 variant

Arnaud Ebalard (2):
      arm: kirkwood: readynas duo v2: Add GMT G762 Fan Controller
      ARM: mvebu: Add Netgear ReadyNAS 102 board

Ezequiel Garcia (1):
      ARM: mvebu: Fix the Armada 370/XP timer compatible strings

Gregory CLEMENT (1):
      ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c

Jason Cooper (2):
      ARM: kirkwood: use dts pre-processor for nsa310 boards
      ARM: mvebu: use dts pre-processor for readynas 102

Thomas Petazzoni (1):
      ARM: mvebu: use correct #interrupt-cells instead of #interrupts-cells

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  13 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 179 +++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 -
 arch/arm/boot/dts/armada-370.dtsi                  |  19 ++-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   4 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   6 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   6 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |  12 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  20 +++
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      | 107 ++++++++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 100 +-----------
 arch/arm/boot/dts/kirkwood-nsa310a.dts             | 165 +++++++++++++++++++
 13 files changed, 521 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn102.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310a.dts

And the resolution (I'm looking into the 'Conflicts' in the commit
message, the diff is correct, but I'm not sure how the commit message
ended up wrong) (The left-justified #address-cells and #size-cells were
mistakenly merged by me, and corrected in a subsequent patch by Ezequiel):
---------------------->8------------------------------

commit 4367924e3a4df71962a629f62f0eb667e62a9a66
Merge: fb07959 1bacc35
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Aug 14 17:56:36 2013 +0000

    Merge branch 'mvebu/dt' into for-next
    
    Conflicts:
    	Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
    	arch/arm/boot/dts/kirkwood-nsa310.dts

diff --cc Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 6113f92,c5dd952..49d7bf4
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@@ -4,7 -4,8 +4,9 @@@
  Required properties :
  
   - reg             : Offset and length of the register set for the device
-  - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
 - - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv7230-i2c"
 -for controller which support the I2C Transaction Generator
++ - compatible      : Should be "allwinner,sun4i-i2c", or "marvell,mv64xxx-i2c"
++and "marvell,mv7230-i2c" for controller which support the I2C Transaction
++Generator
   - interrupts      : The interrupt number
  
  Optional properties :
diff --cc arch/arm/boot/dts/Makefile
index 8522958,3d4b882..984a997
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -102,8 -101,8 +103,9 @@@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.
  	msm8960-cdp.dtb
  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
  	armada-370-mirabox.dtb \
+ 	armada-370-netgear-rn102.dtb \
  	armada-370-rd.dtb \
 +	armada-xp-axpwifiap.dtb \
  	armada-xp-db.dtb \
  	armada-xp-gp.dtb \
  	armada-xp-openblocks-ax3-4.dtb
diff --cc arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 0963bc5,ab40f96..3f5e612
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@@ -193,9 -74,113 +193,9 @@@
  				gpio-controller;
  				#gpio-cells = <2>;
  				interrupt-controller;
- 				#interrupts-cells = <2>;
+ 				#interrupt-cells = <2>;
  				interrupts = <87>, <88>, <89>;
  			};
 -
 -			/*
 -			 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 -			 * configured as x4 or quad x1 lanes. One unit is
 -			 * x4/x1.
 -			 */
 -			pcie-controller {
 -				compatible = "marvell,armada-xp-pcie";
 -				status = "disabled";
 -				device_type = "pci";
 -
 -#address-cells = <3>;
 -#size-cells = <2>;
 -
 -				bus-range = <0x00 0xff>;
 -
 -				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
 -					0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
 -					0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
 -					0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
 -					0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
 -					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
 -					0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
 -
 -				pcie at 1,0 {
 -					device_type = "pci";
 -					assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
 -					reg = <0x0800 0 0 0 0>;
 -					#address-cells = <3>;
 -					#size-cells = <2>;
 -					#interrupt-cells = <1>;
 -					ranges;
 -					interrupt-map-mask = <0 0 0 0>;
 -					interrupt-map = <0 0 0 0 &mpic 58>;
 -					marvell,pcie-port = <0>;
 -					marvell,pcie-lane = <0>;
 -					clocks = <&gateclk 5>;
 -					status = "disabled";
 -				};
 -
 -				pcie at 2,0 {
 -					device_type = "pci";
 -					assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
 -					reg = <0x1000 0 0 0 0>;
 -					#address-cells = <3>;
 -					#size-cells = <2>;
 -					#interrupt-cells = <1>;
 -					ranges;
 -					interrupt-map-mask = <0 0 0 0>;
 -					interrupt-map = <0 0 0 0 &mpic 59>;
 -					marvell,pcie-port = <0>;
 -					marvell,pcie-lane = <1>;
 -					clocks = <&gateclk 6>;
 -					status = "disabled";
 -				};
 -
 -				pcie at 3,0 {
 -					device_type = "pci";
 -					assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
 -					reg = <0x1800 0 0 0 0>;
 -					#address-cells = <3>;
 -					#size-cells = <2>;
 -					#interrupt-cells = <1>;
 -					ranges;
 -					interrupt-map-mask = <0 0 0 0>;
 -					interrupt-map = <0 0 0 0 &mpic 60>;
 -					marvell,pcie-port = <0>;
 -					marvell,pcie-lane = <2>;
 -					clocks = <&gateclk 7>;
 -					status = "disabled";
 -				};
 -
 -				pcie at 4,0 {
 -					device_type = "pci";
 -					assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
 -					reg = <0x2000 0 0 0 0>;
 -					#address-cells = <3>;
 -					#size-cells = <2>;
 -					#interrupt-cells = <1>;
 -					ranges;
 -					interrupt-map-mask = <0 0 0 0>;
 -					interrupt-map = <0 0 0 0 &mpic 61>;
 -					marvell,pcie-port = <0>;
 -					marvell,pcie-lane = <3>;
 -					clocks = <&gateclk 8>;
 -					status = "disabled";
 -				};
 -
 -				pcie at 9,0 {
 -					device_type = "pci";
 -					assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
 -					reg = <0x4800 0 0 0 0>;
 -					#address-cells = <3>;
 -					#size-cells = <2>;
 -					#interrupt-cells = <1>;
 -					ranges;
 -					interrupt-map-mask = <0 0 0 0>;
 -					interrupt-map = <0 0 0 0 &mpic 99>;
 -					marvell,pcie-port = <2>;
 -					marvell,pcie-lane = <0>;
 -					clocks = <&gateclk 26>;
 -					status = "disabled";
 -				};
 -			};
  		};
  	};
  };
