From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 7 Nov 2014 18:58:35 +0100
Subject: [PATCH 2/2] clk: at91: usb: fix at91sam9x5 recalc, round and
 set rate
In-Reply-To: <20141107175139.GF4068@piout.net>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415179995-25062-3-git-send-email-boris.brezillon@free-electrons.com>
 <20141107175139.GF4068@piout.net>
Message-ID: <20141107185835.1fd3871a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Nov 2014 18:51:39 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 05/11/2014 at 10:33:15 +0100, Boris Brezillon wrote :
> > First check for rate == 0 in set_rate and round_rate to avoid div by zero.
> > Then, in order to get the closest rate, round all divisions to the closest
> > result instead of rounding them down.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/clk/at91/clk-usb.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> > index 5b3b63c..7980e8c 100644
> > --- a/drivers/clk/at91/clk-usb.c
> > +++ b/drivers/clk/at91/clk-usb.c
> > @@ -52,7 +52,8 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
> >  
> >  	tmp = pmc_read(pmc, AT91_PMC_USB);
> >  	usbdiv = (tmp & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
> > -	return parent_rate / (usbdiv + 1);
> > +
> > +	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
> >  }
> >  
> >  static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
> > @@ -62,19 +63,19 @@ static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
> >  	unsigned long bestrate;
> >  	unsigned long tmp;
> >  
> > +	if (!rate)
> > +		return DIV_ROUND_CLOSEST(*parent_rate, SAM9X5_USB_MAX_DIV + 1);
> > +
> 
> Maybe I'm missing something but I would return -EINVAL here.

That's what I did at first, but just realized maybe 0 is a valid
request and we should try to be as close as possible to 0.

Anyway, I'm not really convinced we need that, so I can drop it.

> 
> >  	if (rate >= *parent_rate)
> >  		return *parent_rate;
> >  
> > -	div = *parent_rate / rate;
> > -	if (div >= SAM9X5_USB_MAX_DIV)
> > -		return *parent_rate / (SAM9X5_USB_MAX_DIV + 1);
> > +	div = DIV_ROUND_CLOSEST(*parent_rate, rate);
> > +	if (div > SAM9X5_USB_MAX_DIV + 1)
> > +		div = SAM9X5_USB_MAX_DIV + 1;
> > +	else if (!div)
> > +		div = 1;
> 
> In that case, you are also screwed, I would return -EINVAL.

Well, actually that cannot happen, because I already tested
rate >= *parent_rate.
I'll remove that line.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
