From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2017 15:03:22 +0000
Subject: [PATCH v4 3/4] arm64: Use __tlbi() macros in KVM code
In-Reply-To: <20170125155232.10277-3-cov@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-3-cov@codeaurora.org>
Message-ID: <20170127150321.GM21144@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:52:31AM -0500, Christopher Covington wrote:
> Refactor the KVM code to use the __tlbi macros, which will allow an errata
> workaround that repeats tlbi dsb sequences to only change one location.
> This is not intended to change the generated assembly and comparing before
> and after vmlinux objdump shows no functional changes.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/kvm/hyp/tlb.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

[...]

> @@ -82,7 +83,7 @@ void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
>  void __hyp_text __kvm_flush_vm_context(void)
>  {
>  	dsb(ishst);
> -	asm volatile("tlbi alle1is	\n"
> -		     "ic ialluis	  ": : );
> +	__tlbi(alle1is);
> +	asm volatile("ic ialluis" : : );
>  	dsb(ish);

Should be a separate patch, but this can now be a __flush_icache_all instead
of the open-coded asm.

Will
