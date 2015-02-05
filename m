From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Feb 2015 17:45:36 +0800
Subject: [PATCH v8 09/21] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
In-Reply-To: <20150204130626.GE22035@red-moon>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-10-git-send-email-hanjun.guo@linaro.org>
 <20150203172047.GA13339@e104818-lin.cambridge.arm.com>
 <54D1E891.80405@linaro.org> <20150204130626.GE22035@red-moon>
Message-ID: <54D33BC0.4050305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?04? 21:06, Lorenzo Pieralisi wrote:
> On Wed, Feb 04, 2015 at 09:38:25AM +0000, Hanjun Guo wrote:
>> On 2015?02?04? 01:20, Catalin Marinas wrote:
>>> On Mon, Feb 02, 2015 at 12:45:37PM +0000, Hanjun Guo wrote:
>>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>>> index afe10b4..b9f64ec 100644
>>>> --- a/arch/arm64/kernel/acpi.c
>>>> +++ b/arch/arm64/kernel/acpi.c
>>>> @@ -13,6 +13,8 @@
>>>>     *  published by the Free Software Foundation.
>>>>     */
>>>>
>>>> +#define pr_fmt(fmt) "ACPI: " fmt
>>>> +
>>>>    #include <linux/acpi.h>
>>>>    #include <linux/bootmem.h>
>>>>    #include <linux/cpumask.h>
>>>> @@ -49,10 +51,32 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>>>>    	early_memunmap(map, size);
>>>>    }
>>>>
>>>> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>>> +{
>>>> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>>>> +
>>>> +	/*
>>>> +	 * Revision in table header is the FADT Major revision, and there
>>>> +	 * is a minor revision of FADT which was introduced by ACPI 5.1,
>>>> +	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
>>>> +	 * boot protocol configuration data, or we will disable ACPI.
>>>> +	 */
>>>> +	if (table->revision > 5 ||
>>>> +	    (table->revision == 5 && fadt->minor_revision >= 1))
>>>> +		return 0;
>>>> +
>>>> +	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
>>>> +		table->revision, fadt->minor_revision);
>>>> +	disable_acpi();
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>>    /*
>>>>     * acpi_boot_table_init() called from setup_arch(), always.
>>>>     *	1. find RSDP and get its address, and then find XSDT
>>>>     *	2. extract all tables and checksums them all
>>>> + *	3. check ACPI FADT revision
>>>>     *
>>>>     * We can parse ACPI boot-time tables such as MADT after
>>>>     * this function is called.
>>>> @@ -64,8 +88,16 @@ void __init acpi_boot_table_init(void)
>>>>    		return;
>>>>
>>>>    	/* Initialize the ACPI boot-time table parser. */
>>>> -	if (acpi_table_init())
>>>> +	if (acpi_table_init()) {
>>>> +		disable_acpi();
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
>>>> +		/* disable ACPI if no FADT is found */
>>>>    		disable_acpi();
>>>> +		pr_err("Can't find FADT\n");
>>>> +	}
>>>>    }
>>>
>>> It looks fine to call disable_acpi() here but a bit weird to call it
>>> again in acpi_parse_fadt(). I guess that's because acpi_table_parse()
>>> ignores the return value of the handler() call. I think it's better to
>>> fix the core code (can be an additional patch on top of this series).
>>
>> I checked all the code calling acpi_table_parse() and I found that it
>> will be no functional change if we return the value of handler(), but
>> I need Rafael's confirm on it.
>
> Are you sure ? All calls to acpi_table_parse() that checks the return
> value are affected. I guess that depends on what an error return from
> the handler means, from acpi_table_parse():
>
> * Return 0 if table found, -errno if not.

Yes, you are right. What I mean for the "no functional change" because
of most handler passed to acpi_table_parse() just return 0, I didn't
describe it clearly, my bad.

In ARM64 case, I find that we can not disable ACPI even if we return
error for the handler, for example, we return -EOPNOTSUPP when there is
no PSCI support, we can go on with cpu0 boot only.

>
> So, if table is found but parsing fails that acpi_table_parse()
> signature should be changed if the handler barfs with an error and
> it is propagated. Still, I share Catalin's comment.

Sorry, I don't understand the last sentence, do you mean you agree
with Catalin to return the result of handler()?

Thanks
Hanjun
