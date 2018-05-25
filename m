From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 25 May 2018 06:08:20 +0000
Subject: [PATCH v6 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
In-Reply-To: <HE1PR04MB3113D024D0BCCB6B96F0D8F687690@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <1526899612-22856-1-git-send-email-ping.bai@nxp.com>
 <AM0PR04MB42110730C8F91B61CC32168480690@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <HE1PR04MB3113D024D0BCCB6B96F0D8F687690@HE1PR04MB3113.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211C9CDBA0C3DBB510B36F380690@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacky,

> -----Original Message-----
> From: Jacky Bai
> Sent: Friday, May 25, 2018 1:44 PM
> To: A.s. Dong <aisheng.dong@nxp.com>; shawnguo at kernel.org;
> robh+dt at kernel.org; kernel at pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> jacky.baip at gmail.com
> Subject: RE: [PATCH v6 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
> 
> > Subject: RE: [PATCH v6 1/2] ARM: dts: imx: Add basic dtsi file for
> > imx6sll
> >
> > > -----Original Message-----
> > > From: Jacky Bai
> > > Sent: Monday, May 21, 2018 6:47 PM
> > > To: shawnguo at kernel.org; robh+dt at kernel.org; kernel at pengutronix.de
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>;
> > devicetree at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; dl-linux-imx
> > > <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> > > jacky.baip at gmail.com
> > > Subject: [PATCH v6 1/2] ARM: dts: imx: Add basic dtsi file for
> > > imx6sll
> > >
> >
> > [...]
> >
> > [...]
> >
> > > +
> > > +			tempmon: temperature-sensor {
> > > +				compatible = "fsl,imx6sll-tempmon",
> > > "fsl,imx6sx-tempmon";
> > > +				interrupts = <GIC_SPI 49
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				fsl,tempmon = <&anatop>;
> > > +				fsl,tempmon-data = <&ocotp>;
> > > +				clocks = <&clks
> > > IMX6SLL_CLK_PLL3_USB_OTG>;
> > > +				status = "disabled";
> > > +			};
> > > +
> >
> > Pls move it out of SoC node to root node.
> > See:
> > commit 225fa59fddfa7 ("ARM: dts: imx7: Move tempmon node out of bus")
> >
> Ok, will move it out.
> 
> > And probably we need switch to the new way?
> > See:
> > commit de25b9bb4a4 ("ARM: dts: imx7s: add temperature monitor
> > support")
> >
> 
> I prefer to keep it same as other imx6 soc.
> 

Would you please check below patch?
commit a6c856e9a8c ("ARM: dts: imx6sx: Use nvmem-cells for tempmon")
If mx6sll has the same issue as mx6sx, then we may have to use nvmem-cells.

If not, I'm ok with old way.
And please make sure the OTP clk used is correct.

Regards
Dong Aisheng

> BR
> Jacky Bai
> > Otherwise:
> > Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>
> >
> > Regards
> > Dong Aisheng
> >
> > > +			usbphy1: usb-phy at 20c9000 {
> > > +				compatible = "fsl,imx6sll-usbphy",
> > > "fsl,imx6ul-usbphy",
> > > +						"fsl,imx23-usbphy";
> > > +				reg = <0x020c9000 0x1000>;
> > > +				interrupts = <GIC_SPI 40
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USBPHY1>;
> > > +				phy-3p0-supply = <&reg_3p0>;
> > > +				fsl,anatop = <&anatop>;
> > > +			};
> > > +
> > > +			usbphy2: usb-phy at 20ca000 {
> > > +				compatible = "fsl,imx6sll-usbphy",
> > > "fsl,imx6ul-usbphy",
> > > +						"fsl,imx23-usbphy";
> > > +				reg = <0x020ca000 0x1000>;
> > > +				interrupts = <GIC_SPI 41
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
> > > +				phy-reg_3p0-supply = <&reg_3p0>;
> > > +				fsl,anatop = <&anatop>;
> > > +			};
> > > +
> > > +			snvs: snvs at 20cc000 {
> > > +				compatible = "fsl,sec-v4.0-mon", "syscon",
> > > "simple-mfd";
> > > +				reg = <0x020cc000 0x4000>;
> > > +
> > > +				snvs_rtc: snvs-rtc-lp {
> > > +					compatible = "fsl,sec-v4.0-mon-rtc-
> > > lp";
> > > +					regmap = <&snvs>;
> > > +					offset = <0x34>;
> > > +					interrupts = <GIC_SPI 19
> > > IRQ_TYPE_LEVEL_HIGH>,
> > > +						     <GIC_SPI 20
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				};
> > > +
> > > +				snvs_poweroff: snvs-poweroff {
> > > +					compatible = "syscon-poweroff";
> > > +					regmap = <&snvs>;
> > > +					offset = <0x38>;
> > > +					mask = <0x61>;
> > > +				};
> > > +
> > > +				snvs_pwrkey: snvs-powerkey {
> > > +					compatible = "fsl,sec-v4.0-pwrkey";
> > > +					regmap = <&snvs>;
> > > +					interrupts = <GIC_SPI 4
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +					linux,keycode = <KEY_POWER>;
> > > +					wakeup-source;
> > > +				};
> > > +			};
> > > +
> > > +			src: reset-controller at 20d8000 {
> > > +				compatible = "fsl,imx6sll-src";
> > > +				reg = <0x020d8000 0x4000>;
> > > +				interrupts = <GIC_SPI 91
> > > IRQ_TYPE_LEVEL_HIGH>,
> > > +					     <GIC_SPI 96
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				#reset-cells = <1>;
> > > +			};
> > > +
> > > +			gpc: interrupt-controller at 20dc000 {
> > > +				compatible = "fsl,imx6sll-gpc", "fsl,imx6q-
> > > gpc";
> > > +				reg = <0x020dc000 0x4000>;
> > > +				interrupt-controller;
> > > +				#interrupt-cells = <3>;
> > > +				interrupts = <GIC_SPI 89
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				interrupt-parent = <&intc>;
> > > +				fsl,mf-mix-wakeup-irq = <0x7c00000 0x7d00
> > > 0x0 0x1400640>;
> > > +			};
> > > +
> > > +			iomuxc: pinctrl at 20e0000 {
> > > +				compatible = "fsl,imx6sll-iomuxc";
> > > +				reg = <0x020e0000 0x4000>;
> > > +			};
> > > +
> > > +			gpr: iomuxc-gpr at 20e4000 {
> > > +				compatible = "fsl,imx6sll-iomuxc-gpr",
> > > +					     "fsl,imx6q-iomuxc-gpr", "syscon";
> > > +				reg = <0x020e4000 0x4000>;
> > > +			};
> > > +
> > > +			csi: csi at 20e8000 {
> > > +				compatible = "fsl,imx6sll-csi", "fsl,imx6s-csi";
> > > +				reg = <0x020e8000 0x4000>;
> > > +				interrupts = <GIC_SPI 7
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_DUMMY>,
> > > +					 <&clks IMX6SLL_CLK_CSI>,
> > > +					 <&clks IMX6SLL_CLK_DUMMY>;
> > > +				clock-names = "disp-axi", "csi_mclk",
> > > "disp_dcic";
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			sdma: dma-controller at 20ec000 {
> > > +				compatible = "fsl,imx6sll-sdma", "fsl,imx35-
> > > sdma";
> > > +				reg = <0x020ec000 0x4000>;
> > > +				interrupts = <GIC_SPI 2
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_SDMA>,
> > > +					 <&clks IMX6SLL_CLK_SDMA>;
> > > +				clock-names = "ipg", "ahb";
> > > +				#dma-cells = <3>;
> > > +				iram = <&ocram>;
> > > +				fsl,sdma-ram-script-name =
> > > "imx/sdma/sdma-imx6q.bin";
> > > +			};
> > > +
> > > +			lcdif: lcd-controller at 20f8000 {
> > > +				compatible = "fsl,imx6sll-lcdif", "fsl,imx28-
> > > lcdif";
> > > +				reg = <0x020f8000 0x4000>;
> > > +				interrupts = <GIC_SPI 39
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_LCDIF_PIX>,
> > > +					 <&clks IMX6SLL_CLK_LCDIF_APB>,
> > > +					 <&clks IMX6SLL_CLK_DUMMY>;
> > > +				clock-names = "pix", "axi", "disp_axi";
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			dcp: dcp at 20fc000 {
> > > +				compatible = "fsl,imx28-dcp";
> > > +				reg = <0x020fc000 0x4000>;
> > > +				interrupts = <GIC_SPI 99
> > > IRQ_TYPE_LEVEL_HIGH>,
> > > +					     <GIC_SPI 100
> > > IRQ_TYPE_LEVEL_HIGH>,
> > > +					     <GIC_SPI 101
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_DCP>;
> > > +				clock-names = "dcp";
> > > +			};
> > > +		};
> > > +
> > > +		aips2: aips-bus at 2100000 {
> > > +			compatible = "fsl,aips-bus", "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x02100000 0x100000>;
> > > +			ranges;
> > > +
> > > +			usbotg1: usb at 2184000 {
> > > +				compatible = "fsl,imx6sll-usb", "fsl,imx6ul-
> > > usb",
> > > +						"fsl,imx27-usb";
> > > +				reg = <0x02184000 0x200>;
> > > +				interrupts = <GIC_SPI 43
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USBOH3>;
> > > +				fsl,usbphy = <&usbphy1>;
> > > +				fsl,usbmisc = <&usbmisc 0>;
> > > +				fsl,anatop = <&anatop>;
> > > +				ahb-burst-config = <0x0>;
> > > +				tx-burst-size-dword = <0x10>;
> > > +				rx-burst-size-dword = <0x10>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			usbotg2: usb at 2184200 {
> > > +				compatible = "fsl,imx6sll-usb", "fsl,imx6ul-
> > > usb",
> > > +						"fsl,imx27-usb";
> > > +				reg = <0x02184200 0x200>;
> > > +				interrupts = <GIC_SPI 42
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USBOH3>;
> > > +				fsl,usbphy = <&usbphy2>;
> > > +				fsl,usbmisc = <&usbmisc 1>;
> > > +				ahb-burst-config = <0x0>;
> > > +				tx-burst-size-dword = <0x10>;
> > > +				rx-burst-size-dword = <0x10>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			usbmisc: usbmisc at 2184800 {
> > > +				#index-cells = <1>;
> > > +				compatible = "fsl,imx6sll-usbmisc",
> > > "fsl,imx6ul-usbmisc",
> > > +						"fsl,imx6q-usbmisc";
> > > +				reg = <0x02184800 0x200>;
> > > +			};
> > > +
> > > +			usdhc1: mmc at 2190000 {
> > > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-
> > > usdhc";
> > > +				reg = <0x02190000 0x4000>;
> > > +				interrupts = <GIC_SPI 22
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USDHC1>,
> > > +					 <&clks IMX6SLL_CLK_USDHC1>,
> > > +					 <&clks IMX6SLL_CLK_USDHC1>;
> > > +				clock-names = "ipg", "ahb", "per";
> > > +				bus-width = <4>;
> > > +				fsl,tuning-step = <2>;
> > > +				fsl,tuning-start-tap = <20>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			usdhc2: mmc at 2194000 {
> > > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-
> > > usdhc";
> > > +				reg = <0x02194000 0x4000>;
> > > +				interrupts = <GIC_SPI 23
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USDHC2>,
> > > +					 <&clks IMX6SLL_CLK_USDHC2>,
> > > +					 <&clks IMX6SLL_CLK_USDHC2>;
> > > +				clock-names = "ipg", "ahb", "per";
> > > +				bus-width = <4>;
> > > +				fsl,tuning-step = <2>;
> > > +				fsl,tuning-start-tap = <20>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			usdhc3: mmc at 2198000 {
> > > +				compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-
> > > usdhc";
> > > +				reg = <0x02198000 0x4000>;
> > > +				interrupts = <GIC_SPI 24
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_USDHC3>,
> > > +					 <&clks IMX6SLL_CLK_USDHC3>,
> > > +					 <&clks IMX6SLL_CLK_USDHC3>;
> > > +				clock-names = "ipg", "ahb", "per";
> > > +				bus-width = <4>;
> > > +				fsl,tuning-step = <2>;
> > > +				fsl,tuning-start-tap = <20>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			i2c1: i2c at 21a0000 {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +				compatible = "fs,imx6sll-i2c", "fsl,imx21-i2c";
> > > +				reg = <0x021a0000 0x4000>;
> > > +				interrupts = <GIC_SPI 36
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_I2C1>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			i2c2: i2c at 21a4000 {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
> > > +				reg = <0x021a4000 0x4000>;
> > > +				interrupts = <GIC_SPI 37
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_I2C2>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			i2c3: i2c at 21a8000 {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
> > > +				reg = <0x021a8000 0x4000>;
> > > +				interrupts = <GIC_SPI 38
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX6SLL_CLK_I2C3>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			mmdc: memory-controller at 21b0000 {
> > > +				compatible = "fsl,imx6sll-mmdc", "fsl,imx6q-
> > > mmdc";
> > > +				reg = <0x021b0000 0x4000>;
> > > +			};
> > > +
> > > +			ocotp: ocotp-ctrl at 21bc000 {
> > > +				compatible = "fsl,imx6sll-ocotp", "syscon";
> > > +				reg = <0x021bc000 0x4000>;
> > > +				clocks = <&clks IMX6SLL_CLK_OCOTP>;
> > > +			};
> > > +
> > > +			audmux: audmux at 21d8000 {
> > > +				compatible = "fsl,imx6sll-audmux",
> > > "fsl,imx31-audmux";
> > > +				reg = <0x021d8000 0x4000>;
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			uart5: serial at 21f4000 {
> > > +				compatible = "fsl,imx6sll-uart", "fsl,imx6q-
> > > uart",
> > > +					     "fsl,imx21-uart";
> > > +				reg = <0x021f4000 0x4000>;
> > > +				interrupts =<GIC_SPI 30
> > > IRQ_TYPE_LEVEL_HIGH>;
> > > +				dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
> > > +				dma-names = "rx", "tx";
> > > +				clocks = <&clks IMX6SLL_CLK_UART5_IPG>,
> > > +					 <&clks
> > > IMX6SLL_CLK_UART5_SERIAL>;
> > > +				clock-names = "ipg", "per";
> > > +				status = "disabled";
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > --
> > > 1.9.1
