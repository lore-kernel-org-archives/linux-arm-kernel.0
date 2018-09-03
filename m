From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 3 Sep 2018 09:32:54 +0000
Subject: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
 <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
Message-ID: <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 01 September 2018 03:46, Stephen Boyd wrote:
> Quoting Phil Edworthy (2018-08-31 07:07:22)
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c index
> > 9ab3db8..4adb99e 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -54,30 +54,29 @@ EXPORT_SYMBOL(of_clk_get);
> >
> >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> >                                         const char *dev_id,
> > -                                       const char *name)
> > +                                       const char *name,
> > +                                       bool optional)
> >  {
> >         struct clk *clk = ERR_PTR(-ENOENT);
> > +       struct device_node *child = np;
> > +       int index = 0;
> >
> >         /* Walk up the tree of devices looking for a clock that matches */
> >         while (np) {
> > -               int index = 0;
> >
> >                 /*
> >                  * For named clocks, first look up the name in the
> >                  * "clock-names" property.  If it cannot be found, then
> > -                * index will be an error code, and of_clk_get() will fail.
> > +                * index will be an error code.
> >                  */
> >                 if (name)
> >                         index = of_property_match_string(np, "clock-names", name);
> > -               clk = __of_clk_get(np, index, dev_id, name);
> > -               if (!IS_ERR(clk)) {
> > -                       break;
> > -               } else if (name && index >= 0) {
> > -                       if (PTR_ERR(clk) != -EPROBE_DEFER)
> > -                               pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> > -                                       np, name ? name : "", index);
> > +               if (index >= 0)
> > +                       clk = __of_clk_get(np, index, dev_id, name);
> > +               if (!IS_ERR(clk))
> 
> Was this change necessary? It looks like we can leave it all alone and keep
> passing a negative number to __of_clk_get() and have that return an error
> pointer which we then return immediately as an error. But, if the clock is
> optional and we've passed a name here, shouldn't we treat an error from
> of_property_match_string() as success too? This is all looking pretty fragile so
> maybe it can be better commented and also more explicit instead of relying
> on the reader to jump through all the function calls to figure out what the
> return value is in some cases.
If we call __of_clk_get, with index < 0, we will not be able to differentiate
between clock provider not present and other errors with the passed data,
as it will just return -EINVAL.

of_property_match_string() will return -EINVAL if the "clock-names" property
is missing, or -ENODATA if the specified clock name in the "clock-names"
property is missing. That is why I have changed the code to conditionally
call __of_clk_get, so the code will correctly treat optional clocks that are not
present.


> >                         return clk;
> > -               }
> > +               if (name && index >= 0)
> > +                       break;
> 
> And this causes us to duplicate logic down below because we have to check it
> again if it's not optional or some other error condition?
Yes, the error handling is messy, though I have tried to make this simple.
I'll have a think about some other way to make this cleaner.


> >
> >                 /*
> >                  * No matching clock found on this node.  If the
> > parent node @@ -89,6 +88,16 @@ static struct clk
> *__of_clk_get_by_name(struct device_node *np,
> >                         break;
> >         }
> >
> > +       /* The clock is not valid, but it could be optional or deferred */
> > +       if (optional && PTR_ERR(clk) == -ENOENT) {
> > +               clk = NULL;
> > +               pr_info("no optional clock %pOF:%s\n", child,
> > +                       name ? name : "");
> 
> Is this intentionally pr_info?
Yes, it's not an error if an optional clock isn?t there.
Would pr_debug be more appropriate?


> > +       } else if (name && index >= 0 && PTR_ERR(clk) != -EPROBE_DEFER) {
> > +               pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> > +                       child, name, index);
> > +       }
> > +
> >         return clk;
> >  }
> >

Thanks
Phil
