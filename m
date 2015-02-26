From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Feb 2015 11:41:00 +0100
Subject: [PATCH 1/8] irqchip: armada-370-xp: Simplify interrupt map, mask
 and unmask
In-Reply-To: <1424945593-20320-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424945593-20320-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54EEF83C.40003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 26/02/2015 11:13, Maxime Ripard wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> The map, mask and unmask is unnecessarily complicated, with a different
> implementation for shared and per CPU interrupts. The current code does
> the following:
> 
> At probe time, all interrupts are disabled and masked on all CPUs.
> 
> Shared interrupts:
> 
>  * When the interrupt is mapped(), it gets disabled and unmasked on the
>    calling CPU.
> 
>  * When the interrupt is unmasked(), masked(), it gets enabled and
>    disabled.
> 
> Per CPU interrupts:
> 
>  * When the interrupt is mapped, it gets masked on the calling CPU and
>    enabled.
> 
>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>    on the calling CPU.
> 
> This commit simplifies this code, with a much simpler implementation, common
> to shared and per CPU interrupts.
> 
>  * When the interrupt is mapped, it's enabled.
> 
>  * When the interrupt is unmasked(), masked(), it gets unmasked and masked,
>    on the calling CPU.
> 
> Tested on a Armada XP SoC with SMP and UP configurations, with chained and
> regular interrupts.

This patch doesn't only simplify the driver it changes also its
behavior and especially for the affinity.

If a driver call irq_enable() then this functions will call
irq_enable() and as we didn't implement a .enable() operation, it will
call only our unmask() function.

So if the IRQ was unmasked on a CPU and a driver call an irq_enable()
from an other CPU then we will end up with the IRQ enabled on 2
different CPUs. It is a problem for 2 reasons:
- the hardware don't handle a IRQ enable on more than one CPU
- it will modify the affinity at the hardware level because a new CPU
  will be able to receive an IRQ whereas we setup the affinity on only
  one CPU.

By only using the mask and unmask the affinity behavior is no more
reliable. I agree that the current code is not trivial, but adding
more comment instead of removing this capability should be better.


Thanks,

Gregory

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 137ee37a33ed..1caa8b579fdd 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -77,33 +77,18 @@ static DEFINE_MUTEX(msi_used_lock);
>  static phys_addr_t msi_doorbell_addr;
>  #endif
>  
> -/*
> - * In SMP mode:
> - * For shared global interrupts, mask/unmask global enable bit
> - * For CPU interrupts, mask/unmask the calling CPU's bit
> - */
>  static void armada_370_xp_irq_mask(struct irq_data *d)
>  {
>  	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  
> -	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> -		writel(hwirq, main_int_base +
> -				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
> -	else
> -		writel(hwirq, per_cpu_int_base +
> -				ARMADA_370_XP_INT_SET_MASK_OFFS);
> +	writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
>  }
>  
>  static void armada_370_xp_irq_unmask(struct irq_data *d)
>  {
>  	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  
> -	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> -		writel(hwirq, main_int_base +
> -				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
> -	else
> -		writel(hwirq, per_cpu_int_base +
> -				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> +	writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>  }
>  
>  #ifdef CONFIG_PCI_MSI
> @@ -286,12 +271,8 @@ static struct irq_chip armada_370_xp_irq_chip = {
>  static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>  				      unsigned int virq, irq_hw_number_t hw)
>  {
> -	armada_370_xp_irq_mask(irq_get_irq_data(virq));
> -	if (hw != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> -		writel(hw, per_cpu_int_base +
> -			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> -	else
> -		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
> +	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
> +
>  	irq_set_status_flags(virq, IRQ_LEVEL);
>  
>  	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
