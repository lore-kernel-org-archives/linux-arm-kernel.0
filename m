From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 21 Dec 2011 15:12:36 +0100
Subject: [PATCH] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <1323728465.801.YahooMailClassic@web29018.mail.ird.yahoo.com>
References: <1323728465.801.YahooMailClassic@web29018.mail.ird.yahoo.com>
Message-ID: <CA+gwMcc3tbGXmFHQt=y7mwprXumh7sgMSE_e7B0L2LbQ-Hk2fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On Mon, Dec 12, 2011 at 11:21 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> linux-2.6.32 changed the values of PXA_GPIO_IRQ_BASE and PXA_GPIO_IRQ_NUM from
> 64/128 to 96/192. This has broken the hx4700 platform, for example its PCMCIA/CF
> driver. The 9 EGPIO GPIOs have become numbered 256..264, and consequently fail
> the gpio_is_valid() test in gpiolib.c (which limits GPIOs to the range 0..255).
> This patch reverts the values of PXA_GPIO_IRQ_BASE and PXA_GPIO_IRQ_NUM to their
> previous linux-2.6.31 values for the hx4700 platform only.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> diff -uprN clean-3.2-rc5/arch/arm/mach-pxa/include/mach/irqs.h linux-3.2-rc5/arch/arm/mach-pxa/include/mach/irqs.h
> --- clean-3.2-rc5/arch/arm/mach-pxa/include/mach/irqs.h 2011-12-09 23:09:32.000000000 +0000
> +++ linux-3.2-rc5/arch/arm/mach-pxa/include/mach/irqs.h 2011-12-12 15:21:09.770483920 +0000
> @@ -87,8 +87,13 @@
> ?#define IRQ_PXA955_MMC3 ? ? ? ?PXA_IRQ(75) ? ? /* MMC3 Controller (PXA955) */
> ?#define IRQ_U2P ? ? ? ? ? ? ? ?PXA_IRQ(93) ? ? /* USB PHY D+/D- Lines (PXA935) */
>
> +#ifdef CONFIG_MACH_H4700
> +#define PXA_GPIO_IRQ_BASE ? ? ?PXA_IRQ(64)
> +#define PXA_GPIO_IRQ_NUM ? ? ? (128)
> +#else
> ?#define PXA_GPIO_IRQ_BASE ? ? ?PXA_IRQ(96)
> ?#define PXA_GPIO_IRQ_NUM ? ? ? (192)
> +#endif

machine specific definitions were removed from mach/irqs.h in commits
0dc726bb264ca5ecfdfab94a6937e0e9b9b26f64 ([ARM] pxa: move board board
IRQ definitions out of irqs.h) and
6ac6b817f3f4c23c5febd960d8deb343e13af5f3 (ARM: pxa: encode IRQ number
into .nr_irqs).
I'd propose to increase ARCH_NR_GPIOs to 264 in mach/gpio.h or
plat/gpio.h instead.

>
> ?#define GPIO_2_x_TO_IRQ(x) ? ? (PXA_GPIO_IRQ_BASE + (x))
> ?#define IRQ_GPIO(x) ? ?(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))

regards
Philipp
