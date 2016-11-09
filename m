From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 9 Nov 2016 10:42:44 -0800
Subject: KASAN & the vmalloc area
In-Reply-To: <20161109183017.GA837@leverpostej>
References: <20161108190302.GH15297@leverpostej>
 <CACT4Y+ZSgfK-=wFFswMmQ+636Arz4kgwxdxz+FvEJHXvjZ8ckg@mail.gmail.com>
 <20161109105624.GA17020@leverpostej>
 <CACT4Y+Ye+nxj=bQ9q9V2nEUpO+3sSWN1E2d_0KZapYyxx0Y69Q@mail.gmail.com>
 <20161109183017.GA837@leverpostej>
Message-ID: <CACT4Y+Zd-kLhVEc591P5Z-pXjOtAf6M2i9wYpP-bJHCKteDG9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 10:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> I've seen the same iteration slowness problem on x86 with
>> >> CONFIG_DEBUG_RODATA which walks all pages. The is about 1 minute, but
>> >> it is enough to trigger rcu stall warning.
>> >
>> > Interesting; do you know where that happens? I can't spot any obvious
>> > case where we'd have to walk all the page tables for DEBUG_RODATA.
>>
>> As far as I remember it was this path:
>>
>> mark_readonly in main.c -> mark_rodata_ro -> debug_checkwx ->
>> ptdump_walk_pgd_level_checkwx -> ptdump_walk_pgd_level_core.
>
> Ah, that's x86's equivalent DEBUG_WX checks.
>
>> >> The zero pud and vmalloc-ed stacks looks like different problems.
>> >> To overcome the slowness we could map zero shadow for vmalloc area lazily.
>> >> However for vmalloc-ed stacks we need to map actual memory, because
>> >> stack instrumentation will read/write into the shadow.
>> >
>> > Sure. The point I was trying to make is that there' be fewer page tables
>> > to walk (unless the vmalloc area was exhausted), assuming we also lazily
>> > mapped the common zero shadow for the vmalloc area.
>> >
>> >> One downside here is that vmalloc shadow can be as large as 1:1 (if we
>> >> allocate 1 page in vmalloc area we need to allocate 1 page for
>> >> shadow).
>> >
>> > I thought per prior discussion we'd only need to allocate new pages for
>> > the stacks in the vmalloc region, and we could re-use the zero pages?
>>
>> We can't reuse zero ro pages for stacks, because stack instrumentation
>> writes to stack shadow.
>
> Sorry, I'd meant we'd use the zero pages for everything else but stacks.
> I understand we'd have to allocate real shadow for the stacks.
>
>> When we have a large continuous range of memory, shadow for it is
>> 1/8th. However, if we have a separate page, we will need to map whole
>> page of shadow for it, i.e. 1:1 shadow overhead.
>
> Sure, but for everything but stacks we can re-use the same zero pages,
> no?
>
> For everything else, the cost would be dominated by the page tables for
> the shadow.


Can we estimate the memory overhead?
