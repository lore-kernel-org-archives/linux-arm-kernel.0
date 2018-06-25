From: jernej.skrabec@gmail.com (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 25 Jun 2018 11:10:30 +0200
Subject: [linux-sunxi] Re: [PATCH v2 11/27] drm/sun4i: tcon: Add support
 for tcon-top gate
In-Reply-To: <CAGb2v676mFiOry5eQabzkyVaQ6R64gT2_XuBzTAtHorNzfwCuw@mail.gmail.com>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <1797170.duyCyYzgBk@jernej-laptop>
 <CAGb2v676mFiOry5eQabzkyVaQ6R64gT2_XuBzTAtHorNzfwCuw@mail.gmail.com>
Message-ID: <2426089.g6yXFYEL1F@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 25. junij 2018 ob 10:14:52 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 3:58 PM, Jernej ?krabec
> 
> <jernej.skrabec@gmail.com> wrote:
> > Dne ponedeljek, 25. junij 2018 ob 05:51:41 CEST je Chen-Yu Tsai 
napisal(a):
> >> On Mon, Jun 25, 2018 at 3:52 AM, Jernej ?krabec
> >> 
> >> <jernej.skrabec@gmail.com> wrote:
> >> > Dne ?etrtek, 21. junij 2018 ob 17:35:45 CEST je Jernej ?krabec 
napisal(a):
> >> >> Dne ?etrtek, 21. junij 2018 ob 03:23:27 CEST je Chen-Yu Tsai 
napisal(a):
> >> >> > On Thu, Jun 21, 2018 at 3:37 AM, Jernej ?krabec
> >> >> > <jernej.skrabec@siol.net>
> >> >> 
> >> >> wrote:
> >> >> > > Dne sobota, 16. junij 2018 ob 07:48:38 CEST je Chen-Yu Tsai
> > 
> > napisal(a):
> >> >> > >> On Sat, Jun 16, 2018 at 1:33 AM, Jernej ?krabec
> >> >> > >> <jernej.skrabec@siol.net>
> >> >> > > 
> >> >> > > wrote:
> >> >> > >> > Dne petek, 15. junij 2018 ob 19:13:17 CEST je Chen-Yu Tsai
> >> > 
> >> > napisal(a):
> >> >> > >> >> On Sat, Jun 16, 2018 at 12:41 AM, Jernej ?krabec
> >> >> > >> >> 
> >> >> > >> >> <jernej.skrabec@siol.net> wrote:
> >> >> > >> >> > Hi,
> >> >> > >> >> > 
> >> >> > >> >> > Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard
> >> >> 
> >> >> napisal(a):
> >> >> > >> >> >> Hi,
> >> >> > >> >> >> 
> >> >> > >> >> >> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec
> > 
> > wrote:
> >> >> > >> >> >> > TV TCONs connected to TCON TOP have to enable additional
> >> >> > >> >> >> > gate
> >> >> > >> >> >> > in
> >> >> > >> >> >> > order
> >> >> > >> >> >> > to work.
> >> >> > >> >> >> > 
> >> >> > >> >> >> > Add support for such TCONs.
> >> >> > >> >> >> > 
> >> >> > >> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> >> > >> >> >> > ---
> >> >> > >> >> >> > 
> >> >> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> >> >> > >> >> >> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> >> >> > >> >> >> >  2 files changed, 15 insertions(+)
> >> >> > >> >> >> > 
> >> >> > >> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
> >> >> > >> >> >> > 08747fc3ee71..0afb5a94a414
> >> >> > >> >> >> > 100644
> >> >> > >> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> >> > >> >> >> > @@ -688,6 +688,16 @@ static int
> >> >> > >> >> >> > sun4i_tcon_init_clocks(struct
> >> >> > >> >> >> > device
> >> >> > >> >> >> > *dev,
> >> >> > >> >> >> > 
> >> >> > >> >> >> >             dev_err(dev, "Couldn't get the TCON bus
> >> >> > >> >> >> >             clock\n");
> >> >> > >> >> >> >             return PTR_ERR(tcon->clk);
> >> >> > >> >> >> >     
> >> >> > >> >> >> >     }
> >> >> > >> >> >> > 
> >> >> > >> >> >> > +
> >> >> > >> >> >> > +   if (tcon->quirks->has_tcon_top_gate) {
> >> >> > >> >> >> > +           tcon->top_clk = devm_clk_get(dev,
> >> >> > >> >> >> > "tcon-top");
> >> >> > >> >> >> > +           if (IS_ERR(tcon->top_clk)) {
> >> >> > >> >> >> > +                   dev_err(dev, "Couldn't get the TCON
> >> >> > >> >> >> > TOP
> >> >> > >> >> >> > bus
> >> >> > >> >> >> > clock\n");
> >> >> > >> >> >> > +                   return PTR_ERR(tcon->top_clk);
> >> >> > >> >> >> > +           }
> >> >> > >> >> >> > +           clk_prepare_enable(tcon->top_clk);
> >> >> > >> >> >> > +   }
> >> >> > >> >> >> > +
> >> >> > >> >> >> 
> >> >> > >> >> >> Is it required for the TCON itself to operate, or does the
> >> >> > >> >> >> TCON
> >> >> > >> >> >> requires the TCON TOP, which in turn requires that clock to
> >> >> > >> >> >> be
> >> >> > >> >> >> functional?
> >> >> > >> >> >> 
> >> >> > >> >> >> I find it quite odd to have a clock that isn't meant for a
> >> >> > >> >> >> particular
> >> >> > >> >> >> device to actually be wired to another device. I'm not
> >> >> > >> >> >> saying
> >> >> > >> >> >> this
> >> >> > >> >> >> isn't the case, but it would be a first.
> >> >> > >> >> > 
> >> >> > >> >> > Documentation doesn't say much about that gate. I did few
> >> >> > >> >> > tests
> >> >> > >> >> > and
> >> >> > >> >> > TCON
> >> >> > >> >> > registers can be read and written even if TCON TOP TV TCON
> >> >> > >> >> > gate
> >> >> > >> >> > is
> >> >> > >> >> > disabled. However, there is no image, as expected.
> >> >> > >> >> 
> >> >> > >> >> The R40 manual does include it in the diagram, on page 504.
> >> >> > >> >> There's
> >> >> > >> >> also
> >> >> > >> >> a
> >> >> > >> >> mux to select whether the clock comes directly from the CCU or
> >> >> > >> >> the
> >> >> > >> >> TV
> >> >> > >> >> encoder (a feedback mode?). I assume this is the gate you are
> >> >> > >> >> referring
> >> >> > >> >> to
> >> >> > >> >> here, in which case it is not a bus clock, but rather the TCON
> >> >> > >> >> module
> >> >> > >> >> or
> >> >> > >> >> channel clock, strangely routed.
> >> >> > >> >> 
> >> >> > >> >> > More interestingly, I enabled test pattern directly in TCON
> >> >> > >> >> > to
> >> >> > >> >> > eliminate
> >> >> > >> >> > influence of the mixer. As soon as I disabled that gate,
> >> >> > >> >> > test
> >> >> > >> >> > pattern
> >> >> > >> >> > on
> >> >> > >> >> > HDMI screen was gone, which suggest that this gate
> >> >> > >> >> > influences
> >> >> > >> >> > something
> >> >> > >> >> > inside TCON.
> >> >> > >> >> > 
> >> >> > >> >> > Another test I did was that I moved enable/disable gate code
> >> >> > >> >> > to
> >> >> > >> >> > sun4i_tcon_channel_set_status() and it worked just as well.
> >> >> > >> >> > 
> >> >> > >> >> > I'll ask AW engineer what that gate actually does, but from
> >> >> > >> >> > what I
> >> >> > >> >> > saw,
> >> >> > >> >> > I
> >> >> > >> >> > would say that most appropriate location to enable/disable
> >> >> > >> >> > TCON
> >> >> > >> >> > TOP
> >> >> > >> >> > TV
> >> >> > >> >> > TCON
> >> >> > >> >> > gate is TCON driver. Alternatively, TCON TOP driver could
> >> >> > >> >> > check
> >> >> > >> >> > if
> >> >> > >> >> > any
> >> >> > >> >> > TV
> >> >> > >> >> > TCON is in use and enable appropriate gate. However, that
> >> >> > >> >> > doesn't
> >> >> > >> >> > sound
> >> >> > >> >> > right to me for some reason.
> >> >> > >> >> 
> >> >> > >> >> If what I said above it true, then yes, the appropriate
> >> >> > >> >> location
> >> >> > >> >> to
> >> >> > >> >> enable
> >> >> > >> >> it is the TCON driver, but moreover, the representation of the
> >> >> > >> >> clock
> >> >> > >> >> tree
> >> >> > >> >> should be fixed such that the TCON takes the clock from the
> >> >> > >> >> TCON
> >> >> > >> >> TOP
> >> >> > >> >> as
> >> >> > >> >> its
> >> >> > >> >> channel/ module clock instead. That way you don't need this
> >> >> > >> >> patch,
> >> >> > >> >> but
> >> >> > >> >> you'd add another for all the clock routing.
> >> >> > >> > 
> >> >> > >> > Can you be more specific? I not sure what you mean here.
> >> >> > >> 
> >> >> > >> For clock related properties in the device tree:
> >> >> > >> 
> >> >> > >> &tcon_top {
> >> >> > >> 
> >> >> > >>     clocks = <&ccu CLK_BUS_TCON_TOP>,
> >> >> > >>     
> >> >> > >>              <&ccu CLK_TCON_TV0>,
> >> >> > >>              <&tve0>,
> >> >> > >>              <&ccu CLK_TCON_TV1>,
> >> >> > >>              <&tve1>;
> >> >> > >>     
> >> >> > >>     clock-names = "bus", "tcon-tv0", "tve0", "tcon-tv1", "tve1";
> >> >> > >>     clock-output-names = "tcon-top-tv0", "tcon-top-tv1";
> >> >> > >> 
> >> >> > >> };
> >> >> > >> 
> >> >> > >> &tcon_tv0 {
> >> >> > >> 
> >> >> > >>     clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>'
> >> >> > >>     clock-names = "ahb", "tcon-ch1";
> >> >> > >> 
> >> >> > >> };
> >> >> > >> 
> >> >> > >> A diagram would look like:
> >> >> > >>                    | This part is TCON TOP |
> >> >> > >>                    
> >> >> > >>                    v                       v
> >> >> > >> 
> >> >> > >> CCU CLK_TCON_TV0 --|----\                  |
> >> >> > >> 
> >> >> > >>                    |     mux ---- gate ----|-- TCON_TV0
> >> >> > >> 
> >> >> > >> TVE0 --------------|----/                  |
> >> >> > >> 
> >> >> > >> And the same goes for TCON_TV1 and TVE1.
> >> >> > >> 
> >> >> > >> The user manual is a bit lacking on how TVE outputs a clock
> >> >> > >> though.
> >> >> > > 
> >> >> > > I didn't yet received any response on HW details from AW till now,
> >> >> > > but I
> >> >> > > would like to post new version of patches soon.
> >> >> > > 
> >> >> > > While chaining like you described could be implemented easily, I
> >> >> > > don't
> >> >> > > think it really represents HW as it is. Tests showed that these
> >> >> > > two
> >> >> > > clocks are independent, otherwise register writes/reads wouldn't
> >> >> > > be
> >> >> > > possible with tcon- top gate disabled. I chose tcon-top bus clock
> >> >> > > as
> >> >> > > a
> >> >> > > parent becase if it is not enabled, it simply won't work.
> >> >> > 
> >> >> > AFAIK with the TCONs, even when the TCON channel clock (not the bus
> >> >> > clock)
> >> >> > is disabled, register accesses still work.
> >> >> 
> >> >> You're right, I just tested that.
> >> >> 
> >> >> > I'm saying that the TCON TOP
> >> >> > gate is downstream from the TCON channel clock in the CCU. These are
> >> >> > not
> >> >> > related to the TCON bus clock in the CCU, which affects register
> >> >> > access.
> >> >> > 
> >> >> > Did Allwinner provide any information regarding the hierarchy of the
> >> >> > clocks?
> >> >> 
> >> >> No reponse for now.
> >> >> 
> >> >> > > However, if everyone feels chaining is the best way to implement
> >> >> > > it,
> >> >> > > I'll
> >> >> > > do it.
> >> >> > 
> >> >> > I would like to get it right and match actual hardware. My proposal
> >> >> > is
> >> >> > based on my understanding from the diagrams in the user manual.
> >> >> 
> >> >> So for now, your explanation is the most reasonable. Should we go
> >> >> ahead
> >> >> and
> >> >> implement your idea?
> >> >> 
> >> >> Please note that H6 has TCON-TOP too, but it has only one LCD TCON and
> >> >> one
> >> >> TV TCON instead of two of each kind. That means we will have hole in
> >> >> indices (tcon_lcd0 is 1, tcon_tv0 is 3, which is aligned with R40) and
> >> >> different TCON- TOP binding (no tcon_tv1 channel clock), but setup is
> >> >> exactly the same.
> >> > 
> >> > I just noticed issue with this proposal. If we have following clock
> >> > chain
> >> > for HDMI, everythings is ok:
> >> > 
> >> > TCON-TV0 -> TCON-TOP-TV0
> >> > 
> >> > TCON TV sets TCON-TOP-TV0 clock rate, which in turn sets TCON-TV0 clock
> >> > and
> >> > everything works.
> >> > 
> >> > However, when TVE will be configured, it would look like this:
> >> > 
> >> > TVE0 -> TCON-TOP-TV0
> >> > 
> >> > TVE driver will set TVE0 clock to 216 MHz and TCON TV would set
> >> > TCON-TOP-TV0 rate which in turn sets TVE0 clock to something like 13.5
> >> > MHz (or whatever is the right clock rate for PAL and NTSC). As you can
> >> > see, same clock is set to two different rates by two different drivers.
> >> > 
> >> > It *might* still work, since encoders set clock rate after TCON (at
> >> > least
> >> > that is my experience for HDMI pipeline), but that is still wrong.
> >> > 
> >> > To overcome above issue, I would stick to original proposal with
> >> > additional
> >> > clock specified in TCON TV DT node. That way TCON driver would always
> >> > set
> >> > clock rate to TCON-TV0 clock. If TVE0 is enabled, TCON wouldn't
> >> > interfere
> >> > with setting clock rate, because TCON-TV0 clock would be decoupled in
> >> > TCON-TOP mux.
> >> > 
> >> > What do you think?
> >> 
> >> I think this is the wrong representation, and worse, you are trying to
> >> work
> >> around software issues with it.
> >> 
> >> So to confirm some details, the TVE expects 216 MHz clock, and it expects
> >> the TCON to run and output data at 216 MHz as well. Is that correct?
> > 
> > Yes, from my understanding. 216 MHz is correct at least for PAL and NTSC,
> > e.g. TV mode. TVE on R40 is also capable of RGB mode (VGA connector).
> > 
> >> Would any settings for the TCON differ between when HDMI or TVE is used?
> > 
> > Apart of clock, no, other settings would be the same.
> > 
> >> Does TVE and TCON run at 216 MHz regardless of resolution? I kind of
> >> doubt
> >> it. It might be expecting 297 MHz for PC resolutions.
> > 
> > Please check this table in BSP:
> > https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/driver
> > s/ video/sunxi/disp2/tv/drv_tv.c#L24
> > 
> > 216 MHz is applicable for low resolution, interlaced modes. Modes like
> > 1080P, 1080I have expected standard timing.
> 
> That's weird. So it only applies to SDTV video resolutions. I remember
> seeing an "up sampling" setting for composite in the TVE, which goes all
> the way up to 216 MHz. Maybe that's the reason?
> 

Probably. If upsampling is set to 0, it still needs 27 MHz, which is 2x more 
than standard PAL/NTSC clock. After studying AC200 manual (which is similar TV 
encoder) and its driver, it seems the reason for that is 8 bit parallel 
interface between TCON and TVE and 16 bit data (CCIR656).

However, actual tests would be needed to confirm all that.

> I wonder how the TCON manages this though. I mean with the dot clock this
> high, doesn't that mean the frame rate is much higher?
> 

Not sure, but IMO it is downscaled somehow in TVE HW to get proper rates at 
the end.

> >> I think these kinds of quirks should be handled in the software, instead
> >> of
> >> being papered over.
> > 
> > Ok, that works for me too. I would just like to have such design that
> > would
> > later allow implementing TVE driver without much issues.
> > 
> > BTW, H3 TV TCON which is connected to TVE doesn't have TCON-TV channel
> > clock at all, since it is controlled with TVE clock (same case as it
> > would be here, if TCON TOP mux is switched to TVE clock source).
> 
> Does it require 216 MHz as well?

Yes. It supports only PAL and NTSC (only one DAC), so BSP driver sets TVE 
clock to 216 MHz.

> 
> > Maybe quirk can be added that it doesn't set clock rate at all if it is
> > connected to TVE?
> 
> A quirk yes. But the dot clock would be 216 MHz instead of not setting it,
> and only for certain display modes. To be honest I think we can get by with
> just a TODO note for now.

Why not leave control of channel rate to TVE, since it knows if oversampling 
is enabled or not? But that's debate for another time.

I will send new R40 HDMI patches according your original proposal.

Best regards,
Jernej
