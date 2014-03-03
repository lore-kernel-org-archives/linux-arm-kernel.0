From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Mar 2014 16:31:39 +0000
Subject: static asmlinkage in irqchip (was Re: next build: 78 warnings
 0 failures (next/next-20140228))
In-Reply-To: <20140303161217.GK7308@joshc.qualcomm.com>
References: <5310415c.2d79420a.3275.ffff92bb@mx.google.com>
 <5311449E.90902@codeaurora.org> <20140301161258.GN12219@tassilo.jf.intel.com>
 <20140303161217.GK7308@joshc.qualcomm.com>
Message-ID: <20140303163139.GJ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 10:12:17AM -0600, Josh Cartwright wrote:
> On Sat, Mar 01, 2014 at 08:12:58AM -0800, Andi Kleen wrote:
> > > These seem to be caused by 128ea04a9885 (lto: Make asmlinkage __visible,
> > > 2014-02-08). Before that change asmlinkage was defined to nothing on
> > > ARM, but now it's __visible. Should we just drop asmlinkage here?
> >
> > These functions are just called by the generic C interrupt layer right?
> > Yes should just drop asmlinkage. It doesn't make any sense to mark
> > functions that only called from C asmlinkage.
> 
> On ARM[64], these functions are called from assembly indirectly through
> the 'handle_arch_irq' function pointer, so I don't think it makes sense
> to drop 'asmlinkage'.

If building with a C++ compiler:

	asmlinkage = extern "C"

	static asmlinkage = static extern "C"

That doesn't quite make much sense when you think about it - even with
the existing definition in current mainline kernels.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
