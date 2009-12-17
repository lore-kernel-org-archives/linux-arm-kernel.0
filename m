From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Dec 2009 11:05:26 +0100
Subject: [PATCH 16/20] imx27: define and use MX27_IO_ADDRESS
In-Reply-To: <19241.55420.124271.517259@ipc1.ka-ro>
References: <1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<19241.55420.124271.517259@ipc1.ka-ro>
Message-ID: <20091217100526.GD19548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lother,

On Thu, Dec 17, 2009 at 08:06:36AM +0100, Lothar Wa?mann wrote:
> > +#define MX27_IO_ADDRESS(x)						\
> > +	(void __force __iomem *) ( 					\
> > +	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
> > +	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
> > +	IMX_IO_ADDRESS(x, MX27_X_MEMC) ?:				\
> > +	0xdeadbeef)
>         ^^^^^^^^^^
> I prefer to have a plain '0' here. Otherwise an invocation of this
> macro with an illegal address could lead to silent corruption of
> memory that happens to be mapped at that virtual address instead of a
> kernel oops due to a null pointer dereference!
> 
> Same for the other processors.
I'm a bit undecided here.  I choosed 0xdeadbeef because it is used in
IO_ADDRESS, too.  It's not aligned, so probably nothing happens.  As
Sasche votes for 0, too, I can change it.  It simplifies the code a bit
and then can read:

#define MX27_IO_ADDRESS(x)					\
	(void __force __iomem *) (				\
	IMX_IO_ADDRESS(x, MX27_AIPI) ?:				\
	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:			\
	IMX_IO_ADDRESS(x, MX27_X_MEMC))

as IMX_IO_ADDRESS returns 0 for out-of-range values, too.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
