From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 10:17:12 +0200
Subject: arm64 memcpy_{from|to}io and memset_io
In-Reply-To: <CAC8NTUUgQk0CNaBj2p=38U+yyFWE6ZQkSgs1KA=MviQg3g_X=Q@mail.gmail.com>
References: <CAC8NTUUgQk0CNaBj2p=38U+yyFWE6ZQkSgs1KA=MviQg3g_X=Q@mail.gmail.com>
Message-ID: <5350512.KZVKFguTOb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 23:12:18 Radha Mohan wrote:
> Hi,
> I see that the memcpy_{from|to}io and memset_io are not in an
> optimized manner. I guess these are just a copy from
> arch/arm/include/asm/io.h where there could be problem with different
> implementations.
> Do we still need these to be byte write ?

No.

> Can we convert them to use a more optimized memcpy ?

Yes.

> We have some drivers, like framebuffer driver using these functions
> and end up writing byte-by-byte. This causes a very poor VGA
> performance.
> 
> Let me know if there are any concerns to convert these to use memcpy.
> I can send a patch.

A few things to watch out for:

- you cannot use a static inline to do the job, because gcc might
  replace a plain memcpy() with unaligned pointer dereferences
  that are not allowed on __iomem

- when providing an external implementation of the functions, make sure
  they honor the alignment as well

- I think you need the same barriers that readl/writel have, but only
  at the start/end of the loop, not in the middle.

	Arnd
