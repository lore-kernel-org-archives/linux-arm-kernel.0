From: liu.h.jason@gmail.com (Jason Liu)
Date: Thu, 1 Jun 2017 18:52:43 +0800
Subject: Unhandled level 2 translation fault on A72 board.
In-Reply-To: <56A7720B.3020505@huawei.com>
References: <56A72246.4050105@huawei.com>
 <20160126110358.GA23579@localhost.localdomain>
 <56A7597D.6020609@huawei.com> <20160126114445.GD23579@localhost.localdomain>
 <56A7720B.3020505@huawei.com>
Message-ID: <CAB4PhKeBc=-1ikZje24kPA5B3RFDqRsP97RqOE9FHtfsDBExTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-26 21:18 GMT+08:00 Ding Tianhong <dingtianhong@huawei.com>:
> On 2016/1/26 19:44, Catalin Marinas wrote:
>> On Tue, Jan 26, 2016 at 07:33:17PM +0800, Ding Tianhong wrote:
>>> On 2016/1/26 19:03, Catalin Marinas wrote:
>>>> On Tue, Jan 26, 2016 at 03:37:42PM +0800, Ding Tianhong wrote:
>>>>> I met this problem when running the hackbench test on A72 chip board:
>>>>>
>>>>> sh[4779]: unhandled level 2 translation fault (11) at 0x7f96be0c80, esr 0x83000006
>>>>> pgd = ffffffc01a1f0000
>>>>> [7f96be0c80] *pgd=0000000084a20003, *pud=0000000084a20003, *pmd=0000000000000000
>> [...]
>>>> I can't tell for sure it's a TLB issue. The kernel page table dump shows
>>>> *pmd being 0, so the fault is correctly called "level 2 translation
>>>> fault". It also seems that there is no vma at this address, hence the
>>>> kernel reports it as unhandled. It looks like data corruption which
>>>> could be caused by cache or TLB incoherence. Just make sure the
>>>> interconnect linking the two clusters is configured correctly by
>>>> _firmware_ before Linux starts.
>>>
>>> Thanks for the apply, I have try to apply this patch to test:
>>>
>>> --- arch/arm64/kernel/process.c | 9 +++++++++
>>> 1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>>> index 6391485..d7d8439 100644
>>> --- a/arch/arm64/kernel/process.c
>>> +++ b/arch/arm64/kernel/process.c
>>> @@ -283,6 +283,13 @@ static void tls_thread_switch(struct task_struct *next)
>>> : : "r" (tpidr), "r" (tpidrro));
>>> }
>>> +static void tlb_flush_thread(struct task_struct *prev)
>>> +{
>>> +/* Flush the prev task&apos;s TLB entries */
>>> +if (prev->mm)
>>> +flush_tlb_mm(prev->mm);
>>> +}
>>> +
>>> /*
>>>   * Thread switching.
>>>   */
>>> @@ -296,6 +303,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>> hw_breakpoint_thread_switch(next);
>>> contextidr_thread_switch(next);
>>> +tlb_flush_thread(prev);
>>> +
>>> /*
>>> * Complete any pending TLB or cache maintenance on this CPU in case
>>> * the thread migrates to a different CPU.
>>>
>>> The hackbench would work fine after this patch, so I guess that the old thread tlb may not be
>>> invalidate as soon as possible, but I don't know why, everything is fine on A57,
>>> Does I miss something?
>>
>> It looks like the TLB invalidation messages may not get across the CCI
>> between clusters. I don't have the TRMs at hand but make sure all the
>> relevant bits in the CPUs and CCI are enabled.
>>
> Indeed check them several times, and need more information, check it again.

How this issue is resolved finally? I search the mail-list and find this old
email thread. Any response will be appreciated.


Jason Liu
>
>
>> BTW, which kernel version are you running? Is the firmware your own or
>> built around ARM Trusted Firmware?
> I use 4.1 kernel version, and the firmware is our own.
>
> Ding
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
