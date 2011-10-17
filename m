From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Oct 2011 12:29:21 +0200
Subject: [RFC] clocktree representation in the devicetree
Message-ID: <20111017102921.GA18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

The following is an attempt to represent the clocktree of a i.MX53 in
the devicetree. I created this to see how it would look like and to
start a discussion whether we want to move in this direction or not.

Some things to consider:

- It seems to be very flexible. A board can customize the clock tree
  by just adding some clk-parent=<phandle> properties to the muxers.
- clocks can easily be associated with devices.

but:

- The following example registers 127 new platform devices and it's
  not even complete. This adds significant overhead to initialization.



(btw I wasn't crazy enough to handcode the clocktree below, I wrote
a little program which initializes the tree from static c code and
then prints it out. I hope this is enough for playing with different
clock tree formats with a real life example tree. If anyones interested
in the program, let me know)


Sascha

	clock {
		ckil: clkfixed-ckil {
			rate = <0x00008000>;
			compatible = "clk-fixed";
		};
		osc: clkfixed-osc {
			rate = <0x016e3600>;
			compatible = "clk-fixed";
			pll1: pll at 0x63f80000 {
				reg = <0x63f80000 0x4000>;
				compatible = "fsl,imx53-pll";
				cpu_podf: divider-cpu_podf at 0x53fd4010 {
					reg = <0x53fd4010 0x0>;
					shift = <0x00000000>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
			pll2: pll at 0x63f84000 {
				reg = <0x63f84000 0x4000>;
				compatible = "fsl,imx53-pll";
			};
			pll3: pll at 0x63f88000 {
				reg = <0x63f88000 0x4000>;
				compatible = "fsl,imx53-pll";
				usb_phy_pred: divider-usb_phy_pred at 0x53fd4030 {
					reg = <0x53fd4030 0x0>;
					shift = <0x00000003>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
					usb_phy_podf: divider-usb_phy_podf at 0x53fd4030 {
						reg = <0x53fd4030 0x0>;
						shift = <0x00000000>;
						width = <0x00000003>;
						compatible = "fsl,imx53-clk-divider";
					};
				};
				di1_pred: divider-di1_pred at 0x53fd4030 {
					reg = <0x53fd4030 0x0>;
					shift = <0x00000006>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
			pll4: pll at 0x63f8c000 {
				reg = <0x63f8c000 0x4000>;
				compatible = "fsl,imx53-pll";
				di_pll4_podf: divider-di_pll4_podf at 0x53fd4030 {
					reg = <0x53fd4030 0x0>;
					shift = <0x00000010>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
			can2_serial_gate: gate-can2_serial_gate at 0x53fd4078 {
				reg = <0x53fd4078 0x0>;
				shift = <0x00000003>;
				compatible = "fsl,imx53-clk-gate";
			};
			can1_serial_gate: gate-can1_serial_gate at 0x53fd4080 {
				reg = <0x53fd4080 0x0>;
				shift = <0x0000000b>;
				compatible = "fsl,imx53-clk-gate";
			};
		};
		ckih1: clkfixed-ckih1 {
			rate = <0x01588800>;
			compatible = "clk-fixed";
		};
		ckih2: clkfixed-ckih2 {
			rate = <0x00000000>;
			compatible = "clk-fixed";
		};
		lp_apm: clkmux-lp_apm at 0x53fd400c {
			reg = <0x53fd400c 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&osc 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		periph_apm: clkmux-periph_apm at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll3 &lp_apm 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		main_bus: clkmux-main_bus at 0x53fd4014 {
			reg = <0x53fd4014 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&pll2 &periph_apm>;
			compatible = "fsl,imx53-clk-mux";
			ahb_root: divider-ahb_root at 0x53fd4014 {
				reg = <0x53fd4014 0x0>;
				shift = <0x0000000a>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				ipg: divider-ipg at 0x53fd4014 {
					reg = <0x53fd4014 0x0>;
					shift = <0x00000008>;
					width = <0x00000002>;
					compatible = "fsl,imx53-clk-divider";
					iim_gate: gate-iim_gate at 0x53fd4068 {
						reg = <0x53fd4068 0x0>;
						shift = <0x0000000f>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart1_ipg_gate: gate-uart1_ipg_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000003>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart2_ipg_gate: gate-uart2_ipg_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000005>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart3_ipg_gate: gate-uart3_ipg_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000007>;
						compatible = "fsl,imx53-clk-gate";
					};
					epit1_ipg_gate: gate-epit1_ipg_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x00000001>;
						compatible = "fsl,imx53-clk-gate";
					};
					epit2_ipg_gate: gate-epit2_ipg_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x00000003>;
						compatible = "fsl,imx53-clk-gate";
					};
					pwm1_ipg_gate: gate-pwm1_ipg_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x00000005>;
						compatible = "fsl,imx53-clk-gate";
					};
					pwm2_ipg_gate: gate-pwm2_ipg_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x00000007>;
						compatible = "fsl,imx53-clk-gate";
					};
					gpt_ipg_gate: gate-gpt_ipg_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x00000009>;
						compatible = "fsl,imx53-clk-gate";
					};
					fec_gate: gate-fec_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x0000000c>;
						compatible = "fsl,imx53-clk-gate";
					};
					usboh3_ahb_gate: gate-usboh3_ahb_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x0000000d>;
						compatible = "fsl,imx53-clk-gate";
					};
					esdhc1_ipg_gate: gate-esdhc1_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000000>;
						compatible = "fsl,imx53-clk-gate";
					};
					esdhc2_ipg_gate: gate-esdhc2_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000002>;
						compatible = "fsl,imx53-clk-gate";
					};
					esdhc3_ipg_gate: gate-esdhc3_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000004>;
						compatible = "fsl,imx53-clk-gate";
					};
					esdhc4_ipg_gate: gate-esdhc4_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000006>;
						compatible = "fsl,imx53-clk-gate";
					};
					ssi1_ipg_gate: gate-ssi1_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000008>;
						compatible = "fsl,imx53-clk-gate";
					};
					ssi2_ipg_gate: gate-ssi2_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000009>;
						compatible = "fsl,imx53-clk-gate";
					};
					ssi3_ipg_gate: gate-ssi3_ipg_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x0000000a>;
						compatible = "fsl,imx53-clk-gate";
					};
					pata_gate: gate-pata_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x00000000>;
						compatible = "fsl,imx53-clk-gate";
					};
					can2_ipg_gate: gate-can2_ipg_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x00000002>;
						compatible = "fsl,imx53-clk-gate";
					};
					ecspi1_ipg_gate: gate-ecspi1_ipg_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x00000009>;
						compatible = "fsl,imx53-clk-gate";
					};
					ecspi2_ipg_gate: gate-ecspi2_ipg_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x0000000b>;
						compatible = "fsl,imx53-clk-gate";
					};
					cspi_ipg_gate: gate-cspi_ipg_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x0000000d>;
						compatible = "fsl,imx53-clk-gate";
					};
					sdma_gate: gate-sdma_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x0000000f>;
						compatible = "fsl,imx53-clk-gate";
					};
					can1_ipg_gate: gate-can1_ipg_gate at 0x53fd4080 {
						reg = <0x53fd4080 0x0>;
						shift = <0x0000000a>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart4_ipg_gate: gate-uart4_ipg_gate at 0x53fd4084 {
						reg = <0x53fd4084 0x0>;
						shift = <0x00000004>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart5_ipg_gate: gate-uart5_ipg_gate at 0x53fd4084 {
						reg = <0x53fd4084 0x0>;
						shift = <0x00000006>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
				sata_gate: gate-sata_gate at 0x53fd4078 {
					reg = <0x53fd4078 0x0>;
					shift = <0x00000001>;
					compatible = "fsl,imx53-clk-gate";
				};
			};
			axi_a: divider-axi_a at 0x53fd4014 {
				reg = <0x53fd4014 0x0>;
				shift = <0x00000010>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
			};
			axi_b: divider-axi_b at 0x53fd4014 {
				reg = <0x53fd4014 0x0>;
				shift = <0x00000013>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
			};
		};
		per_lp_apm_sel: clkmux-per_lp_apm_sel at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&main_bus &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			per_pred1: divider-per_pred1 at 0x53fd4014 {
				reg = <0x53fd4014 0x0>;
				shift = <0x00000006>;
				width = <0x00000002>;
				compatible = "fsl,imx53-clk-divider";
				per_pred2: divider-per_pred2 at 0x53fd4014 {
					reg = <0x53fd4014 0x0>;
					shift = <0x00000003>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
					per_podf: divider-per_podf at 0x53fd4014 {
						reg = <0x53fd4014 0x0>;
						shift = <0x00000000>;
						width = <0x00000003>;
						compatible = "fsl,imx53-clk-divider";
					};
				};
			};
		};
		per_root: clkmux-per_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&per_podf &ipg>;
			compatible = "fsl,imx53-clk-mux";
			i2c1_gate: gate-i2c1_gate at 0x53fd406c {
				reg = <0x53fd406c 0x0>;
				shift = <0x00000009>;
				compatible = "fsl,imx53-clk-gate";
			};
			i2c2_gate: gate-i2c2_gate at 0x53fd406c {
				reg = <0x53fd406c 0x0>;
				shift = <0x0000000a>;
				compatible = "fsl,imx53-clk-gate";
			};
			i2c3_gate: gate-i2c3_gate at 0x53fd406c {
				reg = <0x53fd406c 0x0>;
				shift = <0x0000000b>;
				compatible = "fsl,imx53-clk-gate";
			};
			epit1_hf_gate: gate-epit1_hf_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x00000002>;
				compatible = "fsl,imx53-clk-gate";
			};
			epit2_hf_gate: gate-epit2_hf_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x00000004>;
				compatible = "fsl,imx53-clk-gate";
			};
			pwm1_hf_gate: gate-pwm1_hf_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x00000006>;
				compatible = "fsl,imx53-clk-gate";
			};
			pwm2_hf_gate: gate-pwm2_hf_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x00000008>;
				compatible = "fsl,imx53-clk-gate";
			};
			gpt_gate: gate-gpt_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x0000000a>;
				compatible = "fsl,imx53-clk-gate";
			};
			owire_gate: gate-owire_gate at 0x53fd4070 {
				reg = <0x53fd4070 0x0>;
				shift = <0x0000000b>;
				compatible = "fsl,imx53-clk-gate";
			};
		};
		uart_sel: clkmux-uart_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			uart_pred: divider-uart_pred at 0x53fd4024 {
				reg = <0x53fd4024 0x0>;
				shift = <0x00000003>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				uart_root: divider-uart_root at 0x53fd4024 {
					reg = <0x53fd4024 0x0>;
					shift = <0x00000000>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
					uart1_per_gate: gate-uart1_per_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000004>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart2_per_gate: gate-uart2_per_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000006>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart3_per_gate: gate-uart3_per_gate at 0x53fd406c {
						reg = <0x53fd406c 0x0>;
						shift = <0x00000008>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart4_per_gate: gate-uart4_per_gate at 0x53fd4084 {
						reg = <0x53fd4084 0x0>;
						shift = <0x00000005>;
						compatible = "fsl,imx53-clk-gate";
					};
					uart5_per_gate: gate-uart5_per_gate at 0x53fd4084 {
						reg = <0x53fd4084 0x0>;
						shift = <0x00000007>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
			};
		};
		esdhc1_sel: clkmux-esdhc1_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			esdhc1_pred: divider-esdhc1_pred at 0x53fd4024 {
				reg = <0x53fd4024 0x0>;
				shift = <0x00000010>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				esdhc1_podf: divider-esdhc1_podf at 0x53fd4024 {
					reg = <0x53fd4024 0x0>;
					shift = <0x0000000b>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
					esdhc1_per_gate: gate-esdhc1_per_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000001>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
			};
		};
		esdhc3_sel: clkmux-esdhc3_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			esdhc3_pred: divider-esdhc3_pred at 0x53fd4024 {
				reg = <0x53fd4024 0x0>;
				shift = <0x00000016>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				esdhc3_podf: divider-esdhc3_podf at 0x53fd4024 {
					reg = <0x53fd4024 0x0>;
					shift = <0x00000013>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
					esdhc2_per_gate: gate-esdhc2_per_gate at 0x53fd4074 {
						reg = <0x53fd4074 0x0>;
						shift = <0x00000003>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
			};
		};
		esdhc3: clkmux-esdhc3 at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&esdhc1_podf &esdhc3_podf>;
			compatible = "fsl,imx53-clk-mux";
			esdhc3_per_gate: gate-esdhc3_per_gate at 0x53fd4074 {
				reg = <0x53fd4074 0x0>;
				shift = <0x00000005>;
				compatible = "fsl,imx53-clk-gate";
			};
		};
		esdhc4: clkmux-esdhc4 at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&esdhc1_podf &esdhc3_podf>;
			compatible = "fsl,imx53-clk-mux";
			esdhc4_per_gate: gate-esdhc4_per_gate at 0x53fd4074 {
				reg = <0x53fd4074 0x0>;
				shift = <0x00000007>;
				compatible = "fsl,imx53-clk-gate";
			};
		};
		ssi1_sel: clkmux-ssi1_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 0>;
			compatible = "fsl,imx53-clk-mux";
			ssi1_pred: divider-ssi1_pred at 0x53fd4028 {
				reg = <0x53fd4028 0x0>;
				shift = <0x00000006>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				ssi1_podf: divider-ssi1_podf at 0x53fd4028 {
					reg = <0x53fd4028 0x0>;
					shift = <0x00000000>;
					width = <0x00000006>;
					compatible = "fsl,imx53-clk-divider";
				};
				ssi2_podf: divider-ssi2_podf at 0x53fd402c {
					reg = <0x53fd402c 0x0>;
					shift = <0x00000000>;
					width = <0x00000006>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
			ssi2_pred: divider-ssi2_pred at 0x53fd402c {
				reg = <0x53fd402c 0x0>;
				shift = <0x00000006>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
			};
		};
		ssi2_sel: clkmux-ssi2_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		ssi1_root: clkmux-ssi1_root at 0x53fd4034 {
			reg = <0x53fd4034 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&ssi1_podf 0 0 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		ssi2_root: clkmux-ssi2_root at 0x53fd4034 {
			reg = <0x53fd4034 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&ssi2_podf 0 0 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		ssi3_root: clkmux-ssi3_root at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&ssi1_root &ssi2_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		emi_sel: clkmux-emi_sel at 0x53fd4014 {
			reg = <0x53fd4014 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&main_bus &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
			emi_slow_root: divider-emi_slow_root at 0x53fd4014 {
				reg = <0x53fd4014 0x0>;
				shift = <0x00000016>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				enfc_root: divider-enfc_root at 0x53fd4014 {
					reg = <0x53fd4014 0x0>;
					shift = <0x0000000d>;
					width = <0x00000003>;
					compatible = "fsl,imx53-clk-divider";
				};
				emi_slow_gate: gate-emi_slow_gate at 0x53fd407c {
					reg = <0x53fd407c 0x0>;
					shift = <0x00000008>;
					compatible = "fsl,imx53-clk-gate";
				};
			};
		};
		ecspi_sel: clkmux-ecspi_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			ecspi_pred: divider-ecspi_pred at 0x53fd4038 {
				reg = <0x53fd4038 0x0>;
				shift = <0x00000019>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				ecspi_podf: divider-ecspi_podf at 0x53fd4038 {
					reg = <0x53fd4038 0x0>;
					shift = <0x00000013>;
					width = <0x00000006>;
					compatible = "fsl,imx53-clk-divider";
					ecspi1_per_gate: gate-ecspi1_per_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x0000000a>;
						compatible = "fsl,imx53-clk-gate";
					};
					ecspi2_per_gate: gate-ecspi2_per_gate at 0x53fd4078 {
						reg = <0x53fd4078 0x0>;
						shift = <0x0000000c>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
			};
		};
		usboh3_sel: clkmux-usboh3_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll2 &pll3 &lp_apm>;
			compatible = "fsl,imx53-clk-mux";
			usboh3_pred: divider-usboh3_pred at 0x53fd4024 {
				reg = <0x53fd4024 0x0>;
				shift = <0x00000008>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				usboh3_root: divider-usboh3_root at 0x53fd4024 {
					reg = <0x53fd4024 0x0>;
					shift = <0x00000006>;
					width = <0x00000002>;
					compatible = "fsl,imx53-clk-divider";
					usboh3_gate: gate-usboh3_gate at 0x53fd4070 {
						reg = <0x53fd4070 0x0>;
						shift = <0x0000000e>;
						compatible = "fsl,imx53-clk-gate";
					};
				};
			};
		};
		usb_phy_root: clkmux-usb_phy_root at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&osc &usb_phy_podf>;
			compatible = "fsl,imx53-clk-mux";
			mx53_usb_phy1_gate: gate-mx53_usb_phy1_gate at 0x53fd4078 {
				reg = <0x53fd4078 0x0>;
				shift = <0x00000005>;
				compatible = "fsl,imx53-clk-gate";
			};
			mx53_usb_phy2_gate: gate-mx53_usb_phy2_gate at 0x53fd4078 {
				reg = <0x53fd4078 0x0>;
				shift = <0x00000006>;
				compatible = "fsl,imx53-clk-gate";
			};
		};
		tve_ext_sel: clkmux-tve_ext_sel at 0x53fd401c {
			reg = <0x53fd401c 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&pll4 &ckih1>;
			compatible = "fsl,imx53-clk-mux";
			tve_pred: divider-tve_pred at 0x53fd4030 {
				reg = <0x53fd4030 0x0>;
				shift = <0x0000001c>;
				width = <0x00000003>;
				compatible = "fsl,imx53-clk-divider";
				tve_gate: gate-tve_gate at 0x53fd4070 {
					reg = <0x53fd4070 0x0>;
					shift = <0x0000000f>;
					compatible = "fsl,imx53-clk-gate";
				};
			};
		};
		ldb_di0_serial_root: clkmux-ldb_di0_serial_root at 0x53fd4020 {
			reg = <0x53fd4020 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&pll3 &pll4>;
			compatible = "fsl,imx53-clk-mux";
			ldb_di0_ipu_mul: divider-fixed {
				mult = <0x00000002>;
				div = <0x00000007>;
				compatible = "clk-divider-fixed";
				ldb_di0_ipu: divider-ldb_di0_ipu at 0x53fd4020 {
					reg = <0x53fd4020 0x0>;
					shift = <0x0000000a>;
					width = <0x00000001>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
		};
		ldb_di1_serial_root: clkmux-ldb_di1_serial_root at 0x53fd4020 {
			reg = <0x53fd4020 0x0>;
			shift = <0x00000000>;
			width = <0x00000001>;
			parent = <&pll3 &pll4>;
			compatible = "fsl,imx53-clk-mux";
			ldb_di1_ipu_mul: divider-fixed {
				mult = <0x00000002>;
				div = <0x00000007>;
				compatible = "clk-divider-fixed";
				ldb_di1_ipu: divider-ldb_di1_ipu at 0x53fd4020 {
					reg = <0x53fd4020 0x0>;
					shift = <0x0000000b>;
					width = <0x00000001>;
					compatible = "fsl,imx53-clk-divider";
				};
			};
		};
		di1_root: clkmux-di1_root at 0x53fd4020 {
			reg = <0x53fd4020 0x0>;
			shift = <0x00000000>;
			width = <0x00000003>;
			parent = <&di1_pred &osc &ckih1 0 0 &ldb_di1_ipu 0 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		di0_root: clkmux-di0_root at 0x53fd4020 {
			reg = <0x53fd4020 0x0>;
			shift = <0x00000000>;
			width = <0x00000003>;
			parent = <&di1_pred &osc &ckih1 &di_pll4_podf 0 &ldb_di0_ipu 0 0>;
			compatible = "fsl,imx53-clk-mux";
		};
		gpu2d_root: clkmux-gpu2d_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		arm_axi_root: clkmux-arm_axi_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		ipu_hsp_root: clkmux-ipu_hsp_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		gpu_root: clkmux-gpu_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		vpu_axi_root: clkmux-vpu_axi_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		debug_apb_root: clkmux-debug_apb_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
		ddr_root: clkmux-ddr_root at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&axi_a &axi_b &emi_slow_root &ahb_root>;
			compatible = "fsl,imx53-clk-mux";
		};
	};
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
