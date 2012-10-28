From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 27 Oct 2012 20:23:11 -0600
Subject: [PATCH 2/3] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <1351356317-16758-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351356317-16758-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508C970F.9000305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 10:45 AM, Thomas Petazzoni wrote:
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

> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c

> +static void armctrl_handle_bank(int bank, struct pt_regs *regs)

To make the patch more readable, I'd suggest adding function prototypes
at the start of the file, and not re-arranging the code. That'll remove
the large cut/paste block in the diff. I wouldn't point out this trivial
issue except that I think this needs a respin for the minor issue I
raise below.

> -static int __init armctrl_of_init(struct device_node *node,
> -	struct device_node *parent)
> +int __init armctrl_of_init(struct device_node *node,
> +			   struct device_node *parent)

Since this is now a public API, it should probably be named better. How
about bcm2835_irqchip_init()?

Aside from that,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I don't foresee any likely conflicts with anything I'll stage for 3.8 in
the bcm2835 tree, so feel free to take this through the irq tree or
directly into arm-soc as appropriate.
