From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 19:34:27 +0100
Subject: [PATCH v2 2/7] irqchip: armada-370-xp: Introduce a is_percpu_irq()
 helper for readability
In-Reply-To: <1425379400-4346-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425379400-4346-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F5FEB3.9040308@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:43, Maxime Ripard wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> This commit introduces a helper function is_percpu_irq(), to be used
> when interrupts are mapped to decide which ones are set as per CPU.
> 
> This change will allow to extend the list of per cpu interrupts in a less
> intrusive fashion; also, it makes the code slightly more readable by keeping
> a list of the per CPU interrupts.

Eventually the is_percpu_irq will be only
irq < ARMADA_370_XP_MAX_PER_CPU_IRQS

using just a couple of the PER_CPU_IRQ was bogus, but it is not something
new. At least this patch improves the readability so:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index b455c876974e..ea57fba263cf 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -77,6 +77,16 @@ static DEFINE_MUTEX(msi_used_lock);
>  static phys_addr_t msi_doorbell_addr;
>  #endif
>  
> +static inline bool is_percpu_irq(irq_hw_number_t irq)
> +{
> +	switch (irq) {
> +	case ARMADA_370_XP_TIMER0_PER_CPU_IRQ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * In SMP mode:
>   * For shared global interrupts, mask/unmask global enable bit
> @@ -86,7 +96,7 @@ static void armada_370_xp_irq_mask(struct irq_data *d)
>  {
>  	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  
> -	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +	if (!is_percpu_irq(hwirq))
>  		writel(hwirq, main_int_base +
>  				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
>  	else
> @@ -98,7 +108,7 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
>  {
>  	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>  
> -	if (hwirq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +	if (!is_percpu_irq(hwirq))
>  		writel(hwirq, main_int_base +
>  				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
>  	else
> @@ -287,14 +297,14 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>  				      unsigned int virq, irq_hw_number_t hw)
>  {
>  	armada_370_xp_irq_mask(irq_get_irq_data(virq));
> -	if (hw != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +	if (!is_percpu_irq(hw))
>  		writel(hw, per_cpu_int_base +
>  			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>  	else
>  		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
>  	irq_set_status_flags(virq, IRQ_LEVEL);
>  
> -	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> +	if (is_percpu_irq(hw)) {
>  		irq_set_percpu_devid(virq);
>  		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>  					handle_percpu_devid_irq);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
