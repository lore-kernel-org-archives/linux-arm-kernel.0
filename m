From: tony.xie@rock-chips.com (tony)
Date: Tue, 23 Oct 2018 15:21:50 +0800
Subject: [PATCH v3 1/5] mfd: rk808: Add RK817 and RK809 support
In-Reply-To: <20181023062601.GS4939@dell>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-2-git-send-email-tony.xie@rock-chips.com>
 <20180911114732.GL4185@dell>
 <b0f9fff3-3084-91b3-fa78-5163ebd43bbb@rock-chips.com>
 <20181023062601.GS4939@dell>
Message-ID: <3d96be69-e50c-187e-7d3a-75eec63d2be0@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018/10/23 14:26, Lee Jones ??:
>>>>       The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>>>>       and handheld devices. It contains the following components:
>>>>
>>>>           - Regulators
>>>>           - RTC
>>>>           - Clocking
>>>>
>>>>       Both RK809 and RK817 chips are using a similar register map,
>>>>       so we can reuse the RTC and Clocking and regulators functionality.
>>>>
>>>> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
>>>> ---
>>>>    drivers/mfd/Kconfig       |   6 +-
>>>>    drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>    include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>>>>    kernel/reboot.c           |   1 +
>>>>    4 files changed, 391 insertions(+), 6 deletions(-)
> [...]
>
>>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>>> index e4ced88..83810d7 100644
>>>> --- a/kernel/reboot.c
>>>> +++ b/kernel/reboot.c
>>>> @@ -49,6 +49,7 @@
>>>>     */
>>>>    void (*pm_power_off_prepare)(void);
>>>> +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
>>> Why do you need this where no other driver in the kernel does?
>>  ??? There is a gpio_slp pin for RK809 and RK817?this pin has reset?power
>> down and sleep functions?so
>>  ??? when system is going to power down, this pin is needed to switch to
>> power down function?and then we just only control
>>  ??? this pin to high to power down the system in atf at last?
> There are other PM call-backs that you can use for this.  There
> shouldn't be any requirement to export and call functions at this
> level directly.
 ??? I will use a shutdown call-backs from syscore to implement it.
>
