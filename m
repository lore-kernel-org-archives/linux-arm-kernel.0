From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 15:47:03 +0800
Subject: [PATCH v2 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <d707c657502b87a7f8e70c7b44492bc95939f9f6.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <d707c657502b87a7f8e70c7b44492bc95939f9f6.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64gBi71W=+Tu2vz94xFDtuRNHUyVWK3ken8CSOWvK5t0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 11:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Even though the our binding had the assumption that the allwinner,pull and
> allwinner,drive properties were optional, the code never took that into
> account.
>
> Fix that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 53 ++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 6f6f1e0011e2..2ee8d48ed5d3 100644
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
> +                       ret = drive;
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
> +                       ret = pull;
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
> @@ -321,15 +335,24 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
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
> +
> +       /*
> +        * We know have the number of maps we need, we can resize our
> +        * map array
> +        */
> +       *map = krealloc(*map, i * sizeof(struct pinctrl_map), GFP_KERNEL);
> +       if (!map)
> +               return -ENOMEM;
>
>         return 0;
>
> @@ -342,6 +365,8 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
>                                     struct pinctrl_map *map,
>                                     unsigned num_maps)
>  {
> +       unsigned long *pinconfig;

This looks out of place and context?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +
>         /* All the maps have the same pin config, free only the first one */
>         kfree(map[0].data.configs.configs);
>         kfree(map);
> --
> git-series 0.8.10
