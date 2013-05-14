From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 May 2013 09:22:19 -0700
Subject: [PATCH 2/5] clk: hi3xxx: add clock support
In-Reply-To: <CAD6h2NRqR4Qzpj8x7XTZZ+T==yBf3rq_VooAXNO4HOHb74pGZQ@mail.gmail.com>
References: <1366368567-17322-1-git-send-email-haojian.zhuang@linaro.org>
 <1366368567-17322-2-git-send-email-haojian.zhuang@linaro.org>
 <20130513194703.10068.4450@quantum>
 <CAD6h2NRqR4Qzpj8x7XTZZ+T==yBf3rq_VooAXNO4HOHb74pGZQ@mail.gmail.com>
Message-ID: <20130514162219.10068.9483@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2013-05-13 18:30:38)
> On 14 May 2013 03:47, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Haojian Zhuang (2013-04-19 03:49:24)
> >> +struct hi3620_muxclk {
> >> +       struct clk_hw   hw;
> >> +       void __iomem    *reg;           /* mux register */
> >> +       u8              shift;
> >> +       u8              width;
> >> +       u32             mbits;          /* mask bits in mux register */
> >
> > You need shift, width AND a mask?  Normally either shift+width OR a mask
> > would suffice.
> 
> No, it's a little different. In their mux registers, there're two
> parts. One is lower
> 16 bits that are used to set mux, and the other is higher 16 bits that are
> used to set mux mask.
> 
> At here, I use mbits for higher 16 bits and shift & width for lower 16 bits.
> 

Ok, good to know.

<snip>

> >> +static struct clk_ops hi3620_clkgate_ops = {
> >> +       .prepare        = hi3620_clkgate_prepare,
> >> +       .enable         = hi3620_clkgate_enable,
> >> +       .disable        = hi3620_clkgate_disable,
> >
> > .unprepare?
> 
> I didn't implement unprepare at here. Since I find some device controller
> as uart not working if I disable clocks in unprepare(). Now I leave it as
> unimplemented.
> 

Sounds like the UART driver needs to be fixed.  Do you have plans to
look into that further?  Having only the prepare and not the unprepare
callback feels like a hack to me.

<snip>

> >> +static void __init hs_clkgate_setup(struct device_node *np)
> >> +{
> >> +       struct clk *clk;
> >> +       const char *clk_name, **parent_names, *name;
> >> +       unsigned long flags = 0;
> >> +       u32 data[2];
> >> +
> >> +       hs_init_clocks();
> >> +       if (!hs_clk.sctrl)
> >> +               return;
> >> +       if (of_property_read_string(np, "clock-output-names", &clk_name))
> >> +               return;
> >> +       if (of_property_read_u32_array(np, "hisilicon,clkgate",
> >> +                                      &data[0], 2))
> >> +               return;
> >> +       if (of_property_read_bool(np, "hisilicon,clkgate-inverted"))
> >> +               flags = CLK_GATE_SET_TO_DISABLE;
> >> +       /* gate only has the fixed parent */
> >> +       parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> >> +       if (!parent_names)
> >> +               return;
> >> +       parent_names[0] = of_clk_get_parent_name(np, 0);
> >> +
> >> +       clk = clk_register_gate(NULL, clk_name, parent_names[0], 0,
> >> +                               hs_clk.sctrl + data[0], (u8)data[1], flags,
> >> +                               &hs_clk.lock);
> >> +       if (IS_ERR(clk))
> >> +               goto err;
> >> +       if (!of_property_read_string(np, "clock-names", &name))
> >> +               clk_register_clkdev(clk, name, NULL);
> >> +       of_clk_add_provider(np, of_clk_src_simple_get, clk);
> >> +       return;
> >> +err:
> >> +       kfree(parent_names);
> >> +}
> >
> > I'm working on clock bindings for the generic clock types, so hopefully
> > this can be replaced by those instead of using your own compatible
> > string to wrap around clk_register_gate.
> 
> It's great. Could you cc me when you send patches out?
> 

Yes I will Cc you.  I'll publish a gate-clock binding either this week
or next.  Do you want to wait for that and refactor your next version
based on it?

<snip>

> > This looks like it was copy/pasted from the generic clk-divider type.
> > Is there some reason you cannot use that instead of duplicating all of
> > that code here?
> 
> Yes, it's a copy. The registers are not wrapped in their silicon. In most
> vendor's SoC, the registers are read/write.
> 
> But they links the read/write to different registers. So one clock divider
> register is split into four registers, and they're set, unset, status & final
> status.
> 
> And the other reason is that they use higher 16 bits as mask bits. So
> they're not compatible with other vendor's SoC. Of course, I can also
> use generic clk-divider/clk-mux type, but I need to change a lot in
> common files, such as abstracting read/write. Is it OK for you?
> 

Ok, thanks for explaining that.  The purpose of the basic clock types
(like clk_divider) is to provide common code for platforms that use a
common programming model for their clock controls.  If you think that
you'll have other platforms with similar 4-register dividers then it
may be worth your time to try to abstract it.  However since no other
platforms have this sort of requirement it does not qualify as being
"common".  The choice is yours if you want to give it a shot.  If the
changes are very invasive and ugly for the common divider type (such as
modifying the existing registration function for all users) then I won't
take it.

An alternative might be to create a "superset" clock using the basic
divider.  An example of this is the i.MX divider which uses a "busy
bit".  See here: arch/arm/mach-imx/clk-busy.c

I think you're programming model may be to different to use that, I'm
not sure, but the idea is to reuse the code and just wrap the basic
clock type with your specific clock requirements.

Regards,
Mike

> Regards
> Haojian
> 
> >
> > Thanks,
> > Mike
> >
> >> +CLK_OF_DECLARE(hi3620_mux, "hisilicon,hi3620-clk-mux", hi3620_clkmux_setup)
> >> +CLK_OF_DECLARE(hi3620_gate, "hisilicon,hi3620-clk-gate", hi3620_clkgate_setup)
> >> +CLK_OF_DECLARE(hi3620_div, "hisilicon,hi3620-clk-div", hi3620_clkdiv_setup)
> >> +CLK_OF_DECLARE(hs_gate, "hisilicon,clk-gate", hs_clkgate_setup)
> >> +CLK_OF_DECLARE(hs_fixed, "hisilicon,clk-fixed-factor", hs_fixed_factor_setup)
> >> --
> >> 1.7.10.4
