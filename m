From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Aug 2013 13:04:36 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranav,

On 2013-08-14 12:47, Pranavkumar Sawargaonkar wrote:
> Systems with large external L3-cache (few MBs), might have dirty
> content belonging to the guest page in L3-cache. To tackle this,
> we need to flush such dirty content from d-cache so that guest
> will see correct contents of guest page when guest MMU is disabled.
>
> The patch fixes coherent_icache_guest_page() for external L3-cache.
>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_mmu.h
> b/arch/arm64/include/asm/kvm_mmu.h
> index efe609c..5129038 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -123,6 +123,8 @@ static inline void
> coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>  	if (!icache_is_aliasing()) {		/* PIPT */
>  		unsigned long hva = gfn_to_hva(kvm, gfn);
>  		flush_icache_range(hva, hva + PAGE_SIZE);
> +		/* Flush d-cache for systems with external caches. */
> +		__flush_dcache_area((void *) hva, PAGE_SIZE);
>  	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
>  		/* any kind of VIPT cache */
>  		__flush_icache_all();

[adding Will to the discussion as we talked about this in the past]

That's definitely an issue, but I'm not sure the fix is to hit the data 
cache on each page mapping. It looks overkill.

Wouldn't it be enough to let userspace do the cache cleaning? kvmtools 
knows which bits of the guest memory have been touched, and can do a "DC 
DVAC" on this region.

The alternative is do it in the kernel before running any vcpu - but 
that's not very nice either (have to clean the whole of the guest 
memory, which makes a full dcache clean more appealing).

         M.
-- 
Fast, cheap, reliable. Pick two.
