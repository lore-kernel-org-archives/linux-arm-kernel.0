From: B44548@freescale.com (Chao Fu)
Date: Fri, 10 Jan 2014 08:11:33 +0000
Subject: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
In-Reply-To: <20140109175208.GK12858@sirena.org.uk>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>,
 <20140109175208.GK12858@sirena.org.uk>
Message-ID: <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This looks a lot nicer - a few things below though.
> 
> > +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) :
> cpu_to_le16(v))
> > +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) :
> cpu_to_le32(v))
> 
> These should probably be inline for the same reason as the I/O functions,
> perhaps even being done as part of the I/O functions.
> 
[Chao Fu] Thank you, Mark! I wiil put them into inline functions.

> > +static inline u16 dspi_readw(void __iomem *addr) {
> > +	u16 __v = (__force u16) __raw_readw(addr);
> > +	__iormb();
> > +
> > +	return __v;
> > +}
> 
> Why does this need a barrier and why does it not take care of the
> endianness translation?  A quick glance through shows most if not all of
> the callers doing the translation.
>
[Chao Fu] Our CPUs are working on only ARM architecture. But DSPI have two endianness 
In different series CPU, so we use __raw_read that do not take of endianness.
We need observe ARM io methods  make sure avoid instructions executing reorder .
ARM IO methods :
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
#define readw(c)                ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
#define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })

#define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
#define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })

So add barrier here. Could you give some suggestions? Many thanks!
 
> > +static inline void dspi_writew(u16 val, void __iomem *addr) {
> > +	__iowmb();
> > +	__raw_writew((__force u16) val, addr); }
> 
> Again the memory barrier seems odd, especially the barrier *before* doing
> the write.
