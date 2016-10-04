From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Oct 2016 10:28:18 +0800
Subject: [PATCH 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <8b72a134d957afdee6de48ec2c1891d8bba1b9e3.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <8b72a134d957afdee6de48ec2c1891d8bba1b9e3.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v654vv3B-OhHPgdLjsEOf0zPP=Ky1_+o=8mf9dZHMFjR-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Even though the our binding had the assumption that the allwinner,pull and
> allwinner,drive properties were optional, the code never took that into
> account.
>
> Fix that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 50 +++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 6f6f1e0011e2..cec977fcf98c 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -218,20 +218,29 @@ static unsigned long *sunxi_pctrl_build_pin_config(struct device_node *node,
>  {
>         unsigned long *pinconfig;
>         unsigned int configlen = 0, idx = 0;
> +       int ret;
>
>         if (sunxi_pctrl_has_drive_prop(node))
>                 configlen++;
>         if (sunxi_pctrl_has_bias_prop(node))
>                 configlen++;
>
> +       /*
> +        * If we don't have any configuration, bail out
> +        */
> +       if (!configlen)
> +               return NULL;
> +
>         pinconfig = kzalloc(configlen * sizeof(*pinconfig), GFP_KERNEL);
>         if (!pinconfig)
> -               return NULL;
> +               return ERR_PTR(-ENOMEM);
>
>         if (sunxi_pctrl_has_drive_prop(node)) {
>                 int drive = sunxi_pctrl_parse_drive_prop(node);
> -               if (drive < 0)
> +               if (drive < 0) {
> +                       ret = -EINVAL;

Why not just pass the error code returned from the parse function?

>                         goto err_free;
> +               }
>
>                 pinconfig[idx++] = pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
>                                                           drive);
> @@ -239,8 +248,10 @@ static unsigned long *sunxi_pctrl_build_pin_config(struct device_node *node,
>
>         if (sunxi_pctrl_has_bias_prop(node)) {
>                 int pull = sunxi_pctrl_parse_bias_prop(node);
> -               if (pull < 0)
> +               if (pull < 0) {
> +                       ret = -EINVAL;

Same here.

>                         goto err_free;
> +               }
>
>                 pinconfig[idx++] = pinconf_to_config_packed(pull, 0);
>         }
> @@ -251,7 +262,7 @@ static unsigned long *sunxi_pctrl_build_pin_config(struct device_node *node,
>
>  err_free:
>         kfree(pinconfig);
> -       return NULL;
> +       return ERR_PTR(ret);
>  }
>
>  static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
> @@ -285,7 +296,10 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>
>         /*
>          * We have two maps for each pin: one for the function, one
> -        * for the configuration (bias, strength, etc)
> +        * for the configuration (bias, strength, etc).
> +        *
> +        * We might be slightly overshooting, since we might not have
> +        * any configuration.
>          */
>         nmaps = npins * 2;
>         *map = kmalloc(nmaps * sizeof(struct pinctrl_map), GFP_KERNEL);
> @@ -293,8 +307,8 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>                 return -ENOMEM;
>
>         pinconfig = sunxi_pctrl_build_pin_config(node, &configlen);
> -       if (!pinconfig) {
> -               ret = -EINVAL;
> +       if (IS_ERR(pinconfig)) {
> +               ret = PTR_ERR(pinconfig);
>                 goto err_free_map;
>         }
>
> @@ -321,15 +335,16 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>
>                 i++;
>
> -               (*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> -               (*map)[i].data.configs.group_or_pin = group;
> -               (*map)[i].data.configs.configs = pinconfig;
> -               (*map)[i].data.configs.num_configs = configlen;
> -
> -               i++;
> +               if (pinconfig) {
> +                       (*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> +                       (*map)[i].data.configs.group_or_pin = group;
> +                       (*map)[i].data.configs.configs = pinconfig;
> +                       (*map)[i].data.configs.num_configs = configlen;
> +                       i++;
> +               }
>         }
>
> -       *num_maps = nmaps;
> +       *num_maps = i;

Thought: should we do a krealloc to shrink the array?

>
>         return 0;
>
> @@ -342,8 +357,13 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
>                                     struct pinctrl_map *map,
>                                     unsigned num_maps)
>  {
> +       unsigned long *pinconfig;
> +
>         /* All the maps have the same pin config, free only the first one */
> -       kfree(map[0].data.configs.configs);
> +       pinconfig = map[0].data.configs.configs;
> +       if (pinconfig)
> +               kfree(pinconfig);

Passing NULL to kfree is allowed. (It becomes a no-op.)
So you could leave this function alone.

ChenYu

> +
>         kfree(map);
>  }
>
> --
> git-series 0.8.10
