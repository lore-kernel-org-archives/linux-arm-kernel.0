From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Aug 2015 15:05:52 +0100
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
Message-ID: <20150825140552.GH21300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:31:56PM +0100, Russell King wrote:
> Provide a software-based implementation of the priviledged no access
> support found in ARMv8.1.
> 
> Userspace pages are mapped using a different domain number from the
> kernel and IO mappings.  If we switch the user domain to "no access"
> when we enter the kernel, we can prevent the kernel from touching
> userspace.
> 
> However, the kernel needs to be able to access userspace via the
> various user accessor functions.  With the wrapping in the previous
> patch, we can temporarily enable access when the kernel needs user
> access, and re-disable it afterwards.
> 
> This allows us to trap non-intended accesses to userspace, eg, caused
> by an inadvertent dereference of the LIST_POISON* values, which, with
> appropriate user mappings setup, can be made to succeed.  This in turn
> can allow use-after-free bugs to be further exploited than would
> otherwise be possible.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig               | 15 +++++++++++++++
>  arch/arm/include/asm/domain.h  | 15 ++++++++++++---
>  arch/arm/include/asm/uaccess.h | 14 ++++++++++++++
>  arch/arm/kernel/entry-header.S | 25 +++++++++++++++++++++++++
>  arch/arm/kernel/process.c      | 24 ++++++++++++++++++------
>  5 files changed, 84 insertions(+), 9 deletions(-)

[...]

> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 3aa6c3742182..bec7ee0764e1 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -54,15 +54,40 @@
>  	.endm
>  
>  	.macro	uaccess_disable, tmp
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +	/*
> +	 * Whenever we re-enter userspace, the domains should always be
> +	 * set appropriately.
> +	 */
> +	mov	\tmp, #DACR_UACCESS_DISABLE
> +	mcr	p15, 0, \tmp, c3, c0, 0		@ Set domain register
> +#endif

Missing ISB?

>  	.endm
>  
>  	.macro	uaccess_enable, tmp
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +	/*
> +	 * Whenever we re-enter userspace, the domains should always be
> +	 * set appropriately.
> +	 */
> +	mov	\tmp, #DACR_UACCESS_ENABLE
> +	mcr	p15, 0, \tmp, c3, c0, 0
> +#endif
>  	.endm
>  
>  	.macro	uaccess_save_and_disable, tmp
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +	mrc	p15, 0, \tmp, c3, c0, 0
> +	str	\tmp, [sp, #S_FRAME_SIZE]
> +#endif
> +	uaccess_disable \tmp
>  	.endm

Same here. For the enable/restore cases, the exception return will
synchronise the DACR for us, but I think we need the ISB to be sure that
the change has taken effect on the exception entry paths.

Will
