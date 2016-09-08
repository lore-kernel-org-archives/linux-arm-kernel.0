From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Sep 2016 13:16:48 +0200
Subject: [PATCH 3/3] arm64/kvm: use alternative auto-nop
In-Reply-To: <1473242830-26246-4-git-send-email-mark.rutland@arm.com>
References: <1473242830-26246-1-git-send-email-mark.rutland@arm.com>
 <1473242830-26246-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20160908111648.GZ23592@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 11:07:10AM +0100, Mark Rutland wrote:
> Make use of the new alternative_if and alternative_else_nop_endif and
> get rid of our homebew NOP sleds, making the code simpler to read.

homebew?

> 
> Note that for __kvm_call_hyp the branch to __vhe_hyp_call has been moved
> out of the alternative sequence, and in the default case there will be
> four additional NOPs executed.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: kvmarm at lists.cs.columbia.edu

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm64/include/asm/kvm_mmu.h | 10 +++-------
>  arch/arm64/kvm/hyp.S             |  6 +-----
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index b6bb834..dff1098 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -99,14 +99,10 @@
>  .macro kern_hyp_va	reg
>  alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
>  	and     \reg, \reg, #HYP_PAGE_OFFSET_HIGH_MASK
> -alternative_else
> -	nop
> -alternative_endif
> -alternative_if_not ARM64_HYP_OFFSET_LOW
> -	nop
> -alternative_else
> +alternative_else_nop_endif
> +alternative_if ARM64_HYP_OFFSET_LOW
>  	and     \reg, \reg, #HYP_PAGE_OFFSET_LOW_MASK
> -alternative_endif
> +alternative_else_nop_endif
>  .endm
>  
>  #else
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 7ce9315..2726635 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -46,10 +46,6 @@ alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
>  	hvc	#0
>  	ldr     lr, [sp], #16
>  	ret
> -alternative_else
> +alternative_else_nop_endif
>  	b	__vhe_hyp_call
> -	nop
> -	nop
> -	nop
> -alternative_endif
>  ENDPROC(__kvm_call_hyp)
> -- 
> 1.9.1
> 
