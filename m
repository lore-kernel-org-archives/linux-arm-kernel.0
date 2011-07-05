From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:37:48 +0800
Subject: [PATCH 1/3] ARM: pxa: enable pxa95x interrupt handler
In-Reply-To: <1302861927-6845-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011041501>
	<1302861927-6845-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CAMPhdO8DAhuyX76UmjQ-uMN_Hn4N9v6BgbVnJkx6byte0ki59g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 6:05 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> PXA27x/PXA3xx silicons need to access CP15 co-processor to get interrupt
> information. PXA95x needs to access interrupt controller register.
>
> So make PXA95x support multiple handler interrupt.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-pxa/entry-pxa95x-intc.S | ? 38 +++++++++++++++++++++++++++++++++

Hi Haojian,

The function doesn't need to be assembly code, see my -devel branch
for example. A simple C function should be sufficient to handle this
simple case.

> ?arch/arm/mach-pxa/generic.h ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/saarb.c ? ? ? ? ? ? | ? ?1 +
> ?5 files changed, 42 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-pxa/entry-pxa95x-intc.S
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 2fc9f94..9811f0e 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -660,6 +660,7 @@ config CPU_PXA935
> ?config PXA95x
> ? ? ? ?bool
> ? ? ? ?select CPU_PJ4
> + ? ? ? select MULTI_IRQ_HANDLER
> ? ? ? ?help
> ? ? ? ? ?Select code specific to PXA95x variants
>
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index cc39d17..ed80260 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -19,7 +19,7 @@ endif
> ?obj-$(CONFIG_PXA25x) ? ? ? ? ? += mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa25x.o
> ?obj-$(CONFIG_PXA27x) ? ? ? ? ? += mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa27x.o
> ?obj-$(CONFIG_PXA3xx) ? ? ? ? ? += mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
> -obj-$(CONFIG_PXA95x) ? ? ? ? ? += mfp-pxa3xx.o clock-pxa3xx.o pxa95x.o smemc.o
> +obj-$(CONFIG_PXA95x) ? ? ? ? ? += mfp-pxa3xx.o clock-pxa3xx.o pxa95x.o smemc.o entry-pxa95x-intc.o
> ?obj-$(CONFIG_CPU_PXA300) ? ? ? += pxa300.o
> ?obj-$(CONFIG_CPU_PXA320) ? ? ? += pxa320.o
> ?obj-$(CONFIG_CPU_PXA930) ? ? ? += pxa930.o
> diff --git a/arch/arm/mach-pxa/entry-pxa95x-intc.S b/arch/arm/mach-pxa/entry-pxa95x-intc.S
> new file mode 100644
> index 0000000..4a62486
> --- /dev/null
> +++ b/arch/arm/mach-pxa/entry-pxa95x-intc.S
> @@ -0,0 +1,38 @@
> +/*
> + * ?arch/arm/mach-pxa/entry-pxa95x-intc.S
> + *
> + * ?Low-level IRQ helper macros for PXA95x-based platforms
> + *
> + * ?Copyright (C) 2011 Marvell International Ltd.
> + *
> + * ?This program is free software; you can redistribute it and/or modify
> + * ?it under the terms of the GNU General Public License version 2 as
> + * ?publishhed by the Free Software Foundation.
> + */
> +#include <asm/entry-macro-multi.S>
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +
> + ? ? ? ? ? ? ? .macro ?get_pxa95x_irqnr_and_base, irqnr, irqstat, base, tmp
> + ? ? ? ? ? ? ? mov ? ? \base, #io_p2v(0x40000000) ? ? ?@ IIR Ctl = 0x40d00000
> + ? ? ? ? ? ? ? add ? ? \base, \base, #0x00d00000
> + ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #0x18] ? ? ? ?@ ICHP offset
> + ? ? ? ? ? ? ? tst ? ? \irqstat, #0x80000000
> + ? ? ? ? ? ? ? beq ? ? 2001f
> + ? ? ? ? ? ? ? bic ? ? \irqstat, \irqstat, #0x80000000
> + ? ? ? ? ? ? ? mov ? ? \irqnr, \irqstat, lsr #16
> + ? ? ? ? ? ? ? add ? ? \irqnr, \irqnr, #(PXA_IRQ(0))
> +2001:
> + ? ? ? ? ? ? ? .endm
> +
> + ? ? ? ? ? ? ? .align ?5
> + ? ? ? ? ? ? ? .global pxa95x_handle_irq_intc
> +pxa95x_handle_irq_intc:
> + ? ? ? ? ? ? ? mov ? ? r4, lr
> +1: ? ? ? ? ? ? get_pxa95x_irqnr_and_base r0, r6, r5, lr
> + ? ? ? ? ? ? ? movne ? r1, sp
> +
> + ? ? ? ? ? ? ? @ routine called with r0 = irq number, r1 = struct pt_regs *
> + ? ? ? ? ? ? ? adrne ? lr, BSYM(1b)
> + ? ? ? ? ? ? ? bne ? ? asm_do_IRQ
> + ? ? ? ? ? ? ? mov ? ? pc, r4
> diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
> index a079d8b..e47f863 100644
> --- a/arch/arm/mach-pxa/generic.h
> +++ b/arch/arm/mach-pxa/generic.h
> @@ -30,6 +30,7 @@ extern void __init pxa27x_map_io(void);
> ?extern void __init pxa3xx_map_io(void);
>
> ?extern unsigned int get_clk_frequency_khz(int info);
> +extern void pxa95x_handle_irq_intc(struct pt_regs *);
>
> ?#define SET_BANK(__nr,__start,__size) \
> ? ? ? ?mi->bank[__nr].start = (__start), \
> diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
> index 9322fe5..f98ff38 100644
> --- a/arch/arm/mach-pxa/saarb.c
> +++ b/arch/arm/mach-pxa/saarb.c
> @@ -107,6 +107,7 @@ MACHINE_START(SAARB, "PXA955 Handheld Platform (aka SAARB)")
> ? ? ? ?.map_io ? ? ? ? = pxa_map_io,
> ? ? ? ?.nr_irqs ? ? ? ?= SAARB_NR_IRQS,
> ? ? ? ?.init_irq ? ? ? = pxa95x_init_irq,
> + ? ? ? .handle_irq ? ? = pxa95x_handle_irq_intc,
> ? ? ? ?.timer ? ? ? ? ?= &pxa_timer,
> ? ? ? ?.init_machine ? = saarb_init,
> ?MACHINE_END
> --
> 1.5.6.5
>
>
