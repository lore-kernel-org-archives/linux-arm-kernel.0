From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Tue, 27 Jun 2017 10:41:34 +0800
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <20170626093624.381a25cb@gandalf.local.home>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626093624.381a25cb@gandalf.local.home>
Message-ID: <918253cf-33ef-3152-a492-14f2b8946e99@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

Thanks for your comments.

On 2017/6/26 21:36, Steven Rostedt wrote:
> On Sat, 24 Jun 2017 11:38:23 +0800
> Xie XiuQi <xiexiuqi@huawei.com> wrote:
> 
>> diff --git a/include/linux/cper.h b/include/linux/cper.h
>> index 4c671fc..17546bf 100644
>> --- a/include/linux/cper.h
>> +++ b/include/linux/cper.h
>> @@ -275,6 +275,11 @@ enum {
>>  #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
>>  #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
>>  
>> +#define CPER_ARM_INFO_TYPE_CACHE		0
>> +#define CPER_ARM_INFO_TYPE_TLB			1
>> +#define CPER_ARM_INFO_TYPE_BUS			2
>> +#define CPER_ARM_INFO_TYPE_UARCH		3
>> +
>>  /*
>>   * All tables and structs must be byte-packed to match CPER
>>   * specification, since the tables are provided by the system BIOS
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 429f46f..dd91ba8 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -206,6 +206,85 @@
>>  		  __entry->running_state, __entry->psci_state)
>>  );
>>  
>> +#define ARM_PROC_ERR_TYPE	\
>> +	EM ( CPER_ARM_INFO_TYPE_CACHE, "cache error" )	\
>> +	EM ( CPER_ARM_INFO_TYPE_TLB,  "TLB error" )	\
>> +	EM ( CPER_ARM_INFO_TYPE_BUS, "bus error" )	\
>> +	EMe ( CPER_ARM_INFO_TYPE_UARCH, "micro-architectural error" )
> 
> These are all defines. As the name suggests, the TRACE_DEFINE_ENUM() is
> for use with enums, not defines. You can nuke this part.
> 
>> +
>> +/*
>> + * First define the enums in MM_ACTION_RESULT to be exported to userspace
>> + * via TRACE_DEFINE_ENUM().
>> + */
>> +#undef EM
>> +#undef EMe
>> +#define EM(a, b) TRACE_DEFINE_ENUM(a);
>> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
>> +
>> +ARM_PROC_ERR_TYPE
>> +
>> +/*
>> + * Now redefine the EM() and EMe() macros to map the enums to the strings
>> + * that will be printed in the output.
>> + */
>> +#undef EM
>> +#undef EMe
>> +#define EM(a, b)		{ a, b },
>> +#define EMe(a, b)	{ a, b }
> 
> All the EM* and friends above are not needed. The macro below will
> translate into numbers not names in the format files in tracefs.

So, do you mean we just use __print_symbolic like below:

#define show_proc_err_type(type)                                                \
        __print_symbolic(type,                                                  \
                { CPER_ARM_INFO_TYPE_CACHE, "cache error" },                    \
                { CPER_ARM_INFO_TYPE_TLB, "TLB error" },                        \
                { CPER_ARM_INFO_TYPE_BUS, "bus error" },                        \
                { CPER_ARM_INFO_TYPE_UARCH, "micro-architectural error" })



> 
> -- Steve
> 
> 
>> +
>> +#define show_proc_err_flags(flags) __print_flags(flags, "|",			\
>> +	{ CPER_ARM_INFO_FLAGS_FIRST,		"First error captured" },	\
>> +	{ CPER_ARM_INFO_FLAGS_LAST,		"Last error captured" },	\
>> +	{ CPER_ARM_INFO_FLAGS_PROPAGATED,	"Propagated" },			\
>> +	{ CPER_ARM_INFO_FLAGS_OVERFLOW,		"Overflow" })
>> +
>> +TRACE_EVENT(arm_err_info_event,
>> +
>> +	TP_PROTO(const struct cper_arm_err_info *err),
>> +
>> +	TP_ARGS(err),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u8, type)
>> +		__field(u8, flags)
>> +		__field(u16, multiple_error)
>> +		__field(u64, error_info)
>> +		__field(u64, virt_fault_addr)
>> +		__field(u64, physical_fault_addr)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->type = err->type;
>> +		memset(&__entry->flags, 0,
>> +			sizeof(*__entry) - offsetof(typeof(*__entry), flags));
>> +		__entry->multiple_error = ~0;
>> +
>> +		if (err->validation_bits & CPER_ARM_INFO_VALID_MULTI_ERR)
>> +			__entry->multiple_error = err->multiple_error;
>> +
>> +		if (err->validation_bits & CPER_ARM_INFO_VALID_FLAGS)
>> +			__entry->flags = err->flags;
>> +
>> +		if (err->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO)
>> +			__entry->error_info = err->error_info;
>> +
>> +		if (err->validation_bits & CPER_ARM_INFO_VALID_VIRT_ADDR)
>> +			__entry->virt_fault_addr = err->virt_fault_addr;
>> +
>> +		if (err->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
>> +			__entry->physical_fault_addr = err->physical_fault_addr;
>> +	),
>> +
>> +	TP_printk("type: %s; count: %u; flags: %s;"
>> +		  " error info: %016llx; virtual address: %016llx;"
>> +		  " physical address: %016llx",
>> +		  __print_symbolic(__entry->type, ARM_PROC_ERR_TYPE),
>> +		  __entry->multiple_error,
>> +		  show_proc_err_flags(__entry->flags),
>> +		  __entry->error_info, __entry->virt_fault_addr,
>> +		  __entry->physical_fault_addr)
>> +);
>> +
>>  /*
>>   * Non-Standard Section Report
>>   *
> 
> 
> .
> 

-- 
Thanks,
Xie XiuQi
