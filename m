From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 18 Mar 2013 12:46:01 -0400
Subject: some question about monitor mode support in arm
In-Reply-To: <CANudz+u2kEJRu0P1oVv84AhuGXM8RW-inr=LrPp4WJSKYQ3iJQ@mail.gmail.com>
References: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
 <5141D298.6010401@codeaurora.org>
 <CANudz+u2kEJRu0P1oVv84AhuGXM8RW-inr=LrPp4WJSKYQ3iJQ@mail.gmail.com>
Message-ID: <514744C9.7070505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/18/2013 05:38 AM, loody wrote:
> hi Christopher:
> 
> 2013/3/14 Christopher Covington <cov@codeaurora.org>:
>> Hi,
>>
>> On 03/14/2013 05:43 AM, loody wrote:
>>> Hi all:
>>> Does linux kernel support monitor mode handling?
>>
>> It does not, but hypervisor mode support was recently added, which has pretty
>> similar mechanics.
>>
>>> I grep the keyword 'smc' but it only show how switch to, such as
>>> mach-highbank/smc.S,
>>> but not seem where to handle it.
>>
>> You can take a look at __hyp_set_vectors in arch/arm/kernel/hyp-stub.S for one
>> example of setting up exception vectors.
> I grep what you mentioned.
> But it seems nothing about __hyp_set_vectors you described
> in arch/arm/kernel/hyp-stub.S
> ENTRY(__hyp_set_vectors)
>         __HVC(0)
>         mov     pc, lr
> ENDPROC(__hyp_set_vectors)

I don't think I understand your question, so I'll try to elaborate in hopes of
answering it nevertheless. __hyp_set_vectors may have not been the best label
to start off at, but it looked good at the time because of the nice big
comment above it.

During early boot, assuming a couple sanity checks pass, the hypervisor vector
base is set to __hyp_stub_vectors.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/hyp-stub.S?id=refs/tags/v3.9-rc3#n128

You'll notice that __hyp_stub_vectors is mostly dummy infinite loop entries
except for __hyp_stub_trap, which branches to __hyp_stub_do_trap.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/hyp-stub.S?id=refs/tags/v3.9-rc3#n207

The HVC call in __hyp_set_vectors should follow the
HVBAR->__hyp_stub_trap->__hyp_stub_do_trap path.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/hyp-stub.S?id=refs/tags/v3.9-rc3#n162

At this point the hypervisor exception vectors are swapped out for whatever
the caller specified.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
