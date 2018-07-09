From: sboyd@kernel.org (Stephen Boyd)
Date: Sun, 08 Jul 2018 23:33:44 -0700
Subject: [PATCH] clk: clkdev - add managed versions of lookup registrations
In-Reply-To: <20180628075453.GA7793@localhost.localdomain>
References: <20180628075453.GA7793@localhost.localdomain>
Message-ID: <153111802456.143105.16373079820431081414@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Matti Vaittinen (2018-06-28 00:54:53)
> Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
> devm_clk_release_clkdev as a first styep to clean up drivers which are

s/styep/step/

> leaking clkdev lookups at driver remove.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
>  drivers/clk/clkdev.c   | 165 +++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/clkdev.h |   8 +++

Also need to update the Documentation file at
Documentation/driver-model/devres.txt

>  2 files changed, 147 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 7513411140b6..4752a0004a6c 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -390,7 +390,7 @@ void clkdev_drop(struct clk_lookup *cl)
>  }
>  EXPORT_SYMBOL(clkdev_drop);
>  
> -static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> +static struct clk_lookup *do_clk_register_clkdev(struct clk_hw *hw,

Don't rename this.

>                                                 const char *con_id,
>                                                 const char *dev_id, ...)
>  {
> @@ -404,6 +404,24 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
>         return cl;
>  }
>  
> +static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> +       const char *con_id, const char *dev_id)
> +{
> +       struct clk_lookup *cl;
> +
> +       /*
> +        * Since dev_id can be NULL, and NULL is handled specially, we must
> +        * pass it as either a NULL format string, or with "%s".
> +        */
> +       if (dev_id)
> +               cl = do_clk_register_clkdev(hw, con_id, "%s",
> +                                          dev_id);
> +       else
> +               cl = do_clk_register_clkdev(hw, con_id, NULL);
> +
> +       return cl;

I think this is the same code as before? Try to minimize the diff so we
can focus on what's really changing.

> +}
> +
>  /**
>   * clk_register_clkdev - register one clock lookup for a struct clk
>   * @clk: struct clk to associate with all clk_lookups
[...]
> +
> +/**
> + * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
> + * @dev: device this lookup is bound
> + * @hw: struct clk_hw to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_id: format string describing device name
> + *
> + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> + * clkdev.
> + *
> + * To make things easier for mass registration, we detect error clk_hws
> + * from a previous clk_hw_register_*() call, and return the error code for
> + * those.  This is to permit this function to be called immediately
> + * after clk_hw_register_*().
> + */
> +int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
> +                               const char *con_id, const char *dev_id)
> +{
> +       struct clk_lookup **cl = NULL;

Don't assign to NULL to just overwrite it later.

>  
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);

Put another newline here.

> +       cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
> +       if (cl) {
> +               *cl = __clk_register_clkdev(hw, con_id, dev_id);

Why can't we just call clk_hw_register_clkdev()? Sure the IS_ERR()
chain is duplicated, but that can be left out of the devm version and
rely on the clk_hw_register_clkdev() to take care of it otherwise.


> +               if (*cl)
> +                       devres_add(dev, cl);
> +               else
> +                       devres_free(cl);
> +       }
> +       return (cl && *cl) ? 0 : -ENOMEM;
> +}
> +EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
>  
> -       /*
> -        * Since dev_id can be NULL, and NULL is handled specially, we must
> -        * pass it as either a NULL format string, or with "%s".
> -        */
> -       if (dev_id)
> -               cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
> -       else
> -               cl = __clk_register_clkdev(hw, con_id, NULL);
> -
> -       return cl ? 0 : -ENOMEM;
> +/**
> + * devm_clk_register_clkdev - managed clk lookup registration for a struct clk
> + * @dev: device this lookup is bound
> + * @clk: struct clk to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_id: string describing device name
> + *
> + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> + * clkdev.
> + *
> + * To make things easier for mass registration, we detect error clks
> + * from a previous clk_register() call, and return the error code for
> + * those.  This is to permit this function to be called immediately
> + * after clk_register().
> + */
> +int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
> +                            const char *con_id, const char *dev_id)

I wouldn't even add this function, to encourage driver writers to
migrate to clk_hw based registration functions and to avoid removing it
later on.

> +{
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       return devm_clk_hw_register_clkdev(dev, __clk_get_hw(clk), con_id,
> +                                          dev_id);
>  }
> -EXPORT_SYMBOL(clk_hw_register_clkdev);
> +EXPORT_SYMBOL(devm_clk_register_clkdev);
> diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
> index 4890ff033220..27ebeae8ae26 100644
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -52,4 +52,12 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
>  int clk_register_clkdev(struct clk *, const char *, const char *);
>  int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
>  
> +int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
> +                            const char *con_id, const char *dev_id);
> +int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
> +                               const char *con_id, const char *dev_id);
> +void devm_clk_release_clkdev(struct device *dev, const char *con_id,
> +                            const char *dev_id);
> +
> +
>  #endif
