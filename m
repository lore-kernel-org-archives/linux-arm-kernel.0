From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2018 14:12:42 +0200
Subject: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
In-Reply-To: <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
 <20181008125009.3721-5-m.szyprowski@samsung.com>
 <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
Message-ID: <20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e~dxxpPrR4A1710517105eucas1p1W@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 2018-10-08 15:17, Marc Zyngier wrote:
> + Mark Rutland
>
> Hi Marek,
>
> On 08/10/18 13:50, Marek Szyprowski wrote:
>> Use common infrastructure for ARM Architected Timers erratum to enable
>> support for systems with broken CPU firmware (timer registers not
>> properly configured). This mode has been already availabled on ARM
>> (32bits) architecture. This enables to run Linux kernel on ARM64 boards
>> using physical architected timers instead of the virtual ones. Examples
>> of such system with broken firmware are Samsung Exynos5433 SoC based
>> TM2(e) boards, which is already deployed for years and updating firmware
>> is not possible.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> ? drivers/clocksource/Kconfig????????? | 11 +++++++++++
>> ? drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
>> ? 2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index a11f4ba98b05..a30752579b03 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>> ??????? The workaround will be dynamically enabled when an affected
>> ??????? core is detected.
>> ? +config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
>> +??? bool "Workaround for arch timer registers not configured by
>> firmware"
>> +??? default y
>> +??? select ARM_ARCH_TIMER_OOL_WORKAROUND
>> +??? depends on ARM_ARCH_TIMER && ARM64
>> +??? help
>> +????? This option enables a workaround for boards, on which arch timer
>> +????? registers are not properly configured by the board firmware.
>> +????? The workaround will be dynamically enabled when an affected
>> +????? board is detected.
>> +
>
> I'm sorry, but I'm strongly pushing back on this.
>
> This horrible hack was accepted with the express condition that it
> would be limited to ARMv7 platforms (on the ground that we never
> really documented the arch timer boot requirements on that version of
> the architecture), and would never proliferate on arm64. From day 1,
> we established what the boot protocol was, and we mandated that either:
>
> - kernel is entered at EL2 on all CPUs
> - cntvoff_el2 is zeroed on all CPUs
>
> and we've got most people to fix their firmware, or live with the
> consequences. If these machines cannot receive a non-broken firmware,
> what are the odds that they will receive a mainline kernel?

Well, I know that the firmware is broken, but I cannot do anything about it.
On the other hand updating kernel is still possible and mainline runs fine
on TM2(e) boards. I will send v2 without this patch then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
