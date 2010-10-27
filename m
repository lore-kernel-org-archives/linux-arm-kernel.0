From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 27 Oct 2010 11:38:11 -0400
Subject: [PATCH 2/2] [ARM] Dove: add support for multi-purpose pins
	configuration
In-Reply-To: <AANLkTikHDgxgZYdjoBU-BFZbPM1msSpbJTjEi9oNcW_o@mail.gmail.com>
References: <cover.1288166960.git.mike@compulab.co.il>
	<63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
	<AANLkTin1SR2xm7o18uF9vOOAnNJvvjnUxjUPDvifMGp8@mail.gmail.com>
	<4CC83776.8040907@compulab.co.il>
	<AANLkTikHDgxgZYdjoBU-BFZbPM1msSpbJTjEi9oNcW_o@mail.gmail.com>
Message-ID: <AANLkTi=WUwOxEZnhWoLS-8Q4KHaja2BBQfTrBe+2hFPF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 11:16 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Wed, Oct 27, 2010 at 4:30 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> On 10/27/10 14:46, saeed bishara wrote:
>>>> +
>>>> + ? ? ? ? ? ? ? shift = (num & 7) << 2;
>>>> + ? ? ? ? ? ? ? if (*mpp_list & MPP_PMU_MASK) {
>>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_mpp_ctrl |= (0x1 << num);
>>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] &= ~(0xf << shift);
>>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] |= ~(0xf << shift);
>>> the ?~ in line hints something wrong
>>
>> indeed :)
>>
>>>> diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
>>>> new file mode 100644
>>>> index 0000000..c7b8acf
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-dove/mpp.h
>>>> @@ -0,0 +1,214 @@
>>>> +#ifndef __ARCH_DOVE_MPP_CODED_H
>>>> +#define __ARCH_DOVE_MPP_CODED_H
>>>> +
>>>> +#define MPP(_num, _mode, _pmu, _grp, _au1, _nfc) ( ? ? \
>>>> +/* MPP/group number */ ? ? ? ? ((_num) & 0xff) | ? ? ? ? ? ? ? \
>>>> +/* MPP select value */ ? ? ? ? (((_mode) & 0xf) << 8) | ? ? ? ?\
>>>> +/* MPP PMU */ ? ? ? ? ? ? ? ? ?((!!(_pmu)) << 12) | ? ? ? ? ? ?\
>>>> +/* group flag */ ? ? ? ? ? ? ? ((!!(_grp)) << 13) | ? ? ? ? ? ?\
>>>> +/* AU1 flag */ ? ? ? ? ? ? ? ? ((!!(_au1)) << 14) | ? ? ? ? ? ?\
>>>> +/* NFCE flag */ ? ? ? ? ? ? ? ? ? ? ? ?((!!(_nfc)) << 15))
>>> in order to make these defines readable, I suggest to add defines for
>>> the flags, for example:
>>> #define GROUP ? (1 << 13)
>>> then MPP defines look like:
>>>
>>> #define MPPX_GPIO ? ? ? ? ?MPP(MPP_X, 0x1, GROUP|AU1)
>>
>> I think we can make it even more readable with
>>
>> #define MPP_PIN(_num, _sel) ? ? MPP(_num, _sel, 0, 0, 0, 0)
>> #define MPP_GRP(_grp, _sel) ? ? MPP(_grp, _sel, 0, 1, 0, 0)
>> #define MPP_GRP_AU1(_sel) ? ? ? MPP(0, _sel, 0, 0, 1, 0)
>> #define MPP_GRP_NFC(_sel) ? ? ? MPP(0, _sel, 0, 0, 0, 1)
>>
>> What do you think?
> when you have multiple flags in the MPP macro, people would think that
> those flags are not exlusive, in other words, mpp can have multiple
> flags. so I suggest you to use a type (gpr, au1, nfc or pmu).
>

Hi Saeed,

I think it's a good idea to simplify the macros as Mike suggested, we are doing
the same thing for PXA. There is actually another benefit of defining like that
in addition to the readability, - it's less error-prone.

In practice, there is always a fixed combination of flags for a macro
like MPPx_GPIO,
even if the flags are combinational.

I'm not that enthusiastic but it's something to think about.
