From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Jun 2014 18:02:45 +0200
Subject: [PATCH] clocksource: exynos-mct: Register the timer for stable
 udelay
In-Reply-To: <CAD=FV=VUomY-h2euRVWNO=ND0pUNLO5mZr_=sMm_oUSrwBssnA@mail.gmail.com>
References: <1403091060-5054-1-git-send-email-amit.daniel@samsung.com>	<CAD=FV=WHK7TDdqcAd6aVs2g8rcHJx834im_4nTKHJAkUisWq4A@mail.gmail.com>	<53A2A86E.4090903@linaro.org>
 <CAD=FV=VUomY-h2euRVWNO=ND0pUNLO5mZr_=sMm_oUSrwBssnA@mail.gmail.com>
Message-ID: <53A309A5.9040204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 05:49 PM, Doug Anderson wrote:
> Daniel,
>
> On Thu, Jun 19, 2014 at 2:07 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 06/19/2014 01:17 AM, Doug Anderson wrote:
>>>
>>> Amit,
>>>
>>> Thanks for posting!
>>>
>>> On Wed, Jun 18, 2014 at 4:31 AM, Amit Daniel Kachhap
>>> <amit.daniel@samsung.com> wrote:
>>>>
>>>> This patch register the exynos mct clocksource as the current timer
>>>> as it has constant clock rate. This will generate correct udelay for the
>>>> exynos platform and avoid using unnecessary calibrated jiffies. This
>>>> change
>>>> have been tested on exynos5420 based board.
>>>>
>>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>> ---
>>>>
>>>> Patches from David Riley confirmed that udelay is broken in exynos5420.
>>>> Link to those patches are,
>>>> 1) https://patchwork.kernel.org/patch/4344911/
>>>> 2) https://patchwork.kernel.org/patch/4344881/
>>>>
>>>>    drivers/clocksource/exynos_mct.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/clocksource/exynos_mct.c
>>>> b/drivers/clocksource/exynos_mct.c
>>>> index 8d64200..57cb3dc 100644
>>>> --- a/drivers/clocksource/exynos_mct.c
>>>> +++ b/drivers/clocksource/exynos_mct.c
>>>> @@ -198,10 +198,21 @@ static u64 notrace exynos4_read_sched_clock(void)
>>>>           return exynos4_frc_read(&mct_frc);
>>>>    }
>>>>
>>>> +static struct delay_timer exynos4_delay_timer;
>>>> +
>>>> +static unsigned long exynos4_read_current_timer(void)
>>>> +{
>>>> +       return exynos4_frc_read(&mct_frc);
>>>
>>>
>>> This is terribly inefficient to read all 64-bits and then cast back to
>>> a 32-bit value.  Replace with:
>>>
>>> return __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_L);
>>>
>>>
>>>> +}
>>>> +
>>>>    static void __init exynos4_clocksource_init(void)
>>>>    {
>>>>           exynos4_mct_frc_start(0, 0);
>>>
>>>
>>> Please rebase atop (1d80415 clocksource: exynos_mct: Don't reset the
>>> counter during boot and resume), which is in linuxnext among other
>>> places.
>>>
>>>>
>>>> +       exynos4_delay_timer.read_current_timer =
>>>> &exynos4_read_current_timer;
>>>> +       exynos4_delay_timer.freq = clk_rate;
>>>> +       register_current_timer_delay(&exynos4_delay_timer);
>>>> +
>>>>           if (clocksource_register_hz(&mct_frc, clk_rate))
>>>>                   panic("%s: can't register clocksource\n", mct_frc.name);
>>>
>>>
>>> It does seem to work for me though.  :)
>>
>>
>> Doug,
>>
>> aren't you working on a 32 bits version ? So this patch could be simplified
>
> I could do that if someone told me that they'll land it.
>
> My understanding of the current status is:
> * I posed the 64-bit version that's almost as fast as the 32-bit version.
> * I asked if people want the 32-bit version: no answer
> * I asked if anyone is opposed to the 64-bit version: no answer

Yeah, that happens. I thought you were working on the 32 bits.

> I know that you wanted me to clean up the description of the 64-bit
> version so I was going to do that and repost.  If there's someone
> willing to review / ack the 32-bit version I'd be happy to do that
> instead.  Possibly I'll do both and a maintainer can choose which to
> apply?

Please, resend me the patch 1/3 as it is urgent with the changelog changed.

> In the case here I was suggesting using the 32-bit version just
> because on ARM32 there's totally no reason to read 64-bits.  I hadn't
> given a thought to ARM64.  More on that in response to the other
> messages.

Is there a 64bits platform using exynos_mct ?


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
