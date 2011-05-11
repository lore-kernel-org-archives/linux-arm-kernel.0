From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 11:54:19 +0100
Subject: [PATCH 20/19] ARM: LPAE: Invalidate the TLB before freeing the PMD
In-Reply-To: <1305109399-13156-1-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1305109399-13156-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110511105419.GD5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 11:23:19AM +0100, Catalin Marinas wrote:
> +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> +				  unsigned long addr)
> +{
> +#ifdef CONFIG_ARM_LPAE
> +	tlb_add_flush(tlb, addr);
> +	tlb_flush(tlb);
> +	pmd_free((tlb)->mm, pmdp);
> +#endif
> +}

You're:

1. tlb_add_flush() - Adding the address which covers the PMD to the range
   of virtual addresses which need flushing - ok.
2. tlb_flush() - You're then forcing a flush.
3. pmd_free() - You're now freeing the page.

One of the points about the shootdown interface is that it batches things
up.  So what's wrong with:

static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
	unsigned long addr)
{
#ifdef CONFIG_ARM_LPAE
	tlb_add_flush(tlb, addr);
	tlb_remove_page(tlb, virt_to_page(pmdp));
#endif
}

and leave the tlb invalidate and actual page freeing to the batching code
to deal with?
