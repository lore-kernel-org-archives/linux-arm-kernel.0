From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Jul 2010 15:20:43 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007221531.58744.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221410.10087.david.jander@protonic.nl>
	<20100722125652.GL10930@sirena.org.uk>
	<201007221531.58744.david.jander@protonic.nl>
Message-ID: <20100722142043.GK4737@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 03:31:58PM +0200, David Jander wrote:
> On Thursday 22 July 2010 02:56:52 pm Mark Brown wrote:

> > If you don't have JTAG access (either due to device limitations or due
> > to lack of data from the vendor of a reference platform you're using)
> > replacing a bootloader can be rather more stressful than it's worth.
> 
> I agree, but I simply can't believe ARM platform designers all do such a bad 
> job at firmware (=bootloader) development in general, which is in sharp 
> contrast to what I have learned from previous PowerPC developments.

> Maybe the difference is in the market: PowerPC is more geared towards an 
> industrial embedded market (high demand of robustness and reliability), while 
> ARM comes from a pure consumer market, and is just lately making inroads into 
> industrial applications.

I suspect it's more that there are vastly fewer PowerPC vendors out
there so much less independant development - compared to ARM the PowerPC
devices are *very* homogenous.

> > Well, from the point of view of using systems like this all you need the
> > bootloader to do is to set the system up enough to load the kernel and
> > start it running.  You don't need it to understand anything else about
> > the rest of the system, which means you're less reliant on the quality
> > of the bootloader.

> How can you assume that kernel-developers know how to correcly set-up the slew 
> rate and drive-strength of an I/O-pin for a given platform if the manufacturer 
> itself didn't do it nor document it!??

Usually the people doing the kernel bringup on an actual end system will
be part of the same organisation that does the hardware design - if
there's a problem the kernel developer can usually locate the orginal
hardware designer.

> Even if it works with one guessed setting, there is a potential EMC impact 
> that needs to be taken care of.

As I said, even if the bootloader *can* be updated at least some users
are likely to refuse point blank to do so if they don't have a recovery
mechanism that they trust and prefer to fix the code up in a part of the
system they can recover easily if it fails.  The determination of these
paramters may come after the original bootloader is written (since they
may depend in part on measurement, for example).  Another issue can be
that in development simultaneously deploying bootloader and kernel
updates can be more difficult than deploying a single image so people
prefer to keep everything in one place.

The reliability concerns also apply to updates done in the field (eg,
when rolling out new functionality) - anything that may require fallback
to JTAG is fail.

> There are important hardware-design decisions after each of those settings! If 
> we continue this amateuristic approach, ARM-linux platforms will never get 
> taken seriously in more demanding environments. This really needs to change.

I'm not sure what you believe is amateurish about this approach?
Clearly if you think that the kernel should have no involvement in
configuring the system then there's a problem but that's not a given.

For various reasons ARM systems have pretty much ended up in a position
like PCs where the bootloader is responsible for starting the kernel and
not much else.
