From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 2 Jul 2018 08:03:11 +0530
Subject: [PATCH v2 1/3] arm64: dts: actions: Enable clock controller for
 S700
In-Reply-To: <279840d3-a254-394d-7782-b3f837c59e57@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-2-sravanhome@gmail.com>
 <20180630094259.GC7320@Mani-XPS-13-9360>
 <279840d3-a254-394d-7782-b3f837c59e57@gmail.com>
Message-ID: <20180702023311.GB2654@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 01, 2018 at 07:50:01PM +0200, Saravanan Sekar wrote:
> Hi Mani,
> 
> 
> On 06/30/18 11:42, Manivannan Sadhasivam wrote:
> > On Thu, Jun 28, 2018 at 09:18:03PM +0200, Saravanan Sekar wrote:
> > > Added clock management controller for S700
> > > 
> > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
> > >   arch/arm64/boot/dts/actions/s700.dtsi         |   8 ++
> > >   include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++++++++++++++++
> > >   3 files changed, 136 insertions(+), 7 deletions(-)
> > >   create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> > > 
> > > diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > index ef79d7905f44..28f3f4a0f7f0 100644
> > > --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > > @@ -28,12 +28,6 @@
> > >   		device_type = "memory";
> > >   		reg = <0x1 0xe0000000 0x0 0x0>;
> > >   	};
> > > -
> > > -	uart3_clk: uart3-clk {
> > > -		compatible = "fixed-clock";
> > > -		clock-frequency = <921600>;
> > > -		#clock-cells = <0>;
> > > -	};
> > Sourcing CMU clock for UART should be in a separate patch.
> 
> sure
> 
> > >   };
> > >   &timer {
> > > @@ -42,5 +36,4 @@
> > >   &uart3 {
> > >   	status = "okay";
> > > -	clocks = <&uart3_clk>;
> > >   };
> > > diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> > > index 66dd5309f0a2..3530b705df90 100644
> > > --- a/arch/arm64/boot/dts/actions/s700.dtsi
> > > +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> > > @@ -4,6 +4,7 @@
> > >    */
> > >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include <dt-bindings/clock/actions,s700-cmu.h>
> > >   / {
> > >   	compatible = "actions,s700";
> > > @@ -44,6 +45,12 @@
> > >   		};
> > >   	};
> > > +	clock: clock-controller at e0168000 {
> > > +		compatible = "actions,s700-cmu";
> > > +		reg = <0 0xe0168000 0 0x1000>;
> > > +		#clock-cells = <1>;
> > > +	};
> > > +
> > There is no fixed rate clock like losc?
> 
> losc is 32k, I will add it
> 
> > >   	reserved-memory {
> > >   		#address-cells = <2>;
> > >   		#size-cells = <2>;
> > > @@ -129,6 +136,7 @@
> > >   			compatible = "actions,s900-uart", "actions,owl-uart";
> > >   			reg = <0x0 0xe0126000 0x0 0x2000>;
> > >   			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&clock CLK_UART3>;
> > >   			status = "disabled";
> > >   		};
> > > diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
> > > new file mode 100644
> > > index 000000000000..e5b4ea130953
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/actions,s700-cmu.h
> > > @@ -0,0 +1,128 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Actions S700 clock driver
> > > + *
> > > + * Copyright (c) 2014 Actions Semi Inc.
> > > + * Author: David Liu <liuwei@actions-semi.com>
> > > + *
> > > + * Author: Pathiban Nallathambi <pn@denx.de>
> > > + * Author: Saravanan Sekar <sravanhome@gmail.com>
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_CLOCK_S700_H
> > > +#define __DT_BINDINGS_CLOCK_S700_H
> > > +
> > > +#define CLK_NONE			0
> > > +
> > > +/* fixed rate clocks */
> > > +#define CLK_LOSC			1
> > > +#define CLK_HOSC			2
> > > +
> > > +/* pll clocks */
> > > +#define CLK_CORE_PLL			3
> > > +#define CLK_DEV_PLL			4
> > > +#define CLK_DDR_PLL			5
> > > +#define CLK_NAND_PLL			6
> > > +#define CLK_DISPLAY_PLL			7
> > > +#define CLK_TVOUT_PLL			8
> > > +#define CLK_CVBS_PLL			9
> > > +#define CLK_AUDIO_PLL			10
> > > +#define CLK_ETHERNET_PLL		11
> > > +
> > Remove extra new line please.
> > 
> > > +
> > > +/* system clock */
> > > +#define CLK_SYS_BASE			12
> > > +#define CLK_CPU				CLK_SYS_BASE
> > > +#define CLK_DEV				(CLK_SYS_BASE+1)
> > > +#define CLK_AHB				(CLK_SYS_BASE+2)
> > > +#define CLK_APB				(CLK_SYS_BASE+3)
> > > +#define CLK_DMAC			(CLK_SYS_BASE+4)
> > > +#define CLK_NOC0_CLK_MUX		(CLK_SYS_BASE+5)
> > > +#define CLK_NOC1_CLK_MUX		(CLK_SYS_BASE+6)
> > > +#define CLK_HP_CLK_MUX			(CLK_SYS_BASE+7)
> > > +#define CLK_HP_CLK_DIV			(CLK_SYS_BASE+8)
> > > +#define CLK_NOC1_CLK_DIV		(CLK_SYS_BASE+9)
> > > +#define CLK_NOC0			(CLK_SYS_BASE+10)
> > > +#define CLK_NOC1			(CLK_SYS_BASE+11)
> > > +#define CLK_SENOR_SRC			(CLK_SYS_BASE+12)
> > > +
> > > +/* peripheral device clock */
> > > +#define CLK_PERIP_BASE			25
> > > +#define CLK_GPIO			(CLK_PERIP_BASE)
> > > +#define CLK_TIMER			(CLK_PERIP_BASE+1)
> > > +#define CLK_DSI				(CLK_PERIP_BASE+2)
> > > +#define CLK_CSI				(CLK_PERIP_BASE+3)
> > > +#define CLK_SI				(CLK_PERIP_BASE+4)
> > > +#define CLK_DE				(CLK_PERIP_BASE+5)
> > > +#define CLK_HDE				(CLK_PERIP_BASE+6)
> > > +#define CLK_VDE				(CLK_PERIP_BASE+7)
> > > +#define CLK_VCE				(CLK_PERIP_BASE+8)
> > > +#define CLK_NAND			(CLK_PERIP_BASE+9)
> > > +#define CLK_SD0				(CLK_PERIP_BASE+10)
> > > +#define CLK_SD1				(CLK_PERIP_BASE+11)
> > > +#define CLK_SD2				(CLK_PERIP_BASE+12)
> > > +
> > > +#define CLK_UART0			(CLK_PERIP_BASE+13)
> > > +#define CLK_UART1			(CLK_PERIP_BASE+14)
> > > +#define CLK_UART2			(CLK_PERIP_BASE+15)
> > > +#define CLK_UART3			(CLK_PERIP_BASE+16)
> > > +#define CLK_UART4			(CLK_PERIP_BASE+17)
> > > +#define CLK_UART5			(CLK_PERIP_BASE+18)
> > > +#define CLK_UART6			(CLK_PERIP_BASE+19)
> > > +
> > > +#define CLK_PWM0			(CLK_PERIP_BASE+20)
> > > +#define CLK_PWM1			(CLK_PERIP_BASE+21)
> > > +#define CLK_PWM2			(CLK_PERIP_BASE+22)
> > > +#define CLK_PWM3			(CLK_PERIP_BASE+23)
> > > +#define CLK_PWM4			(CLK_PERIP_BASE+24)
> > > +#define CLK_PWM5			(CLK_PERIP_BASE+25)
> > > +#define CLK_GPU3D			(CLK_PERIP_BASE+26)
> > > +
> > > +#define CLK_I2C0			(CLK_PERIP_BASE+27)
> > > +#define CLK_I2C1			(CLK_PERIP_BASE+28)
> > > +#define CLK_I2C2			(CLK_PERIP_BASE+29)
> > > +#define CLK_I2C3			(CLK_PERIP_BASE+30)
> > > +
> > > +
> > > +#define CLK_SPI0			(CLK_PERIP_BASE+31)
> > > +#define CLK_SPI1			(CLK_PERIP_BASE+32)
> > > +#define CLK_SPI2			(CLK_PERIP_BASE+33)
> > > +#define CLK_SPI3			(CLK_PERIP_BASE+34)
> > > +
> > > +#define CLK_USB3_480MPLL0		(CLK_PERIP_BASE+35)
> > > +#define CLK_USB3_480MPHY0		(CLK_PERIP_BASE+36)
> > > +#define CLK_USB3_5GPHY			(CLK_PERIP_BASE+37)
> > > +#define CLK_USB3_CCE			(CLK_PERIP_BASE+48)
> > > +#define CLK_USB3_MAC			(CLK_PERIP_BASE+49)
> > > +
> > > +
> > > +#define CLK_LCD				(CLK_PERIP_BASE+50)
> > > +#define CLK_HDMI_AUDIO			(CLK_PERIP_BASE+51)
> > > +#define CLK_I2SRX			(CLK_PERIP_BASE+52)
> > > +#define CLK_I2STX			(CLK_PERIP_BASE+53)
> > > +
> > > +#define CLK_SENSOR0			(CLK_PERIP_BASE+54)
> > > +#define CLK_SENSOR1			(CLK_PERIP_BASE+55)
> > > +
> > > +#define CLK_HDMI_DEV			(CLK_PERIP_BASE+56)
> > > +
> > > +#define CLK_ETHERNET			(CLK_PERIP_BASE+59)
> > > +#define CLK_RMII_REF			(CLK_PERIP_BASE+60)
> > > +
> > > +#define CLK_USB2H0_PLLEN		(CLK_PERIP_BASE+61)
> > > +#define CLK_USB2H0_PHY			(CLK_PERIP_BASE+62)
> > > +#define CLK_USB2H0_CCE			(CLK_PERIP_BASE+63)
> > > +#define CLK_USB2H1_PLLEN		(CLK_PERIP_BASE+64)
> > > +#define CLK_USB2H1_PHY			(CLK_PERIP_BASE+65)
> > > +#define CLK_USB2H1_CCE			(CLK_PERIP_BASE+66)
> > > +
> > > +
> > > +#define CLK_TVOUT			(CLK_PERIP_BASE+67)
> > > +
> > > +#define CLK_THERMAL_SENSOR		(CLK_PERIP_BASE+68)
> > > +
> > > +#define CLK_IRC_SWITCH			(CLK_PERIP_BASE+69)
> > > +#define CLK_PCM1			(CLK_PERIP_BASE+70)
> > > +#define CLK_NR_CLKS			(CLK_PCM1) /* update on adding new clk */
> > > +
> > Since the index starts from 0, CLK_NR_CLKS should be CLK_PCM1 + 1
> 
> 0 is for CLK_NONE, so actual clock starts from 1
> 

yes, but the clk register only happens till (CLK_NR_CLKS - 1). Please see
[1] the associated code. With your logic, CLK_PCM1 will never get
registered.

Thanks,
Mani

[1] https://github.com/torvalds/linux/blob/master/drivers/clk/actions/owl-common.c#L69

> > Thanks,
> > Mani
> > 
> > > +#endif /* __DT_BINDINGS_CLOCK_S700_H */
> > > -- 
> > > 2.18.0
> > > 
> 
