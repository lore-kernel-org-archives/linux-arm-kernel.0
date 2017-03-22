From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Mar 2017 15:53:47 +0000
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <20170322154114.GE30499@mai>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com> <20170322154114.GE30499@mai>
Message-ID: <ede3d1d8-ba44-3039-35db-3f938bb411bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/17 15:41, Daniel Lezcano wrote:
> On Mon, Mar 20, 2017 at 05:48:17PM +0000, Marc Zyngier wrote:
>> We're currently stuck with DT when it comes to handling errata, which
>> is pretty restrictive. In order to make things more flexible, let's
>> introduce an infrastructure that could support alternative discovery
>> methods. No change in functionality.
>>
>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/arch_timer.h  |  7 +++-
>>  drivers/clocksource/arm_arch_timer.c | 80 +++++++++++++++++++++++++++++++-----
>>  2 files changed, 75 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index b4b34004a21e..5cd964e90d11 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -37,9 +37,14 @@ extern struct static_key_false arch_timer_read_ool_enabled;
>>  #define needs_unstable_timer_counter_workaround()  false
>>  #endif
>>  
>> +enum arch_timer_erratum_match_type {
>> +	ate_match_dt,
>> +};
>>  
>>  struct arch_timer_erratum_workaround {
>> -	const char *id;		/* Indicate the Erratum ID */
>> +	enum arch_timer_erratum_match_type match_type;
> 
> Putting the match_fn instead will be much more simpler and the code won't
> have to deal with ate_match_type, no ?

I'm not sure about the "much simpler" aspect. Each function is not
necessarily standalone (see patches 8 and 13 for example, dealing with
CPU-local defects). We

> 
> [ ... ]
> 
>> +static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
>> +					    void *arg)
>> +{
>> +	const struct arch_timer_erratum_workaround *wa;
>> +	ate_match_fn_t match_fn = NULL;
>> +
>> +	if (static_branch_unlikely(&arch_timer_read_ool_enabled))
>> +		return;
>> +
> 
> Why is this check necessary ?

We don't allow cumulative workarounds at this stage. This restriction
gets lifted (to some extent) later in the series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
