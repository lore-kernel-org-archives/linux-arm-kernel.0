From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 13:25:02 -0700
Subject: [PATCH] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140709161704.9623.92358.stgit@joelaarch64.amd.com>
References: <20140709161704.9623.92358.stgit@joelaarch64.amd.com>
Message-ID: <20140710202502.GA20394@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 11:17:04AM -0500, Joel Schopp wrote:
> The current calculation for VTTBR_BADDR_MASK masks only 39 bits and not
> all 40 bits.  That last bit is important as some systems allocate
> from near the top of the available address space.
> 
> This patch is necessary to run KVM on an aarch64 SOC I have been testing.
> 
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 3d69030..b39e93f 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -148,7 +148,7 @@
>  #endif
>  
>  #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
> +#define VTTBR_BADDR_MASK  (0xffffffffffLLU)              /* bits 0-39 */
>  #define VTTBR_VMID_SHIFT  (48LLU)
>  #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
>  
> 

While this is obviously fixing a bug, it doesn't feel like the right
short-term fix.  I'll have to go back and read the definitions of x in
BADDR[47:x] for VTTBR_EL2 exactly again, but the intended use of
VTTBR_BADDR_MASK (and the only occurence of it in C-code) is to deal
with alignment of the allocated pgd.

So while all the MSB in the physical address range of your system should
be used, we still need to check that the pgd we allocate is actually
aligned properly, because writing any bits in [x-1:0} as non-zero can
potentially cause unpredicted behavior and the translation walk results
can be corrupted.

So, you do need to use a proper shift, I'm fine with fixing it for the
assumed 40-bit physical address space for now, but you need to figure
out the right value of 'x', for the BADDR[47:x], and you should change
the code in update_vttbr() as part of this patch, something like
BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK) and make sure the pgd is allocated
at the right alignment, or ensure that the PGD is large enough that we
can just mask off the lower bits and still contain the required number
of entries.

Thanks,
-Christoffer
