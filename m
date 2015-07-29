From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jul 2015 19:33:21 +0100
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150729183321.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 03:43:04PM +0100, Jon Hunter wrote:
> The gic_init_bases() function initialises an array that stores the mapping
> between the GIC and CPUs. This array is a global array that is
> unconditionally initialised on every call to gic_init_bases(). Although,
> it is not common for there to be more than one GIC instance, there are
> some devices that do support nested GIC controllers and gic_init_bases()
> can be called more than once.
> 
> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
> will only setup the mapping again for CPU0. This is because for child GIC
> controllers there is most likely only one recipient of the interrupt.
> 
> Fix this by moving the CPU mapping array to the GIC chip data structure
> so that it is initialised for each GIC instance separately. It is assumed
> that the bL switcher code is only interested in the root or primary GIC
> instance.

Does it make sense to expose the per-CPU-ness of the non-primary GIC?
If they are chained off a primary GIC SPI interrupt, then all IRQs on
the secondary GIC are routed to the same CPU that the SPI on the primary
GIC is routed to.

Other features like the PPIs and SGIs in the secondary CPU should also
be ignored - they probably aren't used anyway.

I have to say though... are the 1020 IRQs that the primary GIC provides
really not enough?  What insane hardware needs more than 1020 IRQs?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
