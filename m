From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 16:59:35 +0800
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
Message-ID: <20140107085930.GD12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:28:03PM +0000, Russell King wrote:
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e75e11b36dff..0e005f21d241 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -62,6 +62,12 @@
>  		};
>  	};
>  
> +	imx-drm {
> +		compatible = "fsl,imx-drm";
> +		crtcs = <&ipu1 0>, <&ipu1 1>;
> +		connectors = <&ldb>;
> +	};
> +

While the change works fine on imx6dl, it breaks LVDS support on imx6q
right away.

imx-ipuv3 2400000.ipu: IPUv3H probed
imx-ipuv3 2800000.ipu: IPUv3H probed
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
imx-drm imx-drm.16: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
imx-drm imx-drm.16: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
imx-drm imx-drm.16: failed to bind ldb.10 (ops imx_ldb_ops): -517

Because we have 4 crtcs for lvds-channel on imx6q while imx-drm master
defines only 2 in there, the imx_drm_encoder_parse_of() call from
imx_ldb_register() will always return -EPROBE_DEFER.

        lvds-channel at 0 {
                crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
        };

        lvds-channel at 1 {
                crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
        };

Shawn

>  	sound {
>  		compatible = "fsl,imx6q-sabresd-wm8962",
>  			   "fsl,imx-audio-wm8962";
