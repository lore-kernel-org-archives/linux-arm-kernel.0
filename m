From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 19:24:36 -0400
Subject: [PATCH v4 09/18] ARM64 / ACPI: Parse FADT table to get PSCI flags
 for PSCI init
In-Reply-To: <20140915145410.GD5415@arm.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-10-git-send-email-hanjun.guo@linaro.org>
 <20140915063808.GC26649@localhost> <20140915145410.GD5415@arm.com>
Message-ID: <54177534.806@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 10:54 AM, Catalin Marinas wrote:
> On Mon, Sep 15, 2014 at 07:38:08AM +0100, Olof Johansson wrote:
>> On Fri, Sep 12, 2014 at 10:00:07PM +0800, Hanjun Guo wrote:
>>> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>> +{
>>> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>>> +
>>> +	/*
>>> +	 * Revision in table header is the FADT Major revision,
>>> +	 * and there is a minor revision of FADT which was introduced
>>> +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher revision
>>> +	 * to get arm boot flags, or we will disable ACPI.
>>> +	 */
>>> +	if (table->revision > 5 ||
>>> +	    (table->revision == 5 && fadt->minor_revision >= 1))
>>> +		return 0;
>>
>> The commend and code disagree. The code says 5.1 or newer, while the comment say
>> _only_ 5.1. One or the other needs to change.
> 
> I don't think the comment and code disagree, it says "we only deal with
> ACPI 5.1 _or_ higher revision".
> 
> But since you mention it and following my other thread with Grant, I
> think at least for now we should make this check 5.1 only.

The problem with making this 5.1 only is that the specification will
move forward. The way the specification works is that the version
increments, structures grow new members, but additions are done in a
backward-compatible way. Therefore there's no reason why an ACPI6.0
system (in theory) should not be able to boot a 5.1 kernel[0]. By
artificially restricting this compatibility, users are worse off.

Jon.

[0] There will be examples where this is not true - let's say there's a
GICvX specification that's incompatible with GICv3+ and GICvX folks
don't necessarily choose to implement backward compatibility for GICv3.
If there's a new MADT subtype record handling GICvX then the OS would
need to support minimally the ACPI rev that adds this type.
