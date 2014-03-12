From: gsi@denx.de (Gerhard Sittig)
Date: Wed, 12 Mar 2014 22:45:53 +0100
Subject: [PATCH 1/3] spi: bitbang: fix shift for getmosi
In-Reply-To: <20140312162418.GU28112@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
 <20140312162418.GU28112@sirena.org.uk>
Message-ID: <20140312214553.GQ3327@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 16:24 +0000, Mark Brown wrote:
> 
> On Wed, Mar 12, 2014 at 04:53:35PM +0100, Michael Grzeschik wrote:
> > The driver needs to shift the word bit after reading the mosi bit.
> > Otherwise the return word will have an Off-by-one bit value.
> 
> This isn't exactly new code...  do we understand why nobody has noticed
> this before?

I too suspect that the bug (if there is any) is elsewhere.

> > @@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
> >  		spidelay(nsecs);
> >  
> >  		/* sample MSB (from slave) on leading edge */
> > -		word <<= 1;
> >  		if ((flags & SPI_MASTER_NO_RX) == 0)
> >  			word |= getmiso(spi);
> >  		setsck(spi, cpol);
> > +		word <<= 1;
> >  	}
> 
> Just looking at the context here it's not obvious to me that this is
> helping - it means that the last bit we read is going to be shifted
> which seems wrong, we ought to be reading into LSB.

It might be more robust to 

  if (!(flags & SPI_MASTER_NO_RX) && getmiso(spi))
    word |= 1;
    
instead.  This decouples the construction of the received bits
buffer from whatever the getmiso() implementation might look
like.  That's just a thought after the recent GPIO discussion
about whether 1/0 is given or should not be assumed (and I still
suspect that "!!x" need not result in exactly 1/0 values).

And I agree with Mark that the "late shift" is most probably
wrong.  Just noticed the resend too late and responded in the
other thread.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
