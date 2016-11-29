From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 29 Nov 2016 10:30:02 -0700
Subject: [PATCH V5 02/10] ras: acpi/apei: cper: generic error data entry
 v3 per ACPI 6.1
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62DC87D66@lhreml502-mbb>
References: <1479767763-27532-1-git-send-email-tbaicar@codeaurora.org>
 <1479767763-27532-3-git-send-email-tbaicar@codeaurora.org>
 <86258A5CC0A3704780874CF6004BA8A62DC87D66@lhreml502-mbb>
Message-ID: <9cec3193-74b4-4e27-670b-3d6d36ee27a5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 4:29 AM, Shiju Jose wrote:
>> @@ -451,12 +484,12 @@ void cper_estatus_print(const char *pfx,
>>   	printk("%s""event severity: %s\n", pfx,
>> cper_severity_str(severity));
>>   	data_len = estatus->data_length;
>>   	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
>> +
>>   	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
>> -	while (data_len >= sizeof(*gdata)) {
>> -		gedata_len = gdata->error_data_length;
>> +
>> +	while (data_len >= acpi_hest_generic_data_size(gdata)) {
>>   		cper_estatus_print_section(newpfx, gdata, sec_no);
>> -		data_len -= gedata_len + sizeof(*gdata);
>> -		gdata = (void *)(gdata + 1) + gedata_len;
>> +		gdata = acpi_hest_generic_data_next(gdata);
>>   		sec_no++;
>>   	}
>>   }
> Hi Tyler,
> Will the above while loop does not come out because data_len is not getting updated as it did in V4 patch?
> This is the behaviour seen when we tested on our platform. It worked fine when we update the data_len.

Hello Shiju,

Thank you for testing, and you're right...looks like I got a little too excited at this code simplification. :)
I'll add the data_len update in the next patchset.

Thanks,
Tyler
