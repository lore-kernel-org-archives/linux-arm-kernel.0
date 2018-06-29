From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 29 Jun 2018 09:17:46 +0200
Subject: [PATCH] drm/sun4i: Implement zpos for DE2
In-Reply-To: <8012754.crdjCMeE0H@jernej-laptop>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
 <20180627182500.eanqagmcfmsgzos2@flea>
 <8012754.crdjCMeE0H@jernej-laptop>
Message-ID: <20180629071746.ohdhg6mgj6knyijp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 10:58:28PM +0200, Jernej ?krabec wrote:
> Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> > Hi!
> > 
> > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > Initial implementation of DE2 planes only supported fixed zpos.
> > > 
> > > Expand implementation with configurable zpos property.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > Thanks for that work. I guess you should expand a bit on the exact
> > setup you're doing here.
> 
> OK.
> 
> > 
> > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > pipe blending applies before the alpha blending, and therefore you
> > need to make sure that there's not two planes with alpha going to the
> > same pipe?
> 
> I'm not familiar with DE1 and I'm not sure what the problem is.

The alpha blending is happening after the pipe blending. So you
basically have a two-stage blending, the first one between the planes
assigned to a pipe, only taking the plane priority into account, and
using the highest priority plane's pixel in overlapping area. And
then, you have alpha blending between the two pipes.

But that means that if you have two planes with alpha assigned to the
same pipe, it's not going to work since the value and alpha of the
lowest priority plane is going to be dropped in favor of the highest
priority, instead of having transparency.

> However, there is an issue in DE2 when alpha blending multiple planes if 
> bottom-most plane doesn't cover all screen. In this case alpha blending 
> produce weird result on screen. Fortunately, there is elegant solution. Black 
> opaque fill color is enabled for pipe 0 (always at the bottom), which covers 
> any "undefined region" and that makes alpha blending happy again.
> 
> Alternatively, blending modes between planes could be tweaked or
> disabled, but I found aforementioned solution is much simpler and
> you set it only once.

Yeah, we had a similar behaviour as well, if the lowest plane has a
some alpha (!= 0xff), the pixel value is completely dropped. We worked
around this by preventing any plane with alpha at the lowest position,
but it might be a good idea to check if the background color set to
black fixes it. I remember that we were indeed seeing the background
color, but I don't think I tried setting it to black and seeing what
happens.

> > Also, you seem to use the pipe and channels indifferently now, why is
> > that?
> 
> Why do you think so?

Your driver used to use the channel id, and is now replaced by the
zpos assigned (for example in SUN8I_MIXER_BLEND_PIPE_CTL_EN)

> Channel always represents HW unit, for example, on H3, mixer0, channel 0 
> always represents VI plane, channel 1, represents first UI, plane, channel 2, 
> second UI plane, etc.
> 
> Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe 0, 
> etc. Initial, fixed zpos implementation really had 1:1 mapping, but now it can 
> be different.
> 
> Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
> Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents pipe 
> 1, etc.
> 
> Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are enabled 
> and pipe 1 and 2 are disabled.

IIRC, you have 4 layers per channel, and then a combination of VI and
UI channels to form the DE2. Where is the pipe located exactly,
between the layers and the channel output, or between the channel
output?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/cf7361df/attachment-0001.sig>
