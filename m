From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2009 15:05:29 +0000
Subject: [RFC PATCH] ARMv7: Use lazy cache flushing if hardware
	broadcasts cache operations
In-Reply-To: <1257427861.26730.37.camel@pc1117.cambridge.arm.com>
References: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
	<20091105130048.GA21681@n2100.arm.linux.org.uk>
	<1257427861.26730.37.camel@pc1117.cambridge.arm.com>
Message-ID: <20091105150529.GD21681@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 01:31:00PM +0000, Catalin Marinas wrote:
> -#ifndef CONFIG_SMP
> -	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
> +	if (!cache_ops_need_broadcast() &&
> +	    test_and_clear_bit(PG_dcache_dirty, &page->flags))

We really don't need the additional check here - there's only one
place where PG_dcache_dirty gets set, and that's flush_dcache_page().
If we avoid setting the bit for hardware which doesn't broadcast,
we won't call __flush_dcache_page().
