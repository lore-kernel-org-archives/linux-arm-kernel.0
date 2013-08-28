From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 28 Aug 2013 16:45:06 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130828164506.3f8497c59e07b0ccaaa44aec@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/boot/dts/am335x-bone.dts, arch/arm/boot/dts/am335x-evm.dts and
arch/arm/boot/dts/am335x-evmsk.dts between commit c031a7d41934 ("usb:
usb: dsps: update code according to the binding document") from the usb
tree and commits 63f6b2550aa0 ("ARM: dts: AM33XX: don't redefine OCP bus
and device nodes"), 781f17983015 ("usb: musb: am335x-evm: Do not remove
the session bit HOST-only mode") and 2ae847a1b10f ("usb: musb: am335x:
add second port to beagle bone") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am335x-bone.dts
index d318987,d99be03..0000000
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@@ -24,145 -24,6 +24,37 @@@
  		reg = <0x80000000 0x10000000>; /* 256 MB */
  	};
  
- 	am33xx_pinmux: pinmux at 44e10800 {
- 		pinctrl-names = "default";
- 		pinctrl-0 = <&clkout2_pin>;
- 
- 		user_leds_s0: user_leds_s0 {
- 			pinctrl-single,pins = <
- 				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
- 				0x58 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
- 				0x5c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
- 				0x60 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
- 			>;
- 		};
- 
- 		i2c0_pins: pinmux_i2c0_pins {
- 			pinctrl-single,pins = <
- 				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
- 				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
- 			>;
- 		};
- 
- 		uart0_pins: pinmux_uart0_pins {
- 			pinctrl-single,pins = <
- 				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
- 				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
- 			>;
- 		};
- 
- 		clkout2_pin: pinmux_clkout2_pin {
- 			pinctrl-single,pins = <
- 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
- 			>;
- 		};
- 
- 		cpsw_default: cpsw_default {
- 			pinctrl-single,pins = <
- 				/* Slave 1 */
- 				0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
- 				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txen.mii1_txen */
- 				0x118 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
- 				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
- 				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
- 				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
- 				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
- 				0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_txclk.mii1_txclk */
- 				0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
- 				0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
- 				0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
- 				0x13c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
- 				0x140 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
- 			>;
- 		};
- 
- 		cpsw_sleep: cpsw_sleep {
- 			pinctrl-single,pins = <
- 				/* Slave 1 reset value */
- 				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 
- 		davinci_mdio_default: davinci_mdio_default {
- 			pinctrl-single,pins = <
- 				/* MDIO */
- 				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
- 				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
- 			>;
- 		};
- 
- 		davinci_mdio_sleep: davinci_mdio_sleep {
- 			pinctrl-single,pins = <
- 				/* MDIO reset value */
- 				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 	};
- 
 +	ocp {
- 		uart0: serial at 44e09000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&uart0_pins>;
- 
- 			status = "okay";
- 		};
- 
 +		musb: usb at 47400000 {
 +			status = "okay";
 +
 +			control at 44e10000 {
 +				status = "okay";
 +			};
 +
 +			usb-phy at 47401300 {
 +				status = "okay";
 +			};
 +
 +			usb-phy at 47401b00 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401000 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401800 {
 +				status = "okay";
 +				dr_mode = "host";
 +			};
 +
 +			dma-controller at 07402000  {
 +				status = "okay";
 +			};
 +		};
- 
- 		i2c0: i2c at 44e0b000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c0_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <400000>;
- 
- 			tps: tps at 24 {
- 				reg = <0x24>;
- 			};
- 
- 		};
 +	};
 +
  	leds {
  		pinctrl-names = "default";
  		pinctrl-0 = <&user_leds_s0>;
diff --cc arch/arm/boot/dts/am335x-evm.dts
index e8ec875,1a0f33e..0000000
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@@ -24,324 -24,6 +24,37 @@@
  		reg = <0x80000000 0x10000000>; /* 256 MB */
  	};
  
- 	am33xx_pinmux: pinmux at 44e10800 {
- 		pinctrl-names = "default";
- 		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0 &clkout2_pin>;
- 
- 		matrix_keypad_s0: matrix_keypad_s0 {
- 			pinctrl-single,pins = <
- 				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
- 				0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
- 				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
- 				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
- 				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
- 			>;
- 		};
- 
- 		volume_keys_s0: volume_keys_s0 {
- 			pinctrl-single,pins = <
- 				0x150 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_sclk.gpio0_2 */
- 				0x154 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* spi0_d0.gpio0_3 */
- 			>;
- 		};
- 
- 		i2c0_pins: pinmux_i2c0_pins {
- 			pinctrl-single,pins = <
- 				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
- 				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
- 			>;
- 		};
- 
- 		i2c1_pins: pinmux_i2c1_pins {
- 			pinctrl-single,pins = <
- 				0x158 (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_d1.i2c1_sda */
- 				0x15c (PIN_INPUT_PULLUP | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
- 			>;
- 		};
- 
- 		uart0_pins: pinmux_uart0_pins {
- 			pinctrl-single,pins = <
- 				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
- 				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
- 			>;
- 		};
- 
- 		clkout2_pin: pinmux_clkout2_pin {
- 			pinctrl-single,pins = <
- 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
- 			>;
- 		};
- 
- 		nandflash_pins_s0: nandflash_pins_s0 {
- 			pinctrl-single,pins = <
- 				0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
- 				0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
- 				0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
- 				0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
- 				0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
- 				0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
- 				0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
- 				0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
- 				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
- 				0x74 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
- 				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
- 				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
- 				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
- 				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
- 				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
- 			>;
- 		};
- 
- 		ecap0_pins: backlight_pins {
- 			pinctrl-single,pins = <
- 				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
- 			>;
- 		};
- 
- 		cpsw_default: cpsw_default {
- 			pinctrl-single,pins = <
- 				/* Slave 1 */
- 				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
- 				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
- 				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
- 				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
- 				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
- 				0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
- 			>;
- 		};
- 
- 		cpsw_sleep: cpsw_sleep {
- 			pinctrl-single,pins = <
- 				/* Slave 1 reset value */
- 				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 
- 		davinci_mdio_default: davinci_mdio_default {
- 			pinctrl-single,pins = <
- 				/* MDIO */
- 				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
- 				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
- 			>;
- 		};
- 
- 		davinci_mdio_sleep: davinci_mdio_sleep {
- 			pinctrl-single,pins = <
- 				/* MDIO reset value */
- 				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 	};
- 
 +	ocp {
- 		uart0: serial at 44e09000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&uart0_pins>;
- 
- 			status = "okay";
- 		};
- 
- 		i2c0: i2c at 44e0b000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c0_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <400000>;
- 
- 			tps: tps at 2d {
- 				reg = <0x2d>;
- 			};
- 		};
- 
 +		musb: usb at 47400000 {
 +			status = "okay";
 +
 +			control at 44e10000 {
 +				status = "okay";
 +			};
 +
 +			usb-phy at 47401300 {
 +				status = "okay";
 +			};
 +
 +			usb-phy at 47401b00 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401000 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401800 {
 +				status = "okay";
 +				dr_mode = "host";
 +			};
 +
 +			dma-controller at 07402000  {
 +				status = "okay";
 +			};
 +		};
- 
- 		i2c1: i2c at 4802a000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c1_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <100000>;
- 
- 			lis331dlh: lis331dlh at 18 {
- 				compatible = "st,lis331dlh", "st,lis3lv02d";
- 				reg = <0x18>;
- 				Vdd-supply = <&lis3_reg>;
- 				Vdd_IO-supply = <&lis3_reg>;
- 
- 				st,click-single-x;
- 				st,click-single-y;
- 				st,click-single-z;
- 				st,click-thresh-x = <10>;
- 				st,click-thresh-y = <10>;
- 				st,click-thresh-z = <10>;
- 				st,irq1-click;
- 				st,irq2-click;
- 				st,wakeup-x-lo;
- 				st,wakeup-x-hi;
- 				st,wakeup-y-lo;
- 				st,wakeup-y-hi;
- 				st,wakeup-z-lo;
- 				st,wakeup-z-hi;
- 				st,min-limit-x = <120>;
- 				st,min-limit-y = <120>;
- 				st,min-limit-z = <140>;
- 				st,max-limit-x = <550>;
- 				st,max-limit-y = <550>;
- 				st,max-limit-z = <750>;
- 			};
- 
- 			tsl2550: tsl2550 at 39 {
- 				compatible = "taos,tsl2550";
- 				reg = <0x39>;
- 			};
- 
- 			tmp275: tmp275 at 48 {
- 				compatible = "ti,tmp275";
- 				reg = <0x48>;
- 			};
- 		};
- 
- 		elm: elm at 48080000 {
- 			status = "okay";
- 		};
- 
- 		epwmss0: epwmss at 48300000 {
- 			status = "okay";
- 
- 			ecap0: ecap at 48300100 {
- 				status = "okay";
- 				pinctrl-names = "default";
- 				pinctrl-0 = <&ecap0_pins>;
- 			};
- 		};
- 
- 		gpmc: gpmc at 50000000 {
- 			status = "okay";
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&nandflash_pins_s0>;
- 			ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
- 			nand at 0,0 {
- 				reg = <0 0 0>; /* CS0, offset 0 */
- 				nand-bus-width = <8>;
- 				ti,nand-ecc-opt = "bch8";
- 				gpmc,device-nand = "true";
- 				gpmc,device-width = <1>;
- 				gpmc,sync-clk-ps = <0>;
- 				gpmc,cs-on-ns = <0>;
- 				gpmc,cs-rd-off-ns = <44>;
- 				gpmc,cs-wr-off-ns = <44>;
- 				gpmc,adv-on-ns = <6>;
- 				gpmc,adv-rd-off-ns = <34>;
- 				gpmc,adv-wr-off-ns = <44>;
- 				gpmc,we-on-ns = <0>;
- 				gpmc,we-off-ns = <40>;
- 				gpmc,oe-on-ns = <0>;
- 				gpmc,oe-off-ns = <54>;
- 				gpmc,access-ns = <64>;
- 				gpmc,rd-cycle-ns = <82>;
- 				gpmc,wr-cycle-ns = <82>;
- 				gpmc,wait-on-read = "true";
- 				gpmc,wait-on-write = "true";
- 				gpmc,bus-turnaround-ns = <0>;
- 				gpmc,cycle2cycle-delay-ns = <0>;
- 				gpmc,clk-activation-ns = <0>;
- 				gpmc,wait-monitoring-ns = <0>;
- 				gpmc,wr-access-ns = <40>;
- 				gpmc,wr-data-mux-bus-ns = <0>;
- 
- 				#address-cells = <1>;
- 				#size-cells = <1>;
- 				elm_id = <&elm>;
- 
- 				/* MTD partition table */
- 				partition at 0 {
- 					label = "SPL1";
- 					reg = <0x00000000 0x000020000>;
- 				};
- 
- 				partition at 1 {
- 					label = "SPL2";
- 					reg = <0x00020000 0x00020000>;
- 				};
- 
- 				partition at 2 {
- 					label = "SPL3";
- 					reg = <0x00040000 0x00020000>;
- 				};
- 
- 				partition at 3 {
- 					label = "SPL4";
- 					reg = <0x00060000 0x00020000>;
- 				};
- 
- 				partition at 4 {
- 					label = "U-boot";
- 					reg = <0x00080000 0x001e0000>;
- 				};
- 
- 				partition at 5 {
- 					label = "environment";
- 					reg = <0x00260000 0x00020000>;
- 				};
- 
- 				partition at 6 {
- 					label = "Kernel";
- 					reg = <0x00280000 0x00500000>;
- 				};
- 
- 				partition at 7 {
- 					label = "File-System";
- 					reg = <0x00780000 0x0F880000>;
- 				};
- 			};
- 		};
 +	};
 +
  	vbat: fixedregulator at 0 {
  		compatible = "regulator-fixed";
  		regulator-name = "vbat";
diff --cc arch/arm/boot/dts/am335x-evmsk.dts
index a6c5033,8e7279b..0000000
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@@ -30,210 -30,6 +30,24 @@@
  		reg = <0x80000000 0x10000000>; /* 256 MB */
  	};
  
- 	am33xx_pinmux: pinmux at 44e10800 {
- 		pinctrl-names = "default";
- 		pinctrl-0 = <&gpio_keys_s0 &clkout2_pin>;
- 
- 		user_leds_s0: user_leds_s0 {
- 			pinctrl-single,pins = <
- 				0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
- 				0x14 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
- 				0x18 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
- 				0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
- 			>;
- 		};
- 
- 		gpio_keys_s0: gpio_keys_s0 {
- 			pinctrl-single,pins = <
- 				0x94 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
- 				0x90 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
- 				0x70 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
- 				0x9c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
- 			>;
- 		};
- 
- 		i2c0_pins: pinmux_i2c0_pins {
- 			pinctrl-single,pins = <
- 				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
- 				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
- 			>;
- 		};
- 
- 		uart0_pins: pinmux_uart0_pins {
- 			pinctrl-single,pins = <
- 				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
- 				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
- 			>;
- 		};
- 
- 		clkout2_pin: pinmux_clkout2_pin {
- 			pinctrl-single,pins = <
- 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
- 			>;
- 		};
- 
- 		ecap2_pins: backlight_pins {
- 			pinctrl-single,pins = <
- 				0x19c 0x4	/* mcasp0_ahclkr.ecap2_in_pwm2_out MODE4 */
- 			>;
- 		};
- 
- 		cpsw_default: cpsw_default {
- 			pinctrl-single,pins = <
- 				/* Slave 1 */
- 				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
- 				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
- 				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
- 				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
- 				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
- 				0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
- 
- 				/* Slave 2 */
- 				0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
- 				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
- 				0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
- 				0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
- 				0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
- 				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
- 				0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
- 				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
- 				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
- 				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
- 				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
- 				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
- 			>;
- 		};
- 
- 		cpsw_sleep: cpsw_sleep {
- 			pinctrl-single,pins = <
- 				/* Slave 1 reset value */
- 				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 
- 				/* Slave 2 reset value*/
- 				0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 
- 		davinci_mdio_default: davinci_mdio_default {
- 			pinctrl-single,pins = <
- 				/* MDIO */
- 				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
- 				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
- 			>;
- 		};
- 
- 		davinci_mdio_sleep: davinci_mdio_sleep {
- 			pinctrl-single,pins = <
- 				/* MDIO reset value */
- 				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 	};
- 
 +	ocp {
- 		uart0: serial at 44e09000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&uart0_pins>;
- 
- 			status = "okay";
- 		};
- 
- 		i2c0: i2c at 44e0b000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c0_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <400000>;
- 
- 			tps: tps at 2d {
- 				reg = <0x2d>;
- 			};
- 
- 			lis331dlh: lis331dlh at 18 {
- 				compatible = "st,lis331dlh", "st,lis3lv02d";
- 				reg = <0x18>;
- 				Vdd-supply = <&lis3_reg>;
- 				Vdd_IO-supply = <&lis3_reg>;
- 
- 				st,click-single-x;
- 				st,click-single-y;
- 				st,click-single-z;
- 				st,click-thresh-x = <10>;
- 				st,click-thresh-y = <10>;
- 				st,click-thresh-z = <10>;
- 				st,irq1-click;
- 				st,irq2-click;
- 				st,wakeup-x-lo;
- 				st,wakeup-x-hi;
- 				st,wakeup-y-lo;
- 				st,wakeup-y-hi;
- 				st,wakeup-z-lo;
- 				st,wakeup-z-hi;
- 				st,min-limit-x = <120>;
- 				st,min-limit-y = <120>;
- 				st,min-limit-z = <140>;
- 				st,max-limit-x = <550>;
- 				st,max-limit-y = <550>;
- 				st,max-limit-z = <750>;
- 			};
- 		};
- 
 +		musb: usb at 47400000 {
 +			status = "okay";
 +
 +			control at 44e10000 {
 +				status = "okay";
 +			};
 +
 +			usb-phy at 47401300 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401000 {
 +				status = "okay";
 +			};
 +		};
- 
- 		epwmss2: epwmss at 48304000 {
- 			status = "okay";
- 
- 			ecap2: ecap at 48304100 {
- 				status = "okay";
- 				pinctrl-names = "default";
- 				pinctrl-0 = <&ecap2_pins>;
- 			};
- 		};
 +	};
 +
  	vbat: fixedregulator at 0 {
  		compatible = "regulator-fixed";
  		regulator-name = "vbat";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/a1c40af7/attachment-0001.sig>
