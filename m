From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 11:18:15 +0200
Subject: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
In-Reply-To: <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
 <20160815114211.GI9347@sirena.org.uk>
 <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
Message-ID: <20160822091815.GE7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 12:45:39PM +0800, wens Tsai wrote:
> On Mon, Aug 15, 2016 at 7:42 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 15, 2016 at 05:43:55PM +0800, wens Tsai wrote:
> >
> >> What is unexpected is any attempt to play anything under this state makes
> >> the playback software (in my case mpg321) stall, and later report an I/O
> >> error. My guess is that the DAC is still disabled by DAPM, so it doesn't
> >> send any DRQs, and thus the DMA engine is not consuming any data from
> >> userspace.
> >
> > This is normal for ASoC - like you say it'll be becasue the hardware
> > isn't powered up.
> >
> >> I think we should just enable the digital bits of the DAC/ADC all the
> >> time. Or maybe transfer and then discard data if the DAC is off. Not
> >> sure if this is doable though. I expect playback software to work, and
> >> not block, regardless of the hardware status.
> >
> > Powering things up all the time will have a major effect on battery life
> > for systems that care about that.  The expectation is that systems with
> > this sort of hardware won't normally be offering end users direct
> > control of the routing, it'll be something that's handled during system
> > integration.
> 
> Ok. So I guess one solution would be to move the mute controls out of
> DAPM, and maybe change some other mux like paths into actual muxes, so
> there's at least one usable path at all times.

I'm not sure that's even a requirement. IIRC, but Mark might correct
me, you just need to expose whatever the reset state is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/3402858b/attachment.sig>
