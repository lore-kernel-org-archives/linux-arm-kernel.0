From: snakky.zhang@gmail.com (snakky.zhang at gmail.com)
Date: Mon, 04 Jun 2012 17:20:59 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <20120603113449.GB15354@n2100.arm.linux.org.uk>
References: <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
 <4FC6FC38.8090904@gmail.com>
 <CAHkRjk4jJphxST86km4ybuVTGxAr-a=3Ag9cQpEysLYxBt-6WQ@mail.gmail.com>
 <4FC706DA.5040308@gmail.com> <20120531065603.GA2442@mbp>
 <4FC71C13.7090301@gmail.com> <4FC721DD.5020905@gmail.com>
 <CAHkRjk7qL1zDO4WD_LPh5v+v4aiU9Z1wHgMF3v=ykVUwKuw+YQ@mail.gmail.com>
 <4FC81C14.7030702@gmail.com> <20120601032912.GB16273@mbp>
 <20120603113449.GB15354@n2100.arm.linux.org.uk>
Message-ID: <4FCC7DFB.6050102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012?06?03? 19:34, Russell King - ARM Linux wrote:
> On Fri, Jun 01, 2012 at 11:29:13AM +0800, Catalin Marinas wrote:
>> On Fri, Jun 01, 2012 at 02:34:12AM +0100, snakky.zhang at gmail.com wrote:
>>>>> Yes, seems newer CPUs has no such limitation thus this function is global
>>>>> effective naturally. :-)
>>>>>
>>>>> And , I find Mips's c-r4k also has this issue but it use IPI to make it.
>>>>> Details in arch/mips/mm/c-r4k.c.
>>>> Rather than IPI we would better use the read-for-ownership trick like
>>>> in this patch to make flush_dcache_page global (no need for
>>>> write-for-ownership):
>>>>
>>>> http://dchs.spinics.net/lists/arm-kernel/msg125075.html
>>>>
>>>> (it may no longer apply, I haven't checked it for some time).
>>>>
>>>> That's the first thing. Secondly you still need preemption disable so
>>>> that it is not preempted between RFO and the actual cache cleaning.
>>>>
>>> And, another confusion for PREEMPT: Even if we disable preempt, with locally
>>> effective flush_dcache_xxx, there is still possibility to reproduce such
>>> issue(Similar with the previous case):
>>>
>>> 1) Task running on Core-0 loading text section into memory.
>>>       It was schedule out and then migrate into Core-1;
>>> 2) On Core-1, this task continue loading it and then
>>>       "flush_dcache_page" to make sure the loaded text section write
>>>       into main memory.
>>> 3) Task tend to the loaded text section and running it.
>>>
>>> Similar as the previous case, the difference lies in step1 that the
>>> task was interrupted by timer interrupt. Thus it still can be switch
>>> out and then been migrate to another core. Thus in step2 and 3, this
>>> issue may still been reproduced.  So, disable preempt can only lower
>>> the possibility of this issue but can't avoid it.
>> It would work as long as the data copying into the text area (done by
>> the driver and VFS layer) and the flush_dcache_page() sequence are not
>> preemptible. A timer interrupt between data copying and
>> flush_dcache_page() would interrupt a kernel routine which is not
>> preemptible.
> And that doesn't matter because on a non-preemptible kernel, timer ticks
> do _not_ cause the threads to be rescheduled while in kernel mode.  If
> they did, it would be a _preemptible_ kernel.
>
> The only things on a non-preemptible kernel which cause a schedule point
> are functions which may sleep, so semaphores, waiting for events, etc.
>
>
Thanks for your description. :-)

Thanks
Xiao
