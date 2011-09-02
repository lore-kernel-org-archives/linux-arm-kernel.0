From: highguy@gmail.com (Stijn Devriendt)
Date: Fri, 2 Sep 2011 09:02:32 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOY=C6F7x+8UJv+0wChch4SAiRd+PRVgdCbZQ1_Db21uc-_9Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 11:53 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> +
> +/**
> + * pin_request() - request a single pin to be muxed in, typically for GPIO
> + * @pin: the pin number in the global pin space
> + * @function: a functional name to give to this pin, passed to the driver
> + * ? ? so it knows what function to mux in, e.g. the string "gpioNN"
> + * ? ? means that you want to mux in the pin for use as GPIO number NN
> + * @gpio: if this request concerns a single GPIO pin
> + */
> +static int pin_request(struct pinctrl_dev *pctldev,
> + ? ? ? ? ? ? ? ? ? ? ?int pin, const char *function, bool gpio)
> +{
> + ? ? ? struct pin_desc *desc;
> + ? ? ? const struct pinmux_ops *ops;
> + ? ? ? int status = -EINVAL;
> +
> + ? ? ? pr_debug("request pin %d for %s\n", pin, function);
> +
> + ? ? ? if (!pin_is_valid(pctldev, pin)) {
> + ? ? ? ? ? ? ? pr_err("pin is invalid\n");
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? if (!function) {
> + ? ? ? ? ? ? ? pr_err("no function name given\n");
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? desc = pin_desc_get(pctldev, pin);
> + ? ? ? if (desc == NULL) {
> + ? ? ? ? ? ? ? pr_err("pin is not registered so it cannot be requested\n");
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> + ? ? ? if (desc->mux_requested) {
> + ? ? ? ? ? ? ? pr_err("pin already requested\n");
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }

Isn't locking missing here?

> + ? ? ? ops = pctldev->desc->pmxops;
> +
> + ? ? ? /* Let each pin increase references to this module */
> + ? ? ? if (!try_module_get(pctldev->owner)) {
> + ? ? ? ? ? ? ? pr_err("could not increase module refcount for pin %d\n", pin);
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
> + ? ? ? ? ? ? ? status = ops->gpio_request_enable(pctldev, pin);
> + ? ? ? else if (ops->request)
> + ? ? ? ? ? ? ? status = ops->request(pctldev, pin);
> + ? ? ? else
> + ? ? ? ? ? ? ? status = 0;
> +
> + ? ? ? if (status) {
> + ? ? ? ? ? ? ? pr_err("->request on device %s failed "
> + ? ? ? ? ? ? ? ? ? ? ?"for pin %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?pctldev->desc->name, pin);
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? desc->mux_requested = true;
> + ? ? ? strncpy(desc->mux_function, function, sizeof(desc->mux_function));
> +
> +out:
> + ? ? ? if (status)
> + ? ? ? ? ? ? ? pr_err("pin-%d (%s) status %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?pin, function ? : "?", status);
> +
> + ? ? ? return status;
> +}
> +

Regards,
Stijn
