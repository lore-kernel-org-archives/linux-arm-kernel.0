From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 24 Oct 2012 15:02:30 +0300
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.

This doesn't look right to me, aren't you effectively disabling
debounce forever here? _gpio_dbck_disable is called from
omap_gpio_runtime_suspend() and nothing will ever restore
dbck_enable_mask back to what it was set by _set_gpio_debounce and
debounce functionality is lost.

>
> This was discovered when board code was doing
>
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies on v3.7-rc2, targetted for v3.7.
>
>  drivers/gpio/gpio-omap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..dee2856 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>                  * to detect events and generate interrupts at least on OMAP3.
>                  */
>                 __raw_writel(0, bank->base + bank->regs->debounce_en);
> +               bank->dbck_enable_mask = 0;
>
>                 clk_disable(bank->dbck);
>                 bank->dbck_enabled = false;
> --
> 1.8.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Gra?vydas
