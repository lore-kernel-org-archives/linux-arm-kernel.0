From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 27 Oct 2010 17:16:24 +0200
Subject: [PATCH 2/2] [ARM] Dove: add support for multi-purpose pins
	configuration
In-Reply-To: <4CC83776.8040907@compulab.co.il>
References: <cover.1288166960.git.mike@compulab.co.il>
	<63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
	<AANLkTin1SR2xm7o18uF9vOOAnNJvvjnUxjUPDvifMGp8@mail.gmail.com>
	<4CC83776.8040907@compulab.co.il>
Message-ID: <AANLkTikHDgxgZYdjoBU-BFZbPM1msSpbJTjEi9oNcW_o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 4:30 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> On 10/27/10 14:46, saeed bishara wrote:
>>> +
>>> + ? ? ? ? ? ? ? shift = (num & 7) << 2;
>>> + ? ? ? ? ? ? ? if (*mpp_list & MPP_PMU_MASK) {
>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_mpp_ctrl |= (0x1 << num);
>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] &= ~(0xf << shift);
>>> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] |= ~(0xf << shift);
>> the ?~ in line hints something wrong
>
> indeed :)
>
>>> diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
>>> new file mode 100644
>>> index 0000000..c7b8acf
>>> --- /dev/null
>>> +++ b/arch/arm/mach-dove/mpp.h
>>> @@ -0,0 +1,214 @@
>>> +#ifndef __ARCH_DOVE_MPP_CODED_H
>>> +#define __ARCH_DOVE_MPP_CODED_H
>>> +
>>> +#define MPP(_num, _mode, _pmu, _grp, _au1, _nfc) ( ? ? \
>>> +/* MPP/group number */ ? ? ? ? ((_num) & 0xff) | ? ? ? ? ? ? ? \
>>> +/* MPP select value */ ? ? ? ? (((_mode) & 0xf) << 8) | ? ? ? ?\
>>> +/* MPP PMU */ ? ? ? ? ? ? ? ? ?((!!(_pmu)) << 12) | ? ? ? ? ? ?\
>>> +/* group flag */ ? ? ? ? ? ? ? ((!!(_grp)) << 13) | ? ? ? ? ? ?\
>>> +/* AU1 flag */ ? ? ? ? ? ? ? ? ((!!(_au1)) << 14) | ? ? ? ? ? ?\
>>> +/* NFCE flag */ ? ? ? ? ? ? ? ? ? ? ? ?((!!(_nfc)) << 15))
>> in order to make these defines readable, I suggest to add defines for
>> the flags, for example:
>> #define GROUP ? (1 << 13)
>> then MPP defines look like:
>>
>> #define MPPX_GPIO ? ? ? ? ?MPP(MPP_X, 0x1, GROUP|AU1)
>
> I think we can make it even more readable with
>
> #define MPP_PIN(_num, _sel) ? ? MPP(_num, _sel, 0, 0, 0, 0)
> #define MPP_GRP(_grp, _sel) ? ? MPP(_grp, _sel, 0, 1, 0, 0)
> #define MPP_GRP_AU1(_sel) ? ? ? MPP(0, _sel, 0, 0, 1, 0)
> #define MPP_GRP_NFC(_sel) ? ? ? MPP(0, _sel, 0, 0, 0, 1)
>
> What do you think?
when you have multiple flags in the MPP macro, people would think that
those flags are not exlusive, in other words, mpp can have multiple
flags. so I suggest you to use a type (gpr, au1, nfc or pmu).

>
>>
>>> +
>>> +#define MPP20_GPIO20 ? ? ? ? ? MPP(20, 0x0, 0, 0, 0, 0)
>>> +#define MPP20_AC97_SYSCLK_OUT ?MPP(20, 0x1, 0, 0, 0, 0)
>>> +#define MPP20_SPI_2_MISO ? ? ? MPP(20, 0x2, 0, 0, 0, 0)
>> I'ld rather call this LCD_SPI instead of SPI_2 to make it clear that
>> this SPI is different
>
>
> --
> Sincerely yours,
> Mike.
>
