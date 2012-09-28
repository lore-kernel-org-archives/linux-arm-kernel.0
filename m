From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Sep 2012 15:29:14 +0100
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <CAHkRjk684Qbbac4oxY2NpmExG8WKJT_XSXYfv5Tr9vn0+OkFwQ@mail.gmail.com>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
 <201209281336.30728.arnd@arndb.de>
 <CAHkRjk684Qbbac4oxY2NpmExG8WKJT_XSXYfv5Tr9vn0+OkFwQ@mail.gmail.com>
Message-ID: <20120928142914.GJ7916@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 03:13:42PM +0100, Catalin Marinas wrote:
> On 28 September 2012 14:36, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 27 September 2012, Russell King wrote:
> >> +#ifndef __ARMBE__
> >> +static inline void memset_io(volatile void __iomem *dst, unsigned c,
> >> +       size_t count)
> >> +{
> >> +       memset((void __force *)dst, c, count);
> >> +}
> >> +#define memset_io(dst,c,count) memset_io(dst,c,count)
> >> +
> >> +static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
> >> +       size_t count)
> >> +{
> >> +       memcpy(to, (const void __force *)from, count);
> >> +}
> >> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
> >> +
> >
> > I wonder whether we need any barriers here. PowerPC has the strongest
> > barriers befor eand after the access, at least since f007cacffc8870
> > "[POWERPC] Fix MMIO ops to provide expected barrier behaviour".
> 
> In theory, we need barriers but only at the beginning and the end of
> the operation, not for every iteration (and in practice we might even
> be OK without any).

Yes, we at least need a barrier before each.

The reason for a barrier before is that the memory being accessed may
depend on a previous writel() hitting the device, so we need to ensure
proper ordering wrt. other writel()s.

I don't think we need a barrier after because these any future device
writes by the write[bwl]() accessors will have a barrier before them,
which will ensure proper ordering.
