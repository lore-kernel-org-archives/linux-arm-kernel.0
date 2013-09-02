From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Sep 2013 15:18:51 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
In-Reply-To: <7429815.RzOHxBbusd@amdc1032>
References: <4002844.4ZqqJexTv4@amdc1032> <52245239.4000903@linaro.org>
 <7429815.RzOHxBbusd@amdc1032>
Message-ID: <5224903B.9050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 11:41 AM, Bartlomiej Zolnierkiewicz wrote:
> On Monday, September 02, 2013 10:54:17 AM Daniel Lezcano wrote:
>> On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
>>> Add "cpuidle-exynos.max_states=" parameter to allow user to specify
>>> the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.
>>>
>>> This change is needed because C1 state (AFTR mode) is often not able
>>> to work properly due to incompatibility with some bootloader versions.
>>>
>>> Usage examples:
>>>
>>> "cpuidle-exynos.max_states=1" disables C1 state (AFTR mode).
>>>
>>> "cpuidle-exynos.max_states=0" disables the driver completely.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> Cc: Tomasz Figa <t.figa@samsung.com>
>>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> There is a max_cstate option for acpi and intel idle. There is also the
>> cpuidle.off=1 option. As the semantic is the same, I think adding a
>> common cpuidle option usable for all the drivers is better.
> 
> I thought about making the option common for all cpuidle drivers first
> but due to support for multiple cpuidle drivers on one machine (i.e.
> big.LITTLE), per-driver option looked like a better approach.
> 
> Should I make the option common and not worry about multiple drivers on
> one machine support?

Mmh, that's a good point.

I am not in favor of multiple options spread across the different
drivers. Furthermore the max_cstate is used in the intel platform to
'discover' what states the firmware supports which is not the case of
the cpuidle ARM drivers (except new PSCI based). This option does not
really fits well here.

There is the kernel parameter 'cpuidle.off', so disabling the driver is ok.

You converted the cpuidle driver to a platform driver. Isn't possible to
pass information in the platform data field at boot time to tell AFTR is
not supported and then act on the 'disabled' field of this state ?



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
