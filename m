From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Feb 2016 15:30:19 +0100
Subject: [PATCH V2 6/6] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <87h9hn5msz.fsf@ashishki-desk.ger.corp.intel.com>
References: <1454487337-30184-1-git-send-email-zhang.chunyan@linaro.org>
 <1454487337-30184-7-git-send-email-zhang.chunyan@linaro.org>
 <87h9hn5msz.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <1481791.6NqBhgWcKU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 February 2016 15:06:20 Alexander Shishkin wrote:
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
> 
> > +#ifndef CONFIG_64BIT
> > +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > +{
> > +     asm volatile("strd %1, %0"
> > +                  : "+Qo" (*(volatile u64 __force *)addr)
> > +                  : "r" (val));
> > +}
> 
> Is it really ok to do this for all !64bit arms, inside a driver, just
> like that? I'm not an expert, but I'm pretty sure there's more to it.

It's normally device dependent whether this works or not, on 32-bit
architectures, a 64-bit access to an I/O bus tends to get split into
two 32 bit accesses and the order might not be the as what was
intended.

We have functions in include/linux/io-64-nonatomic-hi-lo.h
and include/linux/io-64-nonatomic-lo-hi.h that are meant to
do this right. Maybe the driver can be changed to use whichever
one is correct for it.

	Arnd
