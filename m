From: b20788@freescale.com (Anson Huang)
Date: Tue, 14 Jan 2014 16:42:58 +0800
Subject: [PATCH] ARM: dts: imx6sl: add keypad support for i.mx6sl-evk
 board.
In-Reply-To: <20140114082948.GC1896@S2101-09.ap.freescale.net>
References: <1389685029-17323-1-git-send-email-b20788@freescale.com>
 <20140114082948.GC1896@S2101-09.ap.freescale.net>
Message-ID: <20140114084258.GA18299@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 04:29:50PM +0800, Shawn Guo wrote:
> On Tue, Jan 14, 2014 at 03:37:09PM +0800, Anson Huang wrote:
> > i.MX6SL EVK board has a 3*3 keypad matrix to support 8 keypads,
> > enable them, the keymap is as below:
> > 
> > SW6:  0x00000067    /* KEY_UP */
> > SW7:  0x0001006c    /* KEY_DOWN */
> > SW8:  0x0002001c    /* KEY_ENTER */
> > SW9:  0x01000066    /* KEY_HOME */
> > SW10: 0x0101006a    /* KEY_RIGHT */
> > SW11: 0x01020069    /* KEY_LEFT */
> > SW12: 0x02000072    /* KEY_VOLUMEDOWN */
> > SW13: 0x02010073    /* KEY_VOLUMEUP */
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6sl-evk.dts |   27 +++++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx6sl.dtsi    |    2 ++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> > index f5e4513..8d49a10 100644
> > --- a/arch/arm/boot/dts/imx6sl-evk.dts
> > +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> > @@ -93,6 +93,17 @@
> >  			fsl,pins = <MX6SL_FEC_PINGRP1>;
> >  		};
> >  
> > +		pinctrl_kpp: kppgrp {
> > +			fsl,pins = <
> > +				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
> > +				MX6SL_PAD_KEY_ROW1__KEY_ROW1    0x1b010
> > +				MX6SL_PAD_KEY_ROW2__KEY_ROW2    0x1b0b0
> > +				MX6SL_PAD_KEY_COL0__KEY_COL0    0x80000000
> > +				MX6SL_PAD_KEY_COL1__KEY_COL1    0x80000000
> > +				MX6SL_PAD_KEY_COL2__KEY_COL2    0x80000000
> 
> Rather than using whatever the config register gives us, why don't we
> put a proper pad confg value for COLs just like ROWs?

right, actually I think we should never use 0x80000000, as we might need to add multiple
pin state, so all those pins using 0x80000000, should be configurated, will do it in V2.

> 
> > +			>;
> > +		};
> > +
> >  		pinctrl_uart1: uart1grp {
> >  			fsl,pins = <MX6SL_UART1_PINGRP1>;
> >  		};
> > @@ -139,6 +150,22 @@
> >  	};
> >  };
> >  
> > +&kpp {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_kpp>;
> > +	linux,keymap = <
> > +			0x00000067    /* KEY_UP */
> > +			0x0001006c    /* KEY_DOWN */
> > +			0x0002001c    /* KEY_ENTER */
> > +			0x01000066    /* KEY_HOME */
> > +			0x0101006a    /* KEY_RIGHT */
> > +			0x01020069    /* KEY_LEFT */
> > +			0x02000072    /* KEY_VOLUMEDOWN */
> > +			0x02010073    /* KEY_VOLUMEUP */
> 
> You can use the macros defined in include/dt-bindings/input/input.h to
> make them more readable.

I thought about this, but what we used here is keymap, which contain info other
than key-code, the keymap is (row << 24 | column << 16 | key-code), so should we
use "row << 24 | column << 16 | key-code" format here is using macro define? Does
DTS support it?

> 
> Shawn
> 
> > +		>;
> > +	status = "okay";
> > +};
> > +
> >  &uart1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_uart1>;
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> > index a5ef3c3..a449c4f 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -393,8 +393,10 @@
> >  			};
> >  
> >  			kpp: kpp at 020b8000 {
> > +				compatible = "fsl,imx6sl-kpp", "fsl,imx21-kpp";
> >  				reg = <0x020b8000 0x4000>;
> >  				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6SL_CLK_DUMMY>;
> >  			};
> >  
> >  			wdog1: wdog at 020bc000 {
> > -- 
> > 1.7.9.5
> > 
> > 
> 
