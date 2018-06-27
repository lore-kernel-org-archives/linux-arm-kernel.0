From: jernej.skrabec@gmail.com (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 28 Jun 2018 00:05:07 +0200
Subject: [linux-sunxi] Re: [PATCH] drm/sun4i: Implement zpos for DE2
In-Reply-To: <8012754.crdjCMeE0H@jernej-laptop>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
 <20180627182500.eanqagmcfmsgzos2@flea> <8012754.crdjCMeE0H@jernej-laptop>
Message-ID: <5955444.QSmitHbQH2@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne sreda, 27. junij 2018 ob 22:58:28 CEST je Jernej ?krabec napisal(a):
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
> > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > pipe blending applies before the alpha blending, and therefore you
> > need to make sure that there's not two planes with alpha going to the
> > same pipe?
> 
> I'm not familiar with DE1 and I'm not sure what the problem is.
> 
> However, there is an issue in DE2 when alpha blending multiple planes if
> bottom-most plane doesn't cover all screen. In this case alpha blending
> produce weird result on screen. Fortunately, there is elegant solution.
> Black opaque fill color is enabled for pipe 0 (always at the bottom), which
> covers any "undefined region" and that makes alpha blending happy again.
> 
> Alternatively, blending modes between planes could be tweaked or disabled,
> but I found aforementioned solution is much simpler and you set it only
> once.

I forgot to test one corner case - what happens if pipe 0 has alpha channel 
enabled. I think it still has to work, since there is background color which 
IMO is meant for such cases.

> > Also, you seem to use the pipe and channels indifferently now, why is
> > that?
> 
> Why do you think so?
> 
> Channel always represents HW unit, for example, on H3, mixer0, channel 0
> always represents VI plane, channel 1, represents first UI, plane, channel
> 2, second UI plane, etc.
> 
> Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe 0,
> etc. Initial, fixed zpos implementation really had 1:1 mapping, but now it
> can be different.
> 
> Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
> Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents
> pipe 1, etc.
> 
> Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are enabled
> and pipe 1 and 2 are disabled.
> 
> I hope I answered your questions.

Looking at DE2.0 documentation, chapter 5.10.2 (pp. 87) might give you some 
answers. Block diagram seems much simpler than that of DE1.

Best regards,
Jernej
