From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:20:14 +0100
Subject: [PATCH 03/10] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <CAGb2v66kWnGh1t6wCjH1_uiWr0Px_O7x_camWSGhkGw2DzHc2A@mail.gmail.com>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-4-git-send-email-wens@csie.org>
 <20141206180144.GD12434@lukather>
 <CAGb2v66kWnGh1t6wCjH1_uiWr0Px_O7x_camWSGhkGw2DzHc2A@mail.gmail.com>
Message-ID: <20141207152014.GK12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 09:30:34AM +0800, Chen-Yu Tsai wrote:
> > Having the either clk_prepare_enable (or clk_enable if you're in
> > atomic context) in the assert/deassert seems more logical.
> 
> I'll try it out and see if it works. Didn't work so well with the
> USB clocks...

If it doesn't, it would be good to know why, it really should work.

> >> +     ret = reset_control_deassert(data->reset);
> >> +     if (ret) {
> >> +             dev_err(&pdev->dev, "Reset deassert err %d\n", ret);
> >> +             goto err_reset;
> >> +     }
> >> +
> >> +     for (i = 0; i < count; i++) {
> >> +             of_property_read_string_index(np, "clock-output-names",
> >> +                                           i, &clk_name);
> >> +
> >> +             clk_data->clks[i] = clk_register_gate(&pdev->dev, clk_name,
> >> +                                                   clk_parent, 0,
> >> +                                                   data->membase + SUN9I_MMC_WIDTH * i,
> >> +                                                   SUN9I_MMC_GATE_BIT, 0,
> >> +                                                   &data->lock);
> >> +
> >> +             if (IS_ERR(clk_data->clks[i])) {
> >> +                     ret = PTR_ERR(clk_data->clks[i]);
> >> +                     goto err_clk_register;
> >> +             }
> >> +     }
> >> +
> >> +     ret = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
> >> +     if (ret)
> >> +             goto err_clk_provider;
> >> +
> >> +     data->rcdev.owner = THIS_MODULE;
> >> +     data->rcdev.nr_resets = count;
> >> +     data->rcdev.ops = &sun9i_mmc_reset_ops;
> >> +     data->rcdev.of_node = pdev->dev.of_node;
> >> +
> >> +     ret = reset_controller_register(&data->rcdev);
> >> +     if (ret)
> >> +             goto err_rc_reg;
> >> +
> >> +     platform_set_drvdata(pdev, data);
> >> +
> >> +     return 0;
> >> +
> >> +err_rc_reg:
> >> +     of_clk_del_provider(np);
> >> +
> >> +err_clk_provider:
> >> +     for (i = 0; i < count; i++)
> >> +             clk_unregister(clk_data->clks[i]);
> >> +
> >> +err_clk_register:
> >> +     reset_control_assert(data->reset);
> >> +
> >> +err_reset:
> >> +     clk_disable_unprepare(data->clk);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int sun9i_a80_mmc_clk_remove(struct platform_device *pdev)
> >> +{
> >> +     struct device_node *np = pdev->dev.of_node;
> >> +     struct sun9i_mmc_clk_data *data = platform_get_drvdata(pdev);
> >> +     struct clk_onecell_data *clk_data = &data->clk_data;
> >> +     int i;
> >> +
> >> +     reset_controller_unregister(&data->rcdev);
> >> +     of_clk_del_provider(np);
> >> +     for (i = 0; i < clk_data->clk_num; i++)
> >> +             clk_unregister(clk_data->clks[i]);
> >> +
> >> +     reset_control_assert(data->reset);
> >> +     clk_disable_unprepare(data->clk);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct of_device_id sun9i_a80_mmc_clk_dt_ids[] = {
> >> +     { .compatible = "allwinner,sun9i-a80-mmc-clk" },
> >> +     { /* sentinel */ }
> >> +};
> >> +
> >> +static struct platform_driver sun9i_a80_mmc_clk_driver = {
> >> +     .driver = {
> >> +             .name = "sun9i-a80-mmc-clk",
> >> +             .of_match_table = sun9i_a80_mmc_clk_dt_ids,
> >> +     },
> >> +     .probe = sun9i_a80_mmc_clk_probe,
> >> +     .remove = sun9i_a80_mmc_clk_remove,
> >> +};
> >> +module_platform_driver(sun9i_a80_mmc_clk_driver);
> >> +
> >> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> >> +MODULE_DESCRIPTION("Allwinner A80 MMC clock/reset Driver");
> >> +MODULE_LICENSE("GPL v2");
> >
> > What's the real benefit of enabling it as a platform driver? the reset
> > framework is set up early enough that you can use OF_CLK_DECLARE.
> 
> This clock/reset block also requires a reset control de-asserted. The
> reset controllers are currently setup using platform devices. Are you
> suggesting I use "allwinner,sun6i-a31-ahb1-reset" instead? That would
> also imply having a .init_time callback for sun9i, and having
> sun6i_reset_init() before of_clk_init(). Kind of confusing (not sure
> this is the right word) for something not so critical.
> 
> Also we get to use devres, but that's just a bonus.

Ok, it makes sense then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/5602c9fc/attachment.sig>
