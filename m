From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Jul 2015 11:43:02 +0100
Subject: [PATCH 3/4] irqchip, gicv3: Implement Cavium ThunderX erratum
 23154
In-Reply-To: <1435673643-31676-4-git-send-email-rric@kernel.org>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-4-git-send-email-rric@kernel.org>
Message-ID: <559A5BB6.2040509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 30/06/15 15:14, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch implements Cavium ThunderX erratum 23154.
> 
> The gicv3 of ThunderX requires a modified version for reading the IAR
> status to ensure data synchronization. Since this is in the fast-path
> and called with each interrupt, runtime patching is used using jump
> label patching for smallest overhead (no-op). This is the same
> technique as used for tracepoints.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f4bafc69cc18..57bb69686ec6 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -107,14 +107,38 @@ static void gic_redist_wait_for_rwp(void)
>  }
>  
>  /* Low level accessors */
> -static u64 __maybe_unused gic_read_iar(void)
> +static u64 gic_read_iar_common(void)
> +{
> +	u64 irqstat;
> +
> +	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> +	return irqstat;
> +}
> +
> +/* Cavium ThunderX erratum 23154 */
> +static u64 gic_read_iar_cavium_thunderx(void)
>  {
>  	u64 irqstat;
>  
> +	asm volatile("nop;nop;nop;nop;");
> +	asm volatile("nop;nop;nop;nop;");
>  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> +	asm volatile("nop;nop;nop;nop;");
> +	mb();
> +
>  	return irqstat;
>  }
>  
> +struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;
> +
> +static u64 __maybe_unused gic_read_iar(void)
> +{
> +	if (static_key_false(&is_cavium_thunderx))
> +		return gic_read_iar_common();
> +	else
> +		return gic_read_iar_cavium_thunderx();
> +}
> +
>  static void __maybe_unused gic_write_pmr(u64 val)
>  {
>  	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
> @@ -765,8 +789,19 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.free = gic_irq_domain_free,
>  };
>  
> +static void gicv3_enable_cavium_thunderx(void *data)
> +{
> +	static_key_slow_inc(&is_cavium_thunderx);
> +}
> +
>  static const struct gic_capabilities gicv3_errata[] = {
>  	{
> +		.desc	= "GIC: Cavium erratum 23154",
> +		.id	= 0xa100034c,	/* ThunderX pass 1.x */
> +		.mask	= 0xffff0fff,
> +		.init	= gicv3_enable_cavium_thunderx,
> +	},
> +	{
>  	}
>  };
>  
> 

How does this work when running a guest? Does the virtualized access
suffer from the same erratum? If that's the case, we need a better
workaround...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
