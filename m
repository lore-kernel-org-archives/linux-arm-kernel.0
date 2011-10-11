From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 11 Oct 2011 15:08:57 +0530
Subject: sched: ARM: arch_scale_freq_power
In-Reply-To: <1318324399.14400.71.camel@laptop>
References: <CAKfTPtB3sLWq5fHOTrFg6vfHSKnz2i17oYx9Btr0u_tWV2bsjQ@mail.gmail.com>
	<CAP245DX8b45Nj5SAwtLivp_vMKpwfeUrqnR2sqjnVyqiRd61gg@mail.gmail.com>
	<1318319852.14400.65.camel@laptop>
	<CAKfTPtB_eXgggeEYmNsXkvL8NsoEoz_NJFgA4E5WtAm74F515Q@mail.gmail.com>
	<1318324399.14400.71.camel@laptop>
Message-ID: <CAP245DXbj5nEB2ya5BWVYinvr2RQ+m7vmuHHT3fD1iVZZQ2C5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 2:43 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Tue, 2011-10-11 at 10:51 +0200, Vincent Guittot wrote:
>> I have several goals. The 1st one is that I need to put more load on
>> some cpus when I have packages with different cpu frequency.
>
> That should be rather easy.
>
>> I also study if I can follow the real cpu frequency but it seems to be
>> not so easy.
>
> Why not?
>
>> ?I have noticed that the cpu_power is updated periodical
>> except when we have a lot of newly_idle events.
>
> We can certainly fix that.
>
>> Then, I have some use cases which have several running tasks but a low
>> cpu load. In this case, the small tasks are spread on several cpu by
>> the load_balance whereas they could be easily handled by one cpu
>> without significant performance modification.
>
> That shouldn't be done using cpu_power, we have sched_smt_power_savings
> and sched_mc_power_savings for stuff like that.

AFAICT, sched_mc assume all cores to have the same capacity - which is
certainly true of the x86 architecture. But in ARM you can see hybrid
cores[1] designed using different fab technology, so that some cores
can run at 'n' GHz and some at 'm' GHz. The idea being that when there
isn't much to do (e.g periodic keep alives for messaging, email, etc.)
you don't wake up the higher power-consuming cores.
