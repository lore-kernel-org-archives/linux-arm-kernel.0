From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 23 Mar 2012 14:17:13 +0100
Subject: [RFC][PATCH 4/9] ARM: OMAP3: define cpuidle statically
In-Reply-To: <4F6C6F8C.8010307@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
 <1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org>
 <CAORVsuUZUWrwzx0hYT4YC0HhwAzTKF+q++LPvg43iy-iYbTivA@mail.gmail.com>
 <4F6C6F8C.8010307@linaro.org>
Message-ID: <CAORVsuX0CXjfJkeGyS8LHNsAuTf3yP8Qtqr-G7sm17J83_L1VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 1:41 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 03/23/2012 01:35 PM, Jean Pihet wrote:
>>
>> On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> ?wrote:
>>>
>>> Use the new cpuidle API and define in the driver the states.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>> ---
>
>
> [ ... ]
>
>
>>> ? ? ? ?/*
>>> ? ? ? ? * Erratum i583: implementation for ES rev< ?Es1.2 on 3630. We
>>> cannot
>>
>> C7 is enabled only if the errata does not apply.
>> This causes a problem with the statically defined C-states and also
>> with the per C-state sysfs disable knob. A consistency check should be
>> performed before trying to enter a state.
>
>
> In the patch 5/9, I decrement the state_count if the errata applies. I
> believe it is still compatible with the static C-states.
Correct! That solves the issue with the statically defined C-states.
The (dynamic) per C-state sysfs disable knob requires a runtime check
on .disable though, in case the cpuidle chosen C-state is demoted
(depending on the value of enable_off_mode and later the latency
constraints on the power domain).

>
>
>>> @@ -338,7 +372,6 @@ int __init omap3_idle_init(void)
>>> ? ? ? ?drv->state_count = OMAP3_NUM_STATES;
>>> ? ? ? ?cpuidle_register_driver(&omap3_idle_driver);
>>>
>>> - ? ? ? dev->state_count = OMAP3_NUM_STATES;
>>> ? ? ? ?if (cpuidle_register_device(dev)) {
>>> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: CPUidle register device failed\n",
>>> ? ? ? ? ? ? ? ? ? ? ? __func__);
>>> --
>>> 1.7.5.4
>>>
>>
Thanks!
Jean

>
>
>
> --
> ?<http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro: ?<http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
