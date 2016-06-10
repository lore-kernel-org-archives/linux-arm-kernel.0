From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 11:50:31 +0200
Subject: [PATCH 04/20] clk: sunxi: display: Add per-clock flags
In-Reply-To: <CAGb2v66-GzV=1wrJnHBObLVPVHPk87o0PaJtNyYasp2wFsZabw@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-5-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66-GzV=1wrJnHBObLVPVHPk87o0PaJtNyYasp2wFsZabw@mail.gmail.com>
Message-ID: <20160610095031.GT5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 11:21:41PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The TCON channel 0 clock that is the parent clock of our pixel clock is
> > expected to change its rate depending on the resolution we want to output
> > in our display engine.
> >
> > However, since it's only a mux, the only way it can do that is by changing
> > its parents rate.
> >
> > Allow to give flags in our display clocks description, and add the
> > CLK_SET_RATE_PARENT flag for the TCON channel 0 flag.
> >
> > Fixes: a3b4956ee6d9 ("clk: sunxi: display: Add per-clock flags")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/clk-sun4i-display.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
> > index 445a7498d6df..9780fac6d029 100644
> > --- a/drivers/clk/sunxi/clk-sun4i-display.c
> > +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> > @@ -33,6 +33,8 @@ struct sun4i_a10_display_clk_data {
> >
> >         u8      width_div;
> >         u8      width_mux;
> > +
> 
> Don't really need this separator, but I'm ok either way.
> 
> > +       u32     flags;
> >  };
> >
> >  struct reset_data {
> > @@ -166,7 +168,7 @@ static void __init sun4i_a10_display_init(struct device_node *node,
> >                                      data->has_div ? &div->hw : NULL,
> >                                      data->has_div ? &clk_divider_ops : NULL,
> >                                      &gate->hw, &clk_gate_ops,
> > -                                    0);
> > +                                    data->flags);
> >         if (IS_ERR(clk)) {
> >                 pr_err("%s: Couldn't register the clock\n", clk_name);
> >                 goto free_div;
> > @@ -232,6 +234,7 @@ static const struct sun4i_a10_display_clk_data sun4i_a10_tcon_ch0_data __initcon
> >         .offset_rst     = 29,
> >         .offset_mux     = 24,
> >         .width_mux      = 2,
> > +       .flags          = CLK_SET_RATE_PARENT,
> >  };
> >
> >  static void __init sun4i_a10_tcon_ch0_setup(struct device_node *node)
> > --
> > 2.8.2
> >
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied,

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/110039a6/attachment.sig>
