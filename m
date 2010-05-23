From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 May 2010 13:38:01 +0100
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20100523123801.GC950@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 23, 2010 at 07:48:48PM +0800, tom.leiming at gmail.com wrote:
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 2c1db77..ed471a7 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -58,7 +58,7 @@ work_resched:
>   */
>  ENTRY(ret_to_user)
>  ret_slow_syscall:
> -	disable_irq				@ disable interrupts
> +	disable_irq_notrace				@ disable interrupts

I think this one does need to be traced - the pending work functions are
all C code which could call back into lockdep.

Also, I'm nervious about applying this patch without seeing more people
test it.
