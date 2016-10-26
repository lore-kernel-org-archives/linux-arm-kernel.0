From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 26 Oct 2016 21:41:44 +0800
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <57010864-b2f0-d230-3138-8ace484acb04@arm.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej>
 <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
 <57010864-b2f0-d230-3138-8ace484acb04@arm.com>
Message-ID: <CADyBb7uVaUGoOMBd-pnwT2suBy1OpAmQjLriOtSx1zMC-EWazw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 26 October 2016 at 20:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/10/16 12:10, Fu Wei wrote:
>> Hi Mark,
>>
>> On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
>>> Hi,
>>>
>>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>>> automatically, but this will need to be rebased before the next posting
>>> and/or merging.
>>>
>>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei at linaro.org wrote:
>>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>>> +{
>>>> +     int trigger, polarity;
>>>> +
>>>> +     if (!interrupt)
>>>> +             return 0;
>>>
>>> Urgh.
>>>
>>> Only the secure interrupt (which we do not need) is optional in this
>>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>>> figure 5-24 in the ACPI 6.1 spec.
>>>
>>> So, I think that:
>>>
>>> (a) we should not bother parsing the secure interrupt
>>
>> If I understand correctly, from this point of view, kernel don't
>> handle the secure interrupt.
>> But the current arm_arch_timer driver still enable/disable/request
>> PHYS_SECURE_PPI
>> with PHYS_NONSECURE_PPI.
>> That means we still need to parse the secure interrupt.
>> Please correct me, if I misunderstand something? :-)
>
> That's because we can use the per-cpu timer when 32bit Linux is running
> on the secure side (and we cannot distinguish between secure and
> non-secure at runtime). ACPI is 64bit only, and Linux on 64bit isn't
> supported on the secure side, so only registering the non-secure timer
> is perfectly acceptable.

Great thanks for your explanation :-)
So we just don't need to fill arch_timer_ppi[PHYS_SECURE_PPI] , just skip it.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
