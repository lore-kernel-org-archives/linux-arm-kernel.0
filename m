From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 21:32:58 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <20140107085930.GD12346@S2101-09.ap.freescale.net>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <20140107085930.GD12346@S2101-09.ap.freescale.net>
Message-ID: <20140108213258.GS27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 04:59:35PM +0800, Shawn Guo wrote:
> On Thu, Jan 02, 2014 at 09:28:03PM +0000, Russell King wrote:
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > index e75e11b36dff..0e005f21d241 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > @@ -62,6 +62,12 @@
> >  		};
> >  	};
> >  
> > +	imx-drm {
> > +		compatible = "fsl,imx-drm";
> > +		crtcs = <&ipu1 0>, <&ipu1 1>;
> > +		connectors = <&ldb>;
> > +	};
> > +
> 
> While the change works fine on imx6dl, it breaks LVDS support on imx6q
> right away.
> 
> imx-ipuv3 2400000.ipu: IPUv3H probed
> imx-ipuv3 2800000.ipu: IPUv3H probed
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> imx-drm imx-drm.16: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
> imx-drm imx-drm.16: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
> imx-drm imx-drm.16: failed to bind ldb.10 (ops imx_ldb_ops): -517
> 
> Because we have 4 crtcs for lvds-channel on imx6q while imx-drm master
> defines only 2 in there, the imx_drm_encoder_parse_of() call from
> imx_ldb_register() will always return -EPROBE_DEFER.
> 
>         lvds-channel at 0 {
>                 crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
>         };
> 
>         lvds-channel at 1 {
>                 crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
>         };

This is why some help would be useful here - I think I got these right
but I've no way to check them.

Can you confirm that adding all four is the right thing not only for
the imx6q but also the imx6dl sabresd please?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
