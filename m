From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 14:36 +0200
Subject: [PATCH v4] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <3809181.WuS0af6Yyz@wuerfel>
References: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150914114113.4aa7ea03@bbrezillon> <3809181.WuS0af6Yyz@wuerfel>
Message-ID: <3052942.HDd39OoZnN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 13:49:12 Arnd Bergmann wrote:
> > > If all hardware can do 32-bit accesses here and the size is guaranteed to be a
> > > multiple of four bytes, you can probably improve performance by using a
> > > __raw_writel() loop there. Using __raw_writel() in general is almost always
> > > a bug, but here it actually makes sense. See also the powerpc implementation
> > > of _memcpy_toio().
> > 
> > AFAICT, buffer passed to ->write_bu() are not necessarily aligned on
> > 32bits, so using writel here might require copying data in temporary
> > buffers :-/.
> > 
> > Don't hesitate to point where I'm wrong ;-).
> 
> Brian or Dwmw2 should be able to know for sure. I think it's definitely
> worth trying as the potential performance gains could be huge, if you
> replace
> 
>         for (p = start; p < start + length; data++, p++) {
>                 writeb(*data, p);
>                 wmb();
>         }
> 
> with
> 
>         for (p = start; p < start + length; data++, p+=4) {
>                 writel(*data, p);
>         };
>         wmb();
> 

As Boris pointed out on IRC, we have an optimized version of
memcpy_toio on little-endian, which already does this. I'm not completely
sure why we don't use it for big-endian architectures as well.

Powerpc uses the same method on big-endian, but it's possible that
it does not do the right thing on one of the older platforms using
BE32 mode, or one that has a weird bus mode.

	Arnd
 
