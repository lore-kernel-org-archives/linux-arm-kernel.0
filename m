From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 15:42:38 -0400
Subject: [GIT PULL] ARM: mvebu: boards changes for v3.12
Message-ID: <20130814194238.GG13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's the second round of removing most of the board files from
mach-kirkwood (yay!).  Unfortunately, this also conflicts fairly heavily
with mvebu/drivers and mvebu/msi_mvebu.  I've attached the resolution
I've been using in -next below the summary.

thx,

Jason.

The following changes since commit fa8c5a811e0e7c3e1c49b2e58fcb4db549b5719a:

  ARM: plat-orion: add reg offset to DT irq driver stub (2013-07-25 21:07:33 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/boards-3.12-2

for you to fetch changes up to 5e9eaadb0b3fa8c12715d9761158ec328d7e9523:

  ARM: dove: add initial DT file for Globalscale D2Plug (2013-08-12 21:03:50 +0000)

----------------------------------------------------------------
mvebu boards changes for v3.12

 - kirkwood
    - convert Dockstar, Guruplug, mv88f6281gtw_ge to DT
    - remove legacy boards (which have DT support) sheevaplug, lacie boards
    - ARRAY_AND_SIZE() cleanup

 - dove
    - some DT node updates (depends on irqchip/clocksource DT changes earlier)
    - add the D2Plug board

----------------------------------------------------------------
Jamie Lentin (1):
      ARM: kirkwood: Remove all remaining trace of DNS-320/325 platform code

Jason Cooper (2):
      ARM: kirkwood: use dts pre-processor for mv88f6281gtw-ge
      ARM: kirkwood: fix DT building and update defconfig

Julia Lawall (1):
      arch/arm/mach-kirkwood: Avoid using ARRAY_AND_SIZE(e) as a function argument

Sebastian Hesselbarth (4):
      ARM: dove: add cpu device tree node
      ARM: dove: add common pinmux functions to DT
      ARM: dove: add GPIO IR receiver node to SolidRun CuBox
      ARM: dove: add initial DT file for Globalscale D2Plug

Thomas Petazzoni (5):
      ARM: kirkwood: remove support for legacy booting of Dockstar
      ARM: kirkwood: remove support for legacy booting of Guruplug
      ARM: kirkwood: remove support for legacy booting of Sheevaplug
      ARM: kirkwood: remove LaCie boards that are supported through DT
      ARM: kirkwood: convert the mv88f6281gtw_ge board to DT

 arch/arm/boot/dts/Makefile                     |   2 +
 arch/arm/boot/dts/dove-cubox.dts               |  30 +--
 arch/arm/boot/dts/dove-d2plug.dts              |  69 ++++++
 arch/arm/boot/dts/dove.dtsi                    | 233 ++++++++++++++++++--
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 125 +++++++++++
 arch/arm/configs/kirkwood_defconfig            |  18 +-
 arch/arm/mach-kirkwood/Kconfig                 |  66 +-----
 arch/arm/mach-kirkwood/Makefile                |  10 +-
 arch/arm/mach-kirkwood/board-dnskw.c           |  36 ---
 arch/arm/mach-kirkwood/board-dt.c              |   4 +-
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c |  50 +++++
 arch/arm/mach-kirkwood/common.h                |   6 +-
 arch/arm/mach-kirkwood/dockstar-setup.c        | 111 ----------
 arch/arm/mach-kirkwood/guruplug-setup.c        | 133 -----------
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c | 172 ---------------
 arch/arm/mach-kirkwood/netspace_v2-setup.c     | 293 -------------------------
 arch/arm/mach-kirkwood/openrd-setup.c          |   3 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |   4 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c      | 161 --------------
 19 files changed, 490 insertions(+), 1036 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-d2plug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
 delete mode 100644 arch/arm/mach-kirkwood/board-dnskw.c
 create mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 delete mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/netspace_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/sheevaplug-setup.c


And the resolution:
--------------->8------------------------

commit fb079591dc8282452c35ac6e02dd16f4a43d73a1
Merge: 342fd2f 5e9eaad
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Aug 14 17:55:08 2013 +0000

    Merge branch 'mvebu/boards' into for-next
    
    Conflicts:
    	arch/arm/boot/dts/kirkwood.dtsi

diff --cc arch/arm/boot/dts/kirkwood-db.dtsi
index 45c1bf7,ca8bf36..c0e2a58
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@@ -77,5 -77,29 +77,21 @@@
  			cd-gpios = <&gpio1 6 0>;
  			status = "okay";
  		};
 -
 -		pcie-controller {
 -			status = "okay";
 -
 -			pcie at 1,0 {
 -				status = "okay";
 -			};
 -		};
  	};
  };
