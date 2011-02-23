From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 13:15:51 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <AANLkTimffVNK2EmTqypQcrWHLisf3c8_dMsHwSbv-nWi@mail.gmail.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
	<AANLkTimffVNK2EmTqypQcrWHLisf3c8_dMsHwSbv-nWi@mail.gmail.com>
Message-ID: <AANLkTikk6f0Nv8XZEmY4-85FtBE1re9hKqgFRNZkyPfz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 1:08 PM, Olof Johansson <olof@lixom.net> wrote:
> Stephen,
>
> Since this depends on i2c, and registers one of the adapters to do it,
> we should just get the adapters registered separately (all of them)
> before this. I was holding off that part of board code since the i2c
> driver went up that maintainer path instead, but if Colin pulls it
> into tegra for-next, then I'll go ahead with those peices as well.
>
> I'll pick up the board-side patches from this series (1, 4, 5), and
> Colin will take the core patches (2, 3).
>
>
> On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
>
>> +static struct wm8903_platform_data harmony_wm8903_pdata = {
>> + ? ? ? .irq_active_low = 0,
>> + ? ? ? .micdet_cfg = 0,
>> + ? ? ? .micdet_delay = 100,
>> + ? ? ? .gpio_base = GPIO_WM8903(0),
>> + ? ? ? .gpio_cfg = {
>> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
>> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
>> + ? ? ? ? ? ? ? 0,
>> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
>> + ? ? ? ? ? ? ? WM8903_GPIO_NO_CONFIG,
>> + ? ? ? },
>> +};
> [...]
>> diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
>> index 4fe33b8..fbf2304 100644
>> --- a/arch/arm/mach-tegra/board-harmony.h
>> +++ b/arch/arm/mach-tegra/board-harmony.h
>> @@ -17,12 +17,19 @@
>> ?#ifndef _MACH_TEGRA_BOARD_HARMONY_H
>> ?#define _MACH_TEGRA_BOARD_HARMONY_H
>>
>> +#define GPIO_WM8903(_x_) ? ? ? ? ? ? ? (TEGRA_NR_GPIOS + (_x_))
>
>
> The above assumes that wm8903 is the GPIO controller that gets
> allocated the numbers right after native tegra gpio. That might not be
> the case on all boards, since the TPS PMIC has some as well, I
> believe.
The GPIO numbers above TEGRA_NR_GPIOS are allocated by the board, and
this is in board-harmony.h, so I think its OK.

> Does it need a hardcoded GPIO base, or can it use the dynamic one
> (i.e. use -1 here)? I don't even see any reference to gpio_base in the
> driver...
I assume that is in the ASoC tree.  The platform data in tegra
for-next does not include a gpio_base entry.
