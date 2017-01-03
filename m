From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 19:43:17 +0800
Subject: [PATCH 1/2] ARM: dts: imx6qdl-nitrogen6_max: fix sgtl5000
 pinctrl init
In-Reply-To: <20170103112247.4563-2-gary.bisson@boundarydevices.com>
References: <20170103112247.4563-1-gary.bisson@boundarydevices.com>
 <20170103112247.4563-2-gary.bisson@boundarydevices.com>
Message-ID: <20170103114316.GC20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 12:22:46PM +0100, Gary Bisson wrote:
> This patch fixes the following error:
> sgtl5000 0-000a: Error reading chip id -6
> imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
> imx-sgtl5000 sound: snd_soc_register_card failed (-517)
> 
> The problem was that the pinctrl group was linked to the sound driver
> instead of the codec node. Since the codec is probed first, the sys_mclk
> was missing and it would therefore fail to initialize.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Should we have it go as a fix for v4.10-rc cycles?  In that case, please
add a Fixes: tag.  Also, do we need to apply it for stable kernel?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> index 34887a10c5f1..47ba97229a48 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> @@ -319,8 +319,6 @@
>  		compatible = "fsl,imx6q-nitrogen6_max-sgtl5000",
>  			     "fsl,imx-audio-sgtl5000";
>  		model = "imx6q-nitrogen6_max-sgtl5000";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_sgtl5000>;
>  		ssi-controller = <&ssi1>;
>  		audio-codec = <&codec>;
>  		audio-routing =
> @@ -402,6 +400,8 @@
>  
>  	codec: sgtl5000 at 0a {
>  		compatible = "fsl,sgtl5000";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sgtl5000>;
>  		reg = <0x0a>;
>  		clocks = <&clks IMX6QDL_CLK_CKO>;
>  		VDDA-supply = <&reg_2p5v>;
> -- 
> 2.11.0
> 
