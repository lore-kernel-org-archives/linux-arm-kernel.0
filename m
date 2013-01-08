From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Jan 2013 12:59:29 +0000
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <1357629535-26033-2-git-send-email-acourbot@nvidia.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <1357629535-26033-2-git-send-email-acourbot@nvidia.com>
Message-ID: <201301081259.29839.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 January 2013, Alexandre Courbot wrote:
> +struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
> +                                                    const char *con_id)
> +{
> +       struct gpio_desc **dr;
> +       struct gpio_desc *desc;
> +
> +       dr = devres_alloc(devm_gpio_release, sizeof(struct gpio_desc *),
> +                         GFP_KERNEL);
> +       if (!dr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       desc = gpiod_get(dev, con_id);
> +       if (IS_ERR_OR_NULL(desc)) {
> +               devres_free(dr);
> +               return desc;
> +       }

Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
should not check for that.

> +       *dr = desc;
> +       devres_add(dev, dr);
> +
> +       return 0;
> +}

I'm pretty sure you meant to write 'return desc;' here.

	Arnd
