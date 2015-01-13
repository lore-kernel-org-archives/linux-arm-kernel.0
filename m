From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 12:52:05 +0100
Subject: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
In-Reply-To: <20141219104315.0ccbba9c@xhacker>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
 <20141219104315.0ccbba9c@xhacker>
Message-ID: <20150113115205.GE7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 10:43:15AM +0800, Jisheng Zhang wrote:
> Dear all,
> 
> Is there any issue I need to resolve so that the patch can be merged?

Adding Mika to the loop. He uses the driver a lot (and knows other
people who do)...


> On Wed, 10 Dec 2014 22:26:41 -0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > readl/writel is too expensive especially on Cortex A9 w/ outer L2 cache.
> > This introduces i2c read/write errors on Marvell BG2/BG2Q SoCs when there
> > are heavy L2 cache maintenance operations at the same time.
> > 
> > The driver does not perform DMA, so it's safe to use the relaxed version.
> > From another side, the relaxed io accessor macros are available on all
> > architectures now, so we can use the relaxed versions instead.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c index 23628b7..e279948 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -170,10 +170,10 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
> >  	u32 value;
> >  
> >  	if (dev->accessor_flags & ACCESS_16BIT)
> > -		value = readw(dev->base + offset) |
> > -			(readw(dev->base + offset + 2) << 16);
> > +		value = readw_relaxed(dev->base + offset) |
> > +			(readw_relaxed(dev->base + offset + 2) << 16);
> >  	else
> > -		value = readl(dev->base + offset);
> > +		value = readl_relaxed(dev->base + offset);
> >  
> >  	if (dev->accessor_flags & ACCESS_SWAP)
> >  		return swab32(value);
> > @@ -187,10 +187,10 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int
> > offset) b = swab32(b);
> >  
> >  	if (dev->accessor_flags & ACCESS_16BIT) {
> > -		writew((u16)b, dev->base + offset);
> > -		writew((u16)(b >> 16), dev->base + offset + 2);
> > +		writew_relaxed((u16)b, dev->base + offset);
> > +		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
> >  	} else {
> > -		writel(b, dev->base + offset);
> > +		writel_relaxed(b, dev->base + offset);
> >  	}
> >  }
> >  
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/e21dd833/attachment.sig>
