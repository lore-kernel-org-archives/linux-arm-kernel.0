From: sbabic@denx.de (Stefano Babic)
Date: Tue, 09 Jul 2013 16:59:57 +0200
Subject: [PATCH] ARM: dts: imx: add tempmon node for imx6q thermal support
In-Reply-To: <1370330226-6030-1-git-send-email-shawn.guo@linaro.org>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
 <1370330226-6030-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51DC256D.6040204@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 04/06/2013 09:17, Shawn Guo wrote:
> Mark ocotp as a syscon node and add tempmon for imx6q thermal support.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9e8296e..13e1d7f 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -489,6 +489,13 @@
>  				};
>  			};
>  
> +			tempmon: tempmon {
> +				compatible = "fsl,imx6q-tempmon";
> +				interrupts = <0 49 0x04>;
> +				fsl,tempmon = <&anatop>;
> +				fsl,tempmon-data = <&ocotp>;
> +			};
> +
>  			usbphy1: usbphy at 020c9000 {
>  				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
>  				reg = <0x020c9000 0x1000>;
> @@ -747,8 +754,8 @@
>  				interrupts = <0 14 0x04>;
>  			};
>  
> -			ocotp at 021bc000 {
> -				compatible = "fsl,imx6q-ocotp";
> +			ocotp: ocotp at 021bc000 {
> +				compatible = "fsl,imx6q-ocotp", "syscon";
>  				reg = <0x021bc000 0x4000>;

Sorry to check this very late - is ocotp at 021bc000 the right address for
the thermal data ? According to User Manual (Table 62.3), the start
address is 0x20C8180. Using your patch, by loading the driver I get :

imx_thermal tempmon.7: invalid sensor calibration data
imx_thermal tempmon.7: failed to get sensor data
imx_thermal: probe of tempmon.7 failed with error -22

The driver is loaded successfully if I changed the tempdata to point to
020C8180. Not sure if I get the right values from temp1_crit and
temp1_input, but no error at the initialisation. Am I missing something ?

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================
