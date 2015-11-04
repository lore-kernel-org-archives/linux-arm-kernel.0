From: dianders@chromium.org (Doug Anderson)
Date: Wed, 4 Nov 2015 15:53:44 -0800
Subject: [PATCH 3/8] phy: rockchip-usb: move per-phy init into a separate
 function
In-Reply-To: <1446673454-9529-4-git-send-email-heiko@sntech.de>
References: <1446673454-9529-1-git-send-email-heiko@sntech.de>
 <1446673454-9529-4-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=X02i7rQoV_QZf92VVwdf0i+fBPY8dP=TysfpWoDWimsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Nov 4, 2015 at 1:44 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>         for_each_available_child_of_node(dev->of_node, child) {
> -               rk_phy = devm_kzalloc(dev, sizeof(*rk_phy), GFP_KERNEL);
> -               if (!rk_phy)
> -                       return -ENOMEM;
> -
> -               if (of_property_read_u32(child, "reg", &reg_offset)) {
> -                       dev_err(dev, "missing reg property in node %s\n",
> -                               child->name);
> -                       return -EINVAL;
> -               }
> -
> -               rk_phy->reg_offset = reg_offset;
> -
> -               rk_phy->clk = of_clk_get_by_name(child, "phyclk");
> -               if (IS_ERR(rk_phy->clk))
> -                       rk_phy->clk = NULL;
> -
> -               err = devm_add_action(dev, rockchip_usb_phy_action, rk_phy);
> -               if (err) {
> -                       if (rk_phy->clk)
> -                               clk_put(rk_phy->clk);
> -                       return err;
> -               }
> -
> -               rk_phy->phy = devm_phy_create(dev, child, &ops);
> -               if (IS_ERR(rk_phy->phy)) {
> -                       dev_err(dev, "failed to create PHY\n");
> -                       return PTR_ERR(rk_phy->phy);
> -               }
> -               phy_set_drvdata(rk_phy->phy, rk_phy);
> -
> -               /* only power up usb phy when it use, so disable it when init*/
> -               err = rockchip_usb_phy_power(rk_phy, 1);
> -               if (err)
> +               err = rockchip_usb_phy_init(phy_base, child);
> +               if (err < 0)
>                         return err;

You've also included the minor unrelated tweak to check for erorrs
with "err < 0" rather than "err" that has the incredibly small chance
to affect behavior, making this not a 100% noop change.

I don't personally care that much since it's terribly unlikely to
affect anything.  ...but you get a 1-line better diffstat if you don't
change it and it's unlikely to matter much either way...

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
