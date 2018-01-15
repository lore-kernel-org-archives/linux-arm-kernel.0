From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 15 Jan 2018 22:19:39 +0200
Subject: [RFC PATCH 1/2] pinctrl: add consumer variant for gpio request
In-Reply-To: <20180115162233.6205-2-ludovic.desroches@microchip.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
 <20180115162233.6205-2-ludovic.desroches@microchip.com>
Message-ID: <CAHp75VdGp1_hwK7rUq4u_gKpypdV7LYhV4+kQoVb_u7D+a6pwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 6:22 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

Did I miss cover letter for this?

> Add a consumer variant to GPIO request relative functions. The goal
> is to fix the bad ownership, which is arbitrary set to
> "range->name:gpio", of a GPIO.

Hmm... It's supposed to be name of the owner of the pin range (pin
control device name IIUC).

> There is a lack of configuration features for GPIO. For instance,
> we can't set the bias. Some pin controllers manage both device's
> pins and GPIOs. GPIOs can benefit from pin configuration. Usually,
> a pinctrl node is used to mux the pin as a GPIO and to set up its
> configuration.

Don't we have means to do that?

At least that what I see in aspeed_gpio_set_config().

Or I missed a point here?

> The pinmuxing strict mode involves that a pin which is muxed can't
> be requested as a GPIO if the owner is not the same.

Any elaborated example?

> Unfortunately,
> the ownership of a GPIO is set arbitrarily to "range->name:gpio".
> So there is a mismatch about the ownership which prevents a device
> from being the owner of the pinmuxing and requesting the same pin as
> a GPIO.

> Adding some consumer variants for GPIO request stuff will allow to
> pass the name of the device which requests the GPIO to not return an
> error if it's also the owner of the pinmuxing.

I think we need something more generic in core than producing more API
functions.

But I would like to get problem first.

> +       if (consumer)
> +               return pin_request(pctldev, pin, consumer, range);
> +

Hmm... My understanding that GPIO is just a (special) function out of
pin muxing. So, doing musing is essential to get proper function out
of it.

Does your hardware considers this differently? If so, I would really
want to see some datasheets.

-- 
With Best Regards,
Andy Shevchenko
