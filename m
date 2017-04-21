From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 21 Apr 2017 12:22:09 -0600
Subject: [PATCH V15 04/11] efi: parse ARM processor error
In-Reply-To: <20170421175527.fjwnqd22jz7br5yu@pd.tnic>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-5-git-send-email-tbaicar@codeaurora.org>
 <20170421175527.fjwnqd22jz7br5yu@pd.tnic>
Message-ID: <e54c9893-446f-9e77-b78b-2548d394719b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2017 11:55 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 05:05:16PM -0600, Tyler Baicar wrote:
>> Add support for ARM Common Platform Error Record (CPER).
>> UEFI 2.6 specification adds support for ARM specific
>> processor error information to be reported as part of the
>> CPER records. This provides more detail on for processor error logs.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   drivers/firmware/efi/cper.c | 135 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/cper.h        |  54 ++++++++++++++++++
>>   2 files changed, 189 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 46585f9..f959185 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -110,12 +110,15 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>>   static const char * const proc_type_strs[] = {
>>   	"IA32/X64",
>>   	"IA64",
>> +	"ARM",
>>   };
>>   
>>   static const char * const proc_isa_strs[] = {
>>   	"IA32",
>>   	"IA64",
>>   	"X64",
>> +	"ARM A32/T32",
>> +	"ARM A64",
>>   };
>>   
>>   static const char * const proc_error_type_strs[] = {
>> @@ -184,6 +187,128 @@ static void cper_print_proc_generic(const char *pfx,
>>   		printk("%s""IP: 0x%016llx\n", pfx, proc->ip);
>>   }
>>   
>> +#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
>> +static const char * const arm_reg_ctx_strs[] = {
>> +	"AArch32 general purpose registers",
>> +	"AArch32 EL1 context registers",
>> +	"AArch32 EL2 context registers",
>> +	"AArch32 secure context registers",
>> +	"AArch64 general purpose registers",
>> +	"AArch64 EL1 context registers",
>> +	"AArch64 EL2 context registers",
>> +	"AArch64 EL3 context registers",
>> +	"Misc. system register structure",
>> +};
>> +
>> +static void cper_print_proc_arm(const char *pfx,
>> +				const struct cper_sec_proc_arm *proc)
>> +{
>> +	int i, len, max_ctx_type;
>> +	struct cper_arm_err_info *err_info;
>> +	struct cper_arm_ctx_info *ctx_info;
>> +	char newpfx[64];
>> +
>> +	printk("%ssection length: %d\n", pfx, proc->section_length);
> We need to dump section length because?
I guess it's not really needed. It just may be useful considering there 
can be numerous error info structures, numerous context info structures, 
and a variable length vendor information section. I can move this print 
to only in the length check failure cases.
>
>> +	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
>> +
>> +	len = proc->section_length - (sizeof(*proc) +
>> +		proc->err_info_num * (sizeof(*err_info)));
>> +	if (len < 0) {
>> +		printk("%ssection length is too small\n", pfx);
> Now here we *can* dump it.
>
>> +		printk("%sfirmware-generated error record is incorrect\n", pfx);
>> +		printk("%sERR_INFO_NUM is %d\n", pfx, proc->err_info_num);
>> +		return;
>> +	}
>> +
>> +	if (proc->validation_bits & CPER_ARM_VALID_MPIDR)
>> +		printk("%sMPIDR: 0x%016llx\n", pfx, proc->mpidr);
>
> <---- newline here.
>
> Also, what is MPIDR and can it be written in a more user-friendly manner
> and not be an abbreviation?
>
>> +	if (proc->validation_bits & CPER_ARM_VALID_AFFINITY_LEVEL)
>> +		printk("%serror affinity level: %d\n", pfx,
>> +			proc->affinity_level);
>> +	if (proc->validation_bits & CPER_ARM_VALID_RUNNING_STATE) {
>> +		printk("%srunning state: 0x%x\n", pfx, proc->running_state);
>> +		printk("%sPSCI state: %d\n", pfx, proc->psci_state);
> One more abbreviation. Please consider whether having the abbreviations
> or actually writing them out is more user-friendly.
>
>> +	}
>> +
>> +	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
> That INDENT_SP thing is just silly, someone should kill it.
>
>> +
>> +	err_info = (struct cper_arm_err_info *)(proc + 1);
>> +	for (i = 0; i < proc->err_info_num; i++) {
>> +		printk("%sError info structure %d:\n", pfx, i);
>> +		printk("%sversion:%d\n", newpfx, err_info->version);
>> +		printk("%slength:%d\n", newpfx, err_info->length);
> <---- newline here.
>
> Why do we even dump version and info for *every* err_info structure?
Because these are part of the error information structure. I wouldn't 
think FW would populate error information structures that are different 
versions in the same processor error, but it could be possible from the 
spec (at least once there are different versions of the table).
>
>> +		if (err_info->validation_bits &
>> +		    CPER_ARM_INFO_VALID_MULTI_ERR) {
>> +			if (err_info->multiple_error == 0)
>> +				printk("%ssingle error\n", newpfx);
>> +			else if (err_info->multiple_error == 1)
>> +				printk("%smultiple errors\n", newpfx);
>> +			else
>> +				printk("%smultiple errors count:%u\n",
>> +				newpfx, err_info->multiple_error);
> So this can be simply: "num errors: %d", err_info->multiple_error+1...
>
> Without checking CPER_ARM_INFO_VALID_MULTI_ERR.
>
>> +		}
> <---- newline here.
>
>> +		if (err_info->validation_bits & CPER_ARM_INFO_VALID_FLAGS) {
>> +			if (err_info->flags & CPER_ARM_INFO_FLAGS_FIRST)
>> +				printk("%sfirst error captured\n", newpfx);
>> +			if (err_info->flags & CPER_ARM_INFO_FLAGS_LAST)
>> +				printk("%slast error captured\n", newpfx);
>> +			if (err_info->flags & CPER_ARM_INFO_FLAGS_PROPAGATED)
>> +				printk("%spropagated error captured\n",
>> +				       newpfx);
>> +			if (err_info->flags & CPER_ARM_INFO_FLAGS_OVERFLOW)
>> +				printk("%soverflow occurred, error info is incomplete\n",
>> +				       newpfx);
>> +		}
> <---- newline here.
>
>> +		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
>> +			err_info->type < ARRAY_SIZE(proc_error_type_strs) ?
>> +			proc_error_type_strs[err_info->type] : "unknown");
>> +		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO)
>> +			printk("%serror_info: 0x%016llx\n", newpfx,
>> +			       err_info->error_info);
> err_info->error_info ?
>
> What is that supposed to mean? A u64 value of some sorts.
There is an error information 64 bit value in the ARM processor error 
information structure. (UEFI spec 2.6 table 261)
>
>> +		if (err_info->validation_bits & CPER_ARM_INFO_VALID_VIRT_ADDR)
>> +			printk("%svirtual fault address: 0x%016llx\n",
>> +				newpfx, err_info->virt_fault_addr);
>> +		if (err_info->validation_bits &
>> +		    CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
> Just let that line stick out.
>
>> +			printk("%sphysical fault address: 0x%016llx\n",
>> +				newpfx, err_info->physical_fault_addr);
>> +		err_info += 1;
>> +	}
> <---- newline here.
>
> That function is kinda missing newlines.
>
>> +	ctx_info = (struct cper_arm_ctx_info *)err_info;
>> +	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
>> +	for (i = 0; i < proc->context_info_num; i++) {
>> +		int size = sizeof(*ctx_info) + ctx_info->size;
>> +
>> +		printk("%sContext info structure %d:\n", pfx, i);
>> +		if (len < size) {
>> +			printk("%ssection length is too small\n", newpfx);
>> +			printk("%sfirmware-generated error record is incorrect\n", pfx);
>> +			return;
>> +		}
>> +		if (ctx_info->type > max_ctx_type) {
>> +			printk("%sInvalid context type: %d\n", newpfx,
>> +							ctx_info->type);
>> +			printk("%sMax context type: %d\n", newpfx,
>> +							max_ctx_type);
>> +			return;
> You can combine those into:
>
>                          printk("%sInvalid context type: %d (max: %d)\n",
> 				newpfx, ctx_info->type, max_ctx_type);
>
>
>> +		}
>> +		printk("%sregister context type %d: %s\n", newpfx,
>> +			ctx_info->type, arm_reg_ctx_strs[ctx_info->type]);
> Why dump the type as %d and as a string too? String should be enough, no?
Yes, the string should be sufficient.
>
>> +		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4,
>> +				(ctx_info + 1), ctx_info->size, 0);
>> +		len -= size;
>> +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + size);
>> +	}
>> +
>> +	if (len > 0) {
>> +		printk("%sVendor specific error info has %u bytes:\n", pfx,
>> +		       len);
>> +		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4, ctx_info,
>> +				len, true);
> That looks like it should be a debug printk...
Why's that? Dumping this vendor specific error information is similar to 
the unrecognized CPER section reporting which is also meant for vendor 
specific information https://lkml.org/lkml/2017/4/18/751

