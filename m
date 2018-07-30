From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Mon, 30 Jul 2018 15:55:51 +0300
Subject: [PATCH] clk: clkdev - add managed versions of lookup registrations
In-Reply-To: <153111802456.143105.16373079820431081414@swboyd.mtv.corp.google.com>
References: <20180628075453.GA7793@localhost.localdomain>
 <153111802456.143105.16373079820431081414@swboyd.mtv.corp.google.com>
Message-ID: <20180730125550.GD8862@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

Sorry for longish delay but the exceptionally great summer in Finland
has kept me away from computer... Now when I am back from my travels
it's time to focus on patches again =)

On Sun, Jul 08, 2018 at 11:33:44PM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-06-28 00:54:53)
> > Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
> > devm_clk_release_clkdev as a first styep to clean up drivers which are
> 
> s/styep/step/

Thanks.

> > leaking clkdev lookups at driver remove.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > 
> >  drivers/clk/clkdev.c   | 165 +++++++++++++++++++++++++++++++++++++++++--------
> >  include/linux/clkdev.h |   8 +++
> 
> Also need to update the Documentation file at
> Documentation/driver-model/devres.txt

Right. I'd better check that file then. Thanks for pointing it out.

> 
> >  2 files changed, 147 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > index 7513411140b6..4752a0004a6c 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -390,7 +390,7 @@ void clkdev_drop(struct clk_lookup *cl)
> >  }
> >  EXPORT_SYMBOL(clkdev_drop);
> >  
> > -static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> > +static struct clk_lookup *do_clk_register_clkdev(struct clk_hw *hw,
> 
> Don't rename this.
> 

I did rename this as I introduced new internal __clk_register_clkdev
(see below) - which is utilized by the clk_register_clkdev,
clk_hw_register_clkdev and devm_clk_hw_register_clkdev. This allowed
me to cut off some duplicated code from clk_register_clkdev and
clk_hw_register_clkdev.

(Mainly the:

	/*
	 * Since dev_id can be NULL, and NULL is handled specially, we must
	 * pass it as either a NULL format string, or with "%s".
	 */
if (dev_id) 
	... con_id, "%s", dev_id);
else
	... con_id, NULL);

parameter selection for old __clk_register_clkdev (which I renamed to
do_clk_register_clkdev).

So I tried to reduce code by deciding this only in the new wrapper
function __clk_register_clkdev. For me it was more obvioust that
__clk_register_clkdev would be next internal layer for clk_register_clkdev.
The old __clk_register_clkdev - which is now named as do_clk_register_clkdev
is the final layer doing lookup and registration.

