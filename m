From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 1 Oct 2016 11:25:05 +0200
Subject: [PATCH] mtd: mtk: avoid warning in mtk_ecc_encode
In-Reply-To: <201609301925.17577.arnd@arndb.de>
References: <20160930163429.380785-1-arnd@arndb.de>
 <20160930185139.15c8be66@bbrezillon>
 <201609301925.17577.arnd@arndb.de>
Message-ID: <20161001112505.5f391ee6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Sep 2016 19:25:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 30 September 2016, Boris Brezillon wrote:
> > > +     /* copy into possibly unaligned OOB region with actual length */
> > > +     memcpy(data + bytes, eccdata, len);  
> > 
> > Is it better than
> > 
> >         for (i = 0; i < len; i += 4) {
> >                 u32 val = __raw_readl(ecc->regs + ECC_ENCPAR(i / 4));
> > 
> >                 memcpy(data + bytes + i, &val, min(len, 4));
> >         }
> > 
> > I'm probably missing something, but what's the point of creating a
> > temporary buffer of 112 bytes on the stack since you'll have to copy
> > this data to the oob buffer at some point?  
> 
> 
> I tried something like that first, but wasn't too happy with it for
> a number of small reasons:
> 
> - __raw_readl in a driver is not usually the right API, __memcpy32_from_io
>   uses it internally, but it's better for a driver not to rely on that,
>   in case we need some barriers (which we may in factt need for other drivers).

I agree, even though calling something prefixed with __ (in this case,
__ioread32_copy()) sounds like a bad thing too :).

> 
> - the min(len,4) expression is incorrect, fixing that makes it more complicated
>   again

Sorry, it's min(len - i, 4), which is not that complicated :P.

> 
> - I didn't like to call memcpy() multiple times, as that might get turned
>   into an external function call (the compiler is free to optimize small
>   memcpy calls or not).

Okay.

> 
> I agree that he 112 byte buffer isn't ideal either, it just seemed to
> be the lesser annoyance.

How about we keep your approach, but put the buffer in the mtk_ecc
struct?
