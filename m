From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 19 Feb 2016 14:09:09 -0800
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <20160219181410.GG12864@e104818-lin.cambridge.arm.com>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
 <20160216103104.GC14509@arm.com> <56C300AD.8070505@arm.com>
 <20160216122153.GD19413@e104818-lin.cambridge.arm.com>
 <20160216160055.GH14509@arm.com> <20160216170408.GL14509@arm.com>
 <CA+55aFw-86k4gY46Et=e02HQQSxjUK2Jfz0SJz8tWtk5P8YZFA@mail.gmail.com>
 <20160219181410.GG12864@e104818-lin.cambridge.arm.com>
Message-ID: <CA+55aFyexYP2GLjFcmvyfwBGTyNy_HnBaBLFBgJzE6Le6Uzf0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 10:14 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Unless I misunderstand it, I don't think the user is even aware of this
> potential problem. Let's say it mmap's a file (script etc.) which
> contains a string (file name) towards the end of the last page. Such
> pointer gets passed to sys_open() and it eventually ends up in
> strncpy_from_user() with count == EMBEDDED_NAME_MAX (so well beyond the
> end of the page).
>
> The user also maps a device with mmap(NULL, ...) and there is a slight
> chance that the kernel allocates this VA space without any gap from the
> previous mmap().

Quite frankly, if the user mmap's MMIO - and particularly MMIO that
has side effects on speculative reads - the user had better be damn
sure they separate that MMIO well. Such a user should make sure they
have redzones around it on their own.

First off, it just doesn't happen. Basically zero applications map
MMIO to begin with, and the ones that do do it do it for frame buffers
etc that don't have side effects on reads.

I can't think of a single case of anybody actually having side effects
on reads on any sane hardware (except the obvious side effect of
"that's slow") any more, simply because it's horrible hardware design
and causes way worse problems than the whole page-crosser issue. Yeah,
I'm sure it exists somewhere, but I just wouldn't worry about it.

> Alternatively, aligning the source pointer reads (but not the
> destination) in strncpy_from_user() is another option, though I'm pretty
> sure we would notice some performance penalty.

It definitely is the destination pointer that needs alignment, simply
because that's the case that matters. There's a reason CPU's look
alike, and generally have patterns like "two read ports, one write
port" in their memory subsystem.

But more importantly, the kernel policy has always been to make the
cases that matter fast, and make sure we don't break anything.

If we can actually find a case where this matters and the dcache
access model actually breaks something, I'll care _deeply_, because it
will be the whole "no regressions" rule. But that "no regressions"
rule has always been about reality, not about theory.

We could make our strncpy try to be more careful about alignment. The
problem with that tends to be that keeping both source and destination
aligned is really complicated to do (a) efficiently and (b) portably.
There may well be things like vector extensions etc that are literally
*designed* for doing string copies and do the byte shifting in
hardware so that you can do things like this really well, but I'd like
to keep a (reasonably) simple generic strncpy_from_user() at least
until somebody actually sees it as a problem in real life.

          Linus
