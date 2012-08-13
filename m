From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 13 Aug 2012 15:42:52 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <1613427331.1190769.1344577949008.JavaMail.root@mozilla.com>
References: <1613427331.1190769.1344577949008.JavaMail.root@mozilla.com>
Message-ID: <5029126C.5000202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 10/08/12 06:52, Martin Rosenberg wrote:

> A couple of days ago, I started a project to coalesce calls to
> cachefush in mozilla's JIT.  After working out most of the bugs that
> I could find, there were still some lingering failures, which I
> believe finally tracked down to do_cache_op, where it looks like only
> the first contiguous region of virtual memory is consulted.  I don't
> actually know about any of the functions that are being called, nor
> exactly what the datastructures represent, but if my understanding of
> the code is correct, then it is at odds with the documentation that
> is available (namely, man cacheflush(2)).  Is there something I've
> overlooked, any suggested workarounds?  Thanks --Marty
> 


On my system the cacheflush(2) documentation suggests it is MIPS only:
"This  Linux-specific  system call is only available on MIPS based
systems.  It should not be used in programs intended to be portable."

As you've established by looking at the code, on ARM we intentionally
attempt to flush only the part of the given range that occurs inside the
vma containing 'start'.

When flushing some huge range that spans multiple vmas, there might be
junk in the middle that it doesn't make sense to flush (eg devices), so
a fix that guarantees to flush an entire range isn't trivial and there
need to be some decisions about how to handle nonsensical requests. If
it is *really* necessary to flush large ranges like this it would be
good to understand why.

That said, now that it is possible to return errors from the cache
flushing syscalls[1] we should probably at least consider returning
something to report that the range had been truncated. There'd need to
be some thought given to how to represent errors where the range is
truncated *and* the flush_cache_user_range() function returns an error,
as well as a justification of why reporting truncation is
useful/necessary: For example the gcc builtin function:

    void __builtin___clear_cache (char *begin, char *end) )

has no return value to propagate error data[2], so it is unlikely that
much of userspace could take advantage of the return codes. There's some
historical discussion of this issue at [3]

Hope that helps,

Jonny

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/096299.html
which was committed as c5102f593550 - ARM: 7408/1: cacheflush: return
error to userspace when flushing syscall fails)
[2] http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
[3]
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/094869.html
