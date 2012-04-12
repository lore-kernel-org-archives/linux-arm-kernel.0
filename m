From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 12 Apr 2012 19:07:36 +0100 (BST)
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <1334239606.46697.YahooMailClassic@web29016.mail.ird.yahoo.com>
Message-ID: <1334254056.20098.YahooMailClassic@web29010.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Thu, 12/4/12, Paul Parsons <lost.distance@yahoo.com> wrote:
> The PXA GPIO irq_chip structure
> (pxa_muxed_gpio_chip) sets neither:
> 1. The irq_set_wake() handler.
> 2. The IRQCHIP_SKIP_SET_WAKE flag.
> 
> Consequently any attempt to configure the PXA GPIOs as
> wakeup sources
> results in Unbalanced IRQ warnings when the system is woken
> from sleep
> mode:
> 
> WARNING: at kernel/irq/manage.c:520
> irq_set_irq_wake+0xc4/0xf8()
> Unbalanced IRQ 96 wake disable
> ...
> WARNING: at kernel/irq/manage.c:520
> irq_set_irq_wake+0xc4/0xf8()
> Unbalanced IRQ 190 wake disable
> ...
> WARNING: at kernel/irq/manage.c:520
> irq_set_irq_wake+0xc4/0xf8()
> Unbalanced IRQ 195 wake disable
> ...
> 
> This patch sets the pxa_muxed_gpio_chip
> IRQCHIP_SKIP_SET_WAKE flag,
> thereby eliminating the Unbalanced IRQ warnings.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>  drivers/gpio/gpio-pxa.c |? ? 1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pxa.c
> b/drivers/gpio/gpio-pxa.c
> index 5689ce6..93ce960 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -427,6 +427,7 @@ static struct irq_chip
> pxa_muxed_gpio_chip = {
>  ??? .irq_mask??? =
> pxa_mask_muxed_gpio,
>  ??? .irq_unmask??? =
> pxa_unmask_muxed_gpio,
>  ??? .irq_set_type??? =
> pxa_gpio_irq_type,
> +??? .flags???
> ??? = IRQCHIP_SKIP_SET_WAKE,
>  };
>  
>  static int pxa_gpio_nums(void)
> -- 

Hmm, now I'm wondering if an irq_chip irq_set_wake() handler should
be provided instead.

This question arises because of the gpio_keys driver, which
provides a per-button wakeup flag (in struct gpio_keys_button).

Without an irq_set_wake() handler, the per-button wakeup flag
seems to serve no useful purpose: the flag is used to call
enable_irq_wake() from gpio_keys_suspend(), but enable_irq_wake()
does nothing useful without a handler.

However if an irq_set_wake() handler were to be provided, and if
that handler were to call gpio_set_wake(), then the per-button wakeup
flag would indeed determine which buttons act as wakeup sources.

For example:

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 5689ce6..0a75f3c 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -23,6 +23,9 @@
 #include <linux/slab.h>
 
 #include <mach/irqs.h>
+#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
+#include <mach/mfp-pxa2xx.h>
+#endif
 
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
@@ -421,12 +424,24 @@ static void pxa_unmask_muxed_gpio(struct irq_data *d)
 	update_edge_detect(c);
 }
 
+#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
+static int pxa_gpio_irq_wake(struct irq_data *d, unsigned int on)
+{
+	int gpio = pxa_irq_to_gpio(d->irq);
+
+	return gpio_set_wake(gpio, on);
+}
+#endif
+
 static struct irq_chip pxa_muxed_gpio_chip = {
 	.name		= "GPIO",
 	.irq_ack	= pxa_ack_muxed_gpio,
 	.irq_mask	= pxa_mask_muxed_gpio,
 	.irq_unmask	= pxa_unmask_muxed_gpio,
 	.irq_set_type	= pxa_gpio_irq_type,
+#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
+	.irq_set_wake	= pxa_gpio_irq_wake,
+#endif
 };
 
 static int pxa_gpio_nums(void)

So the underlying question is:
Was it the intention that gpio_set_wake() be called from irq_chip
irq_set_wake() handlers?

Regards,
Paul
