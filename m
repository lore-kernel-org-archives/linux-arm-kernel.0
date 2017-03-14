From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 14 Mar 2017 13:29:08 -0600
Subject: [PATCH V12 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <58C60485.2070509@huawei.com>
References: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
 <1488833103-21082-10-git-send-email-tbaicar@codeaurora.org>
 <58C12342.2090701@huawei.com>
 <14545228-7ff1-b31c-1fa5-daacf89a44b9@codeaurora.org>
 <58C60485.2070509@huawei.com>
Message-ID: <1aceb614-a1ad-8e7c-e488-0437c4bc1502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Xie XiUQi,


On 3/12/2017 8:31 PM, Xie XiuQi wrote:
> Hi Baicar Tyler,
>
> On 2017/3/11 2:23, Baicar, Tyler wrote:
>> Hello Xie XiuQi,
>>
>>
>> On 3/9/2017 2:41 AM, Xie XiuQi wrote:
>>> On 2017/3/7 4:45, Tyler Baicar wrote:
>>>> Currently there are trace events for the various RAS
>>>> errors with the exception of ARM processor type errors.
>>>> Add a new trace event for such errors so that the user
>>>> will know when they occur. These trace events are
>>>> consistent with the ARM processor error section type
>>>> defined in UEFI 2.6 spec section N.2.4.4.
>>>>
>>>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>>>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>>>> ---
>>>>    drivers/acpi/apei/ghes.c    |  8 +++++++-
>>>>    drivers/firmware/efi/cper.c |  1 +
>>>>    drivers/ras/ras.c           |  1 +
>>>>    include/ras/ras_event.h     | 34 ++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 43 insertions(+), 1 deletion(-)
>>>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>>>> index 5861b6f..b36db48 100644
>>>> --- a/include/ras/ras_event.h
>>>> +++ b/include/ras/ras_event.h
>>>> @@ -162,6 +162,40 @@
>>>>    );
>>>>      /*
>>>> + * ARM Processor Events Report
>>>> + *
>>>> + * This event is generated when hardware detects an ARM processor error
>>>> + * has occurred. UEFI 2.6 spec section N.2.4.4.
>>>> + */
>>>> +TRACE_EVENT(arm_event,
>>>> +
>>>> +    TP_PROTO(const struct cper_sec_proc_arm *proc),
>>>> +
>>>> +    TP_ARGS(proc),
>>>> +
>>>> +    TP_STRUCT__entry(
>>>> +        __field(u64, mpidr)
>>>> +        __field(u64, midr)
>>>> +        __field(u32, running_state)
>>>> +        __field(u32, psci_state)
>>>> +        __field(u8, affinity)
>>>> +    ),
>>>> +
>>>> +    TP_fast_assign(
>>>> +        __entry->affinity = proc->affinity_level;
>>>> +        __entry->mpidr = proc->mpidr;
>>>> +        __entry->midr = proc->midr;
>>>> +        __entry->running_state = proc->running_state;
>>>> +        __entry->psci_state = proc->psci_state;
>>>> +    ),
>>>> +
>>>> +    TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
>>>> +          "running state: %d; PSCI state: %d",
>>>> +          __entry->affinity, __entry->mpidr, __entry->midr,
>>>> +          __entry->running_state, __entry->psci_state)
>>>> +);
>>>> +
>>> I think these fields are not enough, we need also export arm processor error
>>> information (UEFI 2.6 spec section N.2.4.4.1), or at least the error type,
>>> address, etc. So that the userspace (such as rasdaemon tool) could know what
>>> error occurred.
>> This is something I am planning on adding in later. It is not clear to me how to
>> actually do this at this point. If you look at the spec, there is not a single
>> error information structure. There is at least one, but possibly a lot. There is
>> also an unknown amount of context information structures. In "Table 260. ARM Processor
>> Error Section" there are ERR_INFO_NUM and CONTEXT_INFO_NUM which give the number of these
>> structures. I think there will need to be separate trace events added in for each of
>> these structures because I don't think there is a way to have variable amounts of
>> structures inside of a trace event.
> Yes, I agree.
>
> Additional, cper_sec_proc_arm has validation bit, which indicates whether or not each of
> the fields is valid in this section. How could we show it in this trace event? If the filed
> is invalid, we would get a wrong value here.
>
I will add in checks for whether the fields are valid similar to what 
you did for the error info patch.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
