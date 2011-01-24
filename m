From: segooon@gmail.com (Vasiliy Kulikov)
Date: Mon, 24 Jan 2011 23:05:17 +0300
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
Message-ID: <20110124200515.GA30963@albatros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 21:00 +0100, Julia Lawall wrote:
> On Tue, 25 Jan 2011, Ryan Mallon wrote:
> 
> > On 01/25/2011 08:55 AM, Julia Lawall wrote:
> > > @@ -224,7 +224,7 @@ void __init at91_clock_associate(const char *id, struct device *dev, const char
> > >  {
> > >  	struct clk *clk = clk_get(NULL, id);
> > >  
> > > -	if (!dev || !clk || !IS_ERR(clk_get(dev, func)))
> > > +	if (!dev || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> > >  		return;
> > 
> > I think we want:
> > 
> > 	if (!dev || !clk || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> > 		return;
> > 
> > Since it is valid to return a NULL clk, and we don't want to try and
> > dereference it if that is the case.
> 
> Looking at the given defintion of clk_get, I can't see how that could 
> happen:

clk_get() is defined per-architecture, sometimes it is NULL only.

> struct clk *clk_get(struct device *dev, const char *id)
> {
>         struct clk *clk;
> 
>         list_for_each_entry(clk, &clocks, node) {
>                 if (strcmp(id, clk->name) == 0)
>                         return clk;
>                 if (clk->function && (dev == clk->dev) && strcmp(id, clk->function) == 0)
>                         return clk;
>         }
> 
>         return ERR_PTR(-ENOENT);
> }
> 
> Both paths to the non-ERR_PTR return dereference clk.
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Vasiliy