> >                                                 const char *con_id,
> >                                                 const char *dev_id, ...)
> >  {
> > @@ -404,6 +404,24 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> >         return cl;
> >  }
> >  
> > +static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> > +       const char *con_id, const char *dev_id)
> > +{
> > +       struct clk_lookup *cl;
> > +
> > +       /*
> > +        * Since dev_id can be NULL, and NULL is handled specially, we must
> > +        * pass it as either a NULL format string, or with "%s".
> > +        */
> > +       if (dev_id)
> > +               cl = do_clk_register_clkdev(hw, con_id, "%s",
> > +                                          dev_id);
> > +       else
> > +               cl = do_clk_register_clkdev(hw, con_id, NULL);
> > +
> > +       return cl;
> 
> I think this is the same code as before? Try to minimize the diff so we
> can focus on what's really changing.
>

This is code that earlier was duiplicated in both the
clk_register_clkdev and clk_hw_register_clkdev. I cleaned the code
duplication by adding this new __clk_register_clkdev function.
 
> > +}
> > +
> >  /**
> >   * clk_register_clkdev - register one clock lookup for a struct clk
> >   * @clk: struct clk to associate with all clk_lookups
> [...]
> > +
> > +/**
> > + * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
> > + * @dev: device this lookup is bound
> > + * @hw: struct clk_hw to associate with all clk_lookups
> > + * @con_id: connection ID string on device
> > + * @dev_id: format string describing device name
> > + *
> > + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> > + * clkdev.
> > + *
> > + * To make things easier for mass registration, we detect error clk_hws
> > + * from a previous clk_hw_register_*() call, and return the error code for
> > + * those.  This is to permit this function to be called immediately
> > + * after clk_hw_register_*().
> > + */
> > +int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
> > +                               const char *con_id, const char *dev_id)
> > +{
> > +       struct clk_lookup **cl = NULL;
> 
> Don't assign to NULL to just overwrite it later.

Right.

> >  
> >         if (IS_ERR(hw))
> >                 return PTR_ERR(hw);
> 
> Put another newline here.
> 
Ok.

> > +       cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
> > +       if (cl) {
> > +               *cl = __clk_register_clkdev(hw, con_id, dev_id);
> 
> Why can't we just call clk_hw_register_clkdev()? Sure the IS_ERR()
> chain is duplicated, but that can be left out of the devm version and
> rely on the clk_hw_register_clkdev() to take care of it otherwise.
>
We could. But as I anyways introduced the new __clk_register_clkdev - in
order to slighly simplify clk_register_clkdev and clk_hw_register_clkdev
- it was convenient to not dublicate the IS_ERR chain and use the interal
__clk_register_clkdev -variant. And actually, I was not sure if it is
required to have some fast handling for the IS_ERR cases here and hence
I thought it should be checked before devres_alloc. But if there is no
need for priorizing this check - then I would remove IS_ERR checks from
devm_clk_hw_register_clkdev and clk_hw_register_clkdev and do it only in the
__clk_register_clkdev. Unfortunately we need to keep it in
clk_register_clkdev because this must be checked before we do
__clk_get_hw(clk). Anyways, that would further simplify this to something
like (untested, not even compiled code below which is only meant to explain
what I mean):

static int __clk_register_clkdev(struct clk_hw *hw, struct clk_lookup **cl,
				 const char *con_id, const char *dev_id)
{
	if (IS_ERR(hw))
		return PTR_ERR(hw);

	if (dev_id)
		*cl = do_clk_register_clkdev(hw, con_id, "%s",
                                           dev_id);
        else
                *cl = do_clk_register_clkdev(hw, con_id, NULL);

        return (*cl) ? 0 : -ENOMEM;


int clk_register_clkdev(struct clk *clk, const char *con_id,
        const char *dev_id)
{
	int rval;
	struct clk_lookup *cl;

	if (!IS_ERR(clk))
		return __clk_register_clkdev(__clk_get_hw(clk), &cl, con_id, dev_id);

	return PTR_ERR(clk);	
}

int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
        const char *dev_id)
{
	int rval;
	struct clk_lookup *cl;
	return __clk_register_clkdev(hw, con_id, &cl, dev_id);
}

int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
                                const char *con_id, const char *dev_id)
{
        struct clk_lookup **cl;
	int rval = -ENOMEM;

        if (IS_ERR(hw))
                return PTR_ERR(hw);

        cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
        if (cl) {
                rval = __clk_register_clkdev(hw, cl, con_id, dev_id);
                if (!rval)
                        devres_add(dev, cl);
                else
                        devres_free(cl);
        }
        return rval;
}
EXPORT_SYMBOL(devm_clk_hw_register_clkdev);

or do you prefer that I do not touch the existing clk_register_clkdev
and clk_hw_register_clkdev at all and only add
devm_clk_hw_register_clkdev? If that's what you prefer we can go with it
too. I just think doing the 

if (dev_id) 
	... con_id, "%s", dev_id);
else
	... con_id, NULL);

selection only in one function makes this cleaner.

> > +/**
> > + * devm_clk_register_clkdev - managed clk lookup registration for a struct clk
> > + * @dev: device this lookup is bound
> > + * @clk: struct clk to associate with all clk_lookups
> > + * @con_id: connection ID string on device
> > + * @dev_id: string describing device name
> > + *
> > + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> > + * clkdev.
> > + *
> > + * To make things easier for mass registration, we detect error clks
> > + * from a previous clk_register() call, and return the error code for
> > + * those.  This is to permit this function to be called immediately
> > + * after clk_register().
> > + */
> > +int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
> > +                            const char *con_id, const char *dev_id)
> 
> I wouldn't even add this function, to encourage driver writers to
> migrate to clk_hw based registration functions and to avoid removing it
> later on.

I can remove this.

Best regards
	Matti Vaittinen
