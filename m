From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 31 Oct 2013 11:22:33 -0700
Subject: [PATCH] clk: Do not dereference potential NULL pointer
In-Reply-To: <1383221036-26890-1-git-send-email-treding@nvidia.com>
References: <1383221036-26890-1-git-send-email-treding@nvidia.com>
Message-ID: <20131031182233.11662.77737@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thierry Reding (2013-10-31 05:03:56)
> A NULL pointer may be passed to _clk_register() for the dev parameter
> (via clk_register()). Make sure not to dereference it before checking
> that it's valid.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Hi Thierry,

I saw Olof's fix first so I took that and applied your Ack.

Regards,
Mike

> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b68a999..c0b52e3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1976,7 +1976,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
>                 hw->regmap = hw->init->regmap;
>         else if (dev && dev_get_regmap(dev, NULL))
>                 hw->regmap = dev_get_regmap(dev, NULL);
> -       else if (dev->parent)
> +       else if (dev && dev->parent)
>                 hw->regmap = dev_get_regmap(dev->parent, NULL);
>  
>         /* allocate local copy in case parent_names is __initdata */
> -- 
> 1.8.4
