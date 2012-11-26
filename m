From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 20:45:46 +1100
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20121126204546.ef1f1b55e903eda38a61d5d1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/am33xx.dtsi between commit 1a39a65cba08 ("arm/dts:
am33xx: Add CPSW and MDIO module nodes for AM33XX") from the net-next
tree and commits 059b185d5345 ("ARM: dts: AM33XX: Add D_CAN device tree
data") and 4c94ac29b5c1 ("ARM: dts: OMAP: Move interrupt-parent to the
root node to avoid duplication") (and a few others that added more later
nodes) from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am33xx.dtsi
index a4615b4,20a3f29..0000000
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@@ -210,53 -222,121 +222,168 @@@
  			interrupts = <91>;
  		};
  
 +		mac: ethernet at 4a100000 {
 +			compatible = "ti,cpsw";
 +			ti,hwmods = "cpgmac0";
 +			cpdma_channels = <8>;
 +			ale_entries = <1024>;
 +			bd_ram_size = <0x2000>;
 +			no_bd_ram = <0>;
 +			rx_descs = <64>;
 +			mac_control = <0x20>;
 +			slaves = <2>;
 +			cpts_active_slave = <0>;
 +			cpts_clock_mult = <0x80000000>;
 +			cpts_clock_shift = <29>;
 +			reg = <0x4a100000 0x800
 +			       0x4a101200 0x100>;
 +			#address-cells = <1>;
 +			#size-cells = <1>;
- 			interrupt-parent = <&intc>;
 +			/*
 +			 * c0_rx_thresh_pend
 +			 * c0_rx_pend
 +			 * c0_tx_pend
 +			 * c0_misc_pend
 +			 */
 +			interrupts = <40 41 42 43>;
 +			ranges;
 +
 +			davinci_mdio: mdio at 4a101000 {
 +				compatible = "ti,davinci_mdio";
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				ti,hwmods = "davinci_mdio";
 +				bus_freq = <1000000>;
 +				reg = <0x4a101000 0x100>;
 +			};
 +
 +			cpsw_emac0: slave at 4a100200 {
 +				/* Filled in by U-Boot */
 +				mac-address = [ 00 00 00 00 00 00 ];
 +			};
 +
 +			cpsw_emac1: slave at 4a100300 {
 +				/* Filled in by U-Boot */
 +				mac-address = [ 00 00 00 00 00 00 ];
 +			};
 +
 +		};
++
+ 		dcan0: d_can at 481cc000 {
+ 			compatible = "bosch,d_can";
+ 			ti,hwmods = "d_can0";
+ 			reg = <0x481cc000 0x2000>;
+ 			interrupts = <52>;
+ 			status = "disabled";
+ 		};
+ 
+ 		dcan1: d_can at 481d0000 {
+ 			compatible = "bosch,d_can";
+ 			ti,hwmods = "d_can1";
+ 			reg = <0x481d0000 0x2000>;
+ 			interrupts = <55>;
+ 			status = "disabled";
+ 		};
+ 
+ 		timer1: timer at 44e31000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x44e31000 0x400>;
+ 			interrupts = <67>;
+ 			ti,hwmods = "timer1";
+ 			ti,timer-alwon;
+ 		};
+ 
+ 		timer2: timer at 48040000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x48040000 0x400>;
+ 			interrupts = <68>;
+ 			ti,hwmods = "timer2";
+ 		};
+ 
+ 		timer3: timer at 48042000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x48042000 0x400>;
+ 			interrupts = <69>;
+ 			ti,hwmods = "timer3";
+ 		};
+ 
+ 		timer4: timer at 48044000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x48044000 0x400>;
+ 			interrupts = <92>;
+ 			ti,hwmods = "timer4";
+ 			ti,timer-pwm;
+ 		};
+ 
+ 		timer5: timer at 48046000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x48046000 0x400>;
+ 			interrupts = <93>;
+ 			ti,hwmods = "timer5";
+ 			ti,timer-pwm;
+ 		};
+ 
+ 		timer6: timer at 48048000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x48048000 0x400>;
+ 			interrupts = <94>;
+ 			ti,hwmods = "timer6";
+ 			ti,timer-pwm;
+ 		};
+ 
+ 		timer7: timer at 4804a000 {
+ 			compatible = "ti,omap2-timer";
+ 			reg = <0x4804a000 0x400>;
+ 			interrupts = <95>;
+ 			ti,hwmods = "timer7";
+ 			ti,timer-pwm;
+ 		};
+ 
+ 		rtc at 44e3e000 {
+ 			compatible = "ti,da830-rtc";
+ 			reg = <0x44e3e000 0x1000>;
+ 			interrupts = <75
+ 				      76>;
+ 			ti,hwmods = "rtc";
+ 		};
+ 
+ 		spi0: spi at 48030000 {
+ 			compatible = "ti,omap4-mcspi";
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			reg = <0x48030000 0x400>;
+ 			interrupt = <65>;
+ 			ti,spi-num-cs = <2>;
+ 			ti,hwmods = "spi0";
+ 			status = "disabled";
+ 		};
+ 
+ 		spi1: spi at 481a0000 {
+ 			compatible = "ti,omap4-mcspi";
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			reg = <0x481a0000 0x400>;
+ 			interrupt = <125>;
+ 			ti,spi-num-cs = <2>;
+ 			ti,hwmods = "spi1";
+ 			status = "disabled";
+ 		};
+ 
+ 		usb at 47400000 {
+ 			compatible = "ti,musb-am33xx";
+ 			reg = <0x47400000 0x1000	/* usbss */
+ 			       0x47401000 0x800		/* musb instance 0 */
+ 			       0x47401800 0x800>;	/* musb instance 1 */
+ 			interrupts = <17		/* usbss */
+ 				      18		/* musb instance 0 */
+ 				      19>;		/* musb instance 1 */
+ 			multipoint = <1>;
+ 			num-eps = <16>;
+ 			ram-bits = <12>;
+ 			port0-mode = <3>;
+ 			port1-mode = <3>;
+ 			power = <250>;
+ 			ti,hwmods = "usb_otg_hs";
+ 		};
  	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/222ee1ff/attachment.sig>
