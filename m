From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2012 12:56:51 +0200
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <5023C923.3080808@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
 <201208060844.29333.arnd@arndb.de>
 <CACRpkdayqp0ptdURHtYWC6G5pk1rNaAiWZkc7bdhv2osY1MaHA@mail.gmail.com>
 <5023C923.3080808@gmail.com>
Message-ID: <CACRpkda0443PF-SwNaiJCO9RmdCFqw1+OtLgTBoTfZzwnFjJ4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 4:28 PM, Daniel Mack <zonque@gmail.com> wrote:

> I am looking at the generic pinctrl code right now

Sweet!

> and I wonder if the following approach would be ok:
>
> - each driver that calls pinctrl_register() has its own dt_match_table
> entry, so the 'compatible' part of the bindings is specific to a pin
> controller chip.

Yep.

> - introduce a pinctrl_parse_of(struct of_node *) and call that after the
> driver has added all its pins. That function walks all the children of
> the given node and uses the callbacks provided by the driver to do the
> actual work.

Isn't that already how it works? Maybe I misunderstand, do you mean
that you want to pass the DT node to pinctrl_register()?

Are you talking about using pinctrl hogs to set up the default
configuration and muxing? That can already be done today,
and has nothing to do with whether you use generic pin config
or not.

This uses the .dt_node_to_map() and .dt_free_map() callbacks
in the pinctrl_ops vtable to generate a map from the device tree,
in any way you want.

So the infrastructure I think already exists, but whereas all
current driver have their own config and mux (etc) parsing
code, pinconf-generic could provide something that would
be common for all driver using generic pin config.

> - Unfortunately, we can't parse the node from pinctrl_register() as the
> gpio ranges are only added after that by the drivers.

The ranges are a *big* problem and we haven't come up with
a proper DT binding for these. After discussion with Grant,
he has proposed that GPIO chips should register their ranges
using their local numberspace and always passing the
struct gpio_chip, instead of pin controllers registering ranges.
Documented here:
https://blueprints.launchpad.net/linux-linaro/+spec/pinctrl-gpiorange-makeover

> If that sounds good, I can come up with a patch.

I think you already have what you need, look closer at how
e.g. the Tegra or i.MX driver does this. Or maybe I'm only
getting it backwards?

Yours,
Linus Walleij
