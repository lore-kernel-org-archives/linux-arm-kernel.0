From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 19:48:37 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217193826.GE362@shareable.org>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
	<20091217183517.GC10707@synopsys.com>
	<20091217190613.GB4440@n2100.arm.linux.org.uk>
	<20091217191401.GD10707@synopsys.com>
	<20091217193826.GE362@shareable.org>
Message-ID: <20091217194837.GD4440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 07:38:26PM +0000, Jamie Lokier wrote:
> Joe Buck wrote:
> > On Thu, Dec 17, 2009 at 11:06:13AM -0800, Russell King - ARM Linux wrote:
> > > On Thu, Dec 17, 2009 at 10:35:17AM -0800, Joe Buck wrote:
> > > > Besides, didn't I see a whole bunch of kernel security patches related
> > > > to null pointer dereferences lately?  If page 0 can be mapped, you
> > > > suddenly won't get your trap.
> > > 
> > > Page 0 can not be mapped on ARM kernels since the late 1990s, and this
> > > protection is independent of the generic kernel.
> > > 
> > > Milage may vary on other architectures, but that's not a concern here.
> 
> It does not trap on at least one ARM-nommu kernel...

I was going to say the following in a different reply but discarded it
because it wasn't relevant to the GCC list.

I regard ARM nommu as highly experimental, especially as the maintainer
vanished half way through merging it into mainline.  I know that there
are some parts of ARM nommu that are highly buggy - such as ARM940
support invalidating the entire data cache on any DMA transaction...
say goodbye stacked return addresses.

As such, I would not be surprised if the ARM nommu kernel has _lots_ of
weird and wonderful bugs.  I am not surprised that NULL pointer dereferences
don't work - its actually something I'd expect given that they have a
protection unit which the kernel doesn't apparently touch.

Maybe the protection unit code never got merged?  I've no idea.  As I
say, uclinux support got as far as being half merged and that's roughly
the state it's remained in ever since.

We don't even have any no-MMU configurations which the kernel builder
automatically tests for us.

Given the lack of progress/bug reporting on ARM uclinux, the lack of
platform support and the lack of configurations, my view is that there
is no one actually using it.  I know that I don't particularly take any
care with respect to uclinux when making changes to the MMU based kernels.
Why bother if apparantly no one's using it?
