From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 21 Apr 2017 10:04:35 -0600
Subject: [PATCH V15 03/11] cper: add timestamp print to CPER status
 printing
In-Reply-To: <20170421122150.76cce2cfrt767glv@pd.tnic>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-4-git-send-email-tbaicar@codeaurora.org>
 <20170421122150.76cce2cfrt767glv@pd.tnic>
Message-ID: <35cc4ae0-e8fa-fd3a-5d7f-243ed2e82ea0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2017 6:21 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 05:05:15PM -0600, Tyler Baicar wrote:
>> The ACPI 6.1 spec added a timestamp to the HEST generic data
> HEST?
>
> I see the timestamp in
>
> Table 18-343 Generic Error Data Entry
>
> where those things are "One or more Generic Error Data Entry structures
> may be recorded in the Generic Error Data Entries field of the Generic
> Error Status Block structure."
>
> And those are part of the "18.3.2.7 Generic Hardware Error Source",
> i.e., GHES. So why do you say "HEST" above?
Ah yes, this should be GHES no HEST. There are too many acronyms 
involved here :)
>
>> structure. Print the timestamp out when printing out the error
>> status information.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Remove those Reviewed-by:s
>
>> ---
>>   drivers/firmware/efi/cper.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 8328a6f..46585f9 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -32,6 +32,8 @@
>>   #include <linux/acpi.h>
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>> +#include <linux/printk.h>
>> +#include <linux/bcd.h>
>>   #include <acpi/ghes.h>
>>   
>>   #define INDENT_SP	" "
>> @@ -387,6 +389,29 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>>   	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
>>   }
>>   
>> +static void cper_estatus_timestamp(const char *pfx,
> cper_print_tstamp()
>
>> +				   struct acpi_hest_generic_data_v300 *gdata)
>> +{
>> +	__u8 hour, min, sec, day, mon, year, century, *timestamp;
>> +
>> +	if (gdata->validation_bits & ACPI_HEST_GEN_VALID_TIMESTAMP) {
>> +		timestamp = (__u8 *)&(gdata->time_stamp);
>> +		sec       = bcd2bin(timestamp[0]);
>> +		min       = bcd2bin(timestamp[1]);
>> +		hour      = bcd2bin(timestamp[2]);
>> +		day       = bcd2bin(timestamp[4]);
>> +		mon       = bcd2bin(timestamp[5]);
>> +		year      = bcd2bin(timestamp[6]);
>> +		century   = bcd2bin(timestamp[7]);
>> +
>> +		if (*(timestamp + 3) & 0x1)
>> +			printk("%stimestamp is precise\n", pfx);
>> +
>> +		printk("%stime: %02d%02d-%02d-%02d %02d:%02d:%02d\n", pfx,
>> +			century, year, mon, day, hour, min, sec);
> Yeah, about the precise tstamp, you can do something like this:
>
> ---
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 46585f92b741..a649884e2264 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -404,10 +404,8 @@ static void cper_estatus_timestamp(const char *pfx,
>   		year      = bcd2bin(timestamp[6]);
>   		century   = bcd2bin(timestamp[7]);
>   
> -		if (*(timestamp + 3) & 0x1)
> -			printk("%stimestamp is precise\n", pfx);
> -
> -		printk("%stime: %02d%02d-%02d-%02d %02d:%02d:%02d\n", pfx,
> +		printk("%s%ststamp: %02d%02d-%02d-%02d %02d:%02d:%02d\n", pfx,
> +			(timestamp[3] & 0x1 ? "precise " : ""),
>   			century, year, mon, day, hour, min, sec);
>   	}
>   }
This is basically what I already had in v14...you asked to move it into 
a different if-statement? https://lkml.org/lkml/2017/4/12/397

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
