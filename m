From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Apr 2014 23:59:19 +0100
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a
 more sensible location
In-Reply-To: <533B0BC1.6080608@wwwdotorg.org>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
Message-ID: <20140401225919.GD7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 12:56:01PM -0600, Stephen Warren wrote:
> On 03/28/2014 09:20 AM, Russell King wrote:
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> EXCEPT this one patch, the series,
> Tested-by: Stephen Warren <swarren@nvidia.com>
> (on Tegra20/Toshiba AC100 and Tegra30/Beaver)
> 
> And any part which touches Tegra code,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> However, this one patch causes boot failures on the Toshiba AC100,
> Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
> investigated what the problem is; do you need me to and/or have any clues?

My first thought is... try reverting the
"l2c: permit flush_all() on large flush_range()" commit and see what effect
that may have - that isn't a perfected patch (hence the XXX in the
summary line).

I'm hoping that we don't have people doing large dma_alloc_coherent() in
interrupt context - if they are, that could lead to a silent deadlock
(even with lockdep enabled.)  Large being defined by "size of your L2
cache or larger".

If we are going to hit that kind of sillyness, then we're just going to
have to pay the price of invalidating large blocks of memory on a per-
cache line basis across the full size - yes, this means it will suck,
people allocating frame buffers using CMA will complain, but then we
really should not be doing such large allocations from IRQ context.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
