From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Jan 2014 23:25:38 +0800
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <20140108213258.GS27432@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <20140107085930.GD12346@S2101-09.ap.freescale.net>
 <20140108213258.GS27432@n2100.arm.linux.org.uk>
Message-ID: <20140109152536.GG21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 09:32:58PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 07, 2014 at 04:59:35PM +0800, Shawn Guo wrote:
> > On Thu, Jan 02, 2014 at 09:28:03PM +0000, Russell King wrote:
> > > diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > > index e75e11b36dff..0e005f21d241 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > > @@ -62,6 +62,12 @@
> > >  		};
> > >  	};
> > >  
> > > +	imx-drm {
> > > +		compatible = "fsl,imx-drm";
> > > +		crtcs = <&ipu1 0>, <&ipu1 1>;
> > > +		connectors = <&ldb>;
> > > +	};
> > > +
> > 
> > While the change works fine on imx6dl, it breaks LVDS support on imx6q
> > right away.
> > 
> > imx-ipuv3 2400000.ipu: IPUv3H probed
> > imx-ipuv3 2800000.ipu: IPUv3H probed
> > [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> > [drm] No driver support for vblank timestamp query.
> > imx-drm imx-drm.16: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
> > imx-drm imx-drm.16: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
> > imx-drm imx-drm.16: failed to bind ldb.10 (ops imx_ldb_ops): -517
> > 
> > Because we have 4 crtcs for lvds-channel on imx6q while imx-drm master
> > defines only 2 in there, the imx_drm_encoder_parse_of() call from
> > imx_ldb_register() will always return -EPROBE_DEFER.
> > 
> >         lvds-channel at 0 {
> >                 crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
> >         };
> > 
> >         lvds-channel at 1 {
> >                 crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
> >         };
> 
> This is why some help would be useful here - I think I got these right
> but I've no way to check them.
> 
> Can you confirm that adding all four is the right thing not only for
> the imx6q but also the imx6dl sabresd please?

Yea, adding all four into imx-drm crtcs works for imx6q, but it doesn't
for imx6dl, because &ipu2 is unavailable for imx6dl at all.

Here is how I get around it.

---8<-----------

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 9cbdfe7..66f220a 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -20,6 +20,10 @@
        compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 };

+&imx_drm {
+       crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+};
+
 &sata {
        status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0e005f2..dfca3e0 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -62,7 +62,7 @@
                };
        };

-       imx-drm {
+       imx_drm: imx-drm {
                compatible = "fsl,imx-drm";
                crtcs = <&ipu1 0>, <&ipu1 1>;
                connectors = <&ldb>;
