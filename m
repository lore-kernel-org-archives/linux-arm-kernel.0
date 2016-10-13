From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Thu, 13 Oct 2016 14:15:48 -0600
Subject: [PATCH V3 08/10] ras: acpi / apei: generate trace event for
 unrecognized CPER section
In-Reply-To: <87mvi8seng.fsf@e105922-lin.cambridge.arm.com>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-9-git-send-email-tbaicar@codeaurora.org>
 <87mvi8seng.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <6d0637b2-3ed5-1392-601d-3cbffd26026a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Punit,

On 10/13/2016 4:54 AM, Punit Agrawal wrote:
> Hi Tyler,
>
> One last comment...
>
> Tyler Baicar <tbaicar@codeaurora.org> writes:
>
>> UEFI spec allows for non-standard section in Common Platform Error
>> Record. This is defined in section N.2.3 of UEFI version 2.5.
>>
>> Currently if the CPER section's type (UUID) does not match with
>> any section type that the kernel knows how to parse, trace event
>> is not generated for such section. And thus user is not able to know
>> happening of such hardware error, including error record of
>> non-standard section.
>>
>> This commit generates a trace event which contains raw error data
>> for unrecognized CPER section.
>>
>> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 18 +++++++++++++++++-
>>   drivers/ras/ras.c        |  1 +
>>   include/ras/ras_event.h  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 36894c8..cb4c7f4 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -49,6 +49,7 @@
>>   #include <acpi/ghes.h>
>>   #include <acpi/apei.h>
>>   #include <asm/tlbflush.h>
>> +#include <ras/ras_event.h>
>>   
>>   #ifdef CONFIG_HAVE_ACPI_APEI_SEA
>>   #include <asm/system_misc.h>
>> @@ -468,12 +469,21 @@ static void ghes_do_proc(struct ghes *ghes,
>>   	int sev, sec_sev;
>>   	struct acpi_hest_generic_data *gdata;
>>   	uuid_le sec_type;
>> +	uuid_le *fru_id;
>> +	char *fru_text = "";
>>   
>>   	sev = ghes_severity(estatus->error_severity);
>>   	apei_estatus_for_each_section(estatus, gdata) {
>>   		sec_sev = ghes_severity(gdata->error_severity);
>>   		sec_type = *(uuid_le *)gdata->section_type;
>>   
>> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
>> +			fru_id = (uuid_le *)gdata->fru_id;
>> +		else
>> +			fru_id = &NULL_UUID_LE;
> fru_id can be initialised at declaration and drop the else here. The
> same is already being done for fru_text.
Yes, I will make this change in the next version.

Thanks,
Tyler
> Thanks,
> Punit
>
>> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>> +			fru_text = gdata->fru_text;
>> +
>>   		if (!uuid_le_cmp(sec_type,
>>   				 CPER_SEC_PLATFORM_MEM)) {
>>   			struct cper_sec_mem_err *mem_err;
> [...]
>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
