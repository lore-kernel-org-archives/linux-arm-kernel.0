From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 12:31:16 -0400
Subject: [PATCH v4 06/18] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <20140915145106.GC5415@arm.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-7-git-send-email-hanjun.guo@linaro.org>
 <20140915062824.GB26649@localhost> <20140915145106.GC5415@arm.com>
Message-ID: <54171454.6090906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 10:51 AM, Catalin Marinas wrote:
> On Mon, Sep 15, 2014 at 07:28:24AM +0100, Olof Johansson wrote:
>> On Fri, Sep 12, 2014 at 10:00:04PM +0800, Hanjun Guo wrote:
>>>  			See also Documentation/power/runtime_pm.txt, pci=noacpi
>>>  
>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>> index 9252f72..693da7f 100644
>>> --- a/arch/arm64/kernel/acpi.c
>>> +++ b/arch/arm64/kernel/acpi.c
>>> @@ -67,3 +67,18 @@ void __init acpi_boot_table_init(void)
>>>  	if (acpi_table_init())
>>>  		disable_acpi();
>>>  }
>>> +
>>> +static int __init parse_acpi(char *arg)
>>> +{
>>> +	if (!arg)
>>> +		return -EINVAL;
>>> +
>>> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
>>> +	if (strcmp(arg, "off") == 0)
>>> +		disable_acpi();
>>> +	else
>>> +		return -EINVAL;	/* Core will print when we return error */
>>
>> For symmetry, you should handle acpi=force here too (i.e. if someone
>> disables by default, which I expect we'll ask for when this code is
>> first merged).
> 
> Does this mean you want another Kconfig option - ACPI_DEFAULT_OFF (which
> would be set by default)?

This would make sense. I mentioned this before since it gives distros an
opportunity to set this differently for their shipping preference
without the upstream having to default to being on.

Jon.
