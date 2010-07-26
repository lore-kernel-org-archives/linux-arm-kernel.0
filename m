From: davidsin@ti.com (Sin, David)
Date: Mon, 26 Jul 2010 14:34:30 -0500
Subject: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
	implementation
In-Reply-To: <20100724080118.GB15064@n2100.arm.linux.org.uk>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
	<1279927348-21750-2-git-send-email-davidsin@ti.com>
	<1279927348-21750-3-git-send-email-davidsin@ti.com>
	<1279927348-21750-4-git-send-email-davidsin@ti.com>
	<1279927348-21750-5-git-send-email-davidsin@ti.com>
	<20100724080118.GB15064@n2100.arm.linux.org.uk>
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D63B9DD3@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK -- I will revisit this.  Thanks for the explanation.

-David

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Saturday, July 24, 2010 3:01 AM
To: Sin, David
Cc: linux-arm-kernel at lists.arm.linux.org.uk; linux-omap at vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Shilimkar, Santosh; Molnar, Lajos
Subject: Re: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and implementation

On Fri, Jul 23, 2010 at 06:22:24PM -0500, David Sin wrote:
> +/* allocate and flush a page */
> +static struct mem *alloc_mem(void)
> +{
> +	struct mem *m = kzalloc(sizeof(*m), GFP_KERNEL);
> +	if (!m)
> +		return NULL;
> +
> +	m->pg = alloc_page(GFP_KERNEL | GFP_DMA);
> +	if (!m->pg) {
> +		kfree(m);
> +		return NULL;
> +	}
> +
> +	m->pa = page_to_phys(m->pg);
> +
> +	/* flush the cache entry for each page we allocate. */
> +	dmac_flush_range(page_address(m->pg),
> +				page_address(m->pg) + PAGE_SIZE);
> +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);

NAK.  This is an abuse of these interfaces, and is buggy in any case.

ARMv6 and ARMv7 CPUs speculatively prefetch memory, which means that
there's no guarantee that if you flush the caches for a particular
range of virtual space, that it will stay flushed until you decide
to read it.  So flushing the caches in some memory allocator can't
guarantee that when you eventually get around to using the page that
there won't be cache lines associated with it.
