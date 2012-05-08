From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 08 May 2012 18:30:19 +0530
Subject: [PATCH 09/13] ARM: OMAP5: Add SMP support.
In-Reply-To: <20120508124759.GI2263@mudshark.cambridge.arm.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-10-git-send-email-r.sricharan@ti.com>
 <20120508124759.GI2263@mudshark.cambridge.arm.com>
Message-ID: <4FA918E3.5060605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012 06:17 PM, Will Deacon wrote:
> Hello,
> 
> On Thu, May 03, 2012 at 08:26:18AM +0100, R Sricharan wrote:
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Add OMAP5 SMP boot support using OMAP4 SMP code. The relevant code paths
>> are runtime checked using cpu id
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> ---
>>  arch/arm/mach-omap2/common.h       |    1 +
>>  arch/arm/mach-omap2/omap-headsmp.S |   21 ++++++++++++++++++
>>  arch/arm/mach-omap2/omap-smp.c     |   41 +++++++++++++++++++++++++----------
>>  3 files changed, 51 insertions(+), 12 deletions(-)
> 
> [...]
> 
>> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
>> index 151fd5b..9424bb6 100644
>> --- a/arch/arm/mach-omap2/omap-smp.c
>> +++ b/arch/arm/mach-omap2/omap-smp.c
>> @@ -33,6 +33,10 @@
>>  #include "common.h"
>>  #include "clockdomain.h"
>>  
>> +#define CPU_MASK		0xff0ffff0
>> +#define CPU_CORTEX_A9		0x410FC090
>> +#define CPU_CORTEX_A15		0x410FC0F0
>> +
>>  /* SCU base address */
>>  static void __iomem *scu_base;
>>  
>> @@ -43,6 +47,14 @@ void __iomem *omap4_get_scu_base(void)
>>  	return scu_base;
>>  }
>>  
>> +static inline unsigned int get_a15_core_count(void)
>> +{
>> +	unsigned int ncores;
>> +
>> +	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (ncores));
>> +	return ((ncores >> 24) & 3) + 1;
>> +}
> 
> This register (L2 control) only tells you how many cores you have hanging
> off the L2 cache, which isn't really viable for future multi-cluster
> configurations. You're probably better off either reading the number of CPU
> nodes out of the DT (ppc, vexpress) or returning a constant for now
> (exynos5).
> 
Thanks will for the information. I agree for the future multiple
packages, this register may not be good enough. We can hard-code
it as well for now.

Regards
Santosh
