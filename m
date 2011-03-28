From: ccross@android.com (Colin Cross)
Date: Mon, 28 Mar 2011 12:00:43 -0700
Subject: [patch 08/29] arm: tegra: Remove unused bogus irq enable/disable
	magic
In-Reply-To: <20110328170651.575138721@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170651.575138721@linutronix.de>
Message-ID: <BANLkTinjYq3F0CwfqRQVzG53ecPm=QyV5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 10:12 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The core code handles thees already.
thees -> these

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Colin Cross <ccross@android.com>
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> ?arch/arm/mach-tegra/gpio.c | ? 19 -------------------
> ?1 file changed, 19 deletions(-)
>
> Index: linux-2.6-tip/arch/arm/mach-tegra/gpio.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-tegra/gpio.c
> +++ linux-2.6-tip/arch/arm/mach-tegra/gpio.c
> @@ -275,13 +275,6 @@ void tegra_gpio_resume(void)
> ? ? ? ?}
>
> ? ? ? ?local_irq_restore(flags);
> -
> - ? ? ? for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> - ? ? ? ? ? ? ? struct irq_desc *desc = irq_to_desc(i);
> - ? ? ? ? ? ? ? if (!desc || (desc->status & IRQ_WAKEUP))
> - ? ? ? ? ? ? ? ? ? ? ? continue;
> - ? ? ? ? ? ? ? enable_irq(i);
> - ? ? ? }
> ?}
>
> ?void tegra_gpio_suspend(void)
> @@ -289,18 +282,6 @@ void tegra_gpio_suspend(void)
> ? ? ? ?unsigned long flags;
> ? ? ? ?int b, p, i;
>
> - ? ? ? for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> - ? ? ? ? ? ? ? struct irq_desc *desc = irq_to_desc(i);
> - ? ? ? ? ? ? ? if (!desc)
> - ? ? ? ? ? ? ? ? ? ? ? continue;
> - ? ? ? ? ? ? ? if (desc->status & IRQ_WAKEUP) {
> - ? ? ? ? ? ? ? ? ? ? ? int gpio = i - INT_GPIO_BASE;
> - ? ? ? ? ? ? ? ? ? ? ? pr_debug("gpio %d.%d is wakeup\n", gpio/8, gpio&7);
> - ? ? ? ? ? ? ? ? ? ? ? continue;
> - ? ? ? ? ? ? ? }
> - ? ? ? ? ? ? ? disable_irq(i);
> - ? ? ? }
> -
> ? ? ? ?local_irq_save(flags);
> ? ? ? ?for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
> ? ? ? ? ? ? ? ?struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
>
>
>
This will cause warnings in both the suspend and resume functions as i
is now unused.

Other than that:
Acked-by: Colin Cross <ccross@android.com>

Do you want me to take this through the Tegra tree for 2.6.39-rc1?
