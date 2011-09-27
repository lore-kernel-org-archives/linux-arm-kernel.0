From: highguy@gmail.com (Stijn Devriendt)
Date: Tue, 27 Sep 2011 11:30:08 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v7
In-Reply-To: <1316175203-10736-1-git-send-email-linus.walleij@stericsson.com>
References: <1316175203-10736-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOY=C6ESgRpdCYb8tCxmmdRGfjv+gqroDNiq63zyRjardVicjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int pin_request(struct pinctrl_dev *pctldev,
> + ? ? ? ? ? ? ? ? ? ? ?int pin, const char *function, bool gpio,
> + ? ? ? ? ? ? ? ? ? ? ?struct pinctrl_gpio_range *gpio_range)
> +{
> + ? ? ? struct pin_desc *desc;
> + ? ? ? const struct pinmux_ops *ops = pctldev->desc->pmxops;
> + ? ? ? int status = -EINVAL;
> +
> + ? ? ? dev_dbg(&pctldev->dev, "request pin %d for %s\n", pin, function);
> +
> + ? ? ? if (!pin_is_valid(pctldev, pin)) {
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev, "pin is invalid\n");
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? if (!function) {
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev, "no function name given\n");
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? desc = pin_desc_get(pctldev, pin);
> + ? ? ? if (desc == NULL) {
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? "pin is not registered so it cannot be requested\n");
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? spin_lock(&desc->lock);
> + ? ? ? if (desc->mux_requested) {
> + ? ? ? ? ? ? ? spin_unlock(&desc->lock);
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? "pin already requested\n");
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> + ? ? ? spin_unlock(&desc->lock);

Now this is racing with...

> +
> + ? ? ? /* Let each pin increase references to this module */
> + ? ? ? if (!try_module_get(pctldev->owner)) {
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? "could not increase module refcount for pin %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? pin);
> + ? ? ? ? ? ? ? status = -EINVAL;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* If there is no kind of request function for the pin we just assume
> + ? ? ? ?* we got it by default and proceed.
> + ? ? ? ?*/
> + ? ? ? if (gpio && ops->gpio_request_enable)
> + ? ? ? ? ? ? ? /* This requests and enables a single GPIO pin */
> + ? ? ? ? ? ? ? status = ops->gpio_request_enable(pctldev, gpio_range, pin);
> + ? ? ? else if (ops->request)
> + ? ? ? ? ? ? ? status = ops->request(pctldev, pin);
> + ? ? ? else
> + ? ? ? ? ? ? ? status = 0;
> +
> + ? ? ? if (status) {
> + ? ? ? ? ? ? ? dev_err(&pctldev->dev, "->request on device %s failed "
> + ? ? ? ? ? ? ? ? ? ? ?"for pin %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?pctldev->desc->name, pin);
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +

... this:

> + ? ? ? spin_lock(&desc->lock);
> + ? ? ? desc->mux_requested = true;
> + ? ? ? strncpy(desc->mux_function, function, sizeof(desc->mux_function));
> + ? ? ? spin_unlock(&desc->lock);
> +

2 threads can pass through when mux_requested is false and they might
both acquire
the pin, depending on specific driver implementation.

Regards,
Stijn
