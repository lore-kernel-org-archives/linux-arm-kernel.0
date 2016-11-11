From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Nov 2016 21:43:26 +0800
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej>
 <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
Message-ID: <5825CAFE.2080005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 07:10 PM, Fu Wei wrote:
> Hi Mark,
>
> On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi,
>>
>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>> automatically, but this will need to be rebased before the next posting
>> and/or merging.
>>
>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei at linaro.org wrote:
>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>> +{
>>> +     int trigger, polarity;
>>> +
>>> +     if (!interrupt)
>>> +             return 0;
>>
>> Urgh.
>>
>> Only the secure interrupt (which we do not need) is optional in this
>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>> figure 5-24 in the ACPI 6.1 spec.
>>
>> So, I think that:
>>
>> (a) we should not bother parsing the secure interrupt
>
> If I understand correctly, from this point of view, kernel don't
> handle the secure interrupt.
> But the current arm_arch_timer driver still enable/disable/request
> PHYS_SECURE_PPI
> with PHYS_NONSECURE_PPI.
> That means we still need to parse the secure interrupt.
> Please correct me, if I misunderstand something? :-)
>
>> (b) we should drop the check above
>
> yes, if zero is a valid GSIV, this makes sense.
>
>> (c) we should report the spec issue to the ASWG
>>
>>> +/*
>>> + * acpi_gtdt_c3stop - got c3stop info from GTDT
>>> + *
>>> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
>>> + */
>>> +bool __init acpi_gtdt_c3stop(void)
>>> +{
>>> +     struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
>>> +
>>> +     return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
>>> +}
>>
>> It looks like this can differ per interrupt. Shouldn't we check the
>> appropriate one?
>
> yes, I think you are right.

I think Mark already clarified this it's a global flag which defined
in the spec, and we don't need to update it.

Thanks
Hanjun
