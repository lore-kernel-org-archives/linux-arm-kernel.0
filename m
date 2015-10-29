From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Oct 2015 19:41:27 +0100
Subject: [PATCH] ARM: v7-M: Fix the stack set by __v7m_setup
In-Reply-To: <1446139880-17311-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1446139880-17311-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <20151029184127.GG4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 29, 2015 at 02:31:20PM -0300, Ezequiel Garcia wrote:
> On ARM v7-M, when PROCINFO_INITFUNC (__v7m_setup) is called,
> a stack is needed before calling the supervisor call (SVC),
> which is used by the supervisor call to save the context.
> 
> Currently, __v7m_setup() prepares a temporary stack in the .text.init
> section, which is is broken if the kernel is executing directly from
> read-only memory.
> 
> This commit fixes this by seting an early stack to its usual location.
> 
> Also, __v7m_setup() is currently saving and restoring the previous
> stack. That was bogus, because there's no stack previously set,
> so this commit removes it.

Maybe add something like:

	This fixes booting on my $somedetails machine which throws an
	exception when a write to ROM is done.

> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
> As suggested by Uwe, this commit tries to set a proper stack
> before calling the SVC in __v7m_setup.
> 
> Instead of putting that in a .data section, I'm just using
> the usual stack location.
> 
> The stack will be reset to the same place in __mmap_switched.
> This means the stack is set twice in the v7-M case, but
> for simplicity I figure we can just leave this that way.

That's ok I think, yes.

>  arch/arm/mm/proc-v7m.S | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 67d9209077c6..f42d4e2774c7 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -12,6 +12,7 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> +#include <asm/memory.h>
>  #include <asm/v7m.h>
>  #include "proc-macros.S"
>  
> @@ -97,19 +98,19 @@ __v7m_setup:
>  	mov	r5, #0x00800000
>  	str	r5, [r0, V7M_SCB_SHPR3]	@ set PendSV priority
>  
> -	@ SVC to run the kernel in this mode
> +	@ SVC to run the kernel in this mode,
Do you consider this understandable? What is "this"? I suggest to change
it to

	@ SVC to switch to handler mode, notice that this requires sp to
	@ point to writeable memory because the processor saves
	@ some registers to the stack.

> +	@ notice that we need to set a stack for SVC to save
> +	@ the context.

Other than that:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
