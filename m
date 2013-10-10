From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 10:03:40 +0200
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131010072624.GA29191@S2101-09.ap.freescale.net>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131010072624.GA29191@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdZFx94kEXiWPHOZVmK1d21pM0jg4y6coqu3Pyd=9HES5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> However, my patch is talking about a different thing.  For example, we
> have a device whose pinctrl-0 consists of two phandle entries that point
> to pin configuration nodes foo and bar.
>
>         pinctrl-0 = <&foo &bar>;
>
>         foo {
>                 ...
>         };
>
>         bar {
>                 ...
>         };
>
> My patch only wants to make it clear that the configuration specified by
> node foo will be applied to pin controller first, and the configuration
> defined in node bar will be applied after that.  When both nodes have
> configuration for a pin, these two configs for the same pin go to two
> different pinctrl_setting structures.  And these two pinctrl_settings
> can not be applied accumulatedly but only sequentially.  That's what my
> patch talks about.

OK I get it (I think).

However isn't this aspect rather a property of how the specific driver
parses and uses the device tree?

Remember that with drivers that do not use generic pin config,
we have left the handling of the device tree node up to the driver
by the callback dt_node_to_map().

But I do understand the ambition to specify this behaviour for all
pin control drivers using device tree.

But we need to be careful since DT isn't very much in the
buisiness of defining sequence semantics for stuff, and that
is why I'm a bit hesitant.

So, maybe we can add this as it only concerns the binding
(but then I want that example to be part of the documentation patch
so that it is crystal clear what we're talking about), but it would be
proper if we also helped enforce this semantic across the drivers,
i.e. centralize more of the DT parsing code...

BTW on a related subject: have you examined if the i.MX driver
can use the new utility functions from pinctrl-utils.h:

pinctrl_utils_reserve_map()
pinctrl_utils_add_map_mux()
pinctrl_utils_add_map_configs()
pinctrl_utils_add_config()
pinctrl_utils_dt_free_map()

It helps a lot the more boilerplate we can move out of the
drivers and get a clear picture of the device tree parsing code,
and see what really needs to be different across the drivers.

Yours,
Linus Walleij