+ 
+ &mdio {
+ 	status = "okay";
+ 
+ 	ethphy0: ethernet-phy at 8 {
+ 		device_type = "ethernet-phy";
+ 		reg = <8>;
+ 	};
+ };
+ 
+ &eth0 {
+ 	status = "okay";
+ 	ethernet0-port at 0 {
+ 		phy-handle = <&ethphy0>;
+ 	};
+ };
diff --cc arch/arm/boot/dts/kirkwood-ts219.dtsi
index 7019cf6,102eaeb..39158cf
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@@ -97,5 -87,28 +97,21 @@@
  			status = "okay";
  			nr-ports = <2>;
  		};
 -		pcie-controller {
 -			status = "okay";
 -
 -			pcie at 1,0 {
 -				status = "okay";
 -			};
 -		};
  	};
  };
+ 
+ &mdio {
+ 	status = "okay";
+ 
+ 	ethphy0: ethernet-phy {
+ 		device_type = "ethernet-phy";
+                 /* overwrite reg property in board file */
+ 	};
+ };
+ 
+ &eth0 {
+ 	status = "okay";
+ 	ethernet0-port at 0 {
+ 		phy-handle = <&ethphy0>;
+ 	};
+ };
diff --cc arch/arm/boot/dts/kirkwood.dtsi
index 70f414d,1d6921d..6489b98
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@@ -22,23 -20,7 +22,16 @@@
  	       gpio0 = &gpio0;
  	       gpio1 = &gpio1;
  	};
- 	intc: interrupt-controller {
- 		compatible = "marvell,orion-intc", "marvell,intc";
- 		interrupt-controller;
- 		#interrupt-cells = <1>;
- 		reg = <0xf1020204 0x04>,
- 		      <0xf1020214 0x04>;
- 	};
  
 +	mbus {
 +		compatible = "marvell,kirkwood-mbus", "simple-bus";
 +		#address-cells = <2>;
 +		#size-cells = <1>;
 +		controller = <&mbusc>;
 +		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
 +		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
 +	};
 +
  	ocp at f1000000 {
  		compatible = "simple-bus";
  		ranges = <0x00000000 0xf1000000 0x0100000
@@@ -47,11 -30,30 +40,35 @@@
  		#address-cells = <1>;
  		#size-cells = <1>;
  
+ 		timer: timer at 20300 {
+ 			compatible = "marvell,orion-timer";
+ 			reg = <0x20300 0x20>;
+ 			interrupt-parent = <&bridge_intc>;
+ 			interrupts = <1>, <2>;
+ 			clocks = <&core_clk 0>;
+ 		};
+ 
+ 		intc: main-interrupt-ctrl at 20200 {
+ 			compatible = "marvell,orion-intc";
+ 			interrupt-controller;
+ 			#interrupt-cells = <1>;
+ 			reg = <0x20200 0x10>, <0x20210 0x10>;
+ 		};
+ 
+ 		bridge_intc: bridge-interrupt-ctrl at 20110 {
+ 			compatible = "marvell,orion-bridge-intc";
+ 			interrupt-controller;
+ 			#interrupt-cells = <1>;
+ 			reg = <0x20110 0x8>;
+ 			interrupts = <1>;
+ 			marvell,#interrupts = <6>;
+ 		};
+ 
 +		mbusc: mbus-controller at 20000 {
 +			compatible = "marvell,mbus-controller";
 +			reg = <0x20000 0x80>, <0x1500 0x20>;
 +		};
 +
  		core_clk: core-clocks at 10030 {
  			compatible = "marvell,kirkwood-core-clock";
  			reg = <0x10030 0x4>;
diff --cc arch/arm/mach-orion5x/edmini_v2-setup.c
index 0fc33c5,7d316ed..f66c1b2
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@@ -152,12 -144,9 +144,11 @@@ void __init edmini_v2_init(void
  	 * Configure peripherals.
  	 */
  	orion5x_ehci0_init();
- 	orion5x_eth_init(&edmini_v2_eth_data);
  
 -	mvebu_mbus_add_window("devbus-boot", EDMINI_V2_NOR_BOOT_BASE,
 -			      EDMINI_V2_NOR_BOOT_SIZE);
 +	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
 +				    ORION_MBUS_DEVBUS_BOOT_ATTR,
 +				    EDMINI_V2_NOR_BOOT_BASE,
 +				    EDMINI_V2_NOR_BOOT_SIZE);
  	platform_device_register(&edmini_v2_nor_flash);
  
  	pr_notice("edmini_v2: USB device port, flash write and power-off "