Thanks,
Tyler
>
>> +	}
>> +}
>> +#endif
>> +
>>   static const char * const mem_err_type_strs[] = {
>>   	"unknown",
>>   	"no error",
>> @@ -461,6 +586,16 @@ static void cper_estatus_timestamp(const char *pfx,
>>   			cper_print_pcie(newpfx, pcie, gdata);
>>   		else
>>   			goto err_section_too_small;
>> +	} else if ((IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)) &&
>> +		   !uuid_le_cmp(*sec_type, CPER_SEC_PROC_ARM)) {
>> +		struct cper_sec_proc_arm *arm_err;
>> +
>> +		arm_err = acpi_hest_get_payload(gdata);
> 		struct cper_sec_proc_arm *arm_err = acpi_hest_get_payload(gdata);
>
>> +		printk("%ssection_type: ARM processor error\n", newpfx);
>> +		if (gdata->error_data_length >= sizeof(*arm_err))
>> +			cper_print_proc_arm(newpfx, arm_err);
>> +		else
>> +			goto err_section_too_small;
> You need to build-test your patches before submitting:
>
> drivers/firmware/efi/cper.c: In function ?cper_estatus_print_section?:
> drivers/firmware/efi/cper.c:596:4: error: implicit declaration of function ?cper_print_proc_arm? [-Werror=implicit-function-declaration]
>      cper_print_proc_arm(newpfx, arm_err);
>      ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/firmware/efi/cper.o] Error 1
> make[2]: *** [drivers/firmware/efi] Error 2
> make[1]: *** [drivers/firmware] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> this is a x86 build.
>
>>   	} else
>>   		printk("%s""section type: unknown, %pUl\n", newpfx, sec_type);
>>   
>> diff --git a/include/linux/cper.h b/include/linux/cper.h
>> index dcacb1a..85450f3 100644
>> --- a/include/linux/cper.h
>> +++ b/include/linux/cper.h
>> @@ -180,6 +180,10 @@ enum {
>>   #define CPER_SEC_PROC_IPF						\
>>   	UUID_LE(0xE429FAF1, 0x3CB7, 0x11D4, 0x0B, 0xCA, 0x07, 0x00,	\
>>   		0x80, 0xC7, 0x3C, 0x88, 0x81)
>> +/* Processor Specific: ARM */
>> +#define CPER_SEC_PROC_ARM						\
>> +	UUID_LE(0xE19E3D16, 0xBC11, 0x11E4, 0x9C, 0xAA, 0xC2, 0x05,	\
>> +		0x1D, 0x5D, 0x46, 0xB0)
>>   /* Platform Memory */
>>   #define CPER_SEC_PLATFORM_MEM						\
>>   	UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83,	\
>> @@ -255,6 +259,22 @@ enum {
>>   
>>   #define CPER_PCIE_SLOT_SHIFT			3
>>   
>> +#define CPER_ARM_VALID_MPIDR			0x00000001
>> +#define CPER_ARM_VALID_AFFINITY_LEVEL		0x00000002
>> +#define CPER_ARM_VALID_RUNNING_STATE		0x00000004
>> +#define CPER_ARM_VALID_VENDOR_INFO		0x00000008
>> +
>> +#define CPER_ARM_INFO_VALID_MULTI_ERR		0x0001
>> +#define CPER_ARM_INFO_VALID_FLAGS		0x0002
>> +#define CPER_ARM_INFO_VALID_ERR_INFO		0x0004
>> +#define CPER_ARM_INFO_VALID_VIRT_ADDR		0x0008
>> +#define CPER_ARM_INFO_VALID_PHYSICAL_ADDR	0x0010
>> +
>> +#define CPER_ARM_INFO_FLAGS_FIRST		0x0001
>> +#define CPER_ARM_INFO_FLAGS_LAST		0x0002
>> +#define CPER_ARM_INFO_FLAGS_PROPAGATED		0x0004
>> +#define CPER_ARM_INFO_FLAGS_OVERFLOW		0x0008
> For all of the above use BIT().
>
>> +
>>   /*
>>    * All tables and structs must be byte-packed to match CPER
>>    * specification, since the tables are provided by the system BIOS
>> @@ -340,6 +360,40 @@ struct cper_ia_proc_ctx {
>>   	__u64	mm_reg_addr;
>>   };
>>   
>> +/* ARM Processor Error Section */
>> +struct cper_sec_proc_arm {
>> +	__u32	validation_bits;
>> +	__u16	err_info_num; /* Number of Processor Error Info */
>> +	__u16	context_info_num; /* Number of Processor Context Info Records*/
>> +	__u32	section_length;
>> +	__u8	affinity_level;
>> +	__u8	reserved[3];	/* must be zero */
>> +	__u64	mpidr;
>> +	__u64	midr;
>> +	__u32	running_state; /* Bit 0 set - Processor running. PSCI = 0 */
>> +	__u32	psci_state;
> Align comments vertically pls.
>
>> +};
>> +
>> +/* ARM Processor Error Information Structure */
>> +struct cper_arm_err_info {
>> +	__u8	version;
>> +	__u8	length;
>> +	__u16	validation_bits;
>> +	__u8	type;
>> +	__u16	multiple_error;
>> +	__u8	flags;
>> +	__u64	error_info;
>> +	__u64	virt_fault_addr;
>> +	__u64	physical_fault_addr;
>> +};
>> +
>> +/* ARM Processor Context Information Structure */
>> +struct cper_arm_ctx_info {
>> +	__u16	version;
>> +	__u16	type;
>> +	__u32	size;
>> +};

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
