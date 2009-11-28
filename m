From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Nov 2009 18:24:39 +0000
Subject: [PATCH] ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
In-Reply-To: <m3zl6owvvi.fsf@intrepid.localdomain>
References: <m3zl6owvvi.fsf@intrepid.localdomain>
Message-ID: <20091128182439.GB497@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2009 at 12:05:05AM +0100, Krzysztof Halasa wrote:
> Define HAVE_IOREAD_AND_IOWRITE macro to indicate that the architecture has its
> own set of ioread*() and iowrite*() routines and doesn't need the generic one
> in arch/arm/include/asm/io.h.
> 
> Previously the ioread8 existence was tested, but it may be a function instead
> of a macro (I want to get rid of IXP4xx ioread*/iowrite* macros).

Missed this.

If you want to override a function, it's preferred to do it the way we're
doing it.

In otherwords, if you want to override a symbol using an inline function.
Eg:

#ifndef ndelay
static inline void ndelay(unsigned long x)
{
        udelay(DIV_ROUND_UP(x, 1000));
}
#define ndelay(x) ndelay(x)
#endif

#ifndef div_u64_rem
static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
        *remainder = do_div(dividend, divisor);
        return dividend;
}
#endif

#ifndef div_s64_rem
extern s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder);
#endif

#ifndef div64_u64
extern u64 div64_u64(u64 dividend, u64 divisor);
#endif

etc.

You just do this to use your own version:

extern u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
#define div_u64_rem div_u64_rem
