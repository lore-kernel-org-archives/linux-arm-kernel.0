From: dengcheng.zhu@imgtec.com (Deng-Cheng Zhu)
Date: Fri, 6 Mar 2015 15:23:20 -0800
Subject: [PATCH 04/15] MIPS: Add sched_clock support
In-Reply-To: <alpine.LFD.2.11.1503061146430.15786@eddie.linux-mips.org>
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com>
 <1425517137-26463-5-git-send-email-dengcheng.zhu@imgtec.com>
 <alpine.LFD.2.11.1503061146430.15786@eddie.linux-mips.org>
Message-ID: <54FA36E8.7010501@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2015 03:58 AM, Maciej W. Rozycki wrote:
> On Wed, 4 Mar 2015, Deng-Cheng Zhu wrote:
>
>> This will provide sched_clock interface to implement individual
>> read_sched_clock(). Not for CAVIUM_OCTEON_SOC as it defines its own
>> sched_clock() directly (not using the sched_clock_register interface).
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>> ---
>>   arch/mips/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 068592a..09405dc 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -43,6 +43,7 @@ config MIPS
>>   	select GENERIC_SMP_IDLE_THREAD
>>   	select BUILDTIME_EXTABLE_SORT
>>   	select GENERIC_CLOCKEVENTS
>> +	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>>   	select GENERIC_CMOS_UPDATE
>>   	select HAVE_MOD_ARCH_SPECIFIC
>>   	select VIRT_TO_BUS
>   Why does this change add this question:
>
> ARM Versatile (Express) reference platforms clock source (CLKSRC_VERSATILE) [N/y/?] (NEW) ?

Good catch.

>
> This option enables clock source based on free running
> counter available in the "System Registers" block of
> ARM Versatile, RealView and Versatile Express reference
> platforms.
>
> Symbol: CLKSRC_VERSATILE [=n]
> Type  : boolean
> Prompt: ARM Versatile (Express) reference platforms clock source
>    Location:
>      -> Device Drivers
>        -> Clock Source drivers
>    Defined at drivers/clocksource/Kconfig:216
>    Depends on: GENERIC_SCHED_CLOCK [=y] && !ARCH_USES_GETTIMEOFFSET [=n]
>    Selects: CLKSRC_OF [=n]
>
> to a MIPS configuration?  I find it silly, this appears a platform
> device to me (use reverse dependencies?).

GENERIC_SCHED_CLOCK is generic, by default it uses jiffy_sched_clock_read() 
for read_sched_clock(). Instead of using reverse dependencies, I suggest 
the following:

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f..22e0ee1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -225,7 +225,7 @@ config CLKSRC_QCOM

  config CLKSRC_VERSATILE
         bool "ARM Versatile (Express) reference platforms clock source"
-       depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
+       depends on PLAT_VERSATILE && GENERIC_SCHED_CLOCK && 
!ARCH_USES_GETTIMEOFFSET
         select CLKSRC_OF
         default y if MFD_VEXPRESS_SYSREG
         help


Deng-Cheng
