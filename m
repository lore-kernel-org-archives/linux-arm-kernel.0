From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 3 Feb 2017 13:18:40 -0700
Subject: [PATCH V8 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <20170201221544.3d8651e5@grimm.local.home>
References: <1485969413-23577-1-git-send-email-tbaicar@codeaurora.org>
 <1485969413-23577-10-git-send-email-tbaicar@codeaurora.org>
 <20170201221544.3d8651e5@grimm.local.home>
Message-ID: <70bd0d57-4369-ac7d-10c6-2c9de62a666f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,


On 2/1/2017 8:15 PM, Steven Rostedt wrote:
> On Wed,  1 Feb 2017 10:16:52 -0700
> Tyler Baicar <tbaicar@codeaurora.org> wrote:
>
>> Currently there are trace events for the various RAS
>> errors with the exception of ARM processor type errors.
>> Add a new trace event for such errors so that the user
>> will know when they occur. These trace events are
>> consistent with the ARM processor error section type
>> defined in UEFI 2.6 spec section N.2.4.4.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>>   drivers/acpi/apei/ghes.c    |  7 ++++++-
>>   drivers/firmware/efi/cper.c |  1 +
>>   drivers/ras/ras.c           |  1 +
>>   include/ras/ras_event.h     | 34 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index a989345..013faf0 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -512,7 +512,12 @@ static void ghes_do_proc(struct ghes *ghes,
>>   
>>   		}
>>   #endif
>> -		else {
>> +		else if (!uuid_le_cmp(sec_type, CPER_SEC_PROC_ARM)) {
>> +			struct cper_sec_proc_arm *arm_err;
>> +
>> +			arm_err = acpi_hest_generic_data_payload(gdata);
>> +			trace_arm_event(arm_err);
> According to the kbuild failure, I'm guessing this file requires a:
>
>   #include <ras/ras_event.h>
I add that include in patch 8/10 of this series, so ghes.c has the 
include before this patch. The kbuild
complained about the same thing for both trace events added in this 
series. Upon further debug, it
looks like I'll need to verify that CONFIG_RAS is enabled to make these 
trace event calls. It's strange
that kbuild didn't complain in earlier versions of this series because 
these have been this way the
whole time :) I'll add the config check in the next series.

Thanks,
Tyler
> -- Steve
>
>> +		} else {
>>   			void *unknown_err = acpi_hest_generic_data_payload(gdata);
>>   			trace_unknown_sec_event(&sec_type,
>>   					fru_id, fru_text, sec_sev,
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 48cb8ee..0ec678e 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/printk.h>
>>   #include <linux/bcd.h>
>>   #include <acpi/ghes.h>
>> +#include <ras/ras_event.h>
>>   
>>   #define INDENT_SP	" "
>>   
>> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
>> index fb2500b..8ba5a94 100644
>> --- a/drivers/ras/ras.c
>> +++ b/drivers/ras/ras.c
>> @@ -28,3 +28,4 @@ static int __init ras_init(void)
>>   #endif
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(unknown_sec_event);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(arm_event);
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 5861b6f..b36db48 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -162,6 +162,40 @@
>>   );
>>   
>>   /*
>> + * ARM Processor Events Report
>> + *
>> + * This event is generated when hardware detects an ARM processor error
>> + * has occurred. UEFI 2.6 spec section N.2.4.4.
>> + */
>> +TRACE_EVENT(arm_event,
>> +
>> +	TP_PROTO(const struct cper_sec_proc_arm *proc),
>> +
>> +	TP_ARGS(proc),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u64, mpidr)
>> +		__field(u64, midr)
>> +		__field(u32, running_state)
>> +		__field(u32, psci_state)
>> +		__field(u8, affinity)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->affinity = proc->affinity_level;
>> +		__entry->mpidr = proc->mpidr;
>> +		__entry->midr = proc->midr;
>> +		__entry->running_state = proc->running_state;
>> +		__entry->psci_state = proc->psci_state;
>> +	),
>> +
>> +	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
>> +		  "running state: %d; PSCI state: %d",
>> +		  __entry->affinity, __entry->mpidr, __entry->midr,
>> +		  __entry->running_state, __entry->psci_state)
>> +);
>> +
>> +/*
>>    * Unknown Section Report
>>    *
>>    * This event is generated when hardware detected a hardware

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
