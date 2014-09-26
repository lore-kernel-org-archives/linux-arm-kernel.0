From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 14:20:20 +0200
Subject: [GIT PULL][for 3.18]pull request for hisilicon hix5hd2 soc dt
 updates
In-Reply-To: <CAOesGMiPVg0aZsvXePyoQ49JPa+zPjz+SDwYSt6uDdHdPHsNcg@mail.gmail.com>
References: <5417D73E.8080309@hisilicon.com>
 <CAOesGMiPVg0aZsvXePyoQ49JPa+zPjz+SDwYSt6uDdHdPHsNcg@mail.gmail.com>
Message-ID: <4373855.m14YA3J9Lf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 17:46:36 Olof Johansson wrote:
> > Zhangfei Gao (6):
> >       ARM: dts: hix5hd2: add gmac node
> >       ARM: dts: hix5hd2: add mmc node
> >       ARM: dts: hix5hd2: add usb node
> >       ARM: dts: hix5hd2: add sata node
> >       ARM: dts: hix5hd2: add gpio node
> >       ARM: dts: hix5hd2: add wdg node
> 
> The watchdog commit causes build failures because:
> 
> Error: arch/arm/boot/dts/hisi-x5hd2.dtsi:374.22-23 syntax error
> 
> This is because HIX5HD2_WDG0_RST is not defined anywhere in the include files.
> 
> You _really_ need to build test branches before you send them to us.
> 
> I've reverted that particular patch now.
> 

The others were also broken, I've removed them all now.

I think the gpio patch was actually ok, but I didn't see a point
in leaving that one in while all the other ones are reverted, and one
patch is shorter, and it gets us back to a known working state.

	Arnd

commit 3a75d1ad9a14dfbc8ea02824457729b79444e74f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Sep 26 14:15:54 2014 +0200

    Revert "Merge tag 'hix5hd2-dt-for-3.18' of git://github.com/hisilicon/linux-hisi into next/dt"
    
    Apparently most of the newly added nodes had the same problem,
    so instead of reverting the individual patches, this undoes
    the effect of the merge and backs out all of them at once.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>


diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index 375a10c6e88b..05b44c272c9a 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -51,36 +51,3 @@
 &uart0 {
 	status = "okay";
 };
-
-&gmac0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	phy-handle = <&phy2>;
-	phy-mode = "mii";
-	/* Placeholder, overwritten by bootloader */
-	mac-address = [00 00 00 00 00 00];
-	status = "okay";
-
-	phy2: ethernet-phy at 2 {
-		reg = <2>;
-	};
-};
-
-&gmac1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
-	/* Placeholder, overwritten by bootloader */
-	mac-address = [00 00 00 00 00 00];
-	status = "okay";
-
-	phy1: ethernet-phy at 1 {
-		reg = <1>;
-	};
-};
-
-&ahci {
-        phys = <&sata_phy>;
-        phy-names = "sata-phy";
-};
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 152f3ad1af6b..f85ba2924ff7 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -131,240 +131,6 @@
 				clock-names = "apb_pclk";
 				status = "disabled";
 			};
