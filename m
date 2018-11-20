From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 20 Nov 2018 13:12:48 +0200
Subject: [PATCH] clk: Add (devm_)clk_get_optional() functions
In-Reply-To: <TY1PR01MB176982D5E11A665D0DCC9E31F5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
 <20181120103832.GV10650@smile.fi.intel.com>
 <TY1PR01MB176982D5E11A665D0DCC9E31F5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <20181120111248.GW10650@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 10:53:33AM +0000, Phil Edworthy wrote:
> On 20 November 2018 10:39 Andy Shevchenko wrote:
> > On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> > > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > > get optional clocks.
> > > They behave the same as (devm_)clk_get except where there is no clock
> > > producer. In this case, instead of returning -ENOENT, the function
> > > returns NULL. This makes error checking simpler and allows
> > > clk_prepare_enable, etc to be called on the returned reference without
> > > additional checks.

> > >  - Instead of messing with the core functions, simply wrap them for the
> > >    _optional() versions. By putting clk_get_optional() inline in the header
> > >    file, we can get rid of the arch specific patches as well.

> > Fine if it would have no surprises with error handling.
> There shouldn't be any surprises. My earlier attempts at implementing this
> were hampered by the fact that of_clk_get_by_name() can return -EINVAL
> in some circumstances. By directly wrapping the (devm_)clk_get() functions
> that problem goes away.

Good!

After my comments being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> > > +	if (ERR_PTR(-ENOENT))
> Huh? That wasn't the code I sent...

Yup, it's my wrong editing flow. Anyway, you got the idea.

> > > +		return NULL;
> > > +	else
> > > +		return clk;

> > return clk == ERR_PTR(-ENOENT) ? NULL : clk;

-- 
With Best Regards,
Andy Shevchenko
