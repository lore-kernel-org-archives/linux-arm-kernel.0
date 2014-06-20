From: loeliger@gmail.com (Jon Loeliger)
Date: Fri, 20 Jun 2014 09:24:10 -0500
Subject: A clockevent IRQ delivery question
In-Reply-To: <CAOh2x=mcmuDb_Mnp2uggNg49m5qrhZqhCR79ZHc4xZEFVNjZpw@mail.gmail.com>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <CAOh2x=mcmuDb_Mnp2uggNg49m5qrhZqhCR79ZHc4xZEFVNjZpw@mail.gmail.com>
Message-ID: <CAJgR-Bi2YhBjJmHW1TmEYwqs4O+w5GJgUacSaVhb+xfGhk79LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 12:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Cc'ing Daniel .. He is maintaining clockevent drivers.

Hi Viresh,

Thanks.


> On Thu, Jun 19, 2014 at 9:47 PM, Jon Loeliger <loeliger@gmail.com> wrote:

>> The problem I see is that near what should be the login prompt,
>> the system hangs.
>>
>> Some questions:
>>
>> In my clockevent init() function, should I be setting the cpumask
>> to cpu_all_mask, cpu_possible_mask, cpumask_of(smp_processor_id())
>> or something else?  Empirically, cpu_possible_mask wasn't working
>> and cpumask_of(smp_processor_id()) allowed the boot to get past
>> the delay calibration.
>>
>> Should I also use irq_set_affinity(smp_processor_id()) here?
>>
>> I think what I am missing is an understanding of which CPUs will or
>> should get the IRQ delivered to it, and how do I arrange to make
>> that happen.
>>
>> Boot log and DTS fragment below.
>>
>> Thanks,
>> jdl

So, for the record, I fixed an incorrect clearing of an interrupt in
my code, and managed to get a full boot using both a cpumask
of cpumask_of(smp_processor_id()) and a call to
irq_set_affinity(smp_processor_id()).

Looking at /proc interrupt info, that IRQ does, in fact, only get
delivered to the boot core.  So I guess at this point it is more
a question of should it be balanced?  And if so, how is that
achieved?  Would a collection of percpu() data structures and
IRQs make that happen?  Or is the percpu() pattern only used
when the IRQ *is* delivered privately like the GIC PPIs?

Thanks,
jdl
