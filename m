From: dima@android.com (Dima Zavin)
Date: Tue, 15 Nov 2011 15:27:18 -0800
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
 online/active
In-Reply-To: <4EC2DF93.2050904@codeaurora.org>
References: <20110908215314.829452535@linutronix.de>
 <CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
 <20110913133258.GA6267@n2100.arm.linux.org.uk>
 <CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
 <20110913175312.GB6267@n2100.arm.linux.org.uk>
 <20110923084001.GP17169@n2100.arm.linux.org.uk>
 <01d501cc84d6$62720890$275619b0$%kim@samsung.com>
 <alpine.LFD.2.02.1110071354310.3240@ionos>
 <CAPz4a6CkOXp6LHX2hFYVBhXWT4rhCUzLyYTLbO7g8u_jYcHt7Q@mail.gmail.com>
 <CAPz4a6C7md+k8pCz6mJtB-v_1h-faGxQZkOqU9vHUtcG-jrYVQ@mail.gmail.com>
 <4EC2DF93.2050904@codeaurora.org>
Message-ID: <CAPz4a6CXVasi2QzMc-+=Jo0RDqQvk5odF_V6q_9y5AoNVKWM-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think your issue is the same one I had. I'm not sure if we can we
rely on cpu_online_mask being valid unless you called
get_online_cpus(), can we?

--DIma

On Tue, Nov 15, 2011 at 1:54 PM, Stepan Moskovchenko
<stepanm@codeaurora.org> wrote:
> On 11:59 AM, Dima Zavin wrote:
>>
>> <go go gadget message retractor>
>>
>> Looks like the issue ended up being the fact that the caller was
>> accessing the cpu_online_mask without calling get_online_cpus anywhere
>> in the path and could have picked up the the intermediate state where
>> CPU was online but not yet active..
>>
>> --Dima
>>
>> On Wed, Oct 19, 2011 at 2:16 PM, Dima Zavin<dima@android.com> ?wrote:
>>>
>>> Thomas,
>>>
>>> I was seeing something similar, and this patch did address part of it,
>>> but I still think we have a problem. What I am seeing is the
>>> following:
>>>
>>> We have a SCHED_FIFO kernel thread which tries to do a blocking IPI
>>> (smp_call_function_single) to all online cpus (for_each_online_cpu).
>>> This introduces a deadlock where the FIFO thread could be preempting
>>> the suspend thread which is the one that's trying to set the second
>>> CPU active after it sees it going online. The second CPU marked itself
>>> online and is then waiting for the first CPU to mark it active before
>>> enabling irqs to service the IPI.
>>>
>>> It feels to me like we should probably not be sending blocking IPIs
>>> from a FIFO thread for sanity reasons, but that does mean there's
>>> still a deadlock present here.
>>>
>>> Thoughts?
>>>
>>> Thanks in advance.
>>>
>>> --Dima
>>>
>
> Hello
>
> I am seeing a deadlock when executing hotplug operations with this patch
> applied. When the secondary CPU gets brought up in _cpu_up, the cpu is
> turned on
> and then the online notifier gets called, which is what marks the secondary
> CPU
> as active. If _cpu_up on the primary CPU is preempted before the secondary
> CPU
> is marked active, it is possible that the primary CPU will want to call
> smp_call_function (or send an IPI) to the secondary CPU because it is marked
> online. However, with this patch, the secondary CPU is still spinning on
> !cpu_active(cpu)
> with interrupts disabled. So, the primary CPU is now stuck in
> csd_lock_wait(),
> waiting for the secondary CPU to respond, while the secondary CPU spins with
> interrupts disabled, waiting for the primary CPU to mark it as active. So,
> while
> your approach to not call smp_function_single may work for you in your
> specific
> case, I believe there is still a problem in the general case.
>
> One suggestion for resolving this might be making smp_call_function look at
> the
> active CPUs rather than online CPUs, or to just let the secondary CPU mark
> itself as active rather than having the primary CPU do this, though this
> might
> defeat the original intended purpose of the active mask.
>
> Steve
>
