From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 13:36:30 +0000
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <201209281336.30728.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 September 2012, Russell King wrote:
> +#ifndef __ARMBE__
> +static inline void memset_io(volatile void __iomem *dst, unsigned c,
> +       size_t count)
> +{
> +       memset((void __force *)dst, c, count);
> +}
> +#define memset_io(dst,c,count) memset_io(dst,c,count)
> +
> +static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
> +       size_t count)
> +{
> +       memcpy(to, (const void __force *)from, count);
> +}
> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
> +

I wonder whether we need any barriers here. PowerPC has the strongest
barriers befor eand after the access, at least since f007cacffc8870
"[POWERPC] Fix MMIO ops to provide expected barrier behaviour".

This seems to be done more out of caution and trying to mimic the
x86 behavior (where all MMIO accesses are synchronous so some degree)
than fixing a particular bug that was observed.

Most other architectures are just using the raw string operations like
you do here.

Some architectures (powerpc and parisc at least) split the access into
naturally aligned accesses of up to 4 bytes. I think those are the
ones that allow unaligned accesses on RAM but not on MMIO pointers
(powerpc will checkstop or throw an exception).

arm64 actually copies the arm variant, and I suspect we can use the
simpler version there as well.

	Arnd
