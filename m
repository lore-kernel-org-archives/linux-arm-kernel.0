From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Oct 2017 14:47:53 +0800
Subject: [PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two steps
 mappings
In-Reply-To: <20170927135449.GA11347@red-moon>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
 <1506475215-2731-4-git-send-email-hanjun.guo@linaro.org>
 <20170927135449.GA11347@red-moon>
Message-ID: <CAGHbJ3DbuGeKH16zr+PdZYjoaZrHJrTmV5tmMxZ5CDPObErUCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Sorry for the late reply, holidays in China for the past week.

At 2017/9/27 21:54, Lorenzo Pieralisi wrote:
> Hi Hanjun,
>
> On Wed, Sep 27, 2017 at 09:20:14AM +0800, Hanjun Guo wrote:
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
> Is this actually true ? I think that currently we would simply skip
> the entry and print an error log but we can't get a wrong ITS parent.

So the only valid single mapping under type SMMUv3 is SMMUv3's dev id
mapping, we need to fix the IORT spec as well.

>
> I am rewriting this commit (I will probably split it), it is doing the
> right thing but the commit log is stale (probably caused by code
> reshuffling).

Do I need to resend another version, or you can help to update it?
please let me know.

By the way, this patch set was tested on Hisilicon Hip08 with MSI
for SMMU, and it works fine.

Thanks
Hanjun
