From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Dec 2016 09:57:57 +0100
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <7603150.D9x404uVey@avalon>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
 <CAGb2v65uTH_PD28KqAhhzkE5zhLt54GUb7xXNxxe0xHW0A+xjQ@mail.gmail.com>
 <7603150.D9x404uVey@avalon>
Message-ID: <20161209085757.gsgw5xsmmxogx7cz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moi,

On Wed, Dec 07, 2016 at 11:48:55AM +0200, Laurent Pinchart wrote:
> On Wednesday 07 Dec 2016 10:26:25 Chen-Yu Tsai wrote:
> > On Wed, Dec 7, 2016 at 1:29 AM, Maxime Ripard wrote:
> > > On Thu, Nov 24, 2016 at 07:22:31PM +0800, Chen-Yu Tsai wrote:
> > >> The panels shipped with Allwinner devices are very "generic", i.e.
> > >> they do not have model numbers or reliable sources of information
> > >> for the timings (that we know of) other than the fex files shipped
> > >> on them. The dot clock frequency provided in the fex files have all
> > >> been rounded to the nearest MHz, as that is the unit used in them.
> > >> 
> > >> We were using the simple panel "urt,umsh-8596md-t" as a substitute
> > >> for the A13 Q8 tablets in the absence of a specific model for what
> > >> may be many different but otherwise timing compatible panels. This
> > >> was usable without any visual artifacts or side effects, until the
> > >> dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> > >> rgb: Validate the clock rate").
> > >> 
> > >> The reason this check fails is because the dotclock frequency for
> > >> this model is 33.26 MHz, which is not achievable with our dot clock
> > >> hardware, and the rate returned by clk_round_rate deviates slightly,
> > >> causing the driver to reject the display mode.
> > >> 
> > >> The LCD panels have some tolerance on the dot clock frequency, even
> > >> if it's not specified in their datasheets.
> > >> 
> > >> This patch adds a 5% tolerence to the dot clock check.
> > > 
> > > As we discussed already, I really believe this is just as arbitrary as
> > > the current behaviour.
> > 
> > Yes. I agree. This patch is mainly to give something that works for
> > people who don't care about the details, and to get some feedback
> > from people that do.
> > 
> > > Some panels require an exact frequency,
> 
> There's no such thing as an exact frequency, there will always be some 
> tolerance (and if your display controller can really generate an exact 
> frequency I'd be very interested in that hardware :-)).
> 
> This is something that has been bugging me for some time now. The problem has 
> been mostly ignored, or worked around in different ways by different drivers. 
> I'm afraid I have no generic solution available, but I think we should try to 
> agree on a common behaviour.
> 
> I don't believe it would be reasonable to request each panel to report a 
> tolerance, as the value is most of the time not available from the 
> documentation (when documentation is available). Worse, I'm pretty sure that 
> most panels documented as fixed timing can actually accept a wide range of 
> timings. The timings reported in the datasheet are just the nominal values.
> 
> Panels that don't support multiple resolutions obviously require fixed active 
> h/v values. Even if they can tolerate some departure from the nominal timings 
> for the sync and porches lengths, it might not be very useful to support that 
> as I don't expect the display controllers and encoders to be a limiting factor 
> by not supporting the particular timings that a panel considers as nominal. On 
> the other hand, departing from the nominal pixel clock frequency is needed as 
> we can't achieve an exact match, and even possibly to have some control over 
> the frame rate (although that might also require changing the sync and porches 
> timings). Without specific information about panel tolerance, do we have any 
> option other than picking an arbitrary value ?

If you consider only panels, yes, chances are the EE picked a panel
that has a decent chance to work (especially since most of the boards
we support are consumer electronics products, and people like to have
a panel that works on their tablet).

However, bridges are a different story, and provide on some SoCs modes
that are way out of reach for our pixel clock, which is why we had
that test in the first place.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/89de3049/attachment.sig>
