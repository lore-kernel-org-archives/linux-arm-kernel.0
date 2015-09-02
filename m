From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 02 Sep 2015 17:25:32 +0200
Subject: [PATCH] ARM: dts: imx6sl: Complete the dcp node
In-Reply-To: <1441206417-27805-1-git-send-email-festevam@gmail.com>
References: <1441206417-27805-1-git-send-email-festevam@gmail.com>
Message-ID: <1441207532.3137.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 02.09.2015, 12:06 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The DCP block present on MX6SL is compatible with the one on MX28,
> so add the compatible string and also complete the interrupt entries.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 320a27f..b105735 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -670,8 +670,12 @@
>  			};
>  
>  			dcp: dcp at 020fc000 {
> +				compatible = "fsl,imx28-dcp";

Can we please start to make it good habit to always introduce a new
compatible to the DTs, even if the blocks are the same in theory?

We already had situations where the SoC IP integration exposed bugs,
which need driver workarounds and the only way to detect such situations
is to check the machine compatible in the driver, which is really ugly.

So can we please make this:
	compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";

This way we can bind any required driver changes to the new compatible
if necessary, without the need to change the DT again. Keep in mind that
we try to push DTs as ABI that doesn't need to be updated in steplock
with the kernel.

Regards,
Lucas

>  				reg = <0x020fc000 0x4000>;
> -				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>,
> +					     <0 100 IRQ_TYPE_LEVEL_HIGH>,
> +					     <0 101 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "okay";
>  			};
>  		};
>  

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
