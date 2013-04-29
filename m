From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Apr 2013 18:35:21 +0100
Subject: [PATCH v3 08/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <1365437854-30214-9-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130429173521.GB16544@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:10PM +0100, Marc Zyngier wrote:
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> new file mode 100644
> index 0000000..2eb2230
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_mmu.h
...
> +/*
> + * Align KVM with the kernel's view of physical memory. Should be
> + * 40bit IPA, with PGD being 8kB aligned.
> + */
> +#define KVM_PHYS_SHIFT	PHYS_MASK_SHIFT

Just wondering - do we allow the IPA to be bigger than what qemu/kvmtool
can map?

> +#define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
> +#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
> +
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define PAGE_LEVELS	2
> +#define BITS_PER_LEVEL	13
> +#else  /* 4kB pages */
> +#define PAGE_LEVELS	3
> +#define BITS_PER_LEVEL	9

You could use (PAGE_SHIFT - 3) for BITS_PER_LEVEL if that's any clearer
but you can get rid of these entirely (see below).

> +#endif
> +
> +/* Make sure we get the right size, and thus the right alignment */
> +#define BITS_PER_S2_PGD (KVM_PHYS_SHIFT - (PAGE_LEVELS - 1) * BITS_PER_LEVEL - PAGE_SHIFT)
> +#define PTRS_PER_S2_PGD (1 << max(BITS_PER_LEVEL, BITS_PER_S2_PGD))
> +#define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> +#define S2_PGD_SIZE	(1 << S2_PGD_ORDER)

It looks like lots of calculations which I can't fully follow ;). So we
need to map KVM_PHYS_SHIFT (40-bit) with a number of stage 2 pgds. We
know that a pgd entry can map PGDIR_SHIFT bits. So the pointers you need
in S2 pgd:

#define PTRS_PER_S2_PGD		(1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))

(no need of PAGE_LEVELS)

With some more juggling you can probably get rid of get_order as well,
though it should be a compile-time constant. Basically KVM_PHYS_SHIFT -
PGDIR_SHIFT - PAGE_SHIFT + 3 (and cope with the negative value for the
64K pages).

> +static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
> +{
> +	unsigned long hva = gfn_to_hva(kvm, gfn);
> +	flush_icache_range(hva, hva + PAGE_SIZE);

Even ARMv8 can have aliasing VIPT I-cache. Do we need to flush some more
here?

> +#define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))

I had a brief look at the other hyp reworking patches and this function
is used in two situations: (1) flush any data before the Hyp is
initialised and (2) page table creation. The first case looks fine but
the second is not needed on AArch64 (and SMP AArch32) nor entirely
optimal as it should flush to PoU for page table walks. Can we have
different functions, at least we can make one a no-op?

-- 
Catalin
