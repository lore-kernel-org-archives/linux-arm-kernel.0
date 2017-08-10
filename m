From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 10 Aug 2017 11:28:10 -0700
Subject: [PATCH v8 1/5] clk: Add support for runtime PM
In-Reply-To: <1502274907-11931-2-git-send-email-m.szyprowski@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170809103512eucas1p2eb66401b357d82bed91182a5a1b1fea9@eucas1p2.samsung.com>
 <1502274907-11931-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <150238969053.5192.13225746723120483789@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Quoting Marek Szyprowski (2017-08-09 03:35:03)
> Registers for some clocks might be located in the SOC area, which are under the
> power domain. To enable access to those registers respective domain has to be
> turned on. Additionally, registers for such clocks will usually loose its
> contents when power domain is turned off, so additional saving and restoring of
> them might be needed in the clock controller driver.
> 
> This patch adds basic infrastructure in the clocks core to allow implementing
> driver for such clocks under power domains. Clock provider can supply a
> struct device pointer, which is the used by clock core for tracking and managing
> clock's controller runtime pm state. Each clk_prepare() operation
> will first call pm_runtime_get_sync() on the supplied device, while
> clk_unprepare() will do pm_runtime_put_sync() at the end.
> 
> Additional calls to pm_runtime_get/put functions are required to ensure that any
> register access (like calculating/changing clock rates and unpreparing/disabling
> unused clocks on boot) will be done with clock controller in runtime resumend
> state.
> 
> When one wants to register clock controller, which make use of this feature, he
> has to:
> 1. Provide a struct device to the core when registering the provider.
> 2. Ensure to enable runtime PM for that device before registering clocks.
> 3. Make sure that the runtime PM status of the controller device reflects
>    the HW state.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Overall the idea and the patch look good to me.

Calling pm_runtime_get for prepare and pm_runtime_put for unprepared
makes perfect sense to me. It means that the power domain that powers
that clock hardware must be on for that clock to function properly.

It?s worth pointing out that this patch leaves that power domain enabled
for for as long as prepare_count is greater than zero.

However the rate-change operations only use the pm_runtime functions to
program the hardware and modify the registers. At the end of each
rate-change call there is a pm_runtime_put. This makes sense to me, but
I?m trying to wrap my head around the fact that this patch introduces
two behaviors:

1) protect access to the clk hardware by wrapping writes across the bus
with pm_runtime calls
2) power the clock logic when the clock is in use (e.g. clk_prepare())

Everything about this patch *seems* correct to me, but I?m trying to
figure out what it means to for a clock consumer driver to do something
like this:

clk_prepare_enable()
clk_disable_unprepare()
clk_set_rate()

Maybe patches #2-5 will help me understand, but I wanted to jot this
down in my review before I forget.

> @@ -2583,6 +2673,12 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>                 goto fail_name;
>         }
>         core->ops = hw->init->ops;
> +       if (dev && pm_runtime_enabled(dev)) {
> +               core->dev = dev;
> +               ret = clk_pm_runtime_get(core);
> +               if (ret)
> +                       goto fail_pm;
> +       }
>         if (dev && dev->driver)
>                 core->owner = dev->driver->owner;
>         core->hw = hw;
> @@ -2629,12 +2725,13 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>         }
>  
>         ret = __clk_core_init(core);
> -       if (!ret)
> +       if (!ret) {
> +               clk_pm_runtime_put(core);
>                 return hw->clk;
> +       }

I wonder if the above can be moved inside of __clk_core_init?
clk_register shouldn't manage any clk_ops directly, only __clk_core_init
does this.

Regards,
Mike
