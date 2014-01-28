From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 28 Jan 2014 11:17:22 +0100
Subject: [PATCH 2/9] ARM: dts: imx6sl: remove the use of pingrp macros
In-Reply-To: <1390668191-20289-3-git-send-email-shawn.guo@linaro.org>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <1390668191-20289-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <5923680.sl3G3EgCsY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sunday, 26. January 2014 00:43:04 Shawn Guo wrote:
> We created the pingrp macros in imx6sl-pingrp.h for purpose of less LOC
> when same pin group is used by multiple boards.  However, DT maintainers
> take it as an abuse of DTC macro support.  So let's get rid of it to
> make the pins used by given device more intuitive.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts  |  120 ++++++++++++++++++++++++++----
>  arch/arm/boot/dts/imx6sl-pingrp.h |  148
> ------------------------------------- arch/arm/boot/dts/imx6sl.dtsi     |  
>  1 -
>  3 files changed, 107 insertions(+), 162 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/imx6sl-pingrp.h
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
> b/arch/arm/boot/dts/imx6sl-evk.dts index f5e4513..8594d13 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -86,55 +86,149 @@
>  		};
> 
>  		pinctrl_ecspi1: ecspi1grp {
> -			fsl,pins = <MX6SL_ECSPI1_PINGRP1>;
> +			fsl,pins = <
> +				MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO	0x100b1
> +				MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x100b1
> +				MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x100b1
> +			>;
>  		};
> 
>  		pinctrl_fec: fecgrp {
> -			fsl,pins = <MX6SL_FEC_PINGRP1>;
> +			fsl,pins = <
> +				MX6SL_PAD_FEC_MDC__FEC_MDC		0x1b0b0
> +				MX6SL_PAD_FEC_MDIO__FEC_MDIO		0x1b0b0
> +				MX6SL_PAD_FEC_CRS_DV__FEC_RX_DV		0x1b0b0
> +				MX6SL_PAD_FEC_RXD0__FEC_RX_DATA0	0x1b0b0
> +				MX6SL_PAD_FEC_RXD1__FEC_RX_DATA1	0x1b0b0
> +				MX6SL_PAD_FEC_TX_EN__FEC_TX_EN		0x1b0b0
> +				MX6SL_PAD_FEC_TXD0__FEC_TX_DATA0	0x1b0b0
> +				MX6SL_PAD_FEC_TXD1__FEC_TX_DATA1	0x1b0b0
> +				MX6SL_PAD_FEC_REF_CLK__FEC_REF_OUT	0x4001b0a8
> +			>;
>  		};

[... and so on for the other groups ... ]

I'm confused now :-) . Current linux-next [0] shows the pin-settings as part 
of imx6sl.dtsi - a way a lot of other architectures organize their pingroups 
too, with the board file only referencing the relevant pingroups from the 
predefined ones of the soc.

So I guess your move to the pingrp-header moved them out of the imx6sl.dtsi to 
the .h and is not part of linux-next; but this patch (and the others in this 
series) now moves the definitions into the individual board files. Can't you 
just move them back to the soc-dtsi files to prevent each board duplicating 
them?

Or I've simply missed previous discussions about this ;-) .


Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/imx6sl.dtsi#n640
