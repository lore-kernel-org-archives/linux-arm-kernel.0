From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Oct 2010 14:39:03 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <87bp70or4r.fsf@macbook.be.48ers.dk>
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121745.GA12849@jasper.tkos.co.il>
	<87bp70or4r.fsf@macbook.be.48ers.dk>
Message-ID: <20101011123903.GU28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 02:23:00PM +0200, Peter Korsgaard wrote:
> >>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:
> 
> Hi,
> 
>  >> +
> 
>  Baruch> Unneeded empty line.
> 
> Yeah, just noticed as well.
> 
>  >> spin_lock_irqsave(&port->lock, flags);
>  >> -	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
>  >> +	l = __raw_readl(reg);
>  >> +	if (value)
>  >> +		l |= 1 << offset;
>  >> +	else
>  >> +		l &= ~(1 << offset);
> 
>  Baruch> Alternative shorter version:
> 
>  Baruch> l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);

This is shorter but I find this significantly harder to read and I bet
the compiler generates the same code from both versions.

> 
> Well, what do you know - I seem to be outnumbered ;)
> 
> Sasha, do you want the !! version instead? Then I'll resend.

I like the !! version. The only problem with this is that people tend
to try to remove the !! as it looks like a noop at first sight.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
