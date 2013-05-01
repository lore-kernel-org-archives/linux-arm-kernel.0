From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 May 2013 12:42:38 +0100
Subject: [RFC PATCH 7/9] ARM64: mm: HugeTLB support.
In-Reply-To: <1367339448-21727-8-git-send-email-steve.capper@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-8-git-send-email-steve.capper@linaro.org>
Message-ID: <20130501114238.GG22796@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Tue, Apr 30, 2013 at 05:30:46PM +0100, Steve Capper wrote:
> Add huge page support to ARM64, different huge page sizes are
> supported depending on the size of normal pages:
> 
> PAGE_SIZE is 4K:
>    2MB - (pmds) these can be allocated at any time.
> 1024MB - (puds) usually allocated on bootup with the command line
>          with something like: hugepagesz=1G hugepages=6
> 
> PAGE_SIZE is 64K:
>  512MB - (pmds), usually allocated on bootup via command line.

[...]

> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 75fd13d..c3cac68 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -53,6 +53,7 @@
>  #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
>  #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
>  #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
> +#define PTE_TYPE_HUGEPAGE	(_AT(pmdval_t, 1) << 0)

This breaks PROT_NONE mappings, where you get:

	pte = pte_mkhuge(pte_modify(pte, newprot));

The pte_modify will clear the valid bit and set the prot_none bit (in order
to create a present, faulting entry) but then your pte_mkhuge will come in
and clobber that with a valid block entry.

Will
