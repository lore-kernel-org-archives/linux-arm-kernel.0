From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Sat, 11 Oct 2014 09:49:29 +0545
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <7h8uknk2gm.fsf@deeprootsystems.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <7hiojuno9e.fsf@deeprootsystems.com>
 <CAM4voanoOV44EQveAeikp1P0bXCU8HHdX2XDi3jwLkfQOP0CNQ@mail.gmail.com>
 <CABxcv==V0vR2XXq5cKzbaqkCbtkqKgrhJotdPSM5K0uyNW968w@mail.gmail.com>
 <7hbnpknc98.fsf@deeprootsystems.com>
 <7hh9zcluhg.fsf@deeprootsystems.com>
 <CAM4voak+OKr+Lu58HfJq_JtE-9Buebme7EK3CiViZA1-Pajc7w@mail.gmail.com>
 <7h8uknk2gm.fsf@deeprootsystems.com>
Message-ID: <CAGm_ybh2OwKMZKzYF+ar3uvCf-_Khz8F4N6yeYNdk3bRMTRteg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Sat, Oct 11, 2014 at 3:47 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Abhilash Kesavan <kesavan.abhilash@gmail.com> writes:
>
>> On Fri, Oct 10, 2014 at 4:29 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Kevin Hilman <khilman@kernel.org> writes:
>>>
>>> [...]
>>>
>>>> Trying $SUBJECT series on top of kukjin's for-next is working fine, but
>>>> I'm still not able to make it work on linux-next, with or without the
>>>> CLK_IGNORE_UNUSED patch.
>>>
>>> Nevermind, turns out I didn't apply the CLK_IGNORE_UNUSED PATCH.  If I
>>> actually apply it, I have it working on top of linux-next.  However, it
>>> seems to have some issues with the nonboot CPUs resuming:
>>>
>>> [   11.319833] Enabling non-boot CPUs ...
>>> [   12.319134] CPU1: failed to come online
>>> [   12.319235] Error taking CPU1 up: -5
>>> [   13.319137] CPU2: failed to come online
>>> [   13.319209] Error taking CPU2 up: -5
>>> [   14.319133] CPU3: failed to come online
>>> [   14.319224] Error taking CPU3 up: -5
>>>
>>> Are you guys seeing all the non-boot CPUs coming up?  They fail to come
>>> online, but the /sys/devices/.../cpu?/online reports that they are
>>> online, which means the next attempt to hotplug them will probably BUG().
>>>
>>> Also, If I turn off the switcher (enabled by default exynos_defconfig),
>>> resume still has problems bringing all the nonboot CPUs online, and then
>>> has a bunch of I2C errors[1].
>>>
>>> And one more..., if I try enabling CPUidle[1] with exynos_defconfig, S2R
>>> causes a reboot (seems to be on resume.)
>>
>> I tested S2R on my Peach-Pi (Exynos5800) on linux-next-20141009. My tree has:
>>
>> a57db95 TEMP: Use CLK_IGNORE_UNUSED for aclk200_disp1
>> 18158ac ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420
>
> I was missing this one.
>
>> d86cb2d ARM: exynos5: Add Suspend-to-RAM support for 5420
>> 93f1b7c ARM: exynos5: Add PMU support for 5420
>> 8dcc2db ARM: EXYNOS: Move PMU specific definitions from common.h
>> 493a16a ARM: EXYNOS: Add platform driver support for Exynos PMU
>> 64e73fb mfd: syscon: Decouple syscon interface from platform devices
>> af7b574 Add linux-next specific files for 20141009
>> 4658bc0 Merge branch 'akpm/master'
>> 9784a19 mm: add strictlimit knob
>>
>> I have tested the following scenarios using exynos_defconfig with
>> CONFIG_COMMON_CLK_MAX77802 enabled:
>>
>> 1) CONFIG_BIG_LITTLE enabled (default in exynos_defconfig)
>> 2) CONFIG_BIG_LITTLE disabled
>> 3) CONFIG_ARM_BIG_LITTLE_CPUIDLE enabled
>>
>> In all 3 cases the secondary cores as well as the system resume fine.
>> Can you please confirm if your kernel has a similar configuration ?
>
> Adding in the missing dependency above, it's now working for me in all 3
> scenarios. Looking back at the cover letter, I see it's clearly listed
> as a dependency.  Sorry, my fault.
>
> Feel free to add
>
> Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks a lot for testing.

>
> to $SUBJECT series.
>
> Kevin
