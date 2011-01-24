From: julia@diku.dk (Julia Lawall)
Date: Mon, 24 Jan 2011 21:00:59 +0100 (CET)
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <4D3DD964.9020107@bluewatersys.com>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
Message-ID: <Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jan 2011, Ryan Mallon wrote:

> On 01/25/2011 08:55 AM, Julia Lawall wrote:
> > Function clk_get, defined just below this code, returns ERR_PTR not NULL in
> > an error case.
> > 
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @r@
> > identifier f;
> > @@
> > f(...) { ... return ERR_PTR(...); }
> > 
> > @@
> > identifier r.f, fld;
> > expression x;
> > statement S1,S2;
> > @@
> >  x = f(...)
> >  ... when != IS_ERR(x)
> > (
> >  if (IS_ERR(x) ||...) S1 else S2
> > |
> > *x->fld
> > )
> > // </smpl>
> 
> I'm always really impressed by this tool :-).
> 
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> > 
> > ---
> >  arch/arm/mach-at91/clock.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> > index 9113da6..c9ee6d0 100644
> > --- a/arch/arm/mach-at91/clock.c
> > +++ b/arch/arm/mach-at91/clock.c
> > @@ -224,7 +224,7 @@ void __init at91_clock_associate(const char *id, struct device *dev, const char
> >  {
> >  	struct clk *clk = clk_get(NULL, id);
> >  
> > -	if (!dev || !clk || !IS_ERR(clk_get(dev, func)))
> > +	if (!dev || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> >  		return;
> 
> I think we want:
> 
> 	if (!dev || !clk || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> 		return;
> 
> Since it is valid to return a NULL clk, and we don't want to try and
> dereference it if that is the case.

Looking at the given defintion of clk_get, I can't see how that could 
happen:

struct clk *clk_get(struct device *dev, const char *id)
{
        struct clk *clk;

        list_for_each_entry(clk, &clocks, node) {
                if (strcmp(id, clk->name) == 0)
                        return clk;
                if (clk->function && (dev == clk->dev) && strcmp(id, clk->function) == 0)
                        return clk;
        }

        return ERR_PTR(-ENOENT);
}

Both paths to the non-ERR_PTR return dereference clk.

julia

> We could also probably drop the !IS_ERR(clk_get(dev, func)) check, since
> as far as I can tell it is just checking to see if the clock is already
> associated, but there is no harm in re-assigning the same values, and
> the two assignments in at91_clock_associate are going to be much quicker
> than the lookup in clk_get.
> 
> ~Ryan
> 
> -- 
> Bluewater Systems Ltd - ARM Technology Solution Centre
> 
> Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
> ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
> http://www.bluewatersys.com	New Zealand
> Phone: +64 3 3779127		Freecall: Australia 1800 148 751
> Fax:   +64 3 3779135			  USA 1800 261 2934
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
