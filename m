From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Mar 2014 22:52:32 +0100
Subject: PL310 errata workarounds
In-Reply-To: <20140318172615.GX21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
 <20140318172615.GX21483@n2100.arm.linux.org.uk>
Message-ID: <201403192252.32443.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 18, 2014 at 06:26:15 PM, Russell King - ARM Linux wrote:
> On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
> > Setting prefetch enables and early BRESP could all be done
> > unconditionally in the core code.
> 
> I think we can do a few things here, if we know that the CPUs we're
> connected to are all Cortex-A9:
> 
> 1. Enable BRESP.
> 
> 2. Enable I+D prefetching - but we really need to tune the prefetch offset
>    for this to be worthwhile.  The value depends on the L3 memory system
>    latency, so isn't something that should be specified at the SoC level.
>    It may also change with different operating points.
> 
> 3. Full line of zeros - I think this is a difficult one to achieve
> properly. The required sequence:
> 
>    - enable FLZ in L2 cache
>    - enable L2 cache
>    - enable FLZ in Cortex A9
> 
>    I'd also assume that when we turn the L2 cache off, we need the reverse
>    sequence too.  So this sequence can't be done entirely by the boot
> loader.
> 
> With (1) enabled and (2) properly tuned, I see a performance increase of
> around 60Mbps on transmission, bringing the Cubox-i4 up from 250Mbps to
> 315Mbps transmit on its gigabit interface with cpufreq ondemand enabled.
> With "performance", this goes up to [323, 323, 321, 325, 322]Mbps.  On
> receive [446, 603, 605, 605, 601]Mbps, which hasn't really changed
> very much (and still impressively exceeds the Freescale stated maximum
> total bandwidth of the gigabit interface.)

Speaking of FEC and slightly off-topic, have you ever seen this on your box 
[1]/[2]/[3] ? I wonder if this might be cache-related as well, since I saw 
similar issue on MX6 with PCIe-connected ethernet. I cannot put a finger on this 
though.

[1] http://www.spinics.net/lists/netdev/msg275354.html
[2] http://www.spinics.net/lists/netdev/msg268190.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-
October/202519.html

Best regards,
Marek Vasut
