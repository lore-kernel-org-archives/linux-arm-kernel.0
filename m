From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 18:00:35 +0000
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <CALdTtnvyT1qjKp5C5AfvSSW7GqN3m2Y_CkTMEX+5OxyvH=+G2Q@mail.gmail.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com>
 <CALdTtnvyT1qjKp5C5AfvSSW7GqN3m2Y_CkTMEX+5OxyvH=+G2Q@mail.gmail.com>
Message-ID: <b40e0cc7-5580-a834-babe-0dfa8427629e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dann,

On 24/03/17 17:48, dann frazier wrote:
> On Mon, Mar 20, 2017 at 11:48 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
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
>> +       ate_match_dt,
>> +};
>>
>>  struct arch_timer_erratum_workaround {
>> -       const char *id;         /* Indicate the Erratum ID */
>> +       enum arch_timer_erratum_match_type match_type;
>> +       const void *id;
>> +       const char *desc;
>>         u32 (*read_cntp_tval_el0)(void);
>>         u32 (*read_cntv_tval_el0)(void);
>>         u64 (*read_cntvct_el0)(void);
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 7a8a4117f123..6a0f0e161a0f 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -182,7 +182,9 @@ EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
>>  static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>>  #ifdef CONFIG_FSL_ERRATUM_A008585
>>         {
>> +               .match_type = ate_match_dt,
>>                 .id = "fsl,erratum-a008585",
>> +               .desc = "Freescale erratum a005858",
>>                 .read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
>>                 .read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
>>                 .read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
>> @@ -190,13 +192,78 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>>  #endif
>>  #ifdef CONFIG_HISILICON_ERRATUM_161010101
>>         {
>> +               .match_type = ate_match_dt,
>>                 .id = "hisilicon,erratum-161010101",
>> +               .desc = "HiSilicon erratum 161010101",
>>                 .read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
>>                 .read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
>>                 .read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
>>         },
>>  #endif
>>  };
>> +
>> +typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
>> +                              const void *);
>> +
>> +static
>> +bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround *wa,
>> +                                const void *arg)
>> +{
>> +       const struct device_node *np = arg;
>> +
>> +       return of_property_read_bool(np, wa->id);
>> +}
>> +
>> +static const struct arch_timer_erratum_workaround *
>> +arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
>> +                         ate_match_fn_t match_fn,
>> +                         void *arg)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
>> +               if (ool_workarounds[i].match_type != type)
>> +                       continue;
>> +
>> +               if (match_fn(&ool_workarounds[i], arg))
>> +                       return &ool_workarounds[i];
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static
>> +void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa)
>> +{
>> +       timer_unstable_counter_workaround = wa;
>> +       static_branch_enable(&arch_timer_read_ool_enabled);
>> +}
>> +
>> +static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
>> +                                           void *arg)
>> +{
>> +       const struct arch_timer_erratum_workaround *wa;
>> +       ate_match_fn_t match_fn = NULL;
>> +
>> +       if (static_branch_unlikely(&arch_timer_read_ool_enabled))
>> +               return;
>> +
>> +       switch (type) {
>> +       case ate_match_dt:
>> +               match_fn = arch_timer_check_dt_erratum;
>> +               break;
> 
> hey Marc,
>    Would it make sense to have a default case here that warns &
> returns? That wouldn't get hit by this series as-is, but might avoid a
> NULL callback in the future.

Sure, I can add that in the next version of this series. I would have
hoped that GCC would warn you if you don't handle all the values of an
enum, but it doesn't hurt to be cautious.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
