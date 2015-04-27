From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 27 Apr 2015 08:56:57 +0200
Subject: [PATCH 3/4] mtd: mxc_nand: fix truncate of unaligned oob copying
In-Reply-To: <20150427044618.GS2258@tarshish>
References: <cover.1430034929.git.baruch@tkos.co.il>
 <1f8e85fd8e75170e1005473c075942cb3d4479fe.1430034929.git.baruch@tkos.co.il>
 <20150426195211.GB19431@pengutronix.de>
 <20150427044618.GS2258@tarshish>
Message-ID: <20150427065657.GD19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Mon, Apr 27, 2015 at 07:46:18AM +0300, Baruch Siach wrote:
> On Sun, Apr 26, 2015 at 09:52:11PM +0200, Uwe Kleine-K?nig wrote:
> > On Sun, Apr 26, 2015 at 11:16:50AM +0300, Baruch Siach wrote:
> > > diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> > > index c650f0950b20..c05f5e8fef17 100644
> > > --- a/drivers/mtd/nand/mxc_nand.c
> > > +++ b/drivers/mtd/nand/mxc_nand.c
> > > @@ -840,22 +840,22 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
> > >  		for (i = 0; i < num_chunks - 1; i++)
> > >  			memcpy32_fromio(d + i * oob_chunk_size,
> > >  					s + i * sparebuf_size,
> > > -					oob_chunk_size);
> > > +					ALIGN(oob_chunk_size, 4));
> > If oob_chunk_size isn't 32-bit-aligned, d + i * oob_chunk_size isn't
> > either for uneven i. That's not nice. I suggest to use memcpy16_fromio.
> 
> memcpy32_fromio() was introduced by Sascha in 096bcc231fd2 (mtd: mxc_nand: use 
> 32bit copy functions, 2012-05-29), replacing memcpy_fromio() to force 32bit io 
> access. Are you sure the hypothetical memcpy16_fromio() would work?
according to the reference manual you can use 16-bit or 32-bit accesses.
And giving that in some cases the amount of valid data (in bytes) is ? 2
(mod 4) 16-bit access seem to be the obvious thing. Also Sascha only
wrote about byte accesses being problematic in 096bcc231fd2. So I'm
expecting that 16-bit operators should be fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
