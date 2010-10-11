From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 14:21:30 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <20101011121511.GY29673@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Mon, 11 Oct 2010 14:15:11 +0200")
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121511.GY29673@pengutronix.de>
Message-ID: <87fwwcor79.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Uwe" == Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

Hi,

 Uwe> On Mon, Oct 11, 2010 at 01:59:05PM +0200, Peter Korsgaard wrote:
 >> @@ -234,8 +234,13 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 >> u32 l;
 >> unsigned long flags;
 >> 
 >> +

Ups, that extra line shouldn't have been there.

 >> spin_lock_irqsave(&port->lock, flags);
 >> -	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
 >> +	l = __raw_readl(reg);
 >> +	if (value)
 >> +		l |= 1 << offset;
 >> +	else
 >> +		l &= ~(1 << offset);
 Uwe> Why not just

 Uwe> 	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);

Se my other reply. I don't feel strongly about it, but I for one don't
remember the precedence rules for !! and << offhand.

-- 
Bye, Peter Korsgaard
