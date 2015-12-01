From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 20:35:51 +0100
Subject: [PATCH 1/1] irqchip/versatile-fpga: Fix PCI IRQ mapping on
 Versatile PB
In-Reply-To: <1448992551-10275-1-git-send-email-guillaume.delbergue@greensocs.com>
References: <1448992551-10275-1-git-send-email-guillaume.delbergue@greensocs.com>
Message-ID: <2937087.lLiS9fjU9h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 18:55:51 Guillaume Delbergue wrote:
> This patch is specifically for PCI support on the Versatile PB board using
> a DT. Currently, the dynamic IRQ mapping is broken when using DTs. For
> example, on QEMU, the SCSI driver is unable to request the IRQ. To fix
> this issue, this patch replaces the current dynamic mechanism with a
> static value as is done in the non-DT case.
> 
> Signed-off-by: Guillaume Delbergue <guillaume.delbergue@greensocs.com>
> ---

Looks good to me. If there are no objections, I'd mark this as
'Cc: stable at vger.kernel.org' and put it into the fixes branch for 4.4.

	Arnd

>  drivers/irqchip/irq-versatile-fpga.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
> index 598ab3f..cadf104 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -210,7 +210,12 @@ int __init fpga_irq_of_init(struct device_node *node,
>  		parent_irq = -1;
>  	}
>  
> +#ifdef CONFIG_ARCH_VERSATILE
> +	fpga_irq_init(base, node->name, IRQ_SIC_START, parent_irq, valid_mask,
> +				  node);
> +#else
>  	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
> +#endif
>  
>  	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
>  	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
> 
