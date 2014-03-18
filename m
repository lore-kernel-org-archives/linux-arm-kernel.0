From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Mar 2014 17:26:15 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
Message-ID: <20140318172615.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
> Setting prefetch enables and early BRESP could all be done
> unconditionally in the core code.

I think we can do a few things here, if we know that the CPUs we're
connected to are all Cortex-A9:

1. Enable BRESP.

2. Enable I+D prefetching - but we really need to tune the prefetch offset
   for this to be worthwhile.  The value depends on the L3 memory system
   latency, so isn't something that should be specified at the SoC level.
   It may also change with different operating points.

3. Full line of zeros - I think this is a difficult one to achieve properly.
   The required sequence:

   - enable FLZ in L2 cache
   - enable L2 cache
   - enable FLZ in Cortex A9

   I'd also assume that when we turn the L2 cache off, we need the reverse
   sequence too.  So this sequence can't be done entirely by the boot loader.

With (1) enabled and (2) properly tuned, I see a performance increase of
around 60Mbps on transmission, bringing the Cubox-i4 up from 250Mbps to
315Mbps transmit on its gigabit interface with cpufreq ondemand enabled.
With "performance", this goes up to [323, 323, 321, 325, 322]Mbps.  On
receive [446, 603, 605, 605, 601]Mbps, which hasn't really changed
very much (and still impressively exceeds the Freescale stated maximum
total bandwidth of the gigabit interface.)

(3) is going to be harder to have the kernel to sort out - because we'd
need to enable FLZ in the L2 cache, enable the cache (that's the easy bit)
and then turn on FLZ in each of the Cortex-A9 AUXCR registers.  That's the
hard bit for the L2 code to do for two reasons:
a) it means SMC stuff for our three non-secure SoC
b) the random placement of where the L2 cache initialisation makes setting
   stuff up at the appropriate time more difficult than it really need be.
   We can't rely on the scheduler running but at the same time, we can't
   rely on other SMP CPUs not running.

I think (3) is going to require a round of L2 cache initialisation
unification across all platforms before we can sanely have the kernel
enabling that feature.

Other features fall under the same problem that (3) does.  If you have a
Cortex-A9 connected to a PL310, then there are performance options you
can enable in the Cortex-A9, such as the prefetch hint enable, which
allow the Cortex-A9 to issue hints to the connected PL310 to bring cache
lines into the L2 without needing to return data to the CA9.

Looking at some of this stuff, there's quite a large number of performance
features that we just plain ignore so far - uboot doesn't seem to touch
them, and from what I can see, not many people have been particularly
interested in evaluating them (people seem to prefer to optimise memcpy
code, or switch to using neon, or some other solution like that.)

I wonder how much system performance we're losing because we've been
ignoring these configuration options.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
