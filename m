From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Sep 2018 11:34:32 +0530
Subject: [PATCH] ARM: dts: da850-lego-ev3: slow down A/DC as much as
 possible
In-Reply-To: <20180924013146.18121-1-david@lechnology.com>
References: <20180924013146.18121-1-david@lechnology.com>
Message-ID: <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 24 September 2018 07:01 AM, David Lechner wrote:
> Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
> if we are reading analog values as fast as possible (i.e. using DMA to
> service the SPI) the A/DC chip will read incorrect values - as much as
> 0.1V off when the SPI is running at 10MHz. (This has to do with the
> capacitor charge time when channels are muxed in the A/DC.)

So you believe this is an issue with the board design rather than the
limitation of the ADC chip itself? Because if its the later, the fix
should be in the driver instead.

> 
> This patch slows down the SPI as much as possible (if CPU is at 456MHz,
> SPI runs at 1/2 of that, so 228MHz and has a max prescalar of 256, so
> we could get ~891kHz, but we're just rounding it to 1MHz). We also use
> the max allowable value for WDELAY to slow things down even more.
> 
> These changes reduce the error of the analog values to about 5mV, which
> is tolerable.
> 
> Commits a3762b13a596 ("spi: spi-davinci: Add support for SPI_CS_WORD")
> and e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
> CPU usage") introduce changes that allow DMA transfers to be used, so
> this slow down is needed now.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> FYI, this patch doesn't strictly depend on the other two mentioned. In fact, it
> would better if it got merged before them, but the consequences are minimal, so
> it doesn't seem worth it to me to try coordinating merges here.
> 
> Both of these patches mentioned have been picked up in the respective
> subsystems.

Is this needed for the -rc cycle or can wait for v4.20?

Thanks,
Sekhar

> 
>  arch/arm/boot/dts/da850-lego-ev3.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
> index c4729d0e6c19..66fcadf0ba91 100644
> --- a/arch/arm/boot/dts/da850-lego-ev3.dts
> +++ b/arch/arm/boot/dts/da850-lego-ev3.dts
> @@ -352,7 +352,8 @@
>  		compatible = "ti,ads7957";
>  		reg = <3>;
>  		#io-channel-cells = <1>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <1000000>;
> +		ti,spi-wdelay = <63>;
>  		vref-supply = <&adc_ref>;
>  	};
>  };
> -- 
> 2.17.1
> 
