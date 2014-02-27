From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 27 Feb 2014 14:06:25 +0100
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <530F1C4C.2010504@ti.com>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com>
Message-ID: <1393506385.4507.49.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 27.02.2014, 13:06 +0200 schrieb Tomi Valkeinen:
> On 25/02/14 16:23, Philipp Zabel wrote:
> 
> > +Freescale i.MX DRM master device
> > +================================
> > +
> > +The freescale i.MX DRM master device is a virtual device needed to list all
> > +IPU or other display interface nodes that comprise the graphics subsystem.
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx-drm"
> > +- ports: Should contain a list of phandles pointing to display interface ports
> > +  of IPU devices
> > +
> > +example:
> > +
> > +imx-drm {
> > +	compatible = "fsl,imx-drm";
> > +	ports = <&ipu_di0>;
> > +};
> 
> I'm not a fan of having non-hardware related things in the DT data.
> Especially if it makes direct references to our SW, in this case DRM.
> There's no DRM on the board. I wanted to avoid all that with OMAP
> display bindings.
> 
> Is there even need for such a master device? You can find all the
> connected display devices from any single display device, by just
> following the endpoint links.

I don't particularly like this either, but it kind of has been decided.

For the i.MX6 display subsystem there is no clear single master device,
and the physical configuration changes across the SoC family. The
i.MX6Q/i.MX6D SoCs have two separate display controller devices IPU1 and
IPU2, with two output ports each. The i.MX6DL/i.MX6S SoCs only have one
IPU1, but it is accompanied by separate lower-power LCDIF display
controller with a single output. These may or may not be connected
indirectly across the encoder input multiplexers, so collecting them
would require scanning the whole device tree from an always-enabled
imx-drm platform device if we didn't have this node.

Also, we are free to just ignore this node in the future, if a better
way is found.

> >  display at di0 {
> >  	compatible = "fsl,imx-parallel-display";
> >  	edid = [edid-data];
> > -	crtc = <&ipu 0>;
> >  	interface-pix-fmt = "rgb24";
> > +
> > +	port {
> > +		display_in: endpoint {
> > +			remote-endpoint = <&ipu_di0_disp0>;
> > +		};
> > +	};
> >  };
> 
> Shouldn't the pix-fmt be defined in the endpoint node? It is about pixel
> format for a particular endpoint, isn't it?
> 
> > diff --git a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
> > index ed93778..578a1fc 100644
> > --- a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
> > +++ b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
> > @@ -50,12 +50,14 @@ have a look at Documentation/devicetree/bindings/video/display-timing.txt.
> >  
> >  Required properties:
> >   - reg : should be <0> or <1>
> > - - crtcs : a list of phandles with index pointing to the IPU display interfaces
> > -           that can be used as video source for this channel.
> >   - fsl,data-mapping : should be "spwg" or "jeida"
> >                        This describes how the color bits are laid out in the
> >                        serialized LVDS signal.
> >   - fsl,data-width : should be <18> or <24>
> > + - port: A port node with endpoint definitions as defined in
> > +   Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +   On i.MX6, there should be four ports (port@[0-3]) that correspond
> > +   to the four LVDS multiplexer inputs.
> 
> Is the ldb something that's on the imx SoC?

Yes. It consists of two LVDS encoders. On i.MX5 each channel is
connected to one display interface of the single IPU.
On i.MX6Q its parallel input can be connected to any of the four IPU1/2
display interfaces using a 4-port multiplexer (and on i.MX6DL it can be
connected to IPU1 or LCDIF).

> Do you have a public branch somewhere? It'd be easier to look at the
> final result, as I'm not familiar with imx.

Not yet, I will prepare a branch with the next version.

regards
Philipp
