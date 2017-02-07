From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 7 Feb 2017 17:19:28 +0000
Subject: [PATCH] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <f92b8ab6-3728-e038-e3c8-bcaa6491075e@codeaurora.org>
References: <1485987318-9145-1-git-send-email-tbaicar@codeaurora.org>
 <877f57qmeq.fsf@e105922-lin.cambridge.arm.com>
 <f92b8ab6-3728-e038-e3c8-bcaa6491075e@codeaurora.org>
Message-ID: <52890e50-8488-13b0-4517-4ee5f7cd3ee4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/02/17 22:21, Baicar, Tyler wrote:
> Hello Punit,
>
>
> On 2/3/2017 9:17 AM, Punit Agrawal wrote:
>> Tyler Baicar <tbaicar@codeaurora.org> writes:
>>
>>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>>
>>> Add VM_FAULT_HWPOISON[_LARGE] handling to the arm64 page fault
>>> handler. Handling of VM_FAULT_HWPOISON[_LARGE] is very similar
>>> to VM_FAULT_OOM, the only difference is that a different si_code
>>> (BUS_MCEERR_AR) is passed to user space and si_addr_lsb field is
>>> initialized.
>>>
>>> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>>> ---
>>>  arch/arm64/mm/fault.c | 31 +++++++++++++++++++++++++++----
>>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> [...]
>>
>>> @@ -426,7 +439,17 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>>>              */
>>>             sig = SIGBUS;
>>>             code = BUS_ADRERR;
>>> -   } else {
>>> +   }
>>> +#ifdef CONFIG_MEMORY_FAILURE
>>> +   else if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
>> Please add spaces around '|'.
> Will do!
>>
>>> +           pr_err(
>>> +   "Killing %s:%d due to hardware memory corruption fault at %lx\n",
>>> +                   tsk->comm, tsk->pid, addr);
>> The message is misleading as we're not really killing a task but
>> delivering a signal (SIGBUS) which might not always lead to the receiver
>> being killed.
>>
>> But considering that we don't print any message for the other faults,
>> I'd prefer that we drop this pr_err.
> Yes, I'll drop the pr_err.
>>> +           sig = SIGBUS;
>>> +           code = BUS_MCEERR_AR;
>>> +   }
>>> +#endif
>> Although to get a HWPOISON fault CONFIG_MEMORY_FAILURE is needed, the
>> handling seems safe even when it is not enabled. Can the ifdeffery be
>> dropped?
> Yes, I can drop the ifdef. The handling would be fine either way.
>>
>> Also, I was wondering how this code was tested? Did you by any chance
>> try using hwpoison inject debugfs interface?
> This was originally tested using proprietary error injection that we have.
>
> I just tried the hwpoison inject interface and it didn't result in
> hitting this code path.
>
> [   70.747697] Injecting memory failure at pfn 0x400340
>
> [   70.748547] Memory failure: 0x400340: Unknown page state
>
> [   70.752911] Memory failure: 0x400340: unknown page still referenced
> by 1 users
>
> [   70.760167] Memory failure: 0x400340: recovery action for unknown
> page: Failed
>
>
> I've never used hwpoison inject though, so maybe I'm doing something
> wrong :)

No worries. Writing the pfn an executable is loaded at
/sys/kernel/debug/hwpoison/corrupt-pfn triggered the code for me. On my
system the program dies after printing "Bus error" - probably what the
default handler from glibc is configured to do in this situation. :)

>
> Thanks,
> Tyler
>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
