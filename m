From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 19 Jan 2015 09:22:54 -0800
Subject: [PATCH] ARM: clk: add clk-asm9260 driver
In-Reply-To: <54B78C3C.1080109@rempel-privat.de>
References: <1417187120-23659-1-git-send-email-linux@rempel-privat.de>
 <1420707567-22760-1-git-send-email-linux@rempel-privat.de>
 <1420707567-22760-2-git-send-email-linux@rempel-privat.de>
 <20150114230217.22722.88458@quantum> <54B78C3C.1080109@rempel-privat.de>
Message-ID: <20150119172254.22722.41782@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Oleksij Rempel (2015-01-15 01:45:32)
> Am 15.01.2015 um 00:02 schrieb Mike Turquette:
> > Quoting Oleksij Rempel (2015-01-08 00:59:27)
> >> diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
> >> new file mode 100644
> >> index 0000000..6b1c220
> >> --- /dev/null
> >> +++ b/drivers/clk/clk-asm9260.c
> > 
> > <snip>
> > 
> >> +static const char *clk_names[] = {
> >> +       [REFCLK]        = "oscillator",
> >> +       [SYSPLL]        = "pll",
> >> +       [I2S0_MCLK]     = "i2s0_mclk",
> >> +       [I2S1_MCLK]     = "i2s1_mclk",
> >> +       [RTC_OSC]       = "rtc_osc",
> >> +       [USB_PLL]       = "usb_pll",
> >> +};
> > 
> > Why keep this list of names? Only clk_names[REFCLK] is used below and it
> > is overwritten by the name supplied by DT.
> 
> Ok.
> 
> > <snip>
> > 
> >> +static void __init asm9260_acc_init(struct device_node *np)
> >> +{
> >> +       struct clk *clk;
> >> +       u32 rate;
> >> +       int n;
> >> +       u32 accuracy = 0;
> >> +
> >> +       base = of_io_request_and_map(np, 0, np->name);
> >> +       if (!base)
> >> +               panic("%s: unable to map resource", np->name);
> >> +
> >> +       /* register pll */
> >> +       rate = (ioread32(base + HW_SYSPLLCTRL) & 0xffff) * 1000000;
> >> +
> >> +       clk_names[REFCLK] = of_clk_get_parent_name(np, 0);
> >> +       accuracy = clk_get_accuracy(__clk_lookup(clk_names[REFCLK]));
> >> +       clk = clk_register_fixed_rate_with_accuracy(NULL, clk_names[SYSPLL],
> >> +                       clk_names[REFCLK], 0, rate, accuracy);
> > 
> > This is different. Why do the PLLs inherit REFCLKs accuracy? Please see
> > __clk_recalc_accuracies in drivers/clk/clk.c if you haven't already. We
> > propagate accuracy through the clock tree already.
> 
> clk_register_fixed_rate overwrite accuracy to 0. If i use
> clk_register_fixed_rate, then half of my clocks has accuracy = 0.

Ah, interesting. This is a bug that should be fixed. If a fixed-rate
clock has a parent with a non-zero accuracy then we should propagate
that accuracy value at registration-time. I'll look into this soon and
your solution is fine for now. We can always clean it up later.

> 
> >> +
> >> +       if (IS_ERR(clk))
> >> +               panic("%s: can't register REFCLK. Check DT!", np->name);
> >> +
> 
> <snip>
> 
> >> +
> >> +       /* register clk-provider */
> >> +       clk_data.clks = clks;
> >> +       clk_data.clk_num = MAX_CLKS;
> >> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> >> +       return;
> >> +fail:
> >> +       iounmap(base);
> >> +}
> >> +CLK_OF_DECLARE(asm9260_acc, "alphascale,asm9260-clock-controller",
> >> +               asm9260_acc_init);
> > 
> > Where is the DT binding definition for this clock provider?
> > 
> > Thanks,
> > Mike
> > 
> 
> do you mean this patch?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/293147.html
> (probably not last version)
> Should i resend it to you?

No need to resend. DT binding description looks fine (you can add my
Reviewed-by if it is not yet merged), but I like to make sure that the
code doesn't get merged before the binding definition.

Regards,
Mike

> 
> -- 
> Regards,
> Oleksij
> 
