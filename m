From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 19 Nov 2018 12:53:46 +0000
Subject: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <20181119104603.qzuvpoha622l4xvy@pengutronix.de>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
 <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
 <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
 <TY1PR01MB17697C2C8BCE98009EBDECF7F5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181119104603.qzuvpoha622l4xvy@pengutronix.de>
Message-ID: <TY1PR01MB17695E8ED56BBC03AAA7FD8FF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 19 November 2018 10:46 Uwe Kleine-K?nig wrote:
> On Mon, Nov 19, 2018 at 10:41:42AM +0000, Phil Edworthy wrote:
> > On 16 November 2018 16:11 Uwe Kleine-K?nig wrote:
> > > On Fri, Nov 16, 2018 at 05:01:28PM +0100, Uwe Kleine-K?nig wrote:
> > > > Other than that I think the patch is fine
> > >
> > > Thinking again, I wonder why not just do:
> > >
> > > static inline struct clk *clk_get_optional(struct device *dev, const char
> *id) {
> > > 	struct clk *c = clk_get(dev, id);
> > >
> > > 	if (c == ERR_PTR(-ENOENT))
> > > 		return NULL;
> > > 	else
> > > 		return c;
> > > }
> >
> > Unfortunately, underneath this __of_clk_get_by_name() returns -EINVAL
> > when looking for a named clock, and the "clock-names" OF property
> > can't be found or the name is not in that prop. This is because the
> > index returned by of_property_match_string() will be an error code and
> > is then currently always passed to __of_clk_get().
> >
> > If, as you said, I split the patches into one that fixes the error
> > code, and then adds clk_get_optional() like above, it will make more sense.
> 
> Sounds like a good plan.
Now that I have removed of_clk_get_by_name_optional(), I see that clk_get()
deals with __of_clk_get_by_name() returning -EINVAL and -ENOENT the same
way. In both cases, clk_get_sys() will return -ENOENT... i.e. I no longer need to
modify __of_clk_get_by_name().
All I need is a simple wrapper just as you have outlined above.

> > btw, do we need to add of_clk_get_by_name_optional()? I only added it
> > as a counterpart to of_clk_get_by_name(), but it may not be needed.
> 
> I don't need it. Given that it is easy to add when someone has a need, I'd say,
> skip it for now.
I'm wondering if we actually need clk_get_optional(). For me at least, I just
want devm_clk_get_optional(). That would get rid of the arch patches.

Thanks
Phil
