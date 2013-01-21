From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 21 Jan 2013 23:45:08 +0800
Subject: [PATCH v7 08/15] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <CACRpkdZo6mVSaHBr6PJt8QCkiKp-Vs7mWup8n=4zyacRwf8V3g@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-9-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZo6mVSaHBr6PJt8QCkiKp-Vs7mWup8n=4zyacRwf8V3g@mail.gmail.com>
Message-ID: <CAD6h2NQm+VoUv9tDSoHv3Xs8RtuCt5A+_DCBx6bh-d3WP3PK=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 January 2013 22:37, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
> > Add the pl061_gpio_request() to request pinctrl. Create the logic
> > between pl061 gpio driver and pinctrl (pinctrl-single) driver.
> >
> > While a gpio pin is requested, it will request pinctrl driver to
> > set that pin with gpio function mode. So pinctrl driver should
> > append .gpio_request_enable() in pinmux_ops.
> >
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> (...)
> > +static int pl061_gpio_request(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       /*
> > +        * Map back to global GPIO space and request muxing, the direction
> > +        * parameter does not matter for this controller.
> > +        */
> > +       int gpio = chip->base + offset;
> > +
> > +       /*
> > +        * Do NOT check the return value at here. Since sometimes the gpio
> > +        * pin needn't to be configured in pinmux controller. So it's
> > +        * impossible to find the matched gpio range.
> > +        */
> > +       pinctrl_request_gpio(gpio);
>
> Handling of error code?
>
> (Maybe I should add a __must_check on this function.)
>
My case is a little special. I don't want to check return value because some
gpio pins don't have pinmux registers in Hisilicon SoC.
So pinctrl_request_gpio() will always return error for these special pins in
Hisilicon SoC.

If we must check the return value, maybe we need append a dummy pinctrl driver
for those special gpio pins. How do you think about it? Of course, I
need to evaluate
whether it's possible to implement.

> > +       return 0;
> > +}
> > +
> >  static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
> >  {
> >         struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> > @@ -251,6 +269,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
> >
> >         spin_lock_init(&chip->lock);
> >
> > +       chip->gc.request = pl061_gpio_request;
> >         chip->gc.direction_input = pl061_direction_input;
> >         chip->gc.direction_output = pl061_direction_output;
> >         chip->gc.get = pl061_get_value;
>
> What happens on a platform that has a PL061
> GPIO block but no pinctrl related to it?
>
> But still has some other pinctrl driver in the platform ....
>
> Right, it'll return -EPROBE_DEFER from pinctrl_request_gpio().
>
> This may happen on for example a combined SPEAr
> kernel where some platforms have PL061 and others us
> a pin controller, so both will be enabled.
>
> I think, add a field like this to struct pl061_gpio:
>
> bool has_pinctrl_backend;
>
> The only call that from pl061_gpio_request() if this is
> set:
>
> if (pl061->has_pinctrl_backend)
>    ret = pinctrl_request_gpio(gpio);

I'm OK to append "has_pinctrl_backend". But if we append a dummy pinctrl
driver, is it OK to SPEAr kernel? Do we still need has_pinctrl_backend?

>
> Then assign it in some clever way. For DT I think the
> proper way would be so add a cross-binding to the
> pin controller, like:
>
> gpio2: gpio at d8100000 {
>     #gpio-cells = <2>;
>     compatible = "arm,pl061", "arm,primecell";
> (...)
>     pinctrl = <&mr_pincontrol>;
> };

If we could append a dummy pinctrl driver, maybe we needn't
to append pinctrl property into gpio node. What's your opinion?

>
> Then just check if you have this pinctrl binding set
> to figure out if has_pinctrl_backend should be true.
>
> Yours,
> Linus Walleij

Regards
Haojian
