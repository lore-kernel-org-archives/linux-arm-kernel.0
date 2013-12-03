From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 03 Dec 2013 18:02:18 +0200
Subject: [PATCH v2] pinctrl: baytrail: lock IRQs when starting them
In-Reply-To: <1386082822-20094-1-git-send-email-linus.walleij@linaro.org>
References: <1386082822-20094-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <529E008A.6030704@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 05:00 PM, Linus Walleij wrote:
> This uses the new API for tagging GPIO lines as in use by
> IRQs. This enforces a few semantic checks on how the underlying
> GPIO line is used.
>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Actually make the change compile, doh.
> ---
>   drivers/pinctrl/pinctrl-baytrail.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-baytrail.c b/drivers/pinctrl/pinctrl-baytrail.c
> index 1174ea86b6e9..998dbb0c4c93 100644
> --- a/drivers/pinctrl/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/pinctrl-baytrail.c
> @@ -372,11 +372,33 @@ static void byt_irq_mask(struct irq_data *d)
>   {
>   }
>
> +static unsigned int byt_irq_startup(struct irq_data *d)
> +{
> +	struct byt_gpio *vg = irq_data_get_irq_handler_data(d);

This should probably be:

struct byt_gpio *vg = irq_data_get_irq_chip_data(d);

As chip methods use irq_data->chip_data, not irq_data->handler_data
(Mika tested that it works on baytrail)

> +
> +	if (gpio_lock_as_irq(&vg->chip, irqd_to_hwirq(d)))
> +		dev_err(vg->chip.dev,
> +			"unable to lock HW IRQ %lu for IRQ\n",
> +			irqd_to_hwirq(d));
> +	byt_irq_unmask(d);
> +	return 0;
> +}
> +
> +static void byt_irq_shutdown(struct irq_data *d)
> +{
> +	struct byt_gpio *vg = irq_data_get_irq_handler_data(d);

Same here.

-Mathias
