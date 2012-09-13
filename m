From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Sep 2012 18:20:57 +0100
Subject: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
In-Reply-To: <20120913010041.GD7622@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
 <5050CD87.4020800@codeaurora.org> <20120913010041.GD7622@verge.net.au>
Message-ID: <20120913172057.GB13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 10:00:42AM +0900, Simon Horman wrote:
> +config ARM_ERRATA_782773
> +	bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 782773 Cortex-A9 (all r0,
> +	  r2 and r3 revisions) erratum. It might cause MMU exception in case
> +	  page table walk happens just after updating the existing
> +	  with setting page table in L1 data cache.

What if we're running on a SMP system where the L1 caches are mandated
to be in write-allocate mode?  This write will immediately cause the
cache line to be brought back into the cache.

This sounds like a broken work-around to me.
