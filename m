From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 09:25:13 +0000
Subject: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
 <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
Message-ID: <TY1PR01MB17696DB07249128850A58572F52F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 30 July 2018 09:56, Geert Uytterhoeven wrote:
> On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy wrote:
> > Quite a few drivers get an optional clock, e.g. a clock required to
> > access peripheral's registers that is always enabled on some devices.
> >
> > This function behaves the same as of_clk_get_by_name() except that it
> > will return NULL instead of -ENOENT. This makes error checking for
> > users easier and allows clk_prepare_enable, etc to be called on the
> > returned reference without additional checks.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -54,7 +54,8 @@ EXPORT_SYMBOL(of_clk_get);
> >
> >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> >                                         const char *dev_id,
> > -                                       const char *name)
> > +                                       const char *name,
> > +                                       bool optional)
> >  {
> >         struct clk *clk = ERR_PTR(-ENOENT);
> >
> > @@ -73,6 +74,8 @@ static struct clk *__of_clk_get_by_name(struct
> device_node *np,
> >                 if (!IS_ERR(clk)) {
> >                         break;
> >                 } else if (name && index >= 0) {
> > +                       if (optional && PTR_ERR(clk) == -ENOENT)
> > +                               clk = NULL;
> 
> This only handles the "name && index >= 0" case.
> If that condition is never true, the loop will end, eventually, and the last value
> of clk will be returned. Hence there should be a similar check at the end of
> the function.
Oops, I was only considering named optional clocks, I'll fix this.

> >                         if (PTR_ERR(clk) != -EPROBE_DEFER)
> >                                 pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> >                                         np, name ? name : "", index);
> 
> Hence if not found, this will always print an error, even if the clock is
> optional?
Right.

> > @@ -106,15 +109,38 @@ struct clk *of_clk_get_by_name(struct
> device_node *np, const char *name)
> >         if (!np)
> >                 return ERR_PTR(-ENOENT);
> >
> > -       return __of_clk_get_by_name(np, np->full_name, name);
> > +       return __of_clk_get_by_name(np, np->full_name, name, false);
> >  }
> >  EXPORT_SYMBOL(of_clk_get_by_name);
> >
> > +/**
> > + * of_clk_get_by_name_optional() - Parse and lookup an optional clock
> > +referenced
> > + * by a device node
> > + * @np: pointer to clock consumer node
> > + * @name: name of consumer's clock input, or NULL for the first clock
> > +reference
> > + *
> > + * This function parses the clocks and clock-names properties,
> > + * and uses them to look up the struct clk from the registered list
> > +of clock
> > + * providers.
> > + * It behaves the same as of_clk_get_by_name(), except when no clock is
> found.
> > + * In this case, instead of returning -ENOENT, it returns NULL.
> > + */
> > +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> > +                                       const char *name) {
> > +       if (!np)
> > +               return ERR_PTR(-ENOENT);
> 
> Shouldn't this return NULL?
I wasn?t sure on this, I thought the node should be valid, but I guess the node
is also optional. I'll fix.

> Or let __of_clk_get_by_name() handle that (cfr. above)?

> Hmm, of_clk_get_by_name() has a similar check, while the current
> __of_clk_get_by_name() already handle np == NULL, too.
Yes I see, I'll clean that up.

 
> > +
> > +       return __of_clk_get_by_name(np, np->full_name, name, true); }
> > +EXPORT_SYMBOL(of_clk_get_by_name_optional);
> > +
> >  #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
> >
> >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> >                                         const char *dev_id,
> > -                                       const char *name)
> > +                                       const char *name,
> > +                                       bool optional)
> >  {
> >         return ERR_PTR(-ENOENT);
> >  }
> > @@ -197,7 +223,7 @@ struct clk *clk_get(struct device *dev, const char
> *con_id)
> >         struct clk *clk;
> >
> >         if (dev && dev->of_node) {
> > -               clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
> > +               clk = __of_clk_get_by_name(dev->of_node, dev_id,
> > + con_id, false);
> >                 if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
> >                         return clk;
> >         }
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > 4f750c4..8cb5455 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -777,6 +777,7 @@ static inline void clk_bulk_disable_unprepare(int
> > num_clks,  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> > struct clk *of_clk_get(struct device_node *np, int index);  struct clk
> > *of_clk_get_by_name(struct device_node *np, const char *name);
> > +struct clk *of_clk_get_by_name_optional(struct device_node *np, const
> > +char *name);
> >  struct clk *of_clk_get_from_provider(struct of_phandle_args
> > *clkspec);  #else  static inline struct clk *of_clk_get(struct
> > device_node *np, int index)
> 
> No dummy version of of_clk_get_by_name_optional() for the !CLK ||
> !COMMON_CLK case?
> 
> It seems of_clk_get_by_name() and of_clk_get_by_name_optional() can
> just be simple wrappers around __of_clk_get_by_name(), differing only in
> the value of the "optional" parameter. Hence I think it makes sense to move
> them to the header file, and make them static inline.
> Then only __of_clk_get_by_name() needs a (static inline) dummy for the
> !OF || !COMMON_CLK case.
Makes sense.

Thanks!
Phil
