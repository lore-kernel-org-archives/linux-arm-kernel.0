From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 09:44:43 -0700
Subject: [PATCHv4 1/7] ARM: tegra: Create a DT header defining SWGROUP ID
In-Reply-To: <20131115122926.9166a6693bb9378a7f2c1526@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>	<1384158718-4756-2-git-send-email-hdoyu@nvidia.com>	<5282B036.9090604@wwwdotorg.org>
 <20131115122926.9166a6693bb9378a7f2c1526@nvidia.com>
Message-ID: <52864F7B.901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 03:29 AM, Hiroshi Doyu wrote:
> On Tue, 12 Nov 2013 23:48:22 +0100
> Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
>>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
>>> binding. "swgroup" is a group of H/W clients which a Tegra SoC
>>> supports. This unique ID can be used to calculate MC_SMMU_<swgroup
>>> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
>>> register bit. This will allow the same header to be used by both
>>> device tree files, and drivers implementing this binding, which
>>> guarantees that the two stay in sync. This also makes device trees
>>> more readable by using names instead of magic numbers. For HOTRESET
>>> bit shifting we need another conversion table, which will come later.
>>
>>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
>>
>>> +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
>>> +
>>> +#define TEGRA_SWGROUP_MAX	64
>>> +
>>> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
>>
>> If I put the following into a DT and compile it:
>>
>> #define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
>> #define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
>> / {
>> 	test-prop = <(TEGRA_SWGROUP_BIT(PPCS2))>;
>> };
>>
>> I get:
>>
>> Error: arch/arm/boot/dts/tegra20.dtsi:11.28-29 integer value out of
>> range 0000000000000020 (32 bits)
>> FATAL ERROR: Syntax error parsing input tree
>>
>> Is TEGRA_SWGROUP_BIT() not meant to be used in DT files? If it is, the
>> definition is broken. If it is not, it should be defined in the driver
>> not the header, since DT files have no use for it.
> 
> I'd like to use the macro in DT but what I want is 2 cells from 64 bit.
> For the above example, I want the following 2 cell to be generated but I
> haven't found any ways yet.
> 
> #define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> #define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
> / {
>  	test-prop = <0x00000000 0x00000001>;
> };

I guess you'd need to do something like:

#define MSW_OF_U64(x) ((x) >> 32)
#define LSW_OF_U64(x) ((x) & 0xffffffff)

... and use those to construct the two cells explicitly.

Or, explicitly name TEGRA_SWGROUP_xxx so that it's obvious which go in
the MSW and which in the LSW, and then:

#define TEGRA_SWGROUP_BIT(x)	(1ULL << (TEGRA_SWGROUP_##x % 32))

It might also be possible to do:

#define TWO_U32_OF_U64(x) ((x) >> 32) ((x) & 0xffffffff)

... which expands to both cells at once, although that's verging on
hiding DT structure behind a macro, which isn't exceptionally great, but
might be acceptable in this limited case.
