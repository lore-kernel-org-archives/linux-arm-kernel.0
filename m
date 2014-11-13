From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Nov 2014 20:23:39 +0000
Subject: [Patch V1 3/6] genirq: Introduce msi_domain_{alloc|free}_irqs()
In-Reply-To: <1415879029-20098-4-git-send-email-jiang.liu@linux.intel.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <1415879029-20098-4-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <5465134B.7070709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 11:43, Jiang Liu wrote:
> Introduce msi_domain_{alloc|free}_irqs() to alloc/free interrupts
> from generic MSI irqdomain.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  include/linux/msi.h |   35 ++++++++++++++++++++++++++++++
>  kernel/irq/msi.c    |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 714716a3ffdd..6b356a1410b2 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -3,6 +3,7 @@
>  
>  #include <linux/kobject.h>
>  #include <linux/list.h>
> +#include <asm/hw_irq.h>		/* for msi_alloc_info_t */
>  
>  struct msi_msg {
>  	u32	address_lo;	/* low 32 bits of msi message address */
> @@ -100,7 +101,26 @@ struct irq_chip;
>  struct device_node;
>  struct msi_domain_info;
>  
> +#ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
> +#define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
> +#endif
> +
> +/*
> + * Default structure for MSI interrupt allocation.
> + * Arch may overwrite it by define msi_alloc_info_t.
> + */
> +struct msi_alloc_info {
> +	struct msi_desc *desc;
> +	irq_hw_number_t hwirq;
> +	long		scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];

As much as I'm relieved to see a generic structure here, could
scratchpad be slightly less awkward to use? Something like:

struct msi_alloc_info {
	[...]
	union	{
		unsigned long ul;
		void *ptr;
	} scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
};

That would avoid some very ugly casting.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
