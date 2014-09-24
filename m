From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 24 Sep 2014 10:23:23 +0200
Subject: [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
In-Reply-To: <54227893.7020808@samsung.com>
References: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
 <5415D4A8.4010304@gmail.com> <0d2401cfd07b$0e21e190$2a65a4b0$@kernel.org>
 <54227893.7020808@samsung.com>
Message-ID: <54227F7B.80702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 2014-09-24 09:53, Kukjin Kim wrote:
>
> On 09/15/14 09:21, Kukjin Kim wrote:
>>
>>> On 26.08.2014 16:10, Tomasz Figa wrote:
>>>> On Exynos-based boards running secure firmware the sequence of low 
>>>> level
>>>> operations to enter and leave system-wide sleep mode is different than
>>>> on those without the firmware. Namely:
>>>>   - CP15 power control and diagnostic registers cannot be written 
>>>> directly,
>>>>   - the way of setting boot address and boot flag is different,
>>>>   - different resume handler needs to be used,
>>>>   - dedicated SMC call needs to be performed instead of letting the 
>>>> CPU enter
>>>>     WFI.
>>>>
>>>> This series introduces .suspend() and .resume() firmware operations to
>>>> perform low level firmware-specific suspend and resume and then 
>>>> leverages
>>>> them to provide suspend-resume path meeting the above requirements. 
>>>> Three
>>>> additional patches extend device tree sources of Trats2 board with 
>>>> necessary
>>>> setup to enable suspend/resume support.
>>>>
>>>> This series has been tested on Exynos4412-based Trats2 board, 
>>>> without any
>>>> additional patches. Unfortunately v3.17-rc1 regressed ODROID 
>>>> support and
>>>> suspend stopped working on those boards, due to unknown reasons 
>>>> still being
>>>> investigated. It does not seem to be related to anything in this 
>>>> series,
>>>> though, so I would not consider this as a stopper.
>>>>
>>>> Changes since v2:
>>>> (https://lkml.org/lkml/2014/7/17/431)
>>>>   - added board-specific fixes for device tree sources of Trats2 
>>>> board,
>>>>   - rebased on next-20140826 of linux-next tree.
>>>>
>>>> Changes since v1:
>>>>   - dropped outer_resume() - will be handled in assembly in further 
>>>> patches,
>>>>     as support for L2C in non-secure mode gets added,
>>>>   - moved CP15 resume to assembly as it needs to be done before MMU 
>>>> is enabled,
>>>>   - surrounded CP15 save with a check for cpuid part, because it is 
>>>> valid only
>>>>     on Cortex A9,
>>>>   - rebased on next-20140717 tag of linux-next tree.
>>>>
>>>> Tomasz Figa (5):
>>>>    ARM: firmware: Introduce suspend and resume operations
>>>>    ARM: EXYNOS: Add support for firmware-assisted suspend/resume
>>>>    ARM: dts: exynos4412-trats2: Keep eMMC regulators soft-disabled
>>>>    ARM: dts: exynos4x12: Add utility macro to define pin sleep states
>>>>    ARM: dts: exynos4412-trats2: Add sleep mode pin configuration
>>>>
>>>>   Documentation/arm/firmware.txt            |  28 +--
>>>>   arch/arm/boot/dts/exynos4412-trats2.dts   | 320 
>>>> +++++++++++++++++++++++++++++-
>>>>   arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |  16 ++
>>>>   arch/arm/include/asm/firmware.h           |   8 +
>>>>   arch/arm/mach-exynos/Makefile             |   1 +
>>>>   arch/arm/mach-exynos/common.h             |   4 +
>>>>   arch/arm/mach-exynos/firmware.c           |  45 +++++
>>>>   arch/arm/mach-exynos/pm.c                 |  16 +-
>>>>   arch/arm/mach-exynos/sleep.S              |  28 +++
>>>>   arch/arm/mach-exynos/smc.h                |   4 +
>>>>   10 files changed, 438 insertions(+), 32 deletions(-)
>>>>
>>>
>>> Would you consider applying this series? It has been waiting on the ML
>>> long enough (note no changes in core patches since last revision, just
>>> few more board specific patches). Thanks in advance.
>>>
>> Sure, I will. Thanks for your gentle reminder.
>>
> I've reverted this series because of following.
>
> In file included from arch/arm/mach-tegra/cpuidle-tegra114.c:17:0:
> arch/arm/mach-tegra/cpuidle-tegra114.c: In function 
> 'tegra114_idle_power_down':
> arch/arm/include/asm/firmware.h:64:24: error: too few arguments to 
> function 'firmware_ops->do_idle'
>   ((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : (-ENOSYS))
>                         ^
> arch/arm/mach-tegra/cpuidle-tegra114.c:52:6: note: in expansion of 
> macro 'call_firmware_op'
>   if (call_firmware_op(do_idle) == -ENOSYS)
>       ^
>
> Caused by commit f5217f3b9332 ("ARM: EXYNOS: add AFTR mode support to
> firmware do_idle method").
>
> Need to fix...

I don't get why you have reverted the main feature of "Firmware-assisted 
suspend/resume
of Exynos SoCs" because of an issue on the completely independent 
patchset which adds
AFTR idle mode support. Could you please keep the "ARM: firmware: 
Introduce suspend
and resume operations" and "ARM: EXYNOS: Add support for firmware-assisted
suspend/resume" patches?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
