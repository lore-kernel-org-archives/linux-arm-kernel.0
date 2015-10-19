From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 12:11 +0200
Subject: [PATCH] drm/virtio: use %llu format string form atomic64_t
In-Reply-To: <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
References: <5082760.FgB9zHNfte@wuerfel> <5152101.mD2bWzUJ2V@wuerfel>
 <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
Message-ID: <4345582.jiHe94XBb3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 09:34:15 Geert Uytterhoeven wrote:
> On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> >
> > which truncates the result to 32 bit.
> 
> Woops.
> 
> See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
> Re: Add virtio gpu driver.)", which is still valid:
> https://lkml.org/lkml/2015/6/28/18
> 

Regarding your question of

> Instead of sprinkling casts, is there any good reason why atomic64_read()
> and atomic64_t aren't "long long" everywhere, cfr. u64?


I assume the answer is that some (all?) 64-bit architectures intentionally
return 'long' here, in order for atomic_long_read() to return 'long' on
all architectures, given the definitions from
include/asm-generic/atomic-long.h

We would have to either change those, or we have to pick between
atomic_long_* or atomic64_* to have a consistent return type.

	Arnd
