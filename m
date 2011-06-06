From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2011 14:51:05 +0100
Subject: [RFC PATCH V5 1/4] cpuidle: Move dev->last_residency update to
	driver enter routine, remove dev->last_state
In-Reply-To: <20110606133926.5670.4650.stgit@tringupt.in.ibm.com>
References: <20110606133917.5670.54949.stgit@tringupt.in.ibm.com>
	<20110606133926.5670.4650.stgit@tringupt.in.ibm.com>
Message-ID: <20110606135105.GA7023@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 07:09:26PM +0530, Trinabh Gupta wrote:
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 1cfeac1..4696a0d 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -41,10 +41,10 @@ static int at91_enter_idle(struct cpuidle_device *dev,
>  
>  	local_irq_disable();
>  	do_gettimeofday(&before);
> -	if (state == &dev->states[0])
> +	if (index == 0)
>  		/* Wait for interrupt state */
>  		cpu_do_idle();
> -	else if (state == &dev->states[1]) {
> +	else if (index == 1) {
>  		asm("b 1f; .align 5; 1:");
>  		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */

While looking through this patch, it is probably worth pointing out for
the AT91 folk that this is broken.  Here's an extract from the GCC manual:

|  Similarly, you can't expect a sequence of volatile `asm' instructions
| to remain perfectly consecutive.  If you want consecutive output, use a
| single `asm'.  Also, GCC will perform some optimizations across a
| volatile `asm' instruction; GCC does not "forget everything" when it
| encounters a volatile `asm' instruction the way some other compilers do.

It might be a good idea to fix those two asm() statements into one.
