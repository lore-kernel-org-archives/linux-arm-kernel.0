From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 30 Dec 2010 09:56:41 +0200
Subject: [PATCH 1/2] arm/pxa: fix build of it8152
In-Reply-To: <1293654828-24661-1-git-send-email-bigeasy@linutronix.de>
References: <1293654828-24661-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <4D1C3B39.5070208@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/10 22:33, Sebastian Andrzej Siewior wrote:
> Probably since 6ac6b817 aka ("ARM: pxa: encode IRQ number into
> .nr_irqs") the build fails with:
> |   CC      arch/arm/common/it8152.o
> | arch/arm/common/it8152.c: In function ?it8152_init_irq?:
> | arch/arm/common/it8152.c:86: error: ?IT8152_LAST_IRQ? undeclared (first use in this function)
> | arch/arm/common/it8152.c:86: error: (Each undeclared identifier is reported only once
> | arch/arm/common/it8152.c:86: error: for each function it appears in.)
> 
> Before that commit IT8152_LAST_IRQ was (IRQ_BOARD_END + 40) with the
> first IRQ beeing IRQ_BOARD_START. This change als adds +40 so I hope
> this works (I have no HW to verify).
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've already sent a patch for this (1), hopefully Eric or Russell will pick it up.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/036570.html
> ---
>  arch/arm/include/asm/hardware/it8152.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
> index 21fa272..e3931a9 100644
> --- a/arch/arm/include/asm/hardware/it8152.h
> +++ b/arch/arm/include/asm/hardware/it8152.h
> @@ -81,6 +81,8 @@ extern unsigned long it8152_base_address;
>  #define IT8152_LD_IRQ_COUNT     9
>  #define IT8152_LP_IRQ_COUNT     16
>  #define IT8152_PD_IRQ_COUNT     15
> +#define IT8152_LAST_IRQ		(IT8152_IRQ(0) + IT8152_LD_IRQ_COUNT + \
> +				IT8152_LP_IRQ_COUNT + IT8152_PD_IRQ_COUNT)
>  
>  /* Priorities: */
>  #define IT8152_PD_IRQ(i)        IT8152_IRQ(i)


-- 
Sincerely yours,
Mike.
