From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 11 Oct 2011 18:03:30 +0200
Subject: sched: ARM: arch_scale_freq_power
In-Reply-To: <1318328848.8395.45.camel@twins>
References: <CAKfTPtB3sLWq5fHOTrFg6vfHSKnz2i17oYx9Btr0u_tWV2bsjQ@mail.gmail.com>
	<CAP245DX8b45Nj5SAwtLivp_vMKpwfeUrqnR2sqjnVyqiRd61gg@mail.gmail.com>
	<1318319852.14400.65.camel@laptop>
	<CAKfTPtB_eXgggeEYmNsXkvL8NsoEoz_NJFgA4E5WtAm74F515Q@mail.gmail.com>
	<1318324399.14400.71.camel@laptop>
	<CAKfTPtDzY4pORvWd3Qa6kqpNsspKN7iEskQ+7F5D=mAwQWoKNg@mail.gmail.com>
	<1318328848.8395.45.camel@twins>
Message-ID: <CAKfTPtDgKcTucAR-YW27boAeUu1Ur6Txw6hLm3B48jw+sgEUOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2011 12:27, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Tue, 2011-10-11 at 11:40 +0200, Vincent Guittot wrote:
>> On 11 October 2011 11:13, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> > On Tue, 2011-10-11 at 10:51 +0200, Vincent Guittot wrote:
>> >> I have several goals. The 1st one is that I need to put more load on
>> >> some cpus when I have packages with different cpu frequency.
>> >
>> > That should be rather easy.
>> >
>>
>> I agree, I was mainly wondering If I should use a [1-1024] or a
>> [1024-xxxx] range and it seems that both can be used according : SMT
>> uses <1024 and x86 turbo mode uses >1024
>
> Well, turbo mode would typically only boost a cpu 25% or so, and only
> while idling other cores to keep under its thermal limit. So its not
> sufficient to actually affect the capacity calculation much if at all.
>

OK

>> >> Then, I have some use cases which have several running tasks but a low
>> >> cpu load. In this case, the small tasks are spread on several cpu by
>> >> the load_balance whereas they could be easily handled by one cpu
>> >> without significant performance modification.
>> >
>> > That shouldn't be done using cpu_power, we have sched_smt_power_savings
>> > and sched_mc_power_savings for stuff like that.
>> >
>>
>> sched_mc_power_saving works fine when we have more than 2 cpus but
>> can't apply on a dual core because it needs at least 2 sched_groups
>> and the nr_running of these sched_groups must be higher than 0 but
>> smaller than group_capacity which is 1 on a dual core system.
>
> SD_POWERSAVINGS_BALANCE does /=2 to nr_running, effectively doubling the
> capacity iirc. And I know some IBM dudes were toying with the idea of
> playing tricks with the capacity numbers, but that never went anywhere.
>

yes but it's only a special case for 2 tasks on a dual core and the
SD_WAKE_AFFINE flag and cpu_idle_sibling can overwrite this decision.

>> > Although I would really like to kill all those different
>> > sched_*_power_savings knobs and reduce it to one.
>> >
>> >> If the cpu_power is
>> >> higher than 1024, the cpu is no more seen out of capacity by the
>> >> load_balance as soon as a short process is running and teh main result
>> >> is that the small tasks will stay on the same cpu. This configuration
>> >> is mainly usefull for ARM dual core system when we want to power gate
>> >> one cpu. I use cyclictest to simulate such use case.
>> >
>> > Yeah, but that's wrong.
>>
>> That's the only way I have found to gathers small task without any
>> relationship on one cpu. Do you know any better solution ?
>
> How do you know the task is 'small' ?
>

I want to use cpufreq to be notified that we have a large/small cpu
load. If we have several tasks but the cpu uses the lowest frequency,
it "should" mean that we have small tasks that are running (less than
20ms*95% of added duration) and we could gather them on one cpu (by
increasing the cpu_power on a dual core).

> For that you would need to track a time-weighted effective load average
> of the task and we don't have that.
>

yes, that's why I use cpufreq until better option, like a
time-weighted load average, is available

> [ how bad is all this u64 math on ARM btw? and when will ARM finally
> ?agree all this 32bit nonsense is a waste of time and silicon? ]
>
> But yeah, the whole nr_running vs capacity thing was traditionally to
> deal with spreading single tasks around. And traditional power aware
> scheduling was mostly about packing those on sockets (keeps other
> sockets idle) instead of spreading them around sockets (optimizes
> cache).
>
> Now I wouldn't at all mind you ripping out all that
> sched_*_power_savings crap and replacing it, I doubt it actually works
> anyway. I haven't got many patches on the subject, and I know I don't
> have the equipment to measure power usage.
>
> Also, the few patches I got mostly made the sched_*_power_savings mess
> bigger, which I refuse to do (what sysad wants to have a 27-state space
> to configure his power aware scheduling). This has mostly made people go
> away instead of fixing things up :-(
>
> As to what the replacement would have to look like, dunno, its not
> something I've really thought much about, but maybe the time-weighted
> stuff is the only sane approach, that combined with options on how to
> spread tasks (core, socket, node, etc..).
>
> I really think changing the load-balancer is the right way to go about
> solving your power issue (hot-plugging a cpu really is an insane way to
> idle a core) and I'm open to discussing what would work for you.
>

Great. My 1st goal was not to modify the load-balancer and sched_mc
(or as less as possible) and to study how I could tune the scheduler
parameters to have the best power consumption on ARM platform. Now,
changing the load-balancer is probably a better solution.

> All I really ask is to not cobble something together, the load-balancer
> is a horridly complex thing already and the last thing it needs is more
> special cases that don't interact properly.
>
>
>
