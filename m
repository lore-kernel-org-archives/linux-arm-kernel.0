From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 9 Nov 2016 10:16:03 -0800
Subject: KASAN & the vmalloc area
In-Reply-To: <20161109105624.GA17020@leverpostej>
References: <20161108190302.GH15297@leverpostej>
 <CACT4Y+ZSgfK-=wFFswMmQ+636Arz4kgwxdxz+FvEJHXvjZ8ckg@mail.gmail.com>
 <20161109105624.GA17020@leverpostej>
Message-ID: <CACT4Y+Ye+nxj=bQ9q9V2nEUpO+3sSWN1E2d_0KZapYyxx0Y69Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 2:56 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 08, 2016 at 02:09:27PM -0800, Dmitry Vyukov wrote:
>> On Tue, Nov 8, 2016 at 11:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > When KASAN is selected, we allocate shadow for the whole vmalloc area,
>> > using common zero pte, pmd, pud tables. Walking over these in the ptdump
>> > code takes a *very* long time (I've seen up to 15 minutes with
>> > KASAN_OUTLINE enabled). For DEBUG_WX [3], this means boot hangs for that
>> > long, too.
>
> [...]
>
>> I've seen the same iteration slowness problem on x86 with
>> CONFIG_DEBUG_RODATA which walks all pages. The is about 1 minute, but
>> it is enough to trigger rcu stall warning.
>
> Interesting; do you know where that happens? I can't spot any obvious
> case where we'd have to walk all the page tables for DEBUG_RODATA.

As far as I remember it was this path:

mark_readonly in main.c -> mark_rodata_ro -> debug_checkwx ->
ptdump_walk_pgd_level_checkwx -> ptdump_walk_pgd_level_core.


>> The zero pud and vmalloc-ed stacks looks like different problems.
>> To overcome the slowness we could map zero shadow for vmalloc area lazily.
>> However for vmalloc-ed stacks we need to map actual memory, because
>> stack instrumentation will read/write into the shadow.
>
> Sure. The point I was trying to make is that there' be fewer page tables
> to walk (unless the vmalloc area was exhausted), assuming we also lazily
> mapped the common zero shadow for the vmalloc area.
>
>> One downside here is that vmalloc shadow can be as large as 1:1 (if we
>> allocate 1 page in vmalloc area we need to allocate 1 page for
>> shadow).
>
> I thought per prior discussion we'd only need to allocate new pages for
> the stacks in the vmalloc region, and we could re-use the zero pages?

We can't reuse zero ro pages for stacks, because stack instrumentation
writes to stack shadow.
When we have a large continuous range of memory, shadow for it is
1/8th. However, if we have a separate page, we will need to map whole
page of shadow for it, i.e. 1:1 shadow overhead.


> ... or are you trying to quantify the cost of the page tables?
>
>> Re slowness: could we just skip the KASAN zero puds (the top level)
>> while walking? Can they be interesting for anybody?
>
> They're interesting for the ptdump case (which allows privileged users
> to dump the tables via /sys/kernel/debug/kernel_page_tables). I've seen
> 25+ minute hangs there.
>
>> We can just pretend that they are not there. Looks like a trivial
>> solution for the problem at hand.
>
> For the boot time hang it's option. Though I'd prefer that the sanity
> checks applied to all of tables, shadow regions included.
>
> Thanks,
> Mark.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe at googlegroups.com.
> To post to this group, send email to kasan-dev at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20161109105624.GA17020%40leverpostej.
> For more options, visit https://groups.google.com/d/optout.
