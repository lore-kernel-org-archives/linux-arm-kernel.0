From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Nov 2013 09:59:11 -0700
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
In-Reply-To: <20131114.084145.998129499909471378.hdoyu@nvidia.com>
References: <5282C512.5090900@wwwdotorg.org><20131113094517.4608edf4302b61e3c4402a25@nvidia.com><5283BDBF.9020509@wwwdotorg.org>
 <20131114.084145.998129499909471378.hdoyu@nvidia.com>
Message-ID: <5285015F.4090003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 11:41 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 13 Nov 2013 18:58:23 +0100:
> 
>>>  smmu: iommu at xxxxxx {
>>>        #iommu-cells = <3>;
>>>        ^^^^^^^^^^^^^^^^^^
>>>    };
>>>
>>>    host1x {
>>>            compatible = "nvidia,tegra30-host1x", "simple-bus";
>>>            iommu = <&smmu 0x??????? 0x??????? "asid">;
>>> 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#######
>>>            gr3d {
>>>                    compatible = "nvidia,tegra30-gr3d";
>>>                    iommu = <&smmu 0x??????? 0x???????>;
>>>            }
>>>
>>> I think that this "asid" part can be set 0 in tegra??.dtsi and the
>>> actual value can be overwritten in tegra??-<boardname>.dts file.
>>
>> The one issue here is that we can only override entire properties, so
>> it's not possible for a board file to *just* replace the ASID, it'd have
>> to duplicate the entire property, just to change the one value.
>>
>> Is the ASID mapping really likely to be board-specific though? To my
>> naive thinking, it seems that the chip design (e.g. number of
>> peripherals, number of available ASIDs) would tend to imply the
>> device->ASID mapping, since it would have been considered as part of
>> chip design. Hence, wouldn't soc.dtsi typically specify the expected
>> ASID mapping, and boards rarely if ever override it?
>>
>> If the ASID mapping really is likely to vary per board, perhaps it makes
>> sense to put it into a separate property somehow so it's easier to override?
> 
>   Older Tegra like T30: swgroups > asid(==4)
>   Newer Tegra         : swgroups < asid

In that case, I'd vote for hard-coding the mapping in the driver in all
cases. For older Tegra, we'll have to hard-code some static mapping just
like you've already done in the driver. For newer Tegra, we would just
assign a new AS for each swgroup as you say. If we ever need to tweak
this, we can invent a new DT property to affect the default. That makes
the DT content quite a bit simpler for now:-)
