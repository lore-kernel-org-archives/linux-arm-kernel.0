From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Nov 2013 17:07:13 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123004334.GJ10023@atomide.com>
References: <20131123004334.GJ10023@atomide.com>
Message-ID: <20131123010712.GM10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131122 16:44]:
> @@ -168,7 +218,13 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  			rc = of_address_to_resource(np, i, res);
>  			WARN_ON(rc);
>  		}
> -		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
> +
> +		/* See of_device_resource_notify for populating interrupts */
> +		for (i = 0; i < num_irq; i++, res++) {
> +			res->flags = IORESOURCE_IRQ;
> +			res->start = -EPROBE_DEFER;
> +			res->end = -EPROBE_DEFER;
> +		}

Hmm actually we want to use some other value here as res->start
is not an int. Maybe some kind of hwirq_max + EPROBE_DEFER.

Tony
