From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 17:02:39 +0530
Subject: [PATCH v2 01/18] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
In-Reply-To: <87a9pfxuts.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-2-git-send-email-santosh.shilimkar@ti.com>
 <87a9pfxuts.fsf@linaro.org>
Message-ID: <515D64D7.7050403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 01:14 AM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> OMAP5 and future OMAP based SOCs has backward compatible MPUSS
>> IP block with OMAP4. It's programming model is mostly similar.
>> Hence consolidate the OMAP MPUSS code so that it can be re-used
>> on OMAP5 and future SOCs.
>>
>> No functional change.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   65 ++++++++++++++++++++++++-----
>>  1 file changed, 54 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index d650f91..d9e4843 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -71,10 +71,46 @@ struct omap4_cpu_pm_info {
>>  	void (*secondary_startup)(void);
>>  };
>>  
>> +/**
>> + * struct cpu_pm_ops - CPU pm operations
>> + * @finish_suspend:	CPU suspend finisher function pointer
>> + * @resume:		CPU resume function pointer
>> + * @scu_prepare:	CPU Snoop Control program function pointer
>> + *
>> + * Structure holds functions pointer for CPU low power operations like
>> + * suspend, resume and scu programming.
>> + */
>> +struct cpu_pm_ops {
>> +	int (*finish_suspend)(unsigned long cpu_state);
>> +	void (*resume)(void);
>> +	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
>> +};
>> +
>> +extern int omap4_finish_suspend(unsigned long cpu_state);
>> +extern void omap4_cpu_resume(void);
> 
> checkpatch should've yelled at you for adding externs to .c files.
> 
It does. I didn't see they were already in header file and considering
they were shared between asm and mpuss file, I just kept it that way.
i have seen many places in kernel for asm exports, this is being used
and hence kept it.

> Also, aren't these already defined in common.h anyways?
>
Yep. I will just drop above hunk.
 
> Otherwise, patch looks fine.
> 
I will take that as an ack then ?

Regards,
Santosh
