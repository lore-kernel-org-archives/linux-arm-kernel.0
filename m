From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 10:36:07 -0700
Subject: [PATCHv7 06/12] ARM: tegra: create a DT header defining SWGROUP ID
In-Reply-To: <20131220123554.GQ27787@ulmo.nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-7-git-send-email-hdoyu@nvidia.com>
 <52B1568F.1050305@gmail.com> <52B1CCF1.2040907@wwwdotorg.org>
 <20131220123554.GQ27787@ulmo.nvidia.com>
Message-ID: <52B48007.7050002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 05:35 AM, Thierry Reding wrote:
> On Wed, Dec 18, 2013 at 09:27:29AM -0700, Stephen Warren wrote:
>> On 12/18/2013 01:02 AM, Mark Zhang wrote:
>>> On 12/12/2013 03:57 PM, Hiroshi Doyu wrote:
>>>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
>>>> binding. "swgroup" is a group of H/W clients which a Tegra SoC
>>>> supports. This unique ID can be used to calculate MC_SMMU_<swgroup
>>>> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
>>>> register bit. This will allow the same header to be used by both
>>>> device tree files, and drivers implementing this binding, which
>>>> guarantees that the two stay in sync. This also makes device trees
>>>> more readable by using names instead of magic numbers. For HOTRESET
>>>> bit shifting we need another conversion table, which will come later.
>>
>>>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
>>
>>>> +#define TEGRA_SWGROUP_MPE	11	/* 0x264 */
>>>> +#define TEGRA_SWGROUP_MSENC	SWGROUP_MPE
>>>
>>> Need to change this to:
>>>
>>> #define TEGRA_SWGROUP_MSENC	11
>>>
>>> The reason is that, this makes "TEGRA_SWGROUP_BIT" doesn't work. So if I
>>> write "TEGRA_SWGROUP_CELLS(MSENC)" in dt, that causes a dt compiling error.
>>
>> I guess it's because TEGRA_SWGROUP_BIT needs to expand its argument
>> twice, which can be done.
>>
>> That all said, just defining all the names directly to constants is
>> probably the most direct fix.
> 
> Erm... isn't this simply a typo, where:
> 
> 	#define TEGRA_SWGROUP_MSENC	SWGROUP_MPE
> 
> should simply be
> 
> 	#define TEGRA_SWGROUP_MSENC	TEGRA_SWGROUP_MPE
> 
> ?
> 
> That certainly works for me.

You're right. I guess ## is defined to re-expand its result, so
TEGRA_SWGROUP_BIT(ISP2) -> TEGRA_SWGROUP_##ISP2 -> TEGRA_SWGROUP_ISP2 ->
TEGRA_SWGROUP_ISP -> 8.
