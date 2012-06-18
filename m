From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2012 08:37:20 +0200
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
In-Reply-To: <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
 <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
Message-ID: <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 4:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Jun 17, 2012 at 10:44 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>
>> ? ? ? ?uap->pinctrl = devm_pinctrl_get(&dev->dev);
>> ? ? ? ?if (IS_ERR(uap->pinctrl)) {
>> ? ? ? ? ? ? ? ?ret = PTR_ERR(uap->pinctrl);
>> - ? ? ? ? ? ? ? goto unmap;
>> + ? ? ? ? ? ? ? goto out;
>> ? ? ? ?}
>> ? ? ? ?uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PINCTRL_STATE_DEFAULT);
>> @@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>> ? ? ? ?uap->clk = clk_get(&dev->dev, NULL);
>
> Maybe you can use devm_clk_get here too.

That requires all users of the driver to be using CONFIG_CLKDEV, which
I *think* is safe to do, but better check: Russell, do you know if
it's safe to use
this feature from clkdev in the PL011 driver?

It seems so to me and most likely works on the systems I have (Ux500, U300,
Nomadik, Integrator, RealView) but the world of PL011 is so big...

Yours,
Linus Walleij
