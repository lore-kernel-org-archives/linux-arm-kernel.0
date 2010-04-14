From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 14 Apr 2010 10:56:08 -0700
Subject: [PATCH 2/2] arm: invalidate TLBs when enabling mmu
In-Reply-To: <s2uf17812d71004141049je7f7b8e5n7d19e89bcaf28fc4@mail.gmail.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>	<1268143623-22361-3-git-send-email-saeed@marvell.com>
	<1268153134.1000.14.camel@e102109-lin.cambridge.arm.com>
	<s2uf17812d71004141049je7f7b8e5n7d19e89bcaf28fc4@mail.gmail.com>
Message-ID: <4BC601B8.3000309@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2010 10:49 AM, Eric Miao wrote:
> On Wed, Mar 10, 2010 at 12:45 AM, Catalin Marinas
> <catalin.marinas@arm.com>  wrote:
>> On Tue, 2010-03-09 at 14:07 +0000, Saeed Bishara wrote:
>>> Signed-off-by: Saeed Bishara<saeed@marvell.com>
>>> ---
>>>   arch/arm/boot/compressed/head.S |    1 +
>>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/compressed/head.S
>>> b/arch/arm/boot/compressed/head.S
>>> index 4fddc50..a1ab79f 100644
>>> --- a/arch/arm/boot/compressed/head.S
>>> +++ b/arch/arm/boot/compressed/head.S
>>> @@ -489,6 +489,7 @@ __armv7_mmu_cache_on:
>>>                  mcr     p15, 0, r0, c1, c0, 0   @ load control
>>> register
>>>                  mrc     p15, 0, r0, c1, c0, 0   @ and read it back
>>>                  mov     r0, #0
>>> +               mcr     p15, 0, r0, c8, c7, 0   @ invalidate I,D TLBs
>>>                  mcr     p15, 0, r0, c7, c5, 4   @ ISB
>>>                  mov     pc, r12
>>
>> The TLB invalidating is done earlier in the __armv7_mmu_cache_on
>> function, why do you need to do it again?
>>
>
> Well, the only difference between these two "invalidate"s looks like one is
> before control register load and one after.
>
> We do have the problem of slow decompressing when this invalidate
> change is not there. I do suspect this might be Dove specific. But yet,
> Catalin, could you confirm the behavior difference of "invalidate" before
> and after MMU is actaully turned on?
>

I also met this slow decompressing issue without this patch when I was trying 
kexec on Freescale imx51 babbage board.

Sascha, do you have any comments on this?

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
