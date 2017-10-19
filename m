From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:01:37 +0100
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <31b16c9d-48c7-bc0a-51d1-cc6cf892329b@gmail.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <31b16c9d-48c7-bc0a-51d1-cc6cf892329b@gmail.com>
Message-ID: <20171019120137.GT20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 02:42:49AM +0300, Dmitry Osipenko wrote:
> On 11.10.2017 11:22, Abbott Liu wrote:
> > +void __init kasan_map_early_shadow(pgd_t *pgdp)
> > +{
> > +	int i;
> > +	unsigned long start = KASAN_SHADOW_START;
> > +	unsigned long end = KASAN_SHADOW_END;
> > +	unsigned long addr;
> > +	unsigned long next;
> > +	pgd_t *pgd;
> > +
> > +	for (i = 0; i < PTRS_PER_PTE; i++)
> > +		set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
> > +			&kasan_zero_pte[i], pfn_pte(
> > +				virt_to_pfn(kasan_zero_page),
> > +				__pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN)));
> 
> Shouldn't all __pgprot's contain L_PTE_MT_WRITETHROUGH ?

One of the architecture restrictions is that the cache attributes of
all aliases should match (but there is a specific workaround that
permits this, provided that the dis-similar mappings aren't accessed
without certain intervening instructions.)

Why should it be L_PTE_MT_WRITETHROUGH, and not the same cache
attributes as the lowmem mapping?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
