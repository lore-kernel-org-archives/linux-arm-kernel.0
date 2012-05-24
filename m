From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 May 2012 23:11:09 +0530
Subject: [PATCH] ARM: davinci: turn off DDR PHY when entering deep sleep
In-Reply-To: <CAM8FrKJijXr1nJFhJZDSufHmfRQXL1RPwUA7OsSTVAiGPhECuA@mail.gmail.com>
References: <marcus.folkesson@gmail.com>
 <1336672352-23191-1-git-send-email-marcus.folkesson@gmail.com>
 <4FBA7D9D.6060202@ti.com>
 <CAM8FrKJijXr1nJFhJZDSufHmfRQXL1RPwUA7OsSTVAiGPhECuA@mail.gmail.com>
Message-ID: <4FBE72B5.2000106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On 5/24/2012 5:16 PM, Marcus Folkesson wrote:

>>> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
>>> index 5f1e045..30713b2 100644
>>> --- a/arch/arm/mach-davinci/sleep.S
>>> +++ b/arch/arm/mach-davinci/sleep.S
>>> @@ -57,6 +57,11 @@ ENTRY(davinci_cpu_suspend)
>>>
>>>       ldmia   r0, {r0-r4}
>>>
>>> +     /* Turn PHY off */
>>> +     ldr     ip, [r0, #DDR2_DRPHYC1R_OFFSET]
>>> +     orr     ip, ip, #DDR_PWRDNEN_BIT
>>> +     str     ip, [r0, #DDR2_DRPHYC1R_OFFSET]
>>
>> Current TRM (section 14.2.13.1) specifies that this bit be set during
>> DDR initialization sequence itself (done in UBL or U-Boot/SPL). I am
>> checking with folks from the TI design team on whether it can be done
>> later on as part of the DeepSleep sequence.
>>
>> It looks like IOPWRDN bit in VTPIO_CTL also needs to be set for this
>> configuration take effect. You probably did not have to do it because
>> the bootloader you are using already has this set?
>>
>> How much testing has this patch undergone? Have you tested it across
>> multiple suspend-resume cycles? How much does the power consumed by DDR
>> PHY go down by (and which type of DDR)?
> 
> You are right.
> 
> I now see that it is possible to set all those bits in the bootloader
> and let the PHY automatically go down in idle.
> This patch is therefore unnecessary.

It will be great if you can check if the current U-Boot/SPL for AM18x
sets these bits as part of the DDR initialization and if not, submit a
patch to U-Boot list for that?

BTW, I am yet to hear from the designers on whether this can be done
outside of DDR initialization step. If they confirm this can be done, it
will be useful to take this patch in to minimize the bootloader dependency.

Thanks,
Sekhar