-
-			gpio0: gpio at b20000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb20000 0x1000>;
-				interrupts = <0 108 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio1: gpio at b21000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb21000 0x1000>;
-				interrupts = <0 109 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio2: gpio at b22000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb22000 0x1000>;
-				interrupts = <0 110 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio3: gpio at b23000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb23000 0x1000>;
-				interrupts = <0 111 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio4: gpio at b24000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb24000 0x1000>;
-				interrupts = <0 112 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio5: gpio at 004000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0x004000 0x1000>;
-				interrupts = <0 113 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio6: gpio at b26000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb26000 0x1000>;
-				interrupts = <0 114 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio7: gpio at b27000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb27000 0x1000>;
-				interrupts = <0 115 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio8: gpio at b28000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb28000 0x1000>;
-				interrupts = <0 116 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio9: gpio at b29000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb29000 0x1000>;
-				interrupts = <0 117 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio10: gpio at b2a000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2a000 0x1000>;
-				interrupts = <0 118 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio11: gpio at b2b000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2b000 0x1000>;
-				interrupts = <0 119 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio12: gpio at b2c000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2c000 0x1000>;
-				interrupts = <0 120 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio13: gpio at b2d000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2d000 0x1000>;
-				interrupts = <0 121 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio14: gpio at b2e000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2e000 0x1000>;
-				interrupts = <0 122 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio15: gpio at b2f000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb2f000 0x1000>;
-				interrupts = <0 123 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio16: gpio at b30000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb30000 0x1000>;
-				interrupts = <0 124 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
-
-			gpio17: gpio at b31000 {
-				compatible = "arm,pl061", "arm,primecell";
-				reg = <0xb31000 0x1000>;
-				interrupts = <0 125 0x4>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				clocks = <&clock HIX5HD2_FIXED_100M>;
-				clock-names = "apb_pclk";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				status = "disabled";
-			};
 		};
 
 		local_timer at 00a00600 {
@@ -400,72 +166,5 @@
 				#clock-cells = <1>;
 			};
 		};
-
-		/* unremovable emmc as mmcblk0 */
-		mmc: mmc at 1830000 {
-			compatible = "snps,dw-mshc";
-			reg = <0x1830000 0x1000>;
-			interrupts = <0 35 4>;
-			clocks = <&clock HIX5HD2_MMC_CIU_RST>, <&clock HIX5HD2_MMC_BIU_CLK>;
-			clock-names = "ciu", "biu";
-		};
-
-		sd: mmc at 1820000 {
-			compatible = "snps,dw-mshc";
-			reg = <0x1820000 0x1000>;
-			interrupts = <0 34 4>;
-			clocks = <&clock HIX5HD2_SD_CIU_RST>, <&clock HIX5HD2_SD_BIU_CLK>;
-			clock-names = "ciu","biu";
-		};
-
-		gmac0: ethernet at 1840000 {
-			compatible = "hisilicon,hix5hd2-gmac";
-			reg = <0x1840000 0x1000>,<0x184300c 0x4>;
-			interrupts = <0 71 4>;
-			clocks = <&clock HIX5HD2_MAC0_CLK>;
-			status = "disabled";
-		};
-
-		gmac1: ethernet at 1841000 {
-			compatible = "hisilicon,hix5hd2-gmac";
-			reg = <0x1841000 0x1000>,<0x1843010 0x4>;
-			interrupts = <0 72 4>;
-			clocks = <&clock HIX5HD2_MAC1_CLK>;
-			status = "disabled";
-		};
-
-		usb0: ehci at 1890000 {
-		        compatible = "generic-ehci";
-			reg = <0x1890000 0x1000>;
-			interrupts = <0 66 4>;
-			clocks = <&clock HIX5HD2_USB_CLK>;
-	        };
-
-		usb1: ohci at 1880000 {
-			compatible = "generic-ohci";
-			reg = <0x1880000 0x1000>;
-			interrupts = <0 67 4>;
-			clocks = <&clock HIX5HD2_USB_CLK>;
-		};
-
-		peripheral_ctrl: syscon at a20000 {
-			compatible = "syscon";
-			reg = <0xa20000 0x1000>;
-		};
-
-		sata_phy: phy at 1900000 {
-			compatible = "hisilicon,hix5hd2-sata-phy";
-			reg = <0x1900000 0x10000>;
-			#phy-cells = <0>;
-			hisilicon,peripheral-syscon = <&peripheral_ctrl>;
-			hisilicon,power-reg = <0x8 10>;
-		};
-
-		ahci: sata at 1900000 {
-                        compatible = "hisilicon,hisi-ahci";
-                        reg = <0x1900000 0x10000>;
-                        interrupts = <0 70 4>;
-                        clocks = <&clock HIX5HD2_SATA_CLK>;
-		};
 	};
 };
