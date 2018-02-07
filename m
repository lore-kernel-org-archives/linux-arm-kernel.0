From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Feb 2018 11:39:05 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
Message-ID: <20180207103905.mtyzgu73mmifyvvj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 08:37:28PM +0100, Giulio Benetti wrote:
> > > > Also, how was it tested? This seems quite weird that we haven't caught
> > > > that one sooner, and I'm a bit worried about the possible regressions
> > > > here.
> > > 
> > > It sounds really strange to me too,
> > > because everybody under uboot use "sync:3"(HIGH).
> > > I will retry to measure,
> > > unfortunately at home I don't have a scope,
> > > but I think I'm going to have one soon, because of this. :)
> > 
> > Here I am with scope captures and tcon0 registers dump:
> > tcon0_regs => https://pasteboard.co/H4r8Zcs.png
> > dclk_d0 => https://pasteboard.co/H4r8QRe.png
> > dclk_de => https://pasteboard.co/H4r8zh4R.png
> > dclk_vsnc => https://pasteboard.co/H4r8Hye.png
> > 
> > As you can see circled in reg on registers,
> > TCON0_IO_POL_REG = 0x00000000.
> > But on all the waveforms you can see:
> > - dclk_d0: clock phase is 0, but it starts with falling edge, otherwise
> > the rising front overlaps dclk rising edge(not good), so to me this is
> > falling, then I mean it Negative.
> > - dclk_de: de pulse is clearly negative, even if register is 0 and its'
> > polarity bit is 0.
> > - dclk_vsnc: same as dclk_de
> > - dclk_hsync: I didn't take scope screenshot but I can assure you it's
> > negative.
> > 
> > You can also check all the other registers about TCON0.
> > 
> > Now I proceed testing it on A33, maybe the peripheral is slightly
> > different between Axx SoCs, if I find it that way,
> > it should be only a check about SoC or peripheral ID,
> > and treat polarity as it should be done.
> 
> Here I am with A33 waveforms:
> tcon0_regs => https://pasteboard.co/H4rXfN0M.png
> dclk_d0 => https://pasteboard.co/H4rVXwy.png
> dclk_de => https://pasteboard.co/H4rWDt8.png
> dclk_vsnc => https://pasteboard.co/H4rWRACu.png
> dclk_hsync => https://pasteboard.co/H4rWK6I.png
> 
> It behaves the same way as A20, so as I mean IO polarity,
> all signals(except D0-D23), are inverted.
> For A33 I've used A33-OLinuXino.
> For A20 our LiNova1.

If you have an A33 handy, you probably want to read that mail:
https://lists.freedesktop.org/archives/dri-devel/2017-July/147951.html

Especially the 90-phase part.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180207/069af4a7/attachment.sig>
