From: ji.zhang@mediatek.com (Ji.Zhang)
Date: Wed, 25 Oct 2017 17:17:30 +0800
Subject: [PATCH] arm: fix text section corruption
In-Reply-To: <1506050119-2670-1-git-send-email-ji.zhang@mediatek.com>
References: <1506050119-2670-1-git-send-email-ji.zhang@mediatek.com>
Message-ID: <1508923050.26492.1.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All sirs,

Is there any suggestion for this patch?

Since we have found that this issue can be reproduced with high repeat
ratio by some fuzzer tests, we strongly suggest it can be fixed in next
kernel version.

Thanks a lot.

Ji

On Fri, 2017-09-22 at 11:15 +0800, Ji Zhang wrote:
> When CONFIG_CPU_SW_DOMAIN_PAN is enabled, there are 9 registers being
> pushed into stack in save_regs, but in fixup it still consider there are
> 8 registers in stack, which is the case of CONFIG_CPU_SW_DOMAIN_PAN
> disabled.
> When fixup being executed, -EFAULT will be written to the text section.
> 
> In fixup:
> mov	r4, #-EFAULT
> /*
>  * When CONFIG_CPU_SW_DOMAIN_PAN enabled, r5 will load the value stored by
>  * lr in save_regs, which is the address of instruction in text section.
>  */
> ldr	r5, [sp,#8*4]	@err_ptr
> /*
>  * This will write -EFAULT(0xfffffff2) to r5, which points to text section
>  * now, and when function returns, it will use 0xfffffff2 as an
>  * instruction, then undefined instruction occurs.
>  */
> str	r4, [r5]
> 
> Signed-off-by: Ji Zhang <ji.zhang@mediatek.com>
> ---
>  arch/arm/lib/csumpartialcopyuser.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
> index 1712f13..b83fdc0 100644
> --- a/arch/arm/lib/csumpartialcopyuser.S
> +++ b/arch/arm/lib/csumpartialcopyuser.S
> @@ -85,7 +85,11 @@
>  		.pushsection .text.fixup,"ax"
>  		.align	4
>  9001:		mov	r4, #-EFAULT
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +		ldr	r5, [sp, #9*4]		@ *err_ptr
> +#else
>  		ldr	r5, [sp, #8*4]		@ *err_ptr
> +#endif
>  		str	r4, [r5]
>  		ldmia	sp, {r1, r2}		@ retrieve dst, len
>  		add	r2, r2, r1
