From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 23:37:44 +0000
Subject: [PATCH v4 1/2] ARM: avoid tracers in soft_restart
In-Reply-To: <1393441857-15472-2-git-send-email-sebastian.capella@linaro.org>
References: <1393441857-15472-1-git-send-email-sebastian.capella@linaro.org>
 <1393441857-15472-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140226233744.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 11:10:56AM -0800, Sebastian Capella wrote:
> Use of tracers in local_irq_disable is causes recursive aborts when
> called with irqs disabled and using a temporary stack (hibernation).
> Replace local_irq_disable with raw_local_irq_disable instead to
> avoid tracers.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Holt <robin.m.holt@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/kernel/process.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 92f7b15..f58b723 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -100,7 +100,7 @@ void soft_restart(unsigned long addr)
>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>  
>  	/* Disable interrupts first */
> -	local_irq_disable();
> +	raw_local_irq_disable();
>  	local_fiq_disable();

Great, I'm happy with this now.  I assume that the plan is to submit this
to my patch system when everyone's given their fill of acks?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
