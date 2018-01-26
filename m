From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jan 2018 15:56:08 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
Message-ID: <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 05:50:18PM +0100, Giulio Benetti wrote:
> > > > > > On Sat, Jan 20, 2018 at 07:50:21PM +0100, Giulio Benetti wrote:
> > > > > > > On previous handling, if specified DRM_MODE_FLAG_N*SYNC,
> > > > > > > it was ignored,
> > > > > > > because only PHSYNC and PVSYNC were taken into account.
> > > > > > > DRM_MODE_FLAG_P*SYNC and DRM_MODE_FLAG_N*SYNC are not exclusive.
> > > > > > > 
> > > > > > > If flags contains PVSYNC, it doesn't mean it is NVSYNC.
> > > > > > > And it's true also the contrary.
> > > > > > > Also, as I've checked with scope on A20,
> > > > > > > if (flags & PVSYNC) then SUN4I_TCON0_IO_POL_VSYNC_POSITIVE
> > > > > > > must be set, as name suggests.
> > > > > > > It seems all display io polarities starts inverted if 0.
> > > > > > > 
> > > > > > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > > > > 
> > > > > > > PVSYNC and PHSYNC only
> > > > > > > 
> > > > > > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > > > 
> > > > > > Checkpatch:
> > > > > > WARNING: Duplicate signature
> > > > > 
> > > > > Sorry I didn't use ./scripts/checkpatch.pl
> > > > > 
> > > > > > 
> > > > > > > ---
> > > > > > >  ? drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
> > > > > > >  ? 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > > index 6121210..e873a37 100644
> > > > > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > > @@ -224,10 +224,10 @@ static void
> > > > > > > sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > > > > > >  ?????????????? SUN4I_TCON0_BASIC3_H_SYNC(hsync));
> > > > > > >  ????? /* Setup the polarity of the various signals */
> > > > > > > -??? if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> > > > > > > +??? if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> > > > > > >  ????????? val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> > > > > > > -??? if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> > > > > > > +??? if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > > > > > >  ????????? val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> > > > > > 
> > > > > > I'm not sure why you were talking of the differences between NVSYNC
> > > > > > and PVSYNC if you're not making use of any of it here?
> > > > > 
> > > > > Thinking about it more now, the point is that all Lcd IOs seem to be
> > > > > inverted by default(at least on A20).
> > > > > With inverted, I mean that if for example PVSYNC,
> > > > > I should see vsync line low and when asserted to give VSync,
> > > > > it goes high.
> > > > > This is what I've checked with oscilloscope on A20.
> > > > > Can someone give a try on A33? Otherwise I will,
> > > > > but I will take some time.
> > > > > On uboot, everything is treated equal to kernel,
> > > > > but to have my falling edge dclk and low h/vsync I had to specify:
> > > > > CONFIG_VIDEO_LCD_DCLK_PHASE=0 (giving me falling edge on dclk)
> > > > > and
> > > > > CONFIG_VIDEO_LCD_MODE="....,sync:3,..."
> > > > > but digging into code, I see "sync:3" means H/VSYNC HIGH,
> > > > > but I experience both LOW during their pulse.
> > > > > 
> > > > > > 
> > > > > > Also, how was it tested? This seems quite weird that we haven't caught
> > > > > > that one sooner, and I'm a bit worried about the possible regressions
> > > > > > here.
> > > > > 
> > > > > It sounds really strange to me too,
> > > > > because everybody under uboot use "sync:3"(HIGH).
> > > > > I will retry to measure,
> > > > > unfortunately at home I don't have a scope,
> > > > > but I think I'm going to have one soon, because of this. :)
> > > > 
> > > > Here I am with scope captures and tcon0 registers dump:
> > > > tcon0_regs => https://pasteboard.co/H4r8Zcs.png
> > > > dclk_d0 => https://pasteboard.co/H4r8QRe.png
> > > > dclk_de => https://pasteboard.co/H4r8zh4R.png
> > > > dclk_vsnc => https://pasteboard.co/H4r8Hye.png
> > > > 
> > > > As you can see circled in reg on registers,
> > > > TCON0_IO_POL_REG = 0x00000000.
> > > > But on all the waveforms you can see:
> > > > - dclk_d0: clock phase is 0, but it starts with falling edge, otherwise
> > > > the rising front overlaps dclk rising edge(not good), so to me this is
> > > > falling, then I mean it Negative.
> > > > - dclk_de: de pulse is clearly negative, even if register is 0 and its'
> > > > polarity bit is 0.
> > > > - dclk_vsnc: same as dclk_de
> > > > - dclk_hsync: I didn't take scope screenshot but I can assure you it's
> > > > negative.
> > > > 
> > > > You can also check all the other registers about TCON0.
> > > > 
> > > > Now I proceed testing it on A33, maybe the peripheral is slightly
> > > > different between Axx SoCs, if I find it that way,
> > > > it should be only a check about SoC or peripheral ID,
> > > > and treat polarity as it should be done.
> > > 
> > > Here I am with A33 waveforms:
> > > tcon0_regs => https://pasteboard.co/H4rXfN0M.png
> > > dclk_d0 => https://pasteboard.co/H4rVXwy.png
> > > dclk_de => https://pasteboard.co/H4rWDt8.png
> > > dclk_vsnc => https://pasteboard.co/H4rWRACu.png
> > > dclk_hsync => https://pasteboard.co/H4rWK6I.png
> > 
> > Thanks, that's really helpful.
> > 
> > > It behaves the same way as A20, so as I mean IO polarity,
> > > all signals(except D0-D23), are inverted.
> > > For A33 I've used A33-OLinuXino.
> > > For A20 our LiNova1.
> > 
> > Indeed, HSYNC and VSYNC look inverted.
> 
> Yes, so they should be inverted inside the driver.

Yep. And the LCD panels used on our boards as well in order to avoid
any breakages.

> > I don't really know what the polarity of D0 would be just by
> > judging at that capture, but we would have noticed if the colors
> > were inverted for quite some time now.
> 
> D0-D23 are correct.
>
> With that capture, I mean to show you instead dclk is inverted, as
> dclk samples D0 on falling edge.

Ah right, DCLK being the first channel?

> So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
> 1/3 clock phase seems enough to me to be considered POSEDGE,
> 2/3 instead risks to go too much to the right of D0(even if it could work).

Do you have captures with both settings?

> > DE seems to be active high though, since it's only going to be at
> > a logical low level when data are not transmitted, so during the
> > blank periods.
> 
> Yes, you're right, DE is data enable, and is asserted high as 0.

No, it is asserted high as 1

> But it must be added.
> I'm planning to send a new patchset with all these things corrected for
> kernel.

Ok.

> A little out of thread but:
> I'd like to send one for u-boot too,
> but this means also to modify every sunxi "sync:3" to "sync:0" and
> vice-versa.
> 
> What do you think?

That it's going to be a nightmare... We've advertised since the very
beginning something, and we're about to break it. I'm not sure we want
to do that.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/62bccf5c/attachment.sig>
