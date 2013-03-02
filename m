From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 2 Mar 2013 11:22:03 +0530
Subject: [PATCH 06/15] ARM: OMAP5: PM: Enable Mercury retention mode on
 CPUx powerdomains
In-Reply-To: <20130301194216.GB22626@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-7-git-send-email-santosh.shilimkar@ti.com>
 <20130301194216.GB22626@kahuna>
Message-ID: <51319383.7090903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 March 2013 01:12 AM, Nishanth Menon wrote:
> On 17:40-20130301, Santosh Shilimkar wrote:
>> In addition to the standard power-management technique, the OMAP5
>> MPU subsystem also employs an SR3-APG (mercury) power management
>> technology to reduce leakage.
> Mercury fast is employed here - might be good to note that.
Slow is completly descoped from validation and only supported mode
is mercury fast which was the intention. So lets not add any confusion
since other state isn't supported. 
>>
>> It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
>> is controlled by the PRCM_MPU.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index bcd2efb..9fda96b 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -360,6 +360,20 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>>  
>>  
>>  /*
>> + * Enable Mercury Fast HG retention mode by default.
>> + */
>> +static void enable_mercury_retention_mode(void)
>> +{
>> +	u32 reg;
>> +
>> +	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
>> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
>> +	reg |= BIT(24) | BIT(25);
> Can we please use macros here?
> we are setting BIT(25) - fast ramp-up (Mercury fast) Vs 0 (which would
> have been mercury slow)
> BIT(24) is mercury enable basically. OMAP4 prm-regbits-44xx.h did not
> have these ofcourse, so might be a different bit file or so?
As already commented above, only mode supported is mercury fast and
hence to avoid any further confusion, i have used bit fields.
In short, to enable the mercury on O5, both bits needs to be set.
And to avoid any fast/slow confusion, I haven't used macro's.

Regards
Santosh
