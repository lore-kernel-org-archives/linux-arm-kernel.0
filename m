From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 13 Jun 2015 19:32:20 +0800
Subject: [PATCH 01/15] ARM: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-2-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-2-git-send-email-robh@kernel.org>
Message-ID: <CAKT61h_EJgF926gmu0QZB=YHYSC+jWQA86yQ0e2T_4MtOvbXFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-10 2:26 GMT+08:00 Rob Herring <robh@kernel.org>:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>

For Nuvoton W90x900
Acked-by: Wan ZongShun <mcuos.com@gmail.com>

> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> +++ b/arch/arm/mach-w90x900/irq.c
> @@ -211,6 +211,6 @@ void __init nuc900_init_irq(void)
>         for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
>                 irq_set_chip_and_handler(irqno, &nuc900_irq_chip,
>                                          handle_level_irq);
> -               set_irq_flags(irqno, IRQF_VALID);
> +               irq_clear_status_flags(irqno, IRQ_NOREQUEST);
>         }
>  }
> --
> 2.1.0
>



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
