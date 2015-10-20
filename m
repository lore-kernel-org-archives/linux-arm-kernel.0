From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 20 Oct 2015 03:22:55 -0700
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151019155310.GO32532@n2100.arm.linux.org.uk>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux> <5308760.2G5KJFF9Pi@wuerfel>
 <20151008074828.GF4570@linux> <20151019154009.20687.41178@quantum>
 <20151019155310.GO32532@n2100.arm.linux.org.uk>
Message-ID: <20151020102255.20687.72485@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2015-10-19 08:53:11)
> On Mon, Oct 19, 2015 at 08:40:09AM -0700, Michael Turquette wrote:
> > Quoting Viresh Kumar (2015-10-08 00:48:28)
> > > On 07-10-15, 21:12, Arnd Bergmann wrote:
> > > > I think it clearly makes sense to have a fixed length for each of these
> > > > members:
> > > >
> > > > either 32 bit is enough to represent all possible values, then
> > > > there is no need to make them 'long' on 64-bit architectures, or 32 bit
> > > > is not enough and then the code is broken on 32-bit architectures today
> > > > and should be fixed.
> > > 
> > > I agree.
> > > 
> > > But I am not 100% sure why it was done this way to start with.
> > > Probably this is the logic behind that:
> > > - Max clock rate supported by a u32 is ~ 4.295 GHz
> 
> The limit is actually half that when you consider clk_round_rate()
> returns a long, because clk_round_rate() needs to be able to return
> errors.
> 
> The use of long and unsigned long was done in the knowledge that it'd
> restrict to 2GHz the upper limit, partially because 64-bit math on
> 32-bit systems is inefficient and expensive, and I initially wanted
> people to use the thing, so it had to be lean and fast.  (If I'd
> started out with something as complex as the CCF, it would've been
> laughed out as being "far too complex" and "we don't need this").
> 
> It also started out as a way to convey clock information to drivers
> for peripherals, which commonly don't need clocks up in the GHz range,
> indeed, it was rare at that time the API was designed for peripheral
> clocks to be much above 100MHz.

And this is still very true today. We've had a few instances where
platforms hit the 2GHz limit on a PLL feeding a divider to a CPU, but
the current state of things is working for the common case.

The big question is whether to change it in anticipation of higher clock
rates (somebody has to drive those THz transceivers and photonic
interconnects!) or just wait until enough people start screaming.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
