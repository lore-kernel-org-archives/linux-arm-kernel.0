From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Jul 2018 10:59:30 +0200
Subject: [linux-sunxi] Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs
 if they don't have channel 0
In-Reply-To: <1699738.FoQmAThxyL@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com>
 <20180705070358.7ng4shuo3pxp62q6@flea>
 <1699738.FoQmAThxyL@jernej-laptop>
Message-ID: <20180709085930.dgcxrs3jqcrhu5gm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 10:03:35PM +0200, Jernej ?krabec wrote:
> Dne ?etrtek, 05. julij 2018 ob 09:03:58 CEST je Maxime Ripard napisal(a):
> > On Sun, Jul 01, 2018 at 11:11:06PM +0800, Chen-Yu Tsai wrote:
> > > On Sun, Jul 1, 2018 at 4:27 PM, Jernej ?krabec <jernej.skrabec@siol.net> 
> wrote:
> > > > Dne ?etrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai napisal(a):
> > > >> On Thu, Jun 28, 2018 at 12:45 PM, Jernej ?krabec
> > > >> 
> > > >> <jernej.skrabec@siol.net> wrote:
> > > >> > Dne ?etrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai 
> napisal(a):
> > > >> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec
> > > >> >> <jernej.skrabec@siol.net>
> > > >> > 
> > > >> > wrote:
> > > >> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI
> > > >> >> > encoder.
> > > >> >> > Because of that, all output endpoints on such TCON node will point
> > > >> >> > to a
> > > >> >> > encoder which is part of component framework.
> > > >> >> > 
> > > >> >> > Correct current graph traversing algorithm in such way that it
> > > >> >> > doesn't
> > > >> >> > skip output enpoints with id 0 on TV TCONs.
> > > >> >> 
> > > >> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that
> > > >> >> don't
> > > >> >> have channel 0, it must be skipped.
> > > >> > 
> > > >> > I'm not sure where this is stated. I read TCON binding again. Can you
> > > >> > please point me to it?
> > > >> 
> > > >> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree
> > > >> /bind ings/display/sunxi/sun4i-drm.txt#L169
> > > >> 
> > > >> Our TCON driver still expects RGB or LVDS panel / bridges on endpoint
> > > >> 0.
> > > > 
> > > > Yes, but that can only happen on TCON which has channel 0. TV TCONs
> > > > (those
> > > > with channel 1 only) can't have panels or bridges connected to them,
> > > > because they are internally always connected to either HDMI or TV
> > > > encoder or both. Actually, R40 is the only SoC, where same TV TCON can
> > > > be connected to TV encoder or HDMI. Others have specialized TV TCONs,
> > > > which are connect to only one encoder.
> > > > 
> > > > IMO TV TCONs are really just stripped down LCD TCONs to support one (or
> > > > max
> > > > two) specific encoder.
> > > 
> > > I agree. We've seen these first in the H3, and the reverse, TCONs only
> > > with
> > > LCD, on the A23/A33.
> > > 
> > > >> So I guess this was sort of implied historically. It's no longer true.
> > > >> This is something we should probably fix.
> > > > 
> > > > Fixed in what way? You mean update bindings to mention that TCON output
> > > > endpoint 0 is reserved for panels or bridges?
> > > 
> > > Either that, or have the drm driver look at other endpoints. I guess we
> > > should ask Maxime if this is already done or not, since the DSI driver
> > > isn't endpoint 0 in the A33 dtsi.
> > 
> > The DSI driver isn't really a good example for this, since the panel
> > isn't described as part of the OF graph, but DSI binding require that
> > it's a child of the DSI controller node.
> 
> So should be new behaviour reverted? I mean ignoring endpoint 0 on TV TCONs.
> 
> For me, it doesn't make sense to check for panel or bridges on TV TCONs, 
> because they are never exposed on physical pins. They are always connected to 
> TVE or HDMI encoder internally.

It doesn't make sense to check for panels, yes, but it also makes sens
to have a child node at the endpoint 0 for TV TCONs.

> > > >> In practice our drivers don't look at it (yet), but rely on the
> > > >> downstream
> > > >> encoder type to determine which channel to use.
> > > >> 
> > > >> But please add the "allwinner,tcon-channel" property as specified in
> > > >> the binding.
> > > > 
> > > > It's my understanding of TCON binding documentation that property
> > > > "allwinner,tcon-channel" is needed only if TCON supports both channels.
> > > > TV
> > > > TCON clearly supports only channel 1. In that case, there is no doubt to
> > > > which channel output endpoint belongs.
> > > > 
> > > > If that's not true, dt bindings documentation should be reworded to
> > > > contain
> > > > word "needed" or something similar. Currently, no DT for newer SoC
> > > > contains
> > > > that property (for example, A83T, H3, H5 or even A33).
> > 
> > Yeah, but that's mainly because we have a single output enabled for
> > each channel on those newer SoCs. When / if we enable the RGB and LVDS
> > output for example, we will have to set this.
> 
> So just to be clear, before I send follow up series, I have to add 
> "allwinner,tcon-channel" property to DT, because both TV TCONs can be 
> connected to either TVE or HDMI (trough TCON TOP)?
> 
> BTW, since this property is not used at all in the code, why not just simply 
> deprecate it and remove it from existing DTs? I noticed this is standard 
> practice for obsolete properties.

It's not deprecated or obsolete, it's future-proofing.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/b3498fec/attachment.sig>
