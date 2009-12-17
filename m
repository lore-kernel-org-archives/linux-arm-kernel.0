From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Dec 2009 14:17:09 +0100
Subject: [PATCH 16/20] imx27: define and use MX27_IO_ADDRESS
In-Reply-To: <19242.6870.193432.23163@ipc1.ka-ro>
References: <1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<19241.55420.124271.517259@ipc1.ka-ro>
	<20091217100526.GD19548@pengutronix.de>
	<19242.6870.193432.23163@ipc1.ka-ro>
Message-ID: <20091217131709.GB9032@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Thu, Dec 17, 2009 at 12:49:42PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Uwe Kleine-K?nig writes:
> > Hello Lother,
> > 
> Lothar
>     ^
oops, sorry.

> > On Thu, Dec 17, 2009 at 08:06:36AM +0100, Lothar Wa?mann wrote:
> > > > +#define MX27_IO_ADDRESS(x)						\
> > > > +	(void __force __iomem *) ( 					\
> > > > +	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
> > > > +	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
> > > > +	IMX_IO_ADDRESS(x, MX27_X_MEMC) ?:				\
> > > > +	0xdeadbeef)
> > >         ^^^^^^^^^^
> > > I prefer to have a plain '0' here. Otherwise an invocation of this
> > > macro with an illegal address could lead to silent corruption of
> > > memory that happens to be mapped at that virtual address instead of a
> > > kernel oops due to a null pointer dereference!
> > > 
> > > Same for the other processors.
> > I'm a bit undecided here.  I choosed 0xdeadbeef because it is used in
> >
> 0xdeadbeef by itself may look suspicious if you find it in some crash
> dump. But if some offset is added to it, you cannot distinguish it
> from any other legal virtual address.
Together with the discussion that it's better to do

	MX27_IO_ADDRESS(BASE + offset)

instead of

	MX27_IO_ADDRESS(BASE) + offset

there is no offset added to 0xdeadbeef.  Anyhow, 0 looks cleaner and as
all imx machines have a mmu there should be nothing at address 0.
 
> > IO_ADDRESS, too.  It's not aligned, so probably nothing happens.  As
> >
> Then, that macro should be changed also. And for the alignment
> argument, memory can also be accessed bytewise.
The longtime plan for IO_ADDRESS is to go away, so I don't care much.
0xdeadbeaf goes back to (at least)
52c543f90c4095dff71dc125017594b61a753069.  That was 2 years ago.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
