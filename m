From: dianders@chromium.org (Doug Anderson)
Date: Mon, 23 May 2016 13:46:00 -0700
Subject: [PATCH 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <1464015539-19521-3-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
 <1464015539-19521-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=VbrhpyQ8Y+5qnYHmkSvq12im2tZtpgnryGeEdc7mci9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Mon, May 23, 2016 at 7:58 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> +struct rockchip_grf_info {
> +       const struct rockchip_grf_value *values;
> +       int num_values;
> +};
> +
> +#define RK3036_GRF_SOC_CON0            0x140
> +
> +static const struct rockchip_grf_value rk3036_defaults[] = {

Worth saving the little bit of space by marking several of these
structures as __initconst ?


> +#define RK3399_GRF_SOC_CON7            0xe21c
> +
> +static const struct rockchip_grf_value rk3399_defaults[] = {
> +       { "jtag switching", RK3399_GRF_SOC_CON7, HIWORD_UPDATE(0, 1, 12) },
> +
> +};

nit: extra blank line in rk3399_defaults?


> +static int rockchip_grf_probe(struct platform_device *pdev)
> +{
> +       const struct rockchip_grf_info *grf_info;
> +       const struct of_device_id *match;
> +       struct device *dev = &pdev->dev;
> +       struct regmap *grf;
> +       int i;
> +
> +       if (!dev->of_node)
> +               return -ENODEV;
> +
> +       match = of_match_device(rockchip_grf_dt_match, dev);
> +       if (!match || !match->data) {
> +               dev_err(dev, "missing grf data\n");
> +               return -EINVAL;
> +       }
> +
> +       grf_info = match->data;
> +
> +       grf = syscon_node_to_regmap(dev->of_node);
> +       if (IS_ERR(grf)) {
> +               dev_err(dev, "rockchip: could not get grf syscon\n");
> +               return PTR_ERR(grf);
> +       }
> +
> +       for (i = 0; i < grf_info->num_values; i++) {
> +               const struct rockchip_grf_value *val = &grf_info->values[i];
> +
> +               dev_dbg(dev, "adjusting %s in 0x%x to 0x%x\n",

optional-nitty-nit saves a character: s/0x%x/%#x/

...or even force to 4 hex digits: %#6x

> +                       val->desc, val->reg, val->val);
> +               regmap_write(grf, val->reg, val->val);

Dunno if we care, but regmap_write() does return an error.  Presumably
it might return an error here if you somehow specified an offset that
was outside of the range for the GRF?


-Doug
