From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 05:39:00 +0800
Subject: [RFC PATCH v2 3/4] ACPI: IORT: Skip SMMUv3 device ID map for
 two steps mappings
In-Reply-To: <20170922125334.GC3475@red-moon>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
 <1505999838-52530-4-git-send-email-guohanjun@huawei.com>
 <20170922125334.GC3475@red-moon>
Message-ID: <59CAC8F4.2040503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2017 08:53 PM, Lorenzo Pieralisi wrote:
> On Thu, Sep 21, 2017 at 09:17:17PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> IORT revision C introduced SMMUv3 MSI support which adding a
>> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
>> device ID mapping for the output ID (dev ID for ITS) and the
>> link to which ITS.
>>
>> So if a platform supports SMMUv3 MSI for control interrupt,
>> there will be a additional single map entry under SMMU, this
>> will not introduce any difference for devices just use one
>> step map to get its output ID and parent (ITS or SMMU), such
>> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
>> do the special handling for two steps map case such as
>> PCI/NC--->SMMUv3--->ITS.
>>
>> Take a PCI hostbridge for example,
>>
>> |----------------------|
>> |  Root Complex Node   |
>> |----------------------|
>> |    map entry[x]      |
>> |----------------------|
>> |       id value       |
>> | output_reference     |
>> |---|------------------|
>>      |
>>      |   |----------------------|
>>      |-->|        SMMUv3        |
>>          |----------------------|
>>          |     SMMU dev ID      |
>>          |     mapping index 0  |
>>          |----------------------|
>>          |      map entry[0]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 1 (SMMU MSI domain)
>>          |----------------------|
>>          |      map entry[1]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 2 (PCI MSI domain)
>>          |----------------------|
>>
>> When the SMMU dev ID mapping index is 0, there is entry[0]
>> to map to a ITS, we need to skip that map entry for PCI
>> or NC (named component), or we may get the wrong ITS parent.
>
> We do skip it because it is a single mapping that it is currently
> not allowed for SMMUv3 components, right ?
>
> Ok, we barf with a printk log message if we encounter such mapping
> but the mapping won't resolve to the SMMUv3 MSI in the current
> kernel.

This is not clear in the spec, maybe we also need to update the IORT
spec about it.

Thanks
Hanjun
