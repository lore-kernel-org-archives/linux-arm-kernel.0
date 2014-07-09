From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Jul 2014 13:52:54 +0200 (CEST)
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <53BD2509.6070803@codethink.co.uk>
References: <cover.1404665589.git.himangi774@gmail.com>
 <1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>
 <53BD2509.6070803@codethink.co.uk>
Message-ID: <alpine.DEB.2.10.1407091351530.2375@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 9 Jul 2014, Rob Jones wrote:

> Please note that I submitted a patch on 02/07/14 to create this
> function which was acked by Linus Walleij on 05/07/14.
>
> Great minds think alike, and all that.
>
> However, I think that the version I submitted better replicates the
> original (non devm) functionality, see below.
>
> I didn't, however, add it to the documentation. +1 on that.
>
> On 06/07/14 18:47, Himangi Saraogi wrote:
> > This patch introduces the function devm_request_gpio_array that
> > allocates multiple GPIOs in a single call in a managed manner. The
> > function is also included in the documentation and a declaration is
> > added in include/linux/gpio.h.
> >
> > Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> > ---
> >   Documentation/driver-model/devres.txt |  1 +
> >   drivers/gpio/devres.c                 | 21 +++++++++++++++++++++
> >   include/linux/gpio.h                  |  2 ++
> >   3 files changed, 24 insertions(+)
> >
> > diff --git a/Documentation/driver-model/devres.txt
> > b/Documentation/driver-model/devres.txt
> > index 9e2098e..756f6cf 100644
> > --- a/Documentation/driver-model/devres.txt
> > +++ b/Documentation/driver-model/devres.txt
> > @@ -337,6 +337,7 @@ GPIO
> >     devm_gpiod_put()
> >     devm_gpio_request()
> >     devm_gpio_request_one()
> > +  devm_gpio_request_array()
> >     devm_gpio_free()
> >
> >   SND
> > diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
> > index 65978cf..adae7fa 100644
> > --- a/drivers/gpio/devres.c
> > +++ b/drivers/gpio/devres.c
> > @@ -229,6 +229,27 @@ int devm_gpio_request_one(struct device *dev, unsigned
> > gpio,
> >   EXPORT_SYMBOL(devm_gpio_request_one);
> >
> >   /**
> > + *	devm_gpio_request_array - request multiple GPIOs in a single call
> > + *	@dev:   device to request for
> > + *	@array:	array of the 'struct gpio'
> > + *	@num:	how many GPIOs in the array
> > + */
> > +int devm_gpio_request_array(struct device *dev, const struct gpio *array,
> > +			    size_t num)
> > +{
> > +	int i, err;
> > +
> > +	for (i = 0; i < num; i++, array++) {
> > +		err = devm_gpio_request_one(dev, array->gpio, array->flags,
> > +					    array->label);
> > +		if (err)
> > +			return err;
>
> The failure path in the version I submitted frees up any already
> allocated gpios on the first failure.

Himangi first proposed doing that, but I thought it was not really in the
spirit of devm functions, which is to leave that implicit.  No strong
opinion on the matter, though.

julia


>
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_gpio_request_array);
> > +
> > +/**
> >    *      devm_gpio_free - free a GPIO
> >    *      @dev: device to free GPIO for
> >    *      @gpio: GPIO to free
> > diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> > index 85aa5d0..c85f243 100644
> > --- a/include/linux/gpio.h
> > +++ b/include/linux/gpio.h
> > @@ -84,6 +84,8 @@ struct device;
> >   int devm_gpio_request(struct device *dev, unsigned gpio, const char
> > *label);
> >   int devm_gpio_request_one(struct device *dev, unsigned gpio,
> >   			  unsigned long flags, const char *label);
> > +int devm_gpio_request_array(struct device *dev, const struct gpio *array,
> > +			    size_t num);
> >   void devm_gpio_free(struct device *dev, unsigned int gpio);
> >
> >   #else /* ! CONFIG_GPIOLIB */
> >
>
> --
> Rob Jones
> Codethink Ltd
> mailto:rob.jones at codethink.co.uk
> tel:+44 161 236 5575
>
