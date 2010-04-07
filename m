From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Apr 2010 13:12:07 +0100
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <20100407110350.GD3688@pengutronix.de>
References: <4BB22576.1070108@epfl.ch> <20100331083415.GR2241@pengutronix.de>
	<4BB4C362.3000803@epfl.ch> <20100402095358.GZ2241@pengutronix.de>
	<20100402104241.GC27613@sirena.org.uk>
	<20100407110350.GD3688@pengutronix.de>
Message-ID: <20100407121206.GC13576@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 07, 2010 at 01:03:50PM +0200, Sascha Hauer wrote:
> On Fri, Apr 02, 2010 at 11:42:42AM +0100, Mark Brown wrote:

> > What sample rate are you trying to play and what buffer size?  In my
> > testing the FIQ was really struggling with most applications at sample
> > rates over ~16kHz since you need each audio period to be long enough to
> > at least fill the interval between timer polls but applications wanted
> > to select buffer sizes that were consumed faster than the timer tick.

> After deleting the file I could play sounds (and record simultaniously)
> with rates up to 44100kHz without visible cpu utilisation.

Yes, if you tweak the buffer sizes (most of the ALSA test utilities
support this) then you can use higher sample rates - pulseaudio's high
latency modes should work great, for example.

> Looking at it I realised that poll_time is 0, so the timer gets reloaded
> with the actual jiffies value which of course is a bad idea. We should
> probably use a hrtimer here.

Yes, by default you're only going to be able to poll at 1ms intervals so
the poll time ends up going down to zero.  I did look at switching over
to a hrtimer when I was fixing up the sample rate slips but I wasn't
able to convince myself that there was a hrtimer offering sufficient
resolution available on i.MX.
