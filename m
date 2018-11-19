From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 19 Nov 2018 11:37:57 +0000
Subject: [RFC PATCH] ARM: NOMMU: Toggle only bits in EXC_RETURN we are
 really care of
In-Reply-To: <1541591310-31799-1-git-send-email-vladimir.murzin@arm.com>
References: <1541591310-31799-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <a4be606f-bc3c-4b5c-84e6-dfdfc8ab5d0a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping!

On 07/11/18 11:48, Vladimir Murzin wrote:
> ARMv8M introduces support for Security extension to M class, among
> other things it affects exception handling, especially, encoding of
> EXC_RETURN.
> 
> The new bits have been added:
> 
> Bit [6]	Secure or Non-secure stack
> Bit [5]	Default callee register stacking
> Bit [0]	Exception Secure
> 
> which conflicts with hard-coded value of EXC_RETURN:
> 
> In fact, we only care of few bits:
> 
> Bit [3]	 Mode (0 - Handler, 1 - Thread)
> Bit [2]	 Stack pointer selection (0 - Main, 1 - Process)
> 
> We can toggle only those bits and left other bits as they were on
> exception entry.
> 
> It is basically, what patch does - saves EXC_RETURN when we do
> transition form Thread to Handler mode (it is first svc), so later
> saved value is used instead of EXC_RET_THREADMODE_PROCESSSTACK.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
> 
> Kernel Version: v4.20-rc1
> 
>  arch/arm/include/asm/v7m.h     | 2 +-
>  arch/arm/kernel/entry-header.S | 3 ++-
>  arch/arm/kernel/entry-v7m.S    | 4 ++++
>  arch/arm/mm/proc-v7m.S         | 3 +++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
> index 187ccf6..2cb00d1 100644
> --- a/arch/arm/include/asm/v7m.h
> +++ b/arch/arm/include/asm/v7m.h
> @@ -49,7 +49,7 @@
>   * (0 -> msp; 1 -> psp). Bits [1:0] are fixed to 0b01.
>   */
>  #define EXC_RET_STACK_MASK			0x00000004
> -#define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
> +#define EXC_RET_THREADMODE_PROCESSSTACK		(3 << 2)
>  
>  /* Cache related definitions */
>  
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 7734248..62db1c9 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -127,7 +127,8 @@
>           */
>  	.macro	v7m_exception_slow_exit ret_r0
>  	cpsid	i
> -	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
> +	ldr	lr, =exc_ret
> +	ldr	lr, [lr]
>  
>  	@ read original r12, sp, lr, pc and xPSR
>  	add	r12, sp, #S_IP
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index abcf478..19d2dcd 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -146,3 +146,7 @@ ENTRY(vector_table)
>  	.rept	CONFIG_CPU_V7M_NUM_IRQ
>  	.long	__irq_entry		@ External Interrupts
>  	.endr
> +	.align	2
> +	.globl	exc_ret
> +exc_ret:
> +	.space	4
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 47a5acc..92e8418 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -139,6 +139,9 @@ __v7m_setup_cont:
>  	cpsie	i
>  	svc	#0
>  1:	cpsid	i
> +	ldr	r0, =exc_ret
> +	orr	lr, lr, #EXC_RET_THREADMODE_PROCESSSTACK
> +	str	lr, [r0]
>  	ldmia	sp, {r0-r3, r12}
>  	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
>  	mov	lr, r6			@ restore LR
> 
