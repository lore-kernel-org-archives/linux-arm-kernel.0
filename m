From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 15:57:56 +0000
Subject: [PATCH v2 4/5] arm64: Use __tlbi_dsb() macros in KVM code
In-Reply-To: <20161229224335.13531-4-cov@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-4-cov@codeaurora.org>
Message-ID: <20170103155756.GB14183@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 05:43:34PM -0500, Christopher Covington wrote:
> Refactor the KVM code to use the newly introduced __tlbi_dsb macros, which
> will allow an errata workaround that repeats tlbi dsb sequences to only
> change one location. This is not intended to change the generated assembly
> and comparing before and after vmlinux objdump shows no functional changes.

> @@ -40,9 +41,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
>  	 * the Stage-1 invalidation happened first.
>  	 */
> -	dsb(ish);

Looks like this got accidentally removed. AFAICT it is still necessary.

> -	asm volatile("tlbi vmalle1is" : : );
> -	dsb(ish);
> +	__tlbi_dsb(vmalle1is, ish);
>  	isb();

Thanks,
Mark.
