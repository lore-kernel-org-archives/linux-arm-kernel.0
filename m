From: dvyukov@google.com (Dmitry Vyukov)
Date: Tue, 8 Nov 2016 14:09:27 -0800
Subject: KASAN & the vmalloc area
In-Reply-To: <20161108190302.GH15297@leverpostej>
References: <20161108190302.GH15297@leverpostej>
Message-ID: <CACT4Y+ZSgfK-=wFFswMmQ+636Arz4kgwxdxz+FvEJHXvjZ8ckg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2016 at 11:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I see a while back [1] there was a discussion of what to do about KASAN
> and vmapped stacks, but it doesn't look like that was solved, judging by
> the vmapped stacks pull [2] for v4.9.
>
> I wondered whether anyone had looked at that since?
>
> I have an additional reason to want to dynamically allocate the vmalloc
> area shadow: it turns out that KASAN currently interacts rather poorly
> with the arm64 ptdump code.
>
> When KASAN is selected, we allocate shadow for the whole vmalloc area,
> using common zero pte, pmd, pud tables. Walking over these in the ptdump
> code takes a *very* long time (I've seen up to 15 minutes with
> KASAN_OUTLINE enabled). For DEBUG_WX [3], this means boot hangs for that
> long, too.
>
> If I don't allocate vmalloc shadow (and remove the apparently pointlesss
> shadow of the shadow area), and only allocate shadow for the image,
> fixmap, vmemmap and so on, that delay gets cut to a few seconds, which
> is tolerable for a debug configuration...
>
> ... however, things blow up when the kernel touches vmalloc'd memory for
> the first time, as we don't install shadow for that dynamically.


I've seen the same iteration slowness problem on x86 with
CONFIG_DEBUG_RODATA which walks all pages. The is about 1 minute, but
it is enough to trigger rcu stall warning.

The zero pud and vmalloc-ed stacks looks like different problems.
To overcome the slowness we could map zero shadow for vmalloc area lazily.
However for vmalloc-ed stacks we need to map actual memory, because
stack instrumentation will read/write into the shadow. One downside
here is that vmalloc shadow can be as large as 1:1 (if we allocate 1
page in vmalloc area we need to allocate 1 page for shadow).

Re slowness: could we just skip the KASAN zero puds (the top level)
while walking? Can they be interesting for anybody? We can just
pretend that they are not there. Looks like a trivial solution for the
problem at hand.
