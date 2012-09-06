From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 06 Sep 2012 15:11:55 -0700
Subject: [PATCH v2 1/4] clk: add of_clk_src_onecell_get() support
In-Reply-To: <20120831064125.GA3271@r65073-Latitude-D630>
References: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
 <1345642590-29905-2-git-send-email-shawn.guo@linaro.org>
 <20120831064125.GA3271@r65073-Latitude-D630>
Message-ID: <20120906221155.20289.73650@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2012-08-30 23:41:27)
> Ping, Mike.
> 

Hi Shawn,

Do you want me to take everything including patch #2?  I'm OK with the
series but want to make sure it won't cause too much problem for you if
the DTS and arch/arm changes go through my tree.

Regards,
Mike

> Regards,
> Shawn
> 
> On Wed, Aug 22, 2012 at 09:36:27PM +0800, Shawn Guo wrote:
> > For those SoCs that have hundreds of clock outputs, their clock
> > DT bindings could reasonably define #clock-cells as 1 and require
> > the client device specify the index of the clock it consumes in the
> > cell of its "clocks" phandle.
> > 
> > Add a generic of_clk_src_onecell_get() function for this purpose.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/clk/clk.c            |   14 ++++++++++++++
> >  include/linux/clk-provider.h |    5 +++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index efdfd00..308f058 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1582,6 +1582,20 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
> >  }
> >  EXPORT_SYMBOL_GPL(of_clk_src_simple_get);
> >  
> > +struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
> > +{
> > +     struct clk_onecell_data *clk_data = data;
> > +     unsigned int idx = clkspec->args[0];
> > +
> > +     if (idx >= clk_data->clk_num) {
> > +             pr_err("%s: invalid clock index %d\n", __func__, idx);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     return clk_data->clks[idx];
> > +}
> > +EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
> > +
> >  /**
> >   * of_clk_add_provider() - Register a clock provider for a node
> >   * @np: Device node pointer associated with clock provider
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 77335fa..8fe6ec7 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -360,6 +360,11 @@ int of_clk_add_provider(struct device_node *np,
> >  void of_clk_del_provider(struct device_node *np);
> >  struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
> >                                 void *data);
> > +struct clk_onecell_data {
> > +     struct clk **clks;
> > +     unsigned int clk_num;
> > +};
> > +struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
> >  const char *of_clk_get_parent_name(struct device_node *np, int index);
> >  void of_clk_init(const struct of_device_id *matches);
> >  
> > -- 
> > 1.7.5.4
> >
