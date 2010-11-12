From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 12 Nov 2010 09:40:21 +0800
Subject: [Questions] How to run 'perf top' on ARM to profile kernel
	functions with modules loaded
In-Reply-To: <1289478626.2084.73.camel@laptop>
References: <AANLkTinwAL8dFsDbd-ZTQEcEziq6jZk82KPzNqMVxnOx@mail.gmail.com>
	<AANLkTim+BAYKWqiJzSQQLc4e_yNkMsNNnEp5u8YgC2Fk@mail.gmail.com>
	<20101111091733.GA2929@pulham.picochip.com>
	<1289477176.2084.64.camel@laptop>
	<20101111122143.GF2929@pulham.picochip.com>
	<1289478626.2084.73.camel@laptop>
Message-ID: <AANLkTikmfNkGOunxSEkQ28ZFoCT4kMoX1sPdXkQGmpq8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/11 Peter Zijlstra <a.p.zijlstra@chello.nl>:
> On Thu, 2010-11-11 at 12:21 +0000, Jamie Iles wrote:
>> On Thu, Nov 11, 2010 at 01:06:16PM +0100, Peter Zijlstra wrote:
>> > On Thu, 2010-11-11 at 09:17 +0000, Jamie Iles wrote:
>> > > On Thu, Nov 11, 2010 at 03:52:07PM +0800, Ming Lei wrote:
>> > > > 2010/11/11 Ming Lei <tom.leiming@gmail.com>:
>> > > > > Hi,
>> > > > >
>> > > > > 'perf top' can't display any functions when modules are loaded on ARM.
>> > > >
>> > > > Sorry, should be can't display any kernel functions when modules are loaded
>> > > > on ARM.
>> > > I've noticed this myself and I spent a bit of time looking into it last week
>> > > but didn't get too far. I did wonder if it was something to do with the map
>> > > fixups after loading the modules. If you look at the raw events after a perf
>> > > record with 'perf report -D' then the last module has a size that takes it to
>> > > 0xFFFFFFFF which overlaps with the rest of the kernel symbols.
>> > >
>> > > On x86 it looks like the modules are loaded after the kernel image in VM
>> > > unlike ARM.
>> >
>> > Order shouldn't matter, but that overlap is very likely what kills it.
>> > That module size is buggy.
>> I'm guessing that its in util/symbol.c:__map_groups__fixup_end():
>>
>> ? ? ? for (nd = rb_next(prevnd); nd; nd = rb_next(nd)) {
>> ? ? ? ? ? ? ? ? prev = curr;
>> ? ? ? ? ? ? ? ? curr = rb_entry(nd, struct map, rb_node);
>> ? ? ? ? ? ? ? ? prev->end = curr->start - 1;
>> ? ? ? ? }
>>
>> ? ? ? ? /*
>> ? ? ? ? ?* We still haven't the actual symbols, so guess the
>> ? ? ? ? ?* last map final address.
>> ? ? ? ? ?*/
>> ? ? ? ? curr->end = ~0UL;
>>
>> I've noticed that if I change the symbol_conf.{use_modules,try_vmlinux_path}
>> then I can get perf events for kernel symbols from /proc/kallsyms but nothing
>> for the modules.
>
> Hrm,.. depending on how we load things this might be easy or hard to
> fix. If we load the module symbols after having loaded the kernel
> symbols we can replace ~0ULL with the address before the next symbol.

If possible, could you post a patch so that I can verify if the issue is caused
by ~0ULL?

> If however we load modules first we're in a bind and should look at
> changing the load order to make the first suggestion work.
>


thanks,
-- 
Lei Ming
