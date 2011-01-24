From: julia@diku.dk (Julia Lawall)
Date: Mon, 24 Jan 2011 21:09:07 +0100 (CET)
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <20110124200515.GA30963@albatros>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
Message-ID: <Pine.LNX.4.64.1101242108180.3167@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Jan 2011, Vasiliy Kulikov wrote:

> On Mon, Jan 24, 2011 at 21:00 +0100, Julia Lawall wrote:
> > On Tue, 25 Jan 2011, Ryan Mallon wrote:
> > 
> > > On 01/25/2011 08:55 AM, Julia Lawall wrote:
> > > > @@ -224,7 +224,7 @@ void __init at91_clock_associate(const char *id, struct device *dev, const char
> > > >  {
> > > >  	struct clk *clk = clk_get(NULL, id);
> > > >  
> > > > -	if (!dev || !clk || !IS_ERR(clk_get(dev, func)))
> > > > +	if (!dev || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> > > >  		return;
> > > 
> > > I think we want:
> > > 
> > > 	if (!dev || !clk || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
> > > 		return;
> > > 
> > > Since it is valid to return a NULL clk, and we don't want to try and
> > > dereference it if that is the case.
> > 
> > Looking at the given defintion of clk_get, I can't see how that could 
> > happen:
> 
> clk_get() is defined per-architecture, sometimes it is NULL only.

In this case there is a definition in the same file, so it doesn't seem 
necessary to worry about possible other ones.  Unless there is some goal 
in the future to remove the local one?

julia
