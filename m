From: Joe.Buck@synopsys.COM (Joe Buck)
Date: Thu, 17 Dec 2009 10:35:17 -0800
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217181718.GA4440@n2100.arm.linux.org.uk>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
Message-ID: <20091217183517.GC10707@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 10:17:18AM -0800, Russell King - ARM Linux wrote:
> > It shouldn't as *(int *)0 = 0; might trap.  But if you want to be sure
> > use
> >    __builtin_trap ();
> > instead for the whole sequence (the unreachable is implied then).
> > GCC choses a size-optimal trap representation for your target then.
> 
> How is "size-optimal trap" defined?  The point of "*(int *)0 = 0;" is
> to cause a NULL pointer dereference which is trapped by the kernel to
> produce a full post mortem and backtrace which is easily recognised
> as a result of this code.

With something like __builtin_trap, the compiler knows that your intent
is to cause a trap.  But it's asking for trouble, and for future
flame wars between kernel developers and gcc developers, to put in
sequences that happen to do the right thing if the compiler does
no optimizations whatsoever, but that might be messed up by optimizations
because they are code sequences whose behavior is undefined.

Besides, didn't I see a whole bunch of kernel security patches related
to null pointer dereferences lately?  If page 0 can be mapped, you
suddenly won't get your trap.
