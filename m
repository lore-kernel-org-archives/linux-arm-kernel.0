From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Oct 2014 11:26:42 +0100
Subject: [PATCH 1/7] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <490268c9dba3b6d3f5a52c7c1b0dd81686aac6f7.1411604443.git.geoff@infradead.org>
References: <cover.1411604443.git.geoff@infradead.org>
 <490268c9dba3b6d3f5a52c7c1b0dd81686aac6f7.1411604443.git.geoff@infradead.org>
Message-ID: <20141003102641.GA26643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 01:23:26AM +0100, Geoff Levand wrote:
> Some of the macros defined in kvm_arm.h are useful in the exception vector
> routines, but they are not compatible with the assembler.  Change the
> definition of ESR_EL2_ISS to be compatible.
> 
> Fixes build errors like these when using kvm_arm.h in assembly
> source files:
> 
>   Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/kvm_arm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index cc83520..fb42ab5 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -175,7 +175,7 @@
>  /* Exception Syndrome Register (ESR) bits */
>  #define ESR_EL2_EC_SHIFT	(26)
>  #define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
> -#define ESR_EL2_IL		(1U << 25)
> +#define ESR_EL2_IL		(UL(1) << 25)

This looks fine for ESR_EL2_IL (and hence ESR_EL2_ISS)...

>  #define ESR_EL2_ISS		(ESR_EL2_IL - 1)
>  #define ESR_EL2_ISV_SHIFT	(24)
>  #define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)

... but it seems there are a few more instances that could blow up if
used in asm.

Would you be able to fix those up at the same time? It doesn't look like there
are too many, and it should be a fairly mechanical change:

[mark@leverpostej:~/src/linux]% grep '[0-9][UL]' -- arch/arm64/include/asm/kvm_arm.h    
#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
#define VTTBR_VMID_SHIFT  (48LLU)
#define ESR_EL2_IL              (1U << 25)
#define ESR_EL2_ISV             (1U << ESR_EL2_ISV_SHIFT)
#define ESR_EL2_SAS             (3U << ESR_EL2_SAS_SHIFT)
#define ESR_EL2_CV              (1U << ESR_EL2_CV_SHIFT)

Cheers,
Mark.
