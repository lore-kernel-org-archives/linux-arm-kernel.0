From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 10 Oct 2013 15:12:45 +0100
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
In-Reply-To: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <20131010141238.GA4081@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 11:57:03PM +0300, Taras Kondratiuk wrote:
> In Thumb2 kernel (CONFIG_THUMB2_KERNEL) kexec's relocate code is assembled
> in Thumb2 mode, but cpu_v7_reset() jumps to this code in ARM state,
> because its address is page aligned and has 0 in LSB.
> 
> Assemble this code in ARM mode to fix the issue.

I think the actual issue here is that relocate_new_kernel is not properly
annotated as a function symbol.

Can you remove the explicit label declaration and try the following:

	#include <linux/linkage.h>

	ENTRY(relocate_new_kernel)

	/* body of relocate_new_kernel */

	ENDPROC(relocate_new_kernel)


Without this, the linker will treat it as a random pointer to data and
never set the Thumb bit.

This fails in precisely the same was as an ordinary function call
would fail if the destination function doesn't have the needed
annotation.


There should be no need to switch to ARM if the kernel is just jumping
to itself...

Cheers
---Dave

> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
> Based on v3.12-rc4
> 
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linaro-kernel at lists.linaro.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/kernel/relocate_kernel.S |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
> index d0cdedf..a3af323 100644
> --- a/arch/arm/kernel/relocate_kernel.S
> +++ b/arch/arm/kernel/relocate_kernel.S
> @@ -5,6 +5,7 @@
>  #include <asm/kexec.h>
>  
>  	.globl relocate_new_kernel
> +	.arm
>  relocate_new_kernel:
>  
>  	ldr	r0,kexec_indirection_page
> -- 
> 1.7.9.5
> 
