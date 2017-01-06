From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Jan 2017 16:05:15 +0000
Subject: [PATCH v2 4/5] arm64: Use __tlbi_dsb() macros in KVM code
In-Reply-To: <f5020a04-5fc7-26b5-1ded-c58e159bc722@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-4-cov@codeaurora.org>
 <20170103155756.GB14183@leverpostej>
 <f5020a04-5fc7-26b5-1ded-c58e159bc722@codeaurora.org>
Message-ID: <20170106160515.GB17642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 10:51:53AM -0500, Christopher Covington wrote:
> On 01/03/2017 10:57 AM, Mark Rutland wrote:
> > On Thu, Dec 29, 2016 at 05:43:34PM -0500, Christopher Covington wrote:
> >> Refactor the KVM code to use the newly introduced __tlbi_dsb macros, which
> >> will allow an errata workaround that repeats tlbi dsb sequences to only
> >> change one location. This is not intended to change the generated assembly
> >> and comparing before and after vmlinux objdump shows no functional changes.
> 
> @@ -32,7 +33,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  	 * whole of Stage-1. Weep...
>  	 */
>  	ipa >>= 12;
> -	asm volatile("tlbi ipas2e1is, %0" : : "r" (ipa));
> +	__tlbi_dsb(ipas2e1is, ish, ipa);
>  
>  	/*
>  	 * We have to ensure completion of the invalidation at Stage-2,
> 
> >> @@ -40,9 +41,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
> >>  	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
> >>  	 * the Stage-1 invalidation happened first.
> >>  	 */
> >> -	dsb(ish);
> > 
> > Looks like this got accidentally removed. AFAICT it is still necessary.
> 
> Not removed, just hoisted above the comment block to the previous patch hunk.

Ah, sorry. I hadn't spotted that it got folded into the __tlbi_dsb()
above.

Given the comment was previously attached to the DSB, it might make more
sense to fold it into the prior comment block, so that it remains
attached to the __tlbi_dsb(), which guarantees the completion that the
comment describes.

Thanks,
Mark.
