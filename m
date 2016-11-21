From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Nov 2016 15:21:36 +0000
Subject: spin_lock behavior with ARM64 big.Little/HMP
In-Reply-To: <f9fc9549d801fece7422d97d5d89df8b@codeaurora.org>
References: <400ab4b8b2354c5b9283f6ed657363a0@codeaurora.org>
 <8d9d6333-0ebe-65c4-c6f1-3e3475e3e535@arm.com>
 <f9fc9549d801fece7422d97d5d89df8b@codeaurora.org>
Message-ID: <f17207e7-e58c-2e42-04a8-50ed83a9616f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/11/16 20:22, Vikram Mulukutla wrote:
>
> Hi Sudeep,
>
> Thanks for taking a look!
>
> On 2016-11-18 02:30, Sudeep Holla wrote:
>> Hi Vikram,
>>
>> On 18/11/16 02:22, Vikram Mulukutla wrote:
>>> Hello,
>>>
>>> This isn't really a bug report, but just a description of a
>>> frequency/IPC
>>> dependent behavior that I'm curious if we should worry about. The
>>> behavior
>>> is exposed by questionable design so I'm leaning towards don't-care.
>>>
>>> Consider these threads running in parallel on two ARM64 CPUs running
>>> mainline
>>> Linux:
>>>
>>
>> Are you seeing this behavior with the mainline kernel on any platforms
>> as we have a sort of workaround for this ?
>>
>
> If I understand that workaround correctly, the ARM timer event stream is
> used
> to periodically wake up CPUs that are waiting in WFE, is that right? I
> think
> my scenario below may be different because LittleCPU doesn't actually wait
> on a WFE event in the loop that is trying to increment lock->next, i.e.
> it's
> stuck in the following loop:
>
>         ARM64_LSE_ATOMIC_INSN(
>         /* LL/SC */
> "       prfm    pstl1strm, %3\n"
> "1:     ldaxr   %w0, %3\n"
> "       add     %w1, %w0, %w5\n"
> "       stxr    %w2, %w1, %3\n"
> "       cbnz    %w2, 1b\n",
>

Interesting. Just curious if this is r0p0/p1 A53 ? If so, is the errata
819472 enabled ?

-- 
Regards,
Sudeep
