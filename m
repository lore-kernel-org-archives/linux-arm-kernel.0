From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 17:58:13 +0530
Subject: [PATCH v2 07/18] ARM: OMAP5: Add init_late() hook to enable pm
 initialization
In-Reply-To: <87eheruzfx.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-8-git-send-email-santosh.shilimkar@ti.com>
 <87eheruzfx.fsf@linaro.org>
Message-ID: <515D71DD.7050206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:03 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> With consolidated code, now we can add the .init_late hook for
>> OMAP5 to enable power management and mux initialization.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
[..]

>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index e948a39..cdd1264 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -636,6 +636,14 @@ void __init omap5_init_early(void)
>>  	omap_hwmod_init_postsetup();
>>  
>>  }
>> +
>> +void __init omap5_init_late(void)
>> +{
>> +	omap_mux_late_init();
>> +	omap2_common_pm_late_init();
>> +	omap4_pm_init();
>> +	omap2_clk_enable_autoidle_all();
>> +}
> 
> Since you're consolidating, why not rename omap4430_init_late to
> omap4plus_init_late and use it for both OMAP4 and OMAP5?
> 
Now re-looking again, I need to drop omap_mux_late_init()
since OMAP5 is DT only. And hence OMAP5 needs to be a
separate hook at least for now.

Regards,
Santosh
