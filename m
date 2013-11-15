From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 15:05:46 +0000
Subject: [PATCH 1/6] arm64: mm: Add __virt_to_idmap() to keep kvm build
 happy
In-Reply-To: <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5286384A.5050105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/13 19:37, Santosh Shilimkar wrote:
> ARM kvm code will make use of __virt_to_idmap() on arm32
> machines as hardware interconnect supported alias of physical
> memory for idmap purposes. The same code is shared with arm64
> bit and hence will break the builds. So we add __virt_to_idmap()
> which is just __virt_to_phys() on arm64 bit to keep build happy.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm64/include/asm/memory.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 3776217..d9341ee 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -75,6 +75,14 @@
>  #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
>  
>  /*
> + * Added to keep arm64 kvm build working which shares code with
> + * 32bit port. ARM kvm code makes use of __virt_to_idmap() on arm32
> + * machines as hardware interconnect supported alias of physical
> + * memory for idmap purposes.
> + */
> +#define virt_to_idmap(x)	__virt_to_phys(x)
> +
> +/*
>   * Convert a physical address to a Page Frame Number and back
>   */
>  #define	__phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
> 

I'd rather have a kvm_virt_to_phys() in kvm_mmu.h. That's how we've
dealt with that kind of difference so far.

	M.
-- 
Jazz is not dead. It just smells funny...
