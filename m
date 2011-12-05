From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 5 Dec 2011 14:55:28 +0800
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <1322700336-26866-2-git-send-email-swarren@nvidia.com>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
 <1322700336-26866-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111205065527.GD2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 05:45:36PM -0700, Stephen Warren wrote:
[...]
>  static void tegra_gpio_irq_ack(struct irq_data *d)
>  {
> -	int gpio = d->irq - INT_GPIO_BASE;
> +	int gpio = d->hwirq;
>  
Though it's working right now, I'm not sure it's safe enough.  This
only works when d->hwirq_base is 0, which is true for now.  But I doubt
it will be always true.  I guess hwirq_base was introduced there for
some reason.  When some day irqdomain starts using this field, the
above code starts being broken.  IMO, the way that generic-chip.c is
using to calculate the number, d->irq - gc->irq_base, is much more
safer.

-- 
Regards,
Shawn

>  	tegra_gpio_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
>  }
