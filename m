From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 30 Oct 2015 12:27:15 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <20151030115744.GC2854@e104818-lin.cambridge.arm.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <20151029114005.GB389@arm.com> <1446159896024.99950@nvidia.com>
 <20151030110010.GA2854@e104818-lin.cambridge.arm.com>
 <56335024.9090009@arm.com>
 <20151030115744.GC2854@e104818-lin.cambridge.arm.com>
Message-ID: <56336223.4000807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/10/15 11:57, Catalin Marinas wrote:
> On Fri, Oct 30, 2015 at 11:10:28AM +0000, Sudeep Holla wrote:
>> On 30/10/15 11:00, Catalin Marinas wrote:
>>> BTW, it looks like I don't get any cache information on Juno
>>> with 4.3-rc7, it says "Unable to detect cache hierarchy from DT
>>> for CPU 0". I thought the point of the patch you are trying to
>>> revert was to parse this information from the hardware registers.
>>> Sudeep, any idea?
>>>
>>
>> Yes you need to have updated DT from the mainline. Since the
>> architecture doesn't provide any way of detecting the cpus sharing
>> particular cache, we get that information from DT.
>>
>> If DT lacks that info we don't expose any information. It would be
>> wrong to say that a shared cache is shared by all the cpus in the
>> system. DT check was added explicitly to avoid that.
>
> OK, thanks for the information. The good thing is that use space
> should already be able to cope with cache information not present in
> sysfs.
>

True.

> So, rather than reverting this feature, for the Denver case we have
> the option of either providing full cache topology information in DT
> or providing a DT flag which states whether hardware cache ID
> information is relevant.
>

Yes at-least few L2 cache controllers where either hardware can't 
provide that information or provides incorrect one, already use/override
values from DT.

We can probably patch core cacheinfo itself as PPC also completely
depends on DT(though not yet migrated to use generic cacheinfo). In that
way we can avoid calling arch code if all the information is found in DT.

> What about ACPI? Are there any provisions for specifying such
> information?
>

Not yet.

-- 
Regards,
Sudeep
