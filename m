From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 14 Feb 2018 11:49:09 +0800
Subject: [PATCH] arm64: Enable SPRD_TIMER
In-Reply-To: <CAAfSe-v_i=EnrvKWKmWsi4wSx=EiHK_0Q7KfouaQ8o5iYo+yrA@mail.gmail.com>
References: <6fff71482ed7bb63afa46c024638c0a72810ce29.1517913264.git.baolin.wang@linaro.org>
 <CAAfSe-uQqVPB5B0OYij-bx6Q7AnGnONNqYtwWkU_b2rSJfCpfw@mail.gmail.com>
 <CAMz4kuK9GAR8Ao7RbN5+QUo2-v-bDXaCbtGrzE7Qx_TY=xfTng@mail.gmail.com>
 <CAAfSe-v_i=EnrvKWKmWsi4wSx=EiHK_0Q7KfouaQ8o5iYo+yrA@mail.gmail.com>
Message-ID: <CAMz4kuK4gofFoWm8=UE72spqz5OUtkj82=aDC7c=0RwhuXi_Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

On 11 February 2018 at 19:41, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> Hi Baolin,
>
> On 7 February 2018 at 11:12, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 7 February 2018 at 10:31, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>> Hi Baolin,
>>>
>>> On 6 February 2018 at 18:36, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> Enable Spreadtrum timer driver for Spreadtrum plaform, which will be used
>>>> as tick broadcast device.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>> ---
>>>>  arch/arm64/Kconfig.platforms |    1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>> index fbedbd8..3e0bbb0 100644
>>>> --- a/arch/arm64/Kconfig.platforms
>>>> +++ b/arch/arm64/Kconfig.platforms
>>>> @@ -224,6 +224,7 @@ config ARCH_TEGRA
>>>>
>>>>  config ARCH_SPRD
>>>>         bool "Spreadtrum SoC platform"
>>>> +       select SPRD_TIMER
>>>
>>> Do we have to select SPRD_TIMER here? SC9836, SC9860 have been working
>>> with a minimum system without SPRD TIMER.
>>
>> Yes, we need register this timer as the tick broadcast device,
>> otherwise we will use one hrtimer to be registered the broadcast
>> device, which will affect the No-Hz of CPU attaching the
>> broadcast-hrtimer.
>
> Again, Spreadtrum's two boards - SC9836/SC9860 - can run into console
> without SPRD_TIMER, we can also debug some kernel origianl feature or
> some basic drivers on these two boards, such as CoreSight, clock
> driver, etc.

Ii think you misunderstood my meaning, I did not say it can not work
without the SPRD TIMER. Let me try to explain it again, it we did not
select the Spreadtrum timer, we will use one hrtimer to be the tick
broadcast device, so in this situation, the cpu attaching the
broadcast-hrtimer can not be entered into No-Hz to save power to avoid
dead-lock issue. But if we register one timer as the tick broadcast
device, then all cpus can be entered No-Hz to save power. So that's
why we need select the SPRD_TIMER.

>
> In my opinion we should keep the kernel as simple as possible, the
> above information can go to the 'help' graph of SPRD_TIMER in its
> Kconfig.

That's one optimization, not the issue of making the kernel more
complicated. OK, I will add some kerneldoc to explain that.

-- 
Baolin.wang
Best Regards
