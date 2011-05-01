From: ccross@google.com (Colin Cross)
Date: Sun, 1 May 2011 00:26:23 -0700
Subject: [PATCH 2/6] ARM: tegra: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1302633340-4795-3-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-3-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTik4u=f+pFe0mQDV6Moj=-x2JQ1SMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 11:35 AM, Will Deacon <will.deacon@arm.com> wrote:
> This patch updates the Tegra gpio chained IRQ handler to use the chained
> IRQ enter/exit functions in order to function correctly on primary
> controllers with different methods of flow control.
>
> This is required for the GIC to move to fasteoi interrupt handling.
>
> Cc: Colin Cross <ccross@android.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/mach-tegra/gpio.c | ? ?9 ++++++---
> ?arch/arm/mach-tegra/irq.c ?| ? 12 ++++++------
> ?2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> index 76a3f65..494e28f 100644
> --- a/arch/arm/mach-tegra/gpio.c
> +++ b/arch/arm/mach-tegra/gpio.c
> @@ -24,6 +24,8 @@
> ?#include <linux/io.h>
> ?#include <linux/gpio.h>
>
> +#include <asm/mach/irq.h>
> +
> ?#include <mach/iomap.h>
> ?#include <mach/suspend.h>
>
> @@ -221,8 +223,9 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?int port;
> ? ? ? ?int pin;
> ? ? ? ?int unmasked = 0;
> + ? ? ? struct irq_chip *chip = irq_desc_get_chip(desc);
>
> - ? ? ? desc->irq_data.chip->irq_ack(&desc->irq_data);
> + ? ? ? chained_irq_enter(chip, desc);
>
> ? ? ? ?bank = irq_get_handler_data(irq);
>
> @@ -241,7 +244,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ? ? ? ? ?if (lvl & (0x100 << pin)) {
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unmasked = 1;
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chained_irq_exit(chip, desc);
> ? ? ? ? ? ? ? ? ? ? ? ?}
>
> ? ? ? ? ? ? ? ? ? ? ? ?generic_handle_irq(gpio_to_irq(gpio + pin));
> @@ -249,7 +252,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?}
>
> ? ? ? ?if (!unmasked)
> - ? ? ? ? ? ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
> + ? ? ? ? ? ? ? chained_irq_exit(chip, desc);
>
> ?}
>
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> index 4330d89..2424a3b 100644
> --- a/arch/arm/mach-tegra/irq.c
> +++ b/arch/arm/mach-tegra/irq.c
> @@ -48,7 +48,7 @@ static u32 tegra_lp0_wake_level_any;
>
> ?static void (*tegra_gic_mask_irq)(struct irq_data *d);
> ?static void (*tegra_gic_unmask_irq)(struct irq_data *d);
> -static void (*tegra_gic_ack_irq)(struct irq_data *d);
> +static void (*tegra_gic_eoi_irq)(struct irq_data *d);
>
> ?/* ensures that sufficient time is passed for a register write to
> ?* serialize into the 32KHz domain */
> @@ -113,10 +113,10 @@ static void tegra_unmask(struct irq_data *d)
> ? ? ? ?tegra_legacy_unmask_irq(d->irq);
> ?}
>
> -static void tegra_ack(struct irq_data *d)
> +static void tegra_eoi(struct irq_data *d)
> ?{
> ? ? ? ?tegra_legacy_force_irq_clr(d->irq);
> - ? ? ? tegra_gic_ack_irq(d);
> + ? ? ? tegra_gic_eoi_irq(d);
> ?}
>
> ?static int tegra_retrigger(struct irq_data *d)
> @@ -127,7 +127,7 @@ static int tegra_retrigger(struct irq_data *d)
>
> ?static struct irq_chip tegra_irq = {
> ? ? ? ?.name ? ? ? ? ? ? ? ? ? = "PPI",
> - ? ? ? .irq_ack ? ? ? ? ? ? ? ?= tegra_ack,
> + ? ? ? .irq_eoi ? ? ? ? ? ? ? ?= tegra_eoi,
> ? ? ? ?.irq_mask ? ? ? ? ? ? ? = tegra_mask,
> ? ? ? ?.irq_unmask ? ? ? ? ? ? = tegra_unmask,
> ? ? ? ?.irq_retrigger ? ? ? ? ?= tegra_retrigger,
> @@ -147,14 +147,14 @@ void __init tegra_init_irq(void)
> ? ? ? ?gic = irq_get_chip(29);
> ? ? ? ?tegra_gic_unmask_irq = gic->irq_unmask;
> ? ? ? ?tegra_gic_mask_irq = gic->irq_mask;
> - ? ? ? tegra_gic_ack_irq = gic->irq_ack;
> + ? ? ? tegra_gic_eoi_irq = gic->irq_eoi;
> ?#ifdef CONFIG_SMP
> ? ? ? ?tegra_irq.irq_set_affinity = gic->irq_set_affinity;
> ?#endif
>
> ? ? ? ?for (i = 0; i < INT_MAIN_NR; i++) {
> ? ? ? ? ? ? ? ?irq = INT_PRI_BASE + i;
> - ? ? ? ? ? ? ? irq_set_chip_and_handler(irq, &tegra_irq, handle_level_irq);
> + ? ? ? ? ? ? ? irq_set_chip_and_handler(irq, &tegra_irq, handle_fasteoi_irq);
> ? ? ? ? ? ? ? ?set_irq_flags(irq, IRQF_VALID);
> ? ? ? ?}
> ?}
> --
> 1.7.0.4
>
>

This version of the patch contains changes to gpio.c and irq.c.  If
you drop the irq.c changes (which I will fix in my upcoming patch),
Acked-by: Colin Cross <ccross@android.com>
