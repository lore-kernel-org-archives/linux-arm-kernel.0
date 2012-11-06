From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 6 Nov 2012 10:56:39 -0600
Subject: [PATCH v3 2/4] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <1351462748-5224-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121106165639.GF1254@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 11:19:06PM +0100, Thomas Petazzoni wrote:
> Register the irq controller driver in the main
> drivers/irqchip/irqchip.c file, and make sure that the initialization
> function of the driver sets handle_arch_irq() appropriately. This
> requires a bit of movement in the driver since the
> bcm2835_handle_irq() must move before the armctrl_of_init() function
> to avoid a forward declaration.
> 
> On the arch/arm side, use irqchip_init() as the ->init_irq() callback,
> and remove the definition of ->handle_irq() since this is now done by
> the irq controller driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> ---
[..]
> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> index dc670cc..62d1dad 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
[..]
> @@ -199,8 +197,8 @@ static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
>  	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
>  }
>  
> -asmlinkage void __exception_irq_entry bcm2835_handle_irq(
> -	struct pt_regs *regs)
> +static asmlinkage void __exception_irq_entry
> +bcm2835_handle_irq(struct pt_regs *regs)
>  {
>  	u32 stat, irq;
>  
> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> index 410f99f..e2496e4 100644
> --- a/drivers/irqchip/irqchip.c
> +++ b/drivers/irqchip/irqchip.c
> @@ -14,6 +14,12 @@
>  #include "irqchip.h"
>  
>  static const struct of_device_id irqchip_of_match[] __initconst = {
> +#ifdef CONFIG_ARCH_BCM2835
> +	{
> +		.compatible = "brcm,bcm2835-armctrl-ic",
> +		.data = bcm2835_irqchip_init,
> +	},
> +#endif
>  	{},
>  };
>  
> diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
> index 1e7a5c2..1075537 100644
> --- a/drivers/irqchip/irqchip.h
> +++ b/drivers/irqchip/irqchip.h
> @@ -11,4 +11,6 @@
>  #ifndef _IRQCHIP_H
>  #define _IRQCHIP_H
>  
> +int bcm2835_irqchip_init(struct device_node *node, struct device_node *parent);
> +
>  #endif

Could it make sense here to kill the irqchip.h private export, and
instead rely on the linker to stitch together the builtin irqchip's
of_device_id tables?

Something like:

drivers/irqchip/irq-bcm2835.c:

	static bcm2835_irqchip_init(struct device_node *node, struct device_node *parent)
	{
		/*...*/
	}

	static const struct of_device_id bcm2835_match[] __initconst = {
		{ .compatible = "brcm,bcm2835-armctrl-ic", .data = bcm2835_irqchip_init, },
		{},
	};
	DECLARE_IRQCHIP(bcm2835, bcm2835_match);

where include/linux/irqchip.h:

	#define DECLARE_IRQCHIP(name,ids) \
		static of_device_id * __irqchip_##name##_matches __used \
		__attribute__((__section__(".init.irqchip"))) = ids

drivers/irqchip/irqchip.c:

	void irqchip_init(void)
	{
		extern of_device_id *__irqchip_matches_start[], *__irqchip_matches_end[];
		struct of_device_id **matchesp;

		matchesp = __irqchip_matches_start;
		while (matchesp < __irqchip_matches_end)
			of_irq_init(*matchesp);
	}

And a suitable entry in vmlinux.lds.h.

(Hopefully?) This would eliminate the need for the 'private' irqchip.h
declarations and the centrally maintained of_device_id table, which
sounds like a win for maintainability.

Thoughts?

Thanks,
   Josh
