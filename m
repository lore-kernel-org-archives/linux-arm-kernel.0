From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 14 Apr 2014 14:40:01 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com>
 <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140414185916.GA30672@redhat.com>
 <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
Message-ID: <CAA3XUr0SBczZSKui-qOivJKGtOe8_rB8HX4rSX24VYvLXm5yvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 April 2014 13:05, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> On 14 April 2014 11:59, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 04/11, Linus Torvalds wrote:
>>>
>>> On Fri, Apr 11, 2014 at 10:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> > +static void arch_uprobe_copy_ixol(struct xol_area *area, unsigned long vaddr,
>>> > +                                       struct arch_uprobe *auprobe)
>>> > +{
>>> > +#ifndef ARCH_UPROBE_XXX
>>> > +       copy_to_page(area->page, vaddr, &auprobe->ixol, sizeof(&auprobe->ixol));
>>> > +       /*
>>> > +        * We probably need flush_icache_user_range() but it needs vma.
>>> > +        * If this doesn't work define ARCH_UPROBE_XXX.
>>> > +        */
>>> > +       flush_dcache_page(area->page);
>>> > +#else
>>> > +       struct mm_struct *mm = current->mm;
>>> > +       struct vm_area_struct *vma;
>>> > +
>>> > +       down_read(&mm->mmap_sem);
>>> > +       vma = find_exact_vma(mm, area->vaddr, area->vaddr + PAGE_SIZE);
>>> > +       if (vma) {
>>> > +               void *kaddr = kmap_atomic(area->page);
>>> > +               copy_to_user_page(vma, area->page,
>>> > +                                       vaddr, kaddr + (vaddr & ~PAGE_MASK),
>>> > +                                       &auprobe->ixol, sizeof(&auprobe->ixol));
>>> > +               kunmap_atomic(kaddr);
>>> > +       }
>>> > +       up_read(&mm->mmap_sem);
>>> > +#endif
>>>
>>> Yeah, no, this is wrong.
>>
>> Yesss, agreed.
>>
>>> So I really think we should just have a fixed
>>> "flush_icache_page(page,vaddr)" function.
>>> ...
>>> Then the uprobe case can just do
>>>
>>>     copy_to_page()
>>>     flush_dcache_page()
>>>     flush_icache_page()
>>
>>
>> And I obviously like this idea because (iiuc) it more or less matches
>> flush_icache_page_xxx() I tried to suggest.
>
> Would not page granularity to be too expensive? Note you need to do that on
> each probe hit and you flushing whole data and instruction page every time.
> IMHO it will work correctly when you flush just few dcache/icache lines that
> correspond to xol slot that got modified. Note copy_to_user_page takes
> len that describes size of area that has to be flushed. Given that we are
> flushing xol area page at this case; and nothing except one xol slot is
> any interest for current task, and if CPU can flush one dcache and icache
> page as quickly as it can flush range, my remark may not matter.
>
> I personally would prefer if we could have function like copy_to_user_page
> but without requirement to pass vma to it.

I was trying to collect some experimental data around this
discussion. I did not find anything super surprising and
I am not sure how it would matter, but since I collected it already,
I will just share anyway. The result covers only one architecture so
they should be taken with grain of salt.

Test was conducted on ARM h/w. Arndale with Exynos 5250 2 cores CPU
and Pandaboard ES with OMAP 4460 were tested.

The uporbes/systemtap test was arranged in the following way.
SystemTap module was counting number of times functions was
called. The SystemTap action is very simple, counter increment,
is close to noop operation that allows to see tracing overhead.

Traced user-land function had approximately 8000 instructions
(unoptimized empty loop of 1000 iterations, with each
interaction is 8 instructions). That function was constantly
called in the loop 1 million times, and that interval was timed.
SystemTap/uprobes testing was enabled and it was observed how
targeted user-land execution time changed.

Test scenarios and variations
-----------------------------

Here is scenarios where measurements took place:

vanilla - no tracing, 1 million calls of function that executes
8000 instructions

Oleg's fix - Oleg's fix proposed on [1]. Basically it uses
copy_to_user_page and it does dynamic look-up of xol area vma
every tracing

my arm specific fix - this one was proposed on as [2]. It is
close to discussed possible solution if we could have something
similar to copy_to_user_page function but which does not
required vma. My code tried to shared ARM backend of
copy_to_user_page and xol access flush function

Oleg's fix + forced broadcast - one of concerns I had is
situation where smp function call broadcast has to be happen
to flush icache. On both of my board that was not needed.
So to simulated such situation I've changed code ARM backend
of copy_to_user_page to do smp_call_function(flush_ptrace_access_other


Tested application had two possible dimensions:

1) number of threads that runs loop over traced function to see
how tracing would cope with multicore, default is only one
thread, but test could run another loop on second core.

2) number of mapping in target process, target process could
have 1000 files mapping to create bunch of vmas. It is to test
how much dynamic look-up of xol area vma matters.

