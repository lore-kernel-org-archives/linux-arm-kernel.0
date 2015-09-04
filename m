From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Sep 2015 22:24:01 +0100
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
Message-ID: <20150904212401.GI21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 12:48:02PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 4, 2015 at 11:21 AM, Doug Anderson <dianders@chromium.org> wrote:
> > Russell,
> >
> > On Sat, Aug 8, 2015 at 9:10 AM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> >> Adjust the pixel clock values in the N calculation to match the more
> >> accurate clock values we're given by the DRM subsystem, which are the
> >> kHz pixel rate, with any fractional kHz rounded down in the case of
> >> the non-240, non-480 line modes, or rounded up for the others.  So,
> >>
> >>          25.20 / 1.001 =>  25175
> >>          27.00 * 1.001 =>  27027
> >>          74.25 / 1.001 =>  74176
> >>         148.50 / 1.001 => 148352
> >>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> ---
> >>  drivers/gpu/drm/bridge/dw_hdmi.c | 20 ++++++++++----------
> >>  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > For what it's worth, I backported this change into my local 3.14-based
> > tree and it doesn't cause any problems, though it looks like the code
> > isn't being run in my case...
> >
> > I can confirm that the rates you list match the rates I actually see
> > requested by DRM, but in my current tree I've actually got something
> > that allows a little bit of "slop" in HDMI rates because my system
> > can't actually always make exactly the modes requested, but it appears
> > that getting "close enough" works, especially if your clock jitter is
> > low enough (because the sink needs to have a little bit of wiggle room
> > for jitter anyway).  For instance, when 25.175 is requested we
> > actually end up making 25.170732.
> >
> > In my tree this adjustment happens in mode_fixup by changing the
> > adj_mode.  In one particular case, some debug prints show:
> >   640x480, mode=25200000, adj=25171000, actual=25170732
> >   freq=48000, pixel_clk=25171000, n=6144
> >
> > I'm not enough of an HDMI expert to say whether it's better to be
> > using n=6144 or n=6864 in this case, but audio does play with either
> > on the TV I tested.
> >
> > In any case, I'd say that your change at least makes things better
> > than they were, so I'd be in favor of taking it.  If someone later
> > decides that we should add a little margin to these numbers, then a
> > patch to add that could go atop yours.
> 
> Oh!  I just figured this out!  :)
> 
> Basically the spec is saying that you want both N and CTS to be
> integral.  ...as you say you really want:
>   CTS = (TMDS * N) / (128 * audio_freq)

In the case of software-programmed CTS and N values, they have to be
integral because there's no such thing as fractional division here.
The CTS and N values get sent across the HDMI link to the sink, and
they use those in a PLL like arrangement to derive the audio clock.

More "inteligent" hardware automatically measures the CTS number and
continually updates the sink, which allows the sink to remain in
sync with the audio at non-coherent rates.

> ...CTS has no other restrictions (other than being integral) and
> you're allowed a bit of slop for N (you aim for 128 * audio_freq but
> can go up or down a bit).

No.  Both CTS and N have to be accurate to generate the correct
sample rate from the TDMS clock.

> Apparently it's more important to optimize for the CTS formula working
> out then it is for getting close to "128 * audio freq".  ...and that's
> the reason for these special case N values...

The "128 * audio freq" is just a recommendation.  Going through the HDMI
spec's recommended values for various clock rates and sample rates
reveals that quite a number of them are far from this "recommendation".

So I wouldn't read too much into the "128 * audio freq" thing.

> So to put some numbers:
> 
> We're perfect when we have exactly 25.2:
>   25200 * 4096 / (128 * 32)
>   => 25200, so CTS for 25.2 MHz is 25200.  Perfect
> 
> ...but when we have 25.2 / 1.001 we get a non-integral CTS:
>   (25200 / 1.001) * 4096 / (128 * 32)
>   => 25174.82517482518
> 
> ...we can get an integral CTS and still remain in range if:
>   (25200 / 1.001) * 4576 / (128 * 32)
>   => 28125

Correct.  These are the values given in the HDMI specification for each
of your clock rates you mention above.

You can even use 4096 for N _provided_ the source measures and sends
the CTS value (that's basically what happens in the case of
"non-coherent" clocks.)

> In the case of Linux, I'm afraid we just don't have this type of
> accuracy in our APIs.

We don't have that kind of precision in the DRM API, but we do have the
precision in the clock API.

> The spec is talking about making 25.17482517482518 MHz.

+/- 0.5%, according to CEA-861-B.

> As I said, in my case I'm actually making 25170732.

... which is within 0.02%, so is within spec.

> In your case you're probably making the value that Linux
> asked you to make, AKA 25.175000 MHz.

... which is the spec value.

> Unsurprisingly, if you do the
> calculations with 25.175 MHz (or any integral kHz value) you don't
> have to do any special optimization to stay integral:
> 
>   25175 * 4096 / (128 * 32)
>   => 25175
> 
> 
> So unless you have some way to know that the underlying clock is
> actually (25.2 / 1.001) MHz and not just 25.175 MHz then your patch
> looks wrong.

I don't believe you can make that statement.  If you wish to take the
lack of precision up with the authors of the CEA-861 and HDMI
specifications, since they "approximate" to the values I have in this
patch, and are what userspace passes in the mode structures to kernel
space.

> As a first step I'd suggest just removing all the special cases and
> add a comment.  From real world testing it doesn't seem terribly
> critical to be slightly off on CTS.  ...and in any case for any clock
> rates except the small handful in the HDMI spec we'll be slightly off
> on CTS anyway...

They're not "special cases" made up to fit something - they're from the
tables in the HDMI specification.

[everything else cut I'm getting tired...]

At the end of the day, when it comes to video playback, what matters
more is that your video and audio rates are related.  If the stream
audio is 48kHz and your video is expected to be 60fps, then the decoder
is going to want to see audio being consumed at 48kHz and video at
60fps.  If your actual video output is slightly slow due to a crap
hardware implementation, then having the audio clock slow by the same
proportion means that the video decoder doesn't have to stretch or
squeeze the audio to try and make things fit, or worse, skip frames.

That assumes that the audio and video clocks are coherent.  On iMX6
hardware using this, the audio is clocked at the rate defined by the
TDMS clock and the CTS/N values.

Other hardware, where the audio clock is derived differently (and
therefore, noncoherently), won't be using the CTS value software
supplies, because that's meaningless - it's got to measure the audio
clock rate, and pass that over to the sink using CTS - so called
auto-CTS mode.  That allows the sink to track the audio clock rate
irrespective of the actual TDMS clock rate.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
