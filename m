From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Mar 2014 13:12:36 +0800
Subject: [PATCH] arm: dts: vf610-twr: Add support for sdhc1
In-Reply-To: <1393591611-3147-1-git-send-email-cosminstefan.stoica@freescale.com>
References: <1393591611-3147-1-git-send-email-cosminstefan.stoica@freescale.com>
Message-ID: <20140303051234.GB9706@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 02:46:51PM +0200, Stoica Cosmin Stefan wrote:
> From: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> 
> The kernel was not able to boot from SD card because sdhc support
> was not present into the dts.
> 
> A new entry for sdhc1 was added for vf610-twr board based on the
> compatible entry present on imx53.
> 
> After applying these changes, the kernel is able to boot successfully
> from SD card.
> 
> Signed-off-by: Cosmin Stoica <cosminstefan.stoica@freescale.com>

Use "ARM:" instead of "arm:" in patch subject please.

> ---
>  arch/arm/boot/dts/vf610-twr.dts |    7 +++++++
>  arch/arm/boot/dts/vf610.dtsi    |   10 ++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index 7dd1d6e..fa4cf48 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -227,3 +227,10 @@
>  	pinctrl-0 = <&pinctrl_uart1>;
>  	status = "okay";
>  };
> +
> +&esdhc1 {
> +   pinctrl-names = "default";
> +   pinctrl-0 = <&pinctrl_esdhc1_1>;
> +   bus-width = <4>;
> +   status = "okay";
> +};

Sort the node alphabetically.  IOW, it should be put right before &fec0.

> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index c63d26d..516b6d2 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -344,6 +344,16 @@
>  				status = "disabled";
>  			};
>  
> +			esdhc1: esdhc at 400b2000 {
> +				   compatible = "fsl,imx53-esdhc";
> +				   reg = <0x400b2000 0x4000>;
> +				   interrupts = <0 28 0x04>;
> +				   clocks = <&clks VF610_CLK_IPG_BUS>, <&clks VF610_CLK_PLATFORM_BUS>, <&clks VF610_CLK_ESDHC1>;

The line is too long.  You can split it like:

				   clocks = <&clks VF610_CLK_IPG_BUS>,
				   	    <&clks VF610_CLK_PLATFORM_BUS>,
					    <&clks VF610_CLK_ESDHC1>;

> +				   clock-names = "ipg", "ahb", "per";
> +				   bus-width = <4>;

This property can be dropped, since you have it in board dts.

Shawn

> +				   status = "disabled";
> +			};
> +
>  			fec0: ethernet at 400d0000 {
>  				compatible = "fsl,mvf600-fec";
>  				reg = <0x400d0000 0x1000>;
> -- 
> 1.7.9.5
> 
> 
