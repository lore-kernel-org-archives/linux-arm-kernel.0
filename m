From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 28 Aug 2014 10:34:58 +0100
Subject: [PATCH 6/6] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <20140827174001.GI13850@arm.com> (Catalin Marinas's message of
 "Wed, 27 Aug 2014 18:40:01 +0100")
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-7-git-send-email-punit.agrawal@arm.com>
 <20140827174001.GI13850@arm.com>
Message-ID: <9hhzjepc5z1.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Aug 26, 2014 at 11:28:50AM +0100, Punit Agrawal wrote:
>> diff --git a/arch/arm64/kernel/v7_obsolete.c b/arch/arm64/kernel/v7_obsolete.c
>> index e9427cb..ed77889 100644
>> --- a/arch/arm64/kernel/v7_obsolete.c
>> +++ b/arch/arm64/kernel/v7_obsolete.c
>> @@ -227,6 +227,94 @@ static void __init swp_emulation_init(void)
>>  		pr_notice("Registered SWP/SWPB emulation handler\n");
>>  }
>>  
>> +static atomic_t cp15_barrier_count;
>
> Should we add counters for each barrier type? It may be more
> informative.

Arnd proposed to use trace points instead of counters. I can emit
different trace points for the different barrier types.

I am not sure if there is any benefit in providing this extra
information. IIUC, the stats being presented (whether they be via
procfs, debugfs or ftrace) are intended to highglight the presence of
legacy instructions and encourage migration away from using these
features.

But I am happy to defer to your judgement if you see the benefit.

>
>> +/* data barrier */
>> +static struct undef_hook cp15db_hook = {
>> +	.instr_mask	= 0x0fff0fdf,
>> +	.instr_val	= 0x0e070f9a,
>> +	.pstate_mask	= COMPAT_PSR_MODE_MASK,
>> +	.pstate_val	= COMPAT_PSR_MODE_USR,
>> +	.fn		= cp15barrier_handler,
>> +};
>> +
>> +/* instruction barrier */
>> +static struct undef_hook cp15isb_hook = {
>> +	.instr_mask	= 0x0fff0fff,
>> +	.instr_val	= 0x0e070f95,
>> +	.pstate_mask	= COMPAT_PSR_MODE_MASK,
>> +	.pstate_val	= COMPAT_PSR_MODE_USR,
>> +	.fn		= cp15barrier_handler,
>> +};
>
> It now crossed my mind that these CP15 barriers are valid in Thumb-2 as
> well, same encoding. But we need the hook and the masks here to trap
> them.

Right. I'll add the masks. This coupled with the decoding of
instructions in thumb mode for undef exception, should take care of CP15
barriers in Thumb-2.
