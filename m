From: ccross@google.com (Colin Cross)
Date: Fri, 1 Apr 2011 13:29:54 -0700
Subject: [PATCH 2/6] ARM: tegra: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1301669441-13744-3-git-send-email-will.deacon@arm.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
	<1301669441-13744-3-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTikVHUUGtThJkbyXrmxg8Whmaji7DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 7:50 AM, Will Deacon <will.deacon@arm.com> wrote:
> This patch updates the Tegra gpio chained IRQ handler to use the chained
> IRQ enter/exit functions in order to function correctly on primary
> controllers with different methods of flow control.
>
> This is required for the GIC to move to fasteoi interrupt handling.
>
> Cc: Colin Cross <ccross@android.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/mach-tegra/gpio.c | ? ?7 ++++---
> ?1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> index 76a3f65..08c43dd 100644
> --- a/arch/arm/mach-tegra/gpio.c
> +++ b/arch/arm/mach-tegra/gpio.c
> @@ -221,8 +221,9 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?int port;
> ? ? ? ?int pin;
> ? ? ? ?int unmasked = 0;
> + ? ? ? struct irq_chip chip = get_irq_desc_chip(desc);
Should be a pointer, and 35e857c changed get_irq_desc_chip to irq_desc_get_chip

> - ? ? ? desc->irq_data.chip->irq_ack(&desc->irq_data);
> + ? ? ? chained_irq_enter(chip, desc);
asm/mach/irq.h needs to be included to use this function

> ? ? ? ?bank = irq_get_handler_data(irq);
>
> @@ -241,7 +242,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ? ? ? ? ?if (lvl & (0x100 << pin)) {
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unmasked = 1;
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chained_irq_exit(chip, desc);
> ? ? ? ? ? ? ? ? ? ? ? ?}
>
> ? ? ? ? ? ? ? ? ? ? ? ?generic_handle_irq(gpio_to_irq(gpio + pin));
> @@ -249,7 +250,7 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?}
>
> ? ? ? ?if (!unmasked)
> - ? ? ? ? ? ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
> + ? ? ? ? ? ? ? chained_irq_exit(chip, desc);
>
> ?}
>
> --
> 1.7.0.4
>
>
