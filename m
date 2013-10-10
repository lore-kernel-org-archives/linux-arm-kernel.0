From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Oct 2013 10:02:05 +0100
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
In-Reply-To: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <20131010090205.GA3817@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 09:57:03PM +0100, Taras Kondratiuk wrote:
> In Thumb2 kernel (CONFIG_THUMB2_KERNEL) kexec's relocate code is assembled
> in Thumb2 mode, but cpu_v7_reset() jumps to this code in ARM state,
> because its address is page aligned and has 0 in LSB.

This used to work, but Dave broken it when he fixed the reset code in
153cd8e839b5 ("ARM: 7553/1: proc-v7: Ensure correct instruction set after
cpu_reset").

> Assemble this code in ARM mode to fix the issue.

In the interest of keeping kexec a possibility for v7m, it might be better
to do something similar to head.S (i.e. switch back to thumb if we're a
thumb-2 kernel).

Cheers,

Will

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
> 
