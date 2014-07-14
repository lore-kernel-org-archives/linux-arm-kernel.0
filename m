From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 14 Jul 2014 12:46:18 -0500
Subject: [PATCH v4 11/11] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into
 OMAP builds
In-Reply-To: <20140714112121.GD20068@atomide.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-12-git-send-email-d-gerlach@ti.com>
 <20140714112121.GD20068@atomide.com>
Message-ID: <53C4176A.9070602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 06:21 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140710 19:59]:
>> With all the requisite changes in place we can now enable the basic
>> PM support for AM33xx. This patch updates the various OMAP files
>> to enable suspend-resume on AM33xx.
>>
>> Because the suspend resume functionality is different on AM33xx
>> than other OMAP platforms due to the need for M3 firmware and an
>> IPC channel to be in place, separate PM ops are used instead of
>> omap_pm_ops. These are now set using omap2_common_suspend_init
>> so the AM33xx can make a decision at runtime to enable suspend based
>> on the availabilty of aforementioned requirements.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> v3->v4:
>> 	Updated for rproc usage now.
>>
>>   arch/arm/mach-omap2/Kconfig  |  1 +
>>   arch/arm/mach-omap2/Makefile |  2 ++
>>   arch/arm/mach-omap2/common.h |  9 +++++++++
>>   arch/arm/mach-omap2/io.c     |  1 +
>>   arch/arm/mach-omap2/pm.h     |  5 +++++
>>   arch/arm/mach-omap2/sram.c   | 10 +++++++++-
>>   arch/arm/mach-omap2/sram.h   |  2 ++
>>   7 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 1c1ed73..f8a56e5 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -59,6 +59,7 @@ config SOC_AM33XX
>>   	select ARCH_OMAP2PLUS
>>   	select ARCH_HAS_OPP
>>   	select ARM_CPU_SUSPEND if PM
>> +	select WKUP_M3_RPROC if PM
>
> You should not do a select in Kconfig for a driver,
> that will lead into various randconfig build errors
> at some point. It's probably best to make the PM code
> depend on the WKUP_M3_RPROC driver instead.

Ok, I didn't consider that, thanks.

Regards,
Dave

>
> Regards,
>
> Tony
>
