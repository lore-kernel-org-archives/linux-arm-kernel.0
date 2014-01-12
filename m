From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 03:26:51 +0100
Subject: [PATCH 0/6] cpufreq: use cpufreq-cpu0 driver for exynos4210 based
 platforms
In-Reply-To: <CAJuA9ahCc7b=209Tmh-O_cx2aEhPY+s_TjHHnjGk1x3duE-P1g@mail.gmail.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <20140110113240.797381e6@amdc2363>
 <CAJuA9ahCc7b=209Tmh-O_cx2aEhPY+s_TjHHnjGk1x3duE-P1g@mail.gmail.com>
Message-ID: <52D1FD6B.9050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.01.2014 12:59, Thomas Abraham wrote:
> Hi Lukasz,
>
> On Fri, Jan 10, 2014 at 4:02 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> Hi Thomas,
>>
>> I've investigated the topic for a while, so if you don't mind I will
>> share my thoughts :-)
>
> Sure. Thanks for having a look at this patch series.
>
>>
>>> The patch series removes the use of Exynos4210 specific cpufreq driver
>>> and enables to use the cpufreq-cpu0 driver for Exynos4210 based
>>> platforms. This is being done for few reasons.
>>>
>>> (a) The Exynos4210 cpufreq driver reads/writes clock controller
>>> registers bypassing the Exynos4 CCF driver which is sort of
>>> problematic.
>>
>> Also other, already supported devices suffer from it. Namely -
>> Exynos4x12 and Exynos5250.
>>
>
> Right, I did check the cpufreq driver of these SoCs.
>
>> That's why the solution shall be as generic as possible to also work
>> with those two SoCs.
>
> The approach taken here is to encapsulate the source of the CPU domain
> clock in a single logical clock. The implementation of this logical
> clock can vary for different Exynos SoCs but the interface to register
> and use this clock is common for all Exynos SoCs. If the changes in
> the cpufreq-cpu0 driver are accepted, the combination of cpufreq-cpu0
> and the logical clock representing the CPU clock is sufficient to
> provide a generic solution for Exynos4x12 and Exynos5250 SoCs.

Well, looking at Exynos SoCs, the structure of core block is very 
similar on all of them. You have a single mux to select between MPLL and 
APLL and then a number of dividers that need to be configured 
quasi-atomically when CPU frequency is to be changed or, looking at 
higher level, a set of registers, which values need to be changed 
(possibly masked).

I'd say it wouldn't require much more effort to make this common at 
least for all currently supported Exynos SoCs (except 5440, which has 
completely different clock logic).

Best regards,
Tomasz
