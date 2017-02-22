From: agraf@suse.de (Alexander Graf)
Date: Tue, 21 Feb 2017 20:08:14 -0800
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com> <58AC2AEF.1030803@huawei.com>
 <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <F2063470-F18A-4521-AABE-29E35D44CFE5@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Am 21.02.2017 um 07:22 schrieb Marc Zyngier <marc.zyngier@arm.com>:
> 
>> On Tue, Feb 21 2017 at 11:56:31 am GMT, Hanjun Guo <guohanjun@huawei.com> wrote:
>> Hi Marc,
> 
> [...]
> 
>> Thank you very much! I prepared an ACPI patch based on your branch, I was
>> trying to reuse the "const void *id" for ACPI as well but we need to match the
>> oem_id, oem_table_id and oem_revision in GTDT table, so I introduced new
>> matching information for ACPI, please take a look if it's OK.
>> 
>> commit 02d531ae4a88c483db849a611bd9bf7c39d2e1bf
>> Author: Hanjun Guo <hanjun.guo@linaro.org>
>> Date:   Tue Feb 21 15:17:14 2017 +0800
>> 
>>    arm64: arch_timer: enable the erratums in ACPI way
>> 
>>    Match OEM information which are oem_id, oem_table_id and oem_revision
>>    to enable the erratum for specific platforms.
>> 
>>    Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>> arch/arm64/include/asm/arch_timer.h  |  7 +++++++
>> drivers/clocksource/arm_arch_timer.c | 31 +++++++++++++++++++++++++++++++
>> 2 files changed, 38 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 1595134..79d033c 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -22,6 +22,7 @@
>> #include <asm/barrier.h>
>> #include <asm/sysreg.h>
>> 
>> +#include <linux/acpi.h>
>> #include <linux/bug.h>
>> #include <linux/init.h>
>> #include <linux/jump_label.h>
>> @@ -42,6 +43,7 @@ enum arch_timer_erratum_match_type {
>>        ate_match_dt,
>>        ate_match_global_cap_id,
>>        ate_match_local_cap_id,
>> + ate_match_acpi,
>> };
>> 
>> struct clock_event_device;
>> @@ -49,6 +51,11 @@ enum arch_timer_erratum_match_type {
>> struct arch_timer_erratum_workaround {
>>        enum arch_timer_erratum_match_type match_type;
>>        const void *id;         /* Indicate the Erratum ID */
>> +#ifdef CONFIG_ACPI
>> + char oem_id[ACPI_OEM_ID_SIZE + 1];
>> + char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>> + u32 oem_revision;
>> +#endif
>>        const char *desc_str;
>>        u32 (*read_cntp_tval_el0)(void);
>>        u32 (*read_cntv_tval_el0)(void);
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index bbd9361..82ff6e4 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -363,6 +363,32 @@ bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround
>> *wa,
>>        return of_property_read_bool(np, wa->id);
>> }
>> 
>> +#ifdef CONFIG_ACPI
>> +static bool
>> +arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
>> +                       const void *arg)
>> +{
>> + const struct acpi_table_header *table = arg;
>> +
>> + if (!wa->oem_id || !wa->oem_table_id)
>> +         return false;
>> +
>> + if (!memcmp(wa->oem_id, table->oem_id, ACPI_OEM_ID_SIZE) &&
>> +     !memcmp(wa->oem_table_id, table->oem_table_id,
>> +             ACPI_OEM_TABLE_ID_SIZE) &&
>> +     wa->oem_revision == table->oem_revision) {
>> +         return true;
>> + }
>> +
>> + return false;
>> +}
>> +#else
>> +static inline bool
>> +arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
>> +                       const void *arg)
>> +{ return false; }
>> +#endif
>> +
>> static
>> bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
>>                                         const void *arg)
>> @@ -440,6 +466,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_typ
>> e t
>>                match_fn = arch_timer_check_local_cap_erratum;
>>                local = true;
>>                break;
>> + case ate_match_acpi:
>> +         match_fn = arch_timer_check_acpi_erratum;
>> +         break;
>>        }
>> 
>>        wa = arch_timer_iterate_errata(type, match_fn, arg);
>> @@ -1284,6 +1313,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>>        /* Check for globally applicable workarounds */
>>        arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
>> 
>> + arch_timer_check_ool_workaround(ate_match_acpi, table);
>> +
>>        arch_timer_init();
>>        return 0;
>> }
>> 
>> And I got compile errors for this patch [1], seems "#include <linux/acpi.h>" in
>> arch/arm64/include/asm/arch_timer.h triggers the problem of head
>> file inclusions (too early to include <linux/sched.h>?), I'm looking into it,
>> if you can help to take a look too, that will be great :)
> 
> This is really much more complicated (and uglier) than what I had in
> mind, and I don't want to add more cruft to the erratum description
> structure. So instead of trying to explain what I wanted to see, here's
> the patches I whipped together.
> 
> Please let me know if they work for you (as I have no way of testing
> them).

Thanks for handling this quickly :).

One thing I can't get my head around yet is VM propagation of these erratas. For the dt property based approach, I can at least see how someone adds that property into the guest dt when running on broken hosts.

But how would that work when the erratum matching happens based on the OEM identifier? Would a VM suddenly have to have HiSilicon as OEM? Or would we forbid kvm usage altogether on those CPUs?

Alex
