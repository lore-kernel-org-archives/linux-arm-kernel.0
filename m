From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 18 Apr 2016 05:39:11 +0300
Subject: [PATCH 1/3] arm: dts: lpc32xx: add clock properties to spi nodes
In-Reply-To: <1460636437-21764-2-git-send-email-slemieux.tyco@gmail.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <1460636437-21764-2-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <571448CF.5030104@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 14.04.2016 15:20, slemieux.tyco at gmail.com wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The change adds clock properties to spi peripheral devices,
> clock ids are taken from dt-bindings/clock/lpc32xx-clock.h
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
>  arch/arm/boot/dts/lpc32xx.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index c58d8da..0b6a643 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -173,6 +173,8 @@
>  			spi1: spi at 20088000 {
>  				compatible = "nxp,lpc3220-spi";
>  				reg = <0x20088000 0x1000>;
> +				clocks = <&clk LPC32XX_CLK_SPI1>;
> +				clock-names = "apb_pclk";

I'm not sure that here is a correct clock name, and it looks like it
is copied from some PrimeCell device node, may be "arm,pl022" SPI.

Reasons to NOT add clock-names property:
* the name is one in one PrimeCell clock name, which may be confusing,
* there is no "nxp,lpc3220-spi" SPI controller driver in the mainline,
* there is no documented description of controller's properties,
* the controller has only one clock, so I believe "clock-names"
  is redundant here.

I don't object against adding "clocks" property, but no public driver
means no testing, unfortunately.

FWIW there was an attempt to add the driver of pretty bad quality,
and it does not define a "clock-names" property [1].

>  			};
>  
>  			ssp1: ssp at 2008c000 {
> @@ -186,6 +188,8 @@
>  			spi2: spi at 20090000 {
>  				compatible = "nxp,lpc3220-spi";
>  				reg = <0x20090000 0x1000>;
> +				clocks = <&clk LPC32XX_CLK_SPI2>;
> +				clock-names = "apb_pclk";

Same as above.

>  			};
>  
>  			i2s0: i2s at 20094000 {
> 

[1] https://lkml.org/lkml/2015/7/12/61

--
With best wishes,
Vladimir