Results
-------

Number shown in the table is time in microseconds to execute
tested function with and without tracing presence.

Please note well tracing overhead include all related to tracing
pieces, not only cache flush that is under discussion. Those pieces
will be: taking arch exception layer; uprobes layer; uprobes
arch specific layer (before/after); xol look-up, update and cache
flush; uprobes single stepping logic, systemtap module callback
that generated for .stp tracing script, etc


                       Arndale       Pandaboard ES

vanilla              5.0 (100%)         11.5 (100%)

Oleg's fix          9.8 (196%)         28.1 (244%)

Oleg's fix         10.0 (200%)         28.7 (250%)
+ 1000 mappings

Victor's fix        9.4 (188%)         26.4 (230%)

Oleg's fix         13.7 (274%)         39.8 (346%)
+ broadcast
1 thread

Oleg's fix         14.1 (282%)         41.6 (361%)
+ broadcast
2 threads


Observations
------------

x) generally uprobes tracing is a bit expensive 1 trace
roughly would cost around 10000 instructions/cycles

x) the way how cache is flushed matters somewhat, but
because of big overall tracing overhead those differences
may not matter

x) looking at 'Oleg's fix' vs 'Oleg's fix + 1000 mappings'
shows that vma look-up noticeable but the difference is
marginal. No surprise here: rb tree search works fast.

x) need to broadcast icache flush has most noticeable impact.
I am not sure how essential is that. Both tested platforms
Exynos 5250 and OMAP 4460 did not need that operation. I
am not sure what CPU would really have this issue ...

x) fix that I did for ARM that shares ARM code with
copy_to_user_page but does not need vma performs best.
Essentially it differs from 'Oleg's fix' that no vma lookup
at all. But I have to admit resulting code looks a bit
ugly. I wonder whether the gain matters enough ... maybe
not.


Dynamic xol slots vs cached to uprobe xol slots
-----------------------------------------------

This section could be a bit off topic, but introduce
interesting data point.

When I looked at current uprobes single step out line code
and compared it with code that was in the past (utrace
times) I noticed main essential difference how xol slots
are handled: Currently for each hit uprobes code allocate
xol slot and needs dcache/icache flush. But in the past
xol slot was attached/cached to uprobe entry and if there
were enough xol slots dcache/icache flush would happen
only once and latter tracing would not need it. For cases
where there were not enough xol slots lru algorithm was
used to rotate xol slots vs uprobes.

Previous uprobes mechanism was more immune to cost
of modifying instruction stream, because modifying
instruction stream was one time operation and after that
under normal circumstances traced apps did not touch
instructions at all. I am quite sure that semi-static
xol slot allocation scheme had it is own set of issues.

I've tried to hack cached xol slot scheme and measure
time difference it brings.

                         Arndale

hack static           8.9 (188%)
xol slot

8.9 microseconds gives idea about all other overheads
during uprobes tracing except of xol allocation and
icache/dcache flush. I.e cost of dynamically allocating
xol slot, dcache/icache flush and impact of cache flush
on application is around 0.5 and 1.1 microsecond as
long as no cache operations broadcast is involved. I.e
cost is not that big, as long as modern CPU that does
not need cache flush broadcasts, dynamic xol scheme
looks OK to me.

Raw Results and Test Source Code
--------------------------------

I don't publish my test source code and raw results
here because it is quite big. Raw results were
collected with target test running under perf, so
it could be seen how different schemes affect cache
and tlb misses. If anyone interested in source and
raw data please let me know I will post it here.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246595.html

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245743.html

> Thanks,
> Victor
>
>> But we need a short term solution for arm. And unless I misunderstood
>> Russell (this is quite possible), arm needs to disable preemption around
>> copy + flush.
>>
>> Russel, so what do you think we can do for arm right now? Does the patch
>> above (and subsequent discussion) answer the "why reinvent" question ?
>>
>> Oleg.
>>
