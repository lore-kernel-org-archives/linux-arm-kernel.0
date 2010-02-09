From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Feb 2010 10:52:27 +0100
Subject: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
In-Reply-To: <20100209093129.GA2284@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-2-git-send-email-wellsk40@gmail.com>
	<20100209093129.GA2284@pengutronix.de>
Message-ID: <20100209095227.GC2284@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while replying to to patch 02, I noticed yet another thing.

On Tue, Feb 09, 2010 at 10:31:29AM +0100, Uwe Kleine-K?nig wrote:
> > +/*
> > + * Start of virtual addresses for IO devices
> > + */
> > +#define IO_BASE		0xF0000000
> > +
> > +/*
> > + * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
> > + */
> > +#define IO_ADDRESS(x)	(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
> > +			 IO_BASE)
> > +
> > +#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
> Is this cast to unsigned long needed?  AFAIK IO_ADDRESS(x) has
> type unsigned for x in { 0x0 ... 0xffffffff } (provided that int uses a
> 32 bit 2s-complement representation).  If unsigned long is really
> needed, maybe put it into the IO_ADDRESS macro?
> 
> > ...
> > +#define _REG(x)					(void __iomem *)(io_p2v(x))

_REG gets (void __iomem *) twice.

Why not simply do:

	#define io_p2v(x)	(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) | IO_BASE)

	#define _REG(x)		(void __iomem *)(io_p2v(x))

and get rid of IO_ADDRESS completely?  BTW, AFAIK IO_BASE isn't a needed
name, so it should have the LPC32XX_ prefix, too.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
