From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Sep 2018 12:33:22 +0100
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
Message-ID: <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
> On 09/07/2018 05:56 PM, Will Deacon wrote:
> > On Thu, Sep 06, 2018 at 08:05:33PM +0300, Andrey Ryabinin wrote:
> >> ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
> >> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> >> code, thus it can potentially miss many bugs.
> >>
> >> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> >> enabled, so the generic implementations from lib/string.c will be
> >> used.
> >>
> >> Declare asm functions as weak instead of removing them because they
> >> still can be used by efistub.
> > 
> > I don't understand this bit: efistub uses the __pi_ prefixed
> > versions of the routines, so why do we need to declare them as weak?
> 
> Weak needed because we can't have two non-weak functions with the same
> name.
> 
> Alternative approach would be to never use e.g. "strlen" name for asm
> implementation of strlen() under CONFIG_KASAN=y.  But that would
> require adding some special ENDPIPROC_KASAN() macro since we want
> __pi_strlen() to point to the asm_strlen().

Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
AFAICT would suffer from texactly the same problem with things like
memcpy.

So either we're getting away with that by chance already (and should fix
that regardless of this patch), or this is not actually a problem.

Conditionally aliasing <foo> to pi_<foo> in a linker script (or header,
for functions which aren't special per the c spec) seems sane to me.

> Using weak seems like a way better solution to me.

I would strongly prefer fixing this without weak, even if we need a
ENDPRPROC_KASAN, and/or wrappers in some header file somewhere, since if
something goes wrong that will fail deterministically at build time
rather than silently falling back to the wrong piece of code.

Thanks,
Mark.
