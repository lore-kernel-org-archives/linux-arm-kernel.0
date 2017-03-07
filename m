From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 7 Mar 2017 09:39:21 -0700
Subject: [PATCH V12 07/10] efi: print unrecognized CPER section
In-Reply-To: <1488834300.2210.19.camel@perches.com>
References: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
 <1488833103-21082-8-git-send-email-tbaicar@codeaurora.org>
 <1488834300.2210.19.camel@perches.com>
Message-ID: <97e55f70-c494-395b-6e5a-c52cb347162d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/6/2017 2:05 PM, Joe Perches wrote:
> On Mon, 2017-03-06 at 13:45 -0700, Tyler Baicar wrote:
>> UEFI spec allows for non-standard section in Common Platform Error
>> Record. This is defined in section N.2.3 of UEFI version 2.5.
>>
>> Currently if the CPER section's type (UUID) does not match with
>> one of the section types that the kernel knows how to parse, the
>> section is skipped. Therefore, user is not able to see
>> such CPER data, for instance, error record of non-standard section.
>>
>> For above mentioned case, this change prints out the raw data in
>> hex in dmesg buffer. Data length is taken from Error Data length
>> field of Generic Error Data Entry.
> Hi Tyler.
>
> Trivia: (probably not worth resubmitting for this)
>
> There's a slight mismatch between logging output and commit
> message.  Now there's an ASCII block after the output.
>
> Another suggestion below.
True, I can update this commit for the next patch set.
>
>> Following is a sample output from dmesg:
>> [  115.771702] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>> [  115.779042] {1}[Hardware Error]: It has been corrected by h/w and requires no further action
>> [  115.787456] {1}[Hardware Error]: event severity: corrected
>> [  115.792927] {1}[Hardware Error]:  Error 0, type: corrected
>> [  115.798415] {1}[Hardware Error]:  fru_id: 00000000-0000-0000-0000-000000000000
>> [  115.805596] {1}[Hardware Error]:  fru_text:
>> [  115.816105] {1}[Hardware Error]:  section type: d2e2621c-f936-468d-0d84-15a4ed015c8b
>> [  115.823880] {1}[Hardware Error]:  section length: 88
>> [  115.828779] {1}[Hardware Error]:   00000000: 01000001 00000002 5f434345 525f4543
>> [  115.836153] {1}[Hardware Error]:   00000010: 0000574d 00000000 00000000 00000000
>> [  115.843531] {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000
>> [  115.850908] {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000
>> [  115.858288] {1}[Hardware Error]:   00000040: fe800000 00000000 00000004 5f434345
>> [  115.865665] {1}[Hardware Error]:   00000050: 525f4543 0000574d
> []
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> []
>> @@ -591,8 +591,16 @@ static void cper_estatus_print_section(
>>   			cper_print_proc_arm(newpfx, arm_err);
>>   		else
>>   			goto err_section_too_small;
>> -	} else
>> -		printk("%s""section type: unknown, %pUl\n", newpfx, sec_type);
>> +	} else {
>> +		const void *unknown_err;
>> +
>> +		unknown_err = acpi_hest_generic_data_payload(gdata);
>> +		printk("%ssection type: unknown, %pUl\n", newpfx, sec_type);
>> +		printk("%ssection length: %d\n", newpfx,
>> +		       gdata->error_data_length);
> It might be nice to output this as
>
> 		printk("%ssection length: %d (%#x)\n",
> 		       newpfx, gdata->error_data_length, gdata->error_data_length);
>
> so it's easy to know the appropriate hex buffer length too.
I will make this change in the next patch set.

Thanks,
Tyler
>
>> +		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4,
>> +			       unknown_err, gdata->error_data_length, true);
>> +	}
>>   
>>   	return;
>>   

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
