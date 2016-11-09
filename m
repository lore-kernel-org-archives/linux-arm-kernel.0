From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 Nov 2016 10:56:24 +0000
Subject: KASAN & the vmalloc area
In-Reply-To: <CACT4Y+ZSgfK-=wFFswMmQ+636Arz4kgwxdxz+FvEJHXvjZ8ckg@mail.gmail.com>
References: <20161108190302.GH15297@leverpostej>
 <CACT4Y+ZSgfK-=wFFswMmQ+636Arz4kgwxdxz+FvEJHXvjZ8ckg@mail.gmail.com>
Message-ID: <20161109105624.GA17020@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 02:09:27PM -0800, Dmitry Vyukov wrote:
> On Tue, Nov 8, 2016 at 11:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > When KASAN is selected, we allocate shadow for the whole vmalloc area,
> > using common zero pte, pmd, pud tables. Walking over these in the ptdump
> > code takes a *very* long time (I've seen up to 15 minutes with
> > KASAN_OUTLINE enabled). For DEBUG_WX [3], this means boot hangs for that
> > long, too.

[...]
 
> I've seen the same iteration slowness problem on x86 with
> CONFIG_DEBUG_RODATA which walks all pages. The is about 1 minute, but
> it is enough to trigger rcu stall warning.

Interesting; do you know where that happens? I can't spot any obvious
case where we'd have to walk all the page tables for DEBUG_RODATA.

> The zero pud and vmalloc-ed stacks looks like different problems.
> To overcome the slowness we could map zero shadow for vmalloc area lazily.
> However for vmalloc-ed stacks we need to map actual memory, because
> stack instrumentation will read/write into the shadow. 

Sure. The point I was trying to make is that there' be fewer page tables
to walk (unless the vmalloc area was exhausted), assuming we also lazily
mapped the common zero shadow for the vmalloc area.

> One downside here is that vmalloc shadow can be as large as 1:1 (if we
> allocate 1 page in vmalloc area we need to allocate 1 page for
> shadow).

I thought per prior discussion we'd only need to allocate new pages for
the stacks in the vmalloc region, and we could re-use the zero pages?

... or are you trying to quantify the cost of the page tables?

> Re slowness: could we just skip the KASAN zero puds (the top level)
> while walking? Can they be interesting for anybody?

They're interesting for the ptdump case (which allows privileged users
to dump the tables via /sys/kernel/debug/kernel_page_tables). I've seen
25+ minute hangs there.

> We can just pretend that they are not there. Looks like a trivial
> solution for the problem at hand.

For the boot time hang it's option. Though I'd prefer that the sanity
checks applied to all of tables, shadow regions included.

Thanks,
Mark.
