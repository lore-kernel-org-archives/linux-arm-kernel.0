From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 09:41:22 -0400
Subject: [PATCH v2 2/4] irqchip: add LPC32xx interrupt controller driver
In-Reply-To: <1461546038-25668-1-git-send-email-vz@mleia.com>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
 <1461546038-25668-1-git-send-email-vz@mleia.com>
Message-ID: <1461678082.9433.3.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Mon, 2016-04-25 at 04:00 +0300, Vladimir Zapolskiy wrote:
> The change adds improved support of NXP LPC32xx MIC, SIC1 and SIC2
> interrupt controllers.
> 
> This is a list of new features in comparison to the legacy driver:
> * irq types are taken from device tree settings, no more need to
>   hardcode them,
> * old driver is based on irq_domain_add_legacy, which causes problems
>   with handling MIC hardware interrupt 0 produced by SIC1,
> * there is one driver for MIC, SIC1 and SIC2, no more need to handle
>   them separately, e.g. have two separate handlers for SIC1 and SIC2,
> * the driver does not have any dependencies on hardcoded register
>   offsets,
> * the driver is much simpler for maintenance,
> * SPARSE_IRQS option is supported.
> 
> Legacy LPC32xx interrupt controller driver was broken since commit
> 76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler"), which
> requires a private interrupt handler, otherwise any SIC1 generated
> interrupt (mapped to MIC hwirq 0) breaks the kernel with the message
> "unexpected IRQ trap at vector 00".
> 
> The change disables compilation of a legacy driver found at
> arch/arm/mach-lpc32xx/irq.c, the file will be removed in a separate
> commit.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from v1 to v2:
> * added chained_irq_{enter,exit} for SIC chained handler,
> * use {writel,readl}_relaxed flavour of io access functions,
> * changed anchor data type to access iomem from struct irq_domain
>   to private struct lpc32xx_irq_chip,
> * do not read irq status register twice on every irq event,
> * resource deallocation fixes on error path of irqchip driver init,
> * removed handling of "interrupt-controller-name" property, name
>   is constructed from mic/sic type and controller's physical address,
> * minor improvements (renames, __ffs instead of ffs, etc.)
> 
> Many kudos to Marc for review of v1.
> 
>  arch/arm/Kconfig                |   2 +
>  arch/arm/mach-lpc32xx/phy3250.c |   1 -
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-lpc32xx.c   | 238 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 241 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-lpc32xx.c
> 
I tested the driver on a custom LPC3250 board; I was having at
least 1 interrupt generated from each source (MIC/SIC1/SIC2).

Tested-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
