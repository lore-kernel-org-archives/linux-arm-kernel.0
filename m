From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jul 2014 23:55:39 +0100
Subject: [linux-sunxi] Re: GSoC 2014 #0 status report - Improving
 Allwinner SoC support
In-Reply-To: <CAKON4Ow8m07sLXnnm3n6HNh3sg0nU6VDAZ0urZ0r2_6nT7UnHQ@mail.gmail.com>
References: <53BE0B4F.1090001@elopez.com.ar> <20140710203906.GA3745@lukather>
 <CAKON4Ow8m07sLXnnm3n6HNh3sg0nU6VDAZ0urZ0r2_6nT7UnHQ@mail.gmail.com>
Message-ID: <20140710225538.GZ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 06:40:42PM -0400, jonsmirl at gmail.com wrote:
> On Thu, Jul 10, 2014 at 4:39 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > So they just implement a cyclic-like behaviour in software?
> 
> From what I can tell the Allwinner hardware will just cycle on a
> single buffer.  Cyclic DMA for the kernel needs to cycle on the
> equivalent of a scatter/gather list (in most cases the buffers are
> sequential periodic splits of a single buffer).  And as each segment
> completes it needs to signal the DMA subsystem.  Allwinner chips don't
> support hardware scatter gather but that isn't a major problem.

With cyclic DMA, there is no requirement in DMAengine to strictly report
each period completion (due to the behaviour of tasklets.)  However,
ASoC requires one of two things, either:

1. One callback per completed period
2. A report of the current position in the cyclic DMA cycle (via the
   number of bytes remaining to the end of the buffer.)

Either will do, and if you have to implement something which counts
how many callbacks you need to do to satisfy (1), you might as well
implement (2) instead - it's much more efficient that way.

Internally, ALSA prefers (2) because each time you issue the callback,
snd_pcm_period_elapsed() will be called.  This does a load of
processing, including reading where the DMA pointer is so that ALSA
can calculate the appropriate position in the buffer.

That really only needs to happen once per "service" - as per the
documentation for snd_pcm_period_elapsed() on the net.

So, if you find that you've completed two periods, your choices either
to report: "one period completed, one period completed" and have two
runs through snd_pcm_period_elapsed(), or "update DMA residue, period(s)
completed".

I switched imx-sdma.c to use (2) because I was seeing problems with
(1) - see "imx-sdma: update cyclic handling to report residue".

I'd encourage everyone to use (2) rather than (1) - in fact, I'd
suggest that the first method is deprecated and removed.  If the
DMAengine driver knows how many times to make the callback, it can
implement the residue too and not need to play that game.

Another point here is if you are implementing cyclic behaviour in
software, then you need to deal with the cyclic stuff in the hardware
interrupt function, not in the tasklet.  There's too much latency with
getting to the tasklet, especially if you have USB devices (which
chew lots of interrupt time.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
