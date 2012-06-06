From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jun 2012 11:47:30 +0800
Subject: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <1338084656-11961-2-git-send-email-marex@denx.de>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
 <1338084656-11961-2-git-send-email-marex@denx.de>
Message-ID: <20120606034728.GC2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 27, 2012 at 04:10:56AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
> via DT. The DMA operation is enabled by default.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: linux-i2c at vger.kernel.org
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    3 +
>  arch/arm/boot/dts/imx28.dtsi                      |    2 +
>  drivers/i2c/busses/i2c-mxs.c                      |  268 +++++++++++++++++++--
>  3 files changed, 251 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> index 790b5c6..f4b6244 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -6,6 +6,9 @@ Required properties:
>  - interrupts: Should contain ERROR and DMA interrupts
>  - speed: Speed of the bus in kHz (400 or 100 are supported)
>  
> +Optional properties:
> +- use-pio: Use PIO transfers instead of DMA, useful for debug

It should be "fsl,use-pio" which is the one used in code?

> +
>  Examples:
>  
>  i2c0: i2c at 80058000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index d927155..d470276 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -381,6 +381,7 @@
>  				compatible = "fsl,imx28-i2c";
>  				reg = <0x80058000 2000>;
>  				interrupts = <111 68>;
> +				fsl,i2c-dma-channel = <6>;

You may need to document this property in binding doc as well.

>  				fsl,speed = <400>;
>  				status = "disabled";
>  			};
> @@ -391,6 +392,7 @@
>  				compatible = "fsl,imx28-i2c";
>  				reg = <0x8005a000 2000>;
>  				interrupts = <110 69>;
> +				fsl,i2c-dma-channel = <7>;
>  				fsl,speed = <400>;
>  				status = "disabled";
>  			};

-- 
Regards,
Shawn
