From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Dec 2009 12:51:29 +0000
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
Message-ID: <20091222125129.GA8522@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 07:29:03AM -0500, Haojian Zhuang wrote:

> +static void pca953x_irq_work(struct work_struct *work)
> +{
> +	DECLARE_BITMAP(rising, PCA953X_NUM_IRQ);
> +	DECLARE_BITMAP(falling, PCA953X_NUM_IRQ);

...

> +static void pca953x_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct pca953x_chip *chip = desc->handler_data;
> +
> +	desc->chip->ack(irq);
> +	schedule_work(&chip->irq_work);
> +}

genirq ought to be able to handle this in-line with the assistance of
the lock() and sync_unlock() operations that are available to irq_chip,
you shouldn't need a workqueue.  The wm831x driver is as far as I know
the only driver actually doing this at the minute.

> +static struct irq_chip pca953x_irqchip = {
> +	.name		= "GPIO",

Might be nice to call this "pxa953x" or something else including that
name - GPIO is a bit too generic, it's not going to immediately obvious
which chip this GPIO is for.
