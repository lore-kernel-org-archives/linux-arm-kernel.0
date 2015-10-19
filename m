From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 19 Oct 2015 11:37:00 +0200
Subject: [PATCH] drm/virtio: use %llu format string form atomic64_t
In-Reply-To: <5152101.mD2bWzUJ2V@wuerfel>
References: <5082760.FgB9zHNfte@wuerfel>
 <20151007104502.GH21513@n2100.arm.linux.org.uk>
 <6260324.3MlUEc3veg@wuerfel> <5152101.mD2bWzUJ2V@wuerfel>
Message-ID: <20151019093700.GC2092@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 01:23:07PM +0200, Arnd Bergmann wrote:

> > I haven't checked all architectures, but I assume what happens is that
> > 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
> > to provide three sets of functions.
> 
> scratch that, I just looked at all the architectures and found that it's
> just completely arbitrary, even within one architecture you get a mix
> of 'long' and 'long long', plus this gem from MIPS:
> 
> static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> 
> which truncates the result to 32 bit.

Eh...  The result is 0/1 so nothing is truncated.  Alpha, MIPS,
PARISC and PowerPC are using the same prototype and x86 only differs
in the use of inline instead __inline__.  And anyway, that function on
MIPS is only built for CONFIG_64BIT.

What's wrong on MIPS is the comment describing the function's return value
which was changed by f24219b4e90cf70ec4a211b17fbabc725a0ddf3c (atomic: move
atomic_add_unless to generic code) and I've queued up a patch to fix that
since a few days.  I guess that was a cut and paste error from
__atomic_add_unless which indeed does return the old value.

  Ralf
