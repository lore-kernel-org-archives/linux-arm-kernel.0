From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 29 Jun 2013 00:27:04 +0200
Subject: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
In-Reply-To: <1721255.XMYjiW81jp@amdc1227>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
 <19893620.AhWB5HomTT@amdc1227> <51CD7169.6010905@linaro.org>
 <1721255.XMYjiW81jp@amdc1227>
Message-ID: <51CE0DB8.5040407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2013 07:31 PM, Tomasz Figa wrote:
> On Friday 28 of June 2013 13:20:09 Daniel Lezcano wrote:

[ ... ]

>> The kernel is not a playground where you can upstream code and then
>> remove it because a feature seems broken and you don't have an idea of
>> why.
> 
> Well, first of all, it has not been upstreamed correctly: a) without any 
> given rationale (or at least without any I could find) and b) without enough 
> testing.

+1

>> I asked several times the reasons of why the AFTR state couldn't work
>> with multiple CPUs and I had no answer.
>>
>> Frankly speaking I have a couple of hypothesis:
>>
>> 1. something is not correctly setup and the PMU does not wake up the CPU1
>> 2. there is a silicon bug and no one wants to tell it is the case
>>
>> In any case, this must be investigated and identified. And then we can
>> take a decision about this state.
> 
> Well, everything you're saying is correct, assuming that this feature is 
> useful, which needs confirmation. I'd still want any evidence of this 
> feature being of any use first, to not waste time on something that is 
> useless.

IMHO, it is useful. That's sure a highly integrated hardware with a lot
of peripherals, the power saving is lost in the noise but with a small
embedded device, the power saving is significant.

What I am worried about is the different SoCs being introduced in this
driver without investigating this cpu1 restriction and it sounds like
the AFTR seems to work (I have an odroid-u2 with a 4412 I will test to
check if the AFTR works on it) and nobody seems to be hurt by this and,
as you stated, there is no rational about it. That means the Exynos will
become really more and more power aggressive with 4/A15 or 8/A15 based
boards if the AFTR state is not correctly supported.

AFAICT, there is also the LPA state and the DEEPSLEEP, right ? If the
AFTR does not work, I don't see these states working too.

The cpuidle driver is critical for the new b.L architecture. If we
aren't able to put a cluster of big cpus in a power down state, we lose
the benefit of all the work made up-front at the scheduler level (eg.
small task packing, workqueue/timer migration) and more generally we
lose the benefit of the b.L architecture (except if we do some hacks
which are orthogonal to the generic approach).

I should have added this point to 4) to the mail I sent previously to
Bartlomiej...

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
