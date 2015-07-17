From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Jul 2015 11:31:09 +0800
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <CAHrpEqQv4uzQ7+EnFV7rwnhAzaSnEfwoo+_SFRsvMh-nR3PdBw@mail.gmail.com>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
 <20150715072307.GM4119@tiger>
 <BN3PR03MB1509DFB6A1513A23C48476CFA89A0@BN3PR03MB1509.namprd03.prod.outlook.com>
 <20150716155034.GN4119@tiger>
 <CAHrpEqQv4uzQ7+EnFV7rwnhAzaSnEfwoo+_SFRsvMh-nR3PdBw@mail.gmail.com>
Message-ID: <20150717033109.GB12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:22:27AM -0500, Zhi Li wrote:
> On Thu, Jul 16, 2015 at 10:50 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> Although cross IOMUX and IOMUXC-LPSR is rare,  it will be headache if there are
> one boards.
> 
> Some SD card, ENET have reset\wp\cd pin.
> 
> pinctrl_usdhc1: usdhc1grp {
>                         fsl,pins = <
>                                 MX7D_PAD_SD1_CMD__SD1_CMD               0x59
>                                 MX7D_PAD_SD1_CLK__SD1_CLK               0x19
>                                 MX7D_PAD_SD1_DATA0__SD1_DATA0           0x59
>                                 MX7D_PAD_SD1_DATA1__SD1_DATA1           0x59
>                                 MX7D_PAD_SD1_DATA2__SD1_DATA2           0x59
>                                 MX7D_PAD_SD1_DATA3__SD1_DATA3           0x59
>                                 MX7D_PAD_SD1_CD_B__GPIO5_IO0
>  0x59 /* CD */
>                                 MX7D_PAD_SD1_WP__GPIO5_IO1
>  0x59 /* WP */
>                                 MX7D_PAD_SD1_RESET_B__GPIO5_IO2
>  0x59 /* vmmc */
>                         >;
> 
> Customer may choose below pin to IOMUX-lPSR.
> 
> MX7D_PAD_SD1_CD_B__GPIO5_IO0
> MX7D_PAD_SD1_WP__GPIO5_IO1
> MX7D_PAD_SD1_RESET_B__GPIO5_IO2
> 
> FEC have Phy Reset GPIO, which possibly choose IOMUX-lPSR.

I do not understand why it would be a headache.  The following is what I
have in my head, and I think it's nicer and easier to implement.  Most
importantly, this maps how hardware is laid out exactly, save us all
those magics and hacks.

iomuxc: iomuxc at 30330000 {
	compatible = "fsl,imx7d-iomuxc";
	reg = <0x30330000 0x10000>;
};

iomuxc_lpsr: iomuxc-lpsr at 302c0000 {
	compatible = "fsl,imx7d-iomuxc-lpsr";
	reg = <0x302c0000 0x10000>;
	fsl,select-input-controller = <&iomuxc>;
};

&iomuxc {
	pinctrl_usdhc1: usdhc1grp {
		fsl,pins = <
			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
			MX7D_PAD_SD1_CLK__SD1_CLK	0x19
			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
		>;
	};
};

&iomuxc_lpsr {
	pinctrl_usdhc1_lpsr: usdhc1lpsrgrp {
		fsl,pins = <
			MX7D_PAD_LPSR_GPIO1_IO0__GPIO1_IO0  0x59 /* CD */
			MX7D_PAD_LPSR_GPIO1_IO1__GPIO1_IO1  0x59 /* WP */
			MX7D_PAD_LPSR_GPIO1_IO2__GPIO1_IO2  0x59 /* vmmc */
		>;
	};
};

&usdhc1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_usdhc1_lpsr>;
};

> It is very easy to make mistake.
> According to pin NAME macro, it is not easy to distinguish between
> IOMUX and IOMUX-LPSR.

That's easy to resolve.  As I demonstrated above, having LPSR in the
macro names and putting all those LPSR pad macros in a separate header
like imx7d-lpsr-pinfunc.h would make it easy to remember.

> Internal kernel tree use two pinctrl instance.

I think this is the right approach.  You should post that solution
for upstream instead.

> It will be simple if we think IOMUX and IOMUX-LPSR together, and one
> module have two group registers.

No, they are two instances of IOMUX controller from perspective of
hardware design.  And Linux pinctrl subsystem is well-designed to fit
there.

Shawn
