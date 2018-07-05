From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 5 Jul 2018 10:04:20 +0200
Subject: [PATCH] drm/sun4i: Implement zpos for DE2
In-Reply-To: <10555591.O1hNBsOQsL@jernej-laptop>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
 <8012754.crdjCMeE0H@jernej-laptop>
 <20180629071746.ohdhg6mgj6knyijp@flea>
 <10555591.O1hNBsOQsL@jernej-laptop>
Message-ID: <20180705080420.tlwcz7ly5l6xc5rl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 08:59:03PM +0200, Jernej ?krabec wrote:
> Dne petek, 29. junij 2018 ob 09:17:46 CEST je Maxime Ripard napisal(a):
> > On Wed, Jun 27, 2018 at 10:58:28PM +0200, Jernej ?krabec wrote:
> > > Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> > > > Hi!
> > > > 
> > > > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > > > Initial implementation of DE2 planes only supported fixed zpos.
> > > > > 
> > > > > Expand implementation with configurable zpos property.
> > > > > 
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > 
> > > > Thanks for that work. I guess you should expand a bit on the exact
> > > > setup you're doing here.
> > > 
> > > OK.
> > > 
> > > > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > > > pipe blending applies before the alpha blending, and therefore you
> > > > need to make sure that there's not two planes with alpha going to the
> > > > same pipe?
> > > 
> > > I'm not familiar with DE1 and I'm not sure what the problem is.
> > 
> > The alpha blending is happening after the pipe blending. So you
> > basically have a two-stage blending, the first one between the planes
> > assigned to a pipe, only taking the plane priority into account, and
> > using the highest priority plane's pixel in overlapping area. And
> > then, you have alpha blending between the two pipes.
> > 
> > But that means that if you have two planes with alpha assigned to the
> > same pipe, it's not going to work since the value and alpha of the
> > lowest priority plane is going to be dropped in favor of the highest
> > priority, instead of having transparency.
> 
> This sounds familiar. Each channel contains 4 overlays. Those overlays have 
> fixed order, cannot be scaled and only blending supported is premultiply. This 
> is the first step HW does. I guess this is the thing similar to DE1 plane 
> blending.
> 
> After that, HW scaling is done on channel level (if it is enabled). Then 
> channels are mapped (reordered) to pipes according to route register and at 
> the end, alpha blending is done between pipes.
> 
> As you can see, overlays don't fit in DRM concept. They have relative position 
> to channel zpos setting and scalling can't be done on them, with only 
> premultipy supported. Because of those limitations, only one overlay is used 
> in one channel. With this restriction, everything else falls pretty nicely 
> into DRM concept.

I guess you could expose them as planes, but you'd need to improve the
current atomic_check to make sure that all these constraints are
met. That's definitely a topic for another patch serie though.

> > > However, there is an issue in DE2 when alpha blending multiple planes if
> > > bottom-most plane doesn't cover all screen. In this case alpha blending
> > > produce weird result on screen. Fortunately, there is elegant solution.
> > > Black opaque fill color is enabled for pipe 0 (always at the bottom),
> > > which covers any "undefined region" and that makes alpha blending happy
> > > again.
> > > 
> > > Alternatively, blending modes between planes could be tweaked or
> > > disabled, but I found aforementioned solution is much simpler and
> > > you set it only once.
> > 
> > Yeah, we had a similar behaviour as well, if the lowest plane has a
> > some alpha (!= 0xff), the pixel value is completely dropped. We worked
> > around this by preventing any plane with alpha at the lowest position,
> > but it might be a good idea to check if the background color set to
> > black fixes it. I remember that we were indeed seeing the background
> > color, but I don't think I tried setting it to black and seeing what
> > happens.
> > 
> 
> I tested both corner cases I could think of and all seems to be fine. These 
> are:
> 1. Having bottom-most plane only partialy covered. This caused issues with 
> alpha blending. Solution is to set opaque black fill color to bottom-most 
> pipe. In this case, previously undefined region doesn't have undefined pixel 
> data and blending is correct.
> 2. Bottom-most plane has alpha values <0xff. This doesn't cause any issue@
> all. I suspect that the reason for that is background color set to black.

Ok, that's good.

> > > > Also, you seem to use the pipe and channels indifferently now, why is
> > > > that?
> > > 
> > > Why do you think so?
> > 
> > Your driver used to use the channel id, and is now replaced by the
> > zpos assigned (for example in SUN8I_MIXER_BLEND_PIPE_CTL_EN)
> 
> zpos represents pipe number, so that is correct thing to do.
> 
> I think I know what bothers you. Patch shows only part of the changed 
> functions. Please take a look at final functions. sun8i_vi_layer_enable() and 
> sun8i_vi_layer_update_coord() still work (mostly) based on channel id.
> 
> For example, sun8i_vi_layer_update_coord() function sets almost all of the 
> registers based on channel id. Only output size after scaling is set based on 
> pipe (zpos) id.
> 
> More precisely, zpos has to be used for reading/writing pipe settings in 
> global mixer registers (prefixed with SUN8I_MIXER_BLEND_). Channel id has to 
> be used when reading/writing channel registers (prefixed with 
> SUN8I_MIXER_CHAN_UI_ or SUN8I_MIXER_CHAN_VI_).
> 
> Before the patch, channel id was actually the same as zpos id and because of 
> that channel id was used for pipes too.

Ok. It's the kind of explanation that definitely belongs in the commit log :)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/f8018ec1/attachment.sig>
