From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 14:58:13 +0100
Subject: [PATCH 3/7] irqchip: armada-370-xp: Introduce a is_percpu_irq()
 helper for readability
In-Reply-To: <1413985427-20918-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022135813.GK22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 22, 2014 at 02:43:43PM +0100, Ezequiel Garcia wrote:
> This commit introduces a helper function is_percpu_irq(), to be used
> when interrupts are mapped to decide which ones are set as per CPU.
> 
> This change will allow to extend the list of per cpu interrupts in a less
> intrusive fashion; also, it makes the code slightly more readable by keeping
> a list of the per CPU interrupts.

I believe you can use the existing (and similarly named) irq_is_percpu
for this.

Thanks,
Mark.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index de5eb26..3871c688 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -73,6 +73,16 @@ static DEFINE_MUTEX(msi_used_lock);
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
>  static void armada_370_xp_irq_mask(struct irq_data *d)
>  {
>  	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> @@ -271,7 +281,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>  
>  	irq_set_status_flags(virq, IRQ_LEVEL);
>  
> -	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> +	if (is_percpu_irq(hw)) {
>  		irq_set_percpu_devid(virq);
>  		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>  					handle_percpu_devid_irq);
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
