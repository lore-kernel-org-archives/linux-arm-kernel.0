From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 00:28:58 +0000
Subject: ks8695_gettimeoffset
In-Reply-To: <4D18B2B5.5000001@visionsystems.de>
References: <4D0FA9FB.3060309@softplc.com>
	<20101220193049.GI28157@n2100.arm.linux.org.uk>
	<4D18B2B5.5000001@visionsystems.de>
Message-ID: <20110103002858.GD17727@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 27, 2010 at 04:37:25PM +0100, Yegor Yefremov wrote:
> Am 20.12.2010 20:30, schrieb Russell King - ARM Linux:
> > On Mon, Dec 20, 2010 at 01:09:47PM -0600, Dick Hollenbeck wrote:
> >> >From userspace, printing the return values from a rapid looping
> >> sequence of calls to
> >>
> >>    clock_gettime( CLOCK_MONOTONIC, &now );
> >>
> >> leads me to believe that kernel function ks8695_gettimeoffset() is
> >> not worth anything.
> > 
> > That'll be because clock_gettime(CLOCK_MONOTONIC) doesn't use the old
> > gettimeoffset() method to correct the returned time - none of the POSIX
> > timers use the old gettimeoffset() stuff, only gettimeofday() does.
> > 
> > Platforms really should be using the clocksource/clockevents code
> > where ever possible, rather than selecting ARCH_USES_GETTIMEOFFSET.
> > 
> > Does someone with a KS8695-based platform want to have a go at
> > converting it over to clocksource/clockevents?
> 
> Is it possible at all to implement clocksource/clockevents for KS8695?
> As Dick and "Register Description" already said you cannot read the
> time register, so clocksource->read cannot be implemented to return
> ticks elapsed. Or do I see it wrong? 

If you have no register which ticks at a fixed rate, then you have no
hope to use the clocksource/clockevents code, and will be stuck with
the old gettimeoffset() stuff.

Note that even a 16-bit 32768Hz counter would be a candidate for a
clocksource (it'd be an improvement over either a buggy gettimeoffset()
or no gettimeoffset().)

> Is there any documentation for clocksource/clockevents? 

That's a question I've asked many times.

The answer is nothing beyond the comments in the header files
(include/linux/clocksource.h, include/linux/clockchips.h), source files
(kernel/time/), commits covering the same, the already merged
implementations, and some stuff in Documentation/timers/.

Clocksources themselves are very simple:

static cycle_t cksrc_foo_read(struct clocksource *cs)
{
	return readl(cycle_counter);
}

and add maths to make sure the returned value is incrementing if it
isn't.  Optionally implement the enable/disable callbacks if you can
turn on/off this clocksource:

static int cksrc_foo_enable(struct clocksource *cs)
{
	writel(enable_val, enable_reg);
}

static void clksrc_foo_disable(struct clocksource *cs)
{
	writel(disable_val, enable_reg);
}

Declare the clocksource structure:

static struct clocksource cksrc_foo = {
	.name		= "some_descriptive_name",
	.rating 	= 200,
	.read		= cksrc_foo_read,
	.enable 	= cksrc_foo_enable,
	.disable	= cksrc_foo_disable,
	.mask		= CLOCKSOURCE_MASK(number_of_bits_in_cycle_counter),
	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
};

Finally, register it in the sys_timer init method:

	clocksource_register_hz(&cksrc_foo, cycle_counter_tick_rate_in_hz);
or
	clocksource_register_khz(&cksrc_foo, cycle_counter_tick_rate_in_khz);

Once you have that in place, you can kill off the gettimeoffset() stuff
and ensure that you don't enable the ARCH_USES_GETTIMEOFFSET config symbol.

The gotcha here is that the cycle counter must not overflow between any
two timer interrupts - so make sure that it won't wrap within your normal
periodic timer tick rate.  If it does wrap, you won't keep good time.

The clockevent support is similar - but more complicated to explain in an
email without knowing the details of the hardware (because there's too
many possibilities.)  I believe the clockevent stuff needs the clocksource
stuff to be in place first though.
