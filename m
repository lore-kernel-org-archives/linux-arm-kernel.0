From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 1 May 2013 15:16:14 +0100
Subject: [RFC PATCH 9/9] ARM64: mm: THP support.
In-Reply-To: <1367339448-21727-10-git-send-email-steve.capper@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-10-git-send-email-steve.capper@linaro.org>
Message-ID: <20130501141613.GA23462@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 05:30:48PM +0100, Steve Capper wrote:
> Bring Transparent HugePage support to ARM. The size of a
> transparent huge page depends on the normal page size. A
> transparent huge page is always represented as a pmd.
> 
> If PAGE_SIZE is 4K, THPs are 2MB.
> If PAGE_SIZE is 64K, THPs are 512MB.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm64/Kconfig                     |  3 +++
>  arch/arm64/include/asm/pgtable-hwdef.h |  1 +
>  arch/arm64/include/asm/pgtable.h       | 47 ++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/tlb.h           |  6 +++++
>  arch/arm64/include/asm/tlbflush.h      |  2 ++
>  5 files changed, 59 insertions(+)
> 

[ ... ]

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 4b7a058..06bfbd6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h

[ ... ]

> +#define pmd_modify(pmd,newprot)	(__pmd(pmd_val(pmd) | pgprot_val(newprot)))
> +#define set_pmd_at(mm, addr, pmdp, pmd)	set_pmd(pmdp, pmd)

Apologies, I have over-simplified (and broke) pmd_modify whilst tidying up this
patch. It should mask off certain bits. I will send out a correction once
PROT_NONE support has been sorted as this will affect this code path too.

--
Steve
