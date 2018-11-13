From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 13 Nov 2018 11:44:50 -0800
Subject: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <TY1PR01MB1769B2978D73DBC2EADC6B8DF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
 <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB1769B2978D73DBC2EADC6B8DF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <154213829039.88331.14286655280073748584@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Phil Edworthy (2018-09-03 06:21:02)
> Hi Stephen,
> 
> On 03 September 2018 10:33 Phil Edworthy wrote:
> > On 01 September 2018 03:46, Stephen Boyd wrote:
> > > Quoting Phil Edworthy (2018-08-31 07:07:22)
> > > > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c index
> > > > 9ab3db8..4adb99e 100644
> > > > --- a/drivers/clk/clkdev.c
> > > > +++ b/drivers/clk/clkdev.c
> > > > @@ -54,30 +54,29 @@ EXPORT_SYMBOL(of_clk_get);
> > > >
> > > >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> > > >                                         const char *dev_id,
> > > > -                                       const char *name)
> > > > +                                       const char *name,
> > > > +                                       bool optional)
> > > >  {
> > > >         struct clk *clk = ERR_PTR(-ENOENT);
> > > > +       struct device_node *child = np;
> > > > +       int index = 0;
> > > >
> > > >         /* Walk up the tree of devices looking for a clock that matches */
> > > >         while (np) {
> > > > -               int index = 0;
> > > >
> > > >                 /*
> > > >                  * For named clocks, first look up the name in the
> > > >                  * "clock-names" property.  If it cannot be found, then
> > > > -                * index will be an error code, and of_clk_get() will fail.
> > > > +                * index will be an error code.
> > > >                  */
> > > >                 if (name)
> > > >                         index = of_property_match_string(np, "clock-names",
> > name);
> > > > -               clk = __of_clk_get(np, index, dev_id, name);
> > > > -               if (!IS_ERR(clk)) {
> > > > -                       break;
> > > > -               } else if (name && index >= 0) {
> > > > -                       if (PTR_ERR(clk) != -EPROBE_DEFER)
> > > > -                               pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> > > > -                                       np, name ? name : "", index);
> > > > +               if (index >= 0)
> > > > +                       clk = __of_clk_get(np, index, dev_id, name);
> > > > +               if (!IS_ERR(clk))
> > >
> > > Was this change necessary? It looks like we can leave it all alone and keep
> > > passing a negative number to __of_clk_get() and have that return an error
> > > pointer which we then return immediately as an error. But, if the clock is
> > > optional and we've passed a name here, shouldn't we treat an error from
> > > of_property_match_string() as success too? This is all looking pretty fragile
> > so
> > > maybe it can be better commented and also more explicit instead of relying
> > > on the reader to jump through all the function calls to figure out what the
> > > return value is in some cases.
> > If we call __of_clk_get, with index < 0, we will not be able to differentiate
> > between clock provider not present and other errors with the passed data,
> > as it will just return -EINVAL.
> > 
> > of_property_match_string() will return -EINVAL if the "clock-names"
> > property
> > is missing, or -ENODATA if the specified clock name in the "clock-names"
> > property is missing. That is why I have changed the code to conditionally
> > call __of_clk_get, so the code will correctly treat optional clocks that are not
> > present.
> When getting named optional clocks, if the node has a "clock-names" property,
> but no clock matching the name we want, I think the function should stop there
> and *not* walk up the tree of devices looking for a matching clock. In this case,
> the code determines that the optional clock is not present.
> 
> If there isn?t a "clock-names" property in the current node, the function should
> walk up the tree of devices looking for a matching optional clock. If there are no
> parent nodes left and we haven't found a matching optional clock, we determine
> that the clock isn?t there.
> 
> Is that how this should work?
> 

Yes that sounds right.
