From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Aug 2014 12:07:45 +0100
Subject: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI flags
 for PSCI init
In-Reply-To: <53F3297A.1040309@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
 <53F246D4.7040807@arm.com> <53F3297A.1040309@linaro.org>
Message-ID: <53F33001.5000207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/08/14 11:39, Hanjun Guo wrote:
> On 2014-8-19 2:32, Sudeep Holla wrote:
>> On 04/08/14 16:28, Hanjun Guo wrote:
>>> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
>>> the former signals to the OS that the hardware is PSCI compliant.
>>> The latter selects the appropriate conduit for PSCI calls by
>>> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
>>> (SMC).
>>>
>>> FADT table contains such information, parse FADT to get the flags
>>> for PSCI init. Since ACPI 5.1 doesn't support self defined PSCI
>>> function IDs, which means that only PSCI 0.2+ is supported in ACPI.
>>>
>>> At the same time, only ACPI 5.1 or higher verison supports PSCI,
>>> and FADT Major.Minor version was introduced in ACPI 5.1, so we
>>> will check the version and only parse FADT table with version >= 5.1.
>>>
>>> If firmware provides ACPI tables with ACPI version less than 5.1,
>>> OS will be messed up with those information and have no way to
>>> bring up secondery CPUs, so disable ACPI if we get an FADT table
>>> with version less that 5.1.
>>>
> [...]
>>>
>>> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>> +{
>>> +    struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>>> +
>>> +    /*
>>> +     * Revision in table header is the FADT Major version,
>>> +     * and there is a minor version of FADT which was introduced
>>> +     * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
>>> +     * to get arm boot flags, or we will disable ACPI.
>>> +     */
>>> +    if (table->revision < 5 || fadt->minor_revision < 1) {
>>
>>                  &&
>
> Catalin also pointed out this bug :), but && is not enough, for example,
> this would not trigger of revision 4.1, although 4.1 is not exist, but
> the code will still confusing people, so I updated the code as:
>

Right I missed it :), the below code looks fine.

> +       if (table->revision > 5 ||
> +           (table->revision == 5 && fadt->minor_revision >= 1)) {
> +               return 0;
> +       } else {
> +               pr_info("FADT revision is %d.%d, no PSCI support, should be 5.1
> or higher\n",
> +                       table->revision, fadt->minor_revision);
> +               disable_acpi();

As suggested elsewhere try to eliminate this and have it once if
acpi_boot_init failed for any reasons.

Regards,
Sudeep
