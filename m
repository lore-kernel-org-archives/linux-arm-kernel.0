From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 20 Jan 2015 11:05:28 +0800
Subject: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
In-Reply-To: <20150119115017.GH11835@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
 <20150119115017.GH11835@e104818-lin.cambridge.arm.com>
Message-ID: <54BDC5F8.5000702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?19? 19:50, Catalin Marinas wrote:
> On Wed, Jan 14, 2015 at 03:04:55PM +0000, Hanjun Guo wrote:
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
> [...]
>> @@ -64,8 +88,13 @@ void __init acpi_boot_table_init(void)
>>   		return;
>>
>>   	/* Initialize the ACPI boot-time table parser. */
>> -	if (acpi_table_init())
>> +	if (acpi_table_init()) {
>>   		disable_acpi();
>> +		return;
>> +	}
>> +
>> +	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
>> +		pr_err("Can't find FADT or error happened during parsing FADT\n");
>>   }
>
> Do you need a disable_acpi() call here as well?

Yes, if we can not find the FADT table, we should disable ACPI, I will
update it in next version, thanks for pointing this out :)

Thanks
Hanjun
