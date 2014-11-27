From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 18:43:42 +0000
Subject: [PATCH v4 4/7] regulator: Use ena_gpio supplied with generic
 regulator bindings
In-Reply-To: <1417087253-12306-5-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141127184342.GC7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 12:20:50PM +0100, Krzysztof Kozlowski wrote:
> Use ena_gpio from regulator constraints (filled by parsing generic
> bindings) to initialize the GPIO enable control. Support also the old
> way: ena_gpio supplied in regulator_config structure.
> 
> This also adds a new set_ena_gpio() callback in regulator_ops structure
> which driver may provide to actually enable the GPIO control in
> hardware.

This seems really confused like it's trying to work around some other
problem - this all feels like it's at the wrong abstraction level.  As
far as I can tell this is trying to fix bugs in the previous patch and
do some other refactorings (the "also add this other random op" bit
especially) but I'm really not clear what the goal is.

Please try to think if the code you're writing makes sense at the big
picture level rather than just band aiding specific problems you see.
It's also a good idea to keep random code motion separate from
functional changes since it makes it much easier to follow what each is
supposed to do.

> @@ -1044,6 +1045,14 @@ static int set_machine_constraints(struct regulator_dev *rdev,
>  		}
>  	}
>  
> +	if (rdev->constraints->use_ena_gpio && ops->set_ena_gpio) {
> +		ret = ops->set_ena_gpio(rdev);
> +		if (ret < 0) {
> +			rdev_err(rdev, "failed to set enable GPIO control\n");
> +			goto out;
> +		}
> +	}

Why do we need some special magic operation for GPIO based enables
that's separate to any other enable operation?  This seems really
confusing, if the constraint setting doesn't work somehow for GPIO based
enables we should fix that.  Though since this operation takes no
parameters it's hard to see how it's supposed to apply constraints
unless it reparses them which doesn't seem like a good idea...

>  static int regulator_ena_gpio_request(struct regulator_dev *rdev,
> -				const struct regulator_config *config)

> -	ret = gpio_request_one(config->ena_gpio,
> -				GPIOF_DIR_OUT | config->ena_gpio_flags,
> +	ret = gpio_request_one(gpio, GPIOF_DIR_OUT | gpio_flags,
>  				rdev_get_name(rdev));

> +/*
> + * Request GPIO for enable control from regulator_config
> + * or init_data->constraints.
> + */
> +static int regulator_ena_gpio_setup(struct regulator_dev *rdev,
> +			const struct regulator_config *config,
> +			const struct regulator_init_data *init_data)

Why is setting up the GPIO different to requesting it, especially given
that we have an existing function called _request() which still exists?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/cad8a8a4/attachment.sig>
