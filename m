From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Dec 2014 22:02:18 +0100
Subject: [PATCH 5/8] irqchip: Conexant CX92755 interrupts controller driver
In-Reply-To: <7997c913e9f6debc09fd62c788b8ac6bd330d4f3.1419318109.git.baruch@tkos.co.il>
References: <cover.1419318109.git.baruch@tkos.co.il>
 <7997c913e9f6debc09fd62c788b8ac6bd330d4f3.1419318109.git.baruch@tkos.co.il>
Message-ID: <16151065.LjzHK8TaOo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 December 2014 09:58:42 Baruch Siach wrote:
> +static void __exception_irq_entry digicolor_handle_irq(struct pt_regs *regs)
> +{
> +       u32 status, hwirq;
> +
> +       do {
> +               status = readl(digicolor_irq_base + IC_INT0STATUS_LO);
> +               if (status) {
> +                       hwirq = ffs(status) - 1;
> +               } else {
> +                       status = readl(digicolor_irq_base + IC_INT0STATUS_XLO);
> +                       if (status)
> +                               hwirq = ffs(status) - 1 + 32;
> +                       else
> +                               return;
> +               }
> +
> +               handle_domain_irq(digicolor_irq_domain, hwirq, regs);
> +       } while (1);
> +}
> 

Have you tried using the generic_irqchip code for this? The hardware
seems simple enough.

	Arnd
