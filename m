From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 21:09:49 +0100
Subject: Thread pointer changes
In-Reply-To: <53ADC5B1.6080905@amacapital.net>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
Message-ID: <20140627200949.GQ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:27:45PM -0700, Andy Lutomirski wrote:
> The "vectors" page appears to be an abomination that's a lot like the
> x86_64 vsyscall page.  IMO it should be phased out.  I'm not going to do
> it (I don't know enough about ARM, and I'm not really able to test),
> but, having gone through cleaning up the vsyscall mess a couple of years
> ago, I'd be happy to help if anyone is interested in doing it.

It's cleaned up as much as is possible to do - I personally put the
work into that last Summer, so I'm fully aware of all the issues, and
where we are now with it is where we're going to have to stay for at
least the next five to ten years as changing it any further breaks
binary compatibility or severely impacts performance.

There are options:

1. The page is present (which is the default setting) with kuser helpers
   present.

2. The page is not accessible, which must only be set where the guy
   configuring the kernel is sure that the userspace does not need the
   kuser page.  This point is clearly made in the help text for
   CONFIG_KUSER_HELPERS.

There isn't actually a third combination (page accessible but no kuser
helpers) or if there is, that's something someone else has added which
is not part of the mainline kernel.

One thing which did change last Summer is that various bits of kernel
code were moved out of the vectors page, code which user space has no
business poking its nose at (and using it to discover some useful
kernel addresses) and to also poison the vectors page to mitigate
against randomly jumping into the page at non-ABI locations.  Neither
of those two changes should affect any legitimate userspace application.

As I said above, enabling CONFIG_KUSER_HELPERS is known to be an ABI
break, and it's well documented as such.  The future will be running
systems without the kuser helpers because on ARMv6 and later, there's
little point in having them.  In fact, today almost all C libraries
are built without needing the kuser helpers.

As the future will be no kuser helper page, there's no point in trying
to turn it into a VDSO page - that presents many challenges as it's
not as trivial as you think.  Part of the problem that the kuser helper
page addresses is how to deal with per-thread data on early CPUs without
having any per-thread registers to store it.  That requires uniprocessor
and the kernel to poke the thread pointer into the page - and userspace
then needs to be able to access it reliably.

Due to that, any ARMv5 or earlier CPU will always have the kuser helper
page.  ARMv6 and later may or may not have the kuser helper page, but
there you're really building for a different ABI anyway (VFP-based) and
you also know that you have the thread registers.

The final point to make is that only the C library should really be
concerned about this page, not applications.  Applications should not
be making direct calls into this page.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
