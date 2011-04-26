From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 26 Apr 2011 20:14:05 +0530
Subject: [PATCH 13/15] OMAP: GPIO: cleanup _set_gpio_wakeup(),
	remove ifdefs
In-Reply-To: <1303513327-14532-14-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-14-git-send-email-khilman@ti.com>
Message-ID: <BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Make _set_gpio_wakeup() generic by removing ifdefs. ?Code for the
> various SoCs/bank-methods was already the same, except for the
> non-wakeup GPIO checking. ?But that flag is set on a per-SoC basis, so
> can be used for all SoCs.
>
> While here, use pr_err() and remove GPIO bank calculation assumption
> based on subtracting bank pointers.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/plat-omap/gpio.c | ? 49 +++++++++++++-------------------------------
> ?1 files changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index a025b7a..82afed8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -535,42 +535,23 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
> ?*/
> ?static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
> ?{
> - ? ? ? unsigned long uninitialized_var(flags);
> + ? ? ? u32 gpio_bit = GPIO_BIT(bank, gpio);
> + ? ? ? unsigned long flags;
>
> - ? ? ? switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> - ? ? ? case METHOD_MPUIO:
> - ? ? ? case METHOD_GPIO_1610:
> - ? ? ? ? ? ? ? spin_lock_irqsave(&bank->lock, flags);
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? bank->suspend_wakeup |= (1 << gpio);
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? bank->suspend_wakeup &= ~(1 << gpio);
> - ? ? ? ? ? ? ? spin_unlock_irqrestore(&bank->lock, flags);
> - ? ? ? ? ? ? ? return 0;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - ? ? ? case METHOD_GPIO_24XX:
> - ? ? ? case METHOD_GPIO_44XX:
> - ? ? ? ? ? ? ? if (bank->non_wakeup_gpios & (1 << gpio)) {
> - ? ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "Unable to modify wakeup on "
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "non-wakeup GPIO%d\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(bank - gpio_bank) * bank->width + gpio);
> - ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> - ? ? ? ? ? ? ? }
> - ? ? ? ? ? ? ? spin_lock_irqsave(&bank->lock, flags);
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? bank->suspend_wakeup |= (1 << gpio);
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? bank->suspend_wakeup &= ~(1 << gpio);
> - ? ? ? ? ? ? ? spin_unlock_irqrestore(&bank->lock, flags);
> - ? ? ? ? ? ? ? return 0;
> -#endif
> - ? ? ? default:
> - ? ? ? ? ? ? ? printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
> - ? ? ? ? ? ? ? ? ? ? ?bank->method);
> + ? ? ? if (bank->non_wakeup_gpios & gpio_bit) {
> + ? ? ? ? ? ? ? pr_err("Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);

use dev_err instead.

-V Charulatha

<<snip>>
