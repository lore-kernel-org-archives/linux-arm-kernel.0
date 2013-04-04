From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 17:38:50 +0530
Subject: [PATCH v2 06/18] ARM: OMAP5: PM: Enable Mercury retention mode
 on CPUx powerdomains
In-Reply-To: <87k3ojuziu.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-7-git-send-email-santosh.shilimkar@ti.com>
 <87k3ojuziu.fsf@linaro.org>
Message-ID: <515D6D52.50902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:01 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> In addition to the standard power-management technique, the OMAP5
>> MPU subsystem also employs an SR3-APG (mercury) power management
>> technology to reduce leakage.
>>
>> It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
>> is controlled by the PRCM_MPU.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index b1441b1..d390d18 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -62,6 +62,10 @@
>>  #include "prm44xx.h"
>>  #include "prm-regbits-44xx.h"
>>  
>> +/* Add defines needed for mercury mode. Refer MPU's PRM_PSCON_COUNT */
>> +#define PRM_PSCON_HG_EN		(1 << 24)
>> +#define PRM_PSCON_HG_RAMPUP	(1 << 25)
> 
> nit: use BIT()
> 
ok

>>  #ifdef CONFIG_SMP
>>  
>>  struct omap4_cpu_pm_info {
>> @@ -337,6 +341,28 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * enable_mercury_retention_mode: Enable OMAP5 mercury retention feature
>> + *
>> + * OMAP5 devices supports  SR3-APG (mercury) power management technology to
>> + * reduce leakage. It allows for full logic and memories retention on
>> + * MPU_C0 and MPU_C1 and is controlled by the PRCM_MPU. The function enable
>> + * the mercury retention feature.
>> + */
>> +static void enable_mercury_retention_mode(void)
> 
> __init ?
> 
yep.

> This is very OMAP5 specific (unless you generalize the offsets used) so
> should this have omap5_ prefix?
> 
Agree.

> 
>> +{
>> +	u32 reg;
>> +
>> +	/*
>> +	 * To enable mercury mode, both HG_EN and HG_RAMPUP needs to be
>> +	 * enabled from PRM_PSCON_COUNT register.
>> +	 */
>> +	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
>> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
>> +	reg |= PRM_PSCON_HG_EN | PRM_PSCON_HG_RAMPUP;
>> +	omap4_prcm_mpu_write_inst_reg(reg, OMAP54XX_PRCM_MPU_DEVICE_INST,
>> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
> 
> nit: when I see 'reg', I expect it to be a register/offset.  But this is
> a register value.  Maybe use 'val' instead as you've done elsewhere in
> this series.
> 
I generally use 'offset' if it is offset and 'reg' for actual register read.
Anyways, I have changed it to 'val' now.

Regards,
Santosh
