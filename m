From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 08 Jan 2014 17:51:58 -0800
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140109015158.7168.60274@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-12-23 17:12:26)
> Add support to the clock core so that drivers can pass in a
> regmap. If no regmap is specified try to query the device that's
> registering the clock for its regmap. This should allow drivers
> to use the core regmap helpers. This is based on a similar design
> in the regulator framework.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/clk.c            | 8 ++++++++
>  include/linux/clk-provider.h | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9ad7b71..5e71f5c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -20,6 +20,7 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/sched.h>
> +#include <linux/regmap.h>
>  
>  static DEFINE_SPINLOCK(enable_lock);
>  static DEFINE_MUTEX(prepare_lock);
> @@ -1834,6 +1835,13 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
>         clk->num_parents = hw->init->num_parents;
>         hw->clk = clk;
>  
> +       if (hw->init->regmap)
> +               hw->regmap = hw->init->regmap;

Hi Stephen,

The whole series looks good to me except for the placement of the regmap
details inside struct clk_hw. That structure exists only to hide struct
clk from the hardware-specific clock structure and I'd not like to set
the precedent of shoving per-clock data into it.

As an alternative, how about finding a way to put these per-clock regmap
details into the hardware-specific clock structure? I understand that
you want to make these ops available to others, which is why they are in
the public struct clk_hw. I'm just wondering if that is the right way to
do it...

Patch #3 illustrates the sort of struct-member-creep that worries me.
What is to stop someone from putting "unsigned int divider_reg" or
"unsigned int mux_reg", and then the thing just keeps growing.

Regards,
Mike

> +       else if (dev && dev_get_regmap(dev, NULL))
> +               hw->regmap = dev_get_regmap(dev, NULL);
> +       else if (dev && dev->parent)
> +               hw->regmap = dev_get_regmap(dev->parent, NULL);
> +
>         /* allocate local copy in case parent_names is __initdata */
>         clk->parent_names = kcalloc(clk->num_parents, sizeof(char *),
>                                         GFP_KERNEL);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7e59253..31f2890 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -142,6 +142,8 @@ struct clk_ops {
>         void            (*init)(struct clk_hw *hw);
>  };
>  
> +struct regmap;
> +
>  /**
>   * struct clk_init_data - holds init data that's common to all clocks and is
>   * shared between the clock provider and the common clock framework.
> @@ -151,6 +153,7 @@ struct clk_ops {
>   * @parent_names: array of string names for all possible parents
>   * @num_parents: number of possible parents
>   * @flags: framework-level hints and quirks
> + * @regmap: regmap to use for regmap helpers and/or by providers
>   */
>  struct clk_init_data {
>         const char              *name;
> @@ -158,6 +161,7 @@ struct clk_init_data {
>         const char              **parent_names;
>         u8                      num_parents;
>         unsigned long           flags;
> +       struct regmap           *regmap;
>  };
>  
>  /**
> @@ -171,10 +175,13 @@ struct clk_init_data {
>   *
>   * @init: pointer to struct clk_init_data that contains the init data shared
>   * with the common clock framework.
> + *
> + * @regmap: regmap to use for regmap helpers and/or by providers
>   */
>  struct clk_hw {
>         struct clk *clk;
>         const struct clk_init_data *init;
> +       struct regmap *regmap;
>  };
>  
>  /*
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
