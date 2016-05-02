From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 2 May 2016 14:43:56 +0200
Subject: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus
 domain number.
In-Reply-To: <20160427111758.GA6234@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-3-git-send-email-tn@semihalf.com>
 <20160427022649.GD6789@localhost> <20160427111758.GA6234@red-moon>
Message-ID: <57274B8C.5030304@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 01:17 PM, Lorenzo Pieralisi wrote:
> On Tue, Apr 26, 2016 at 09:26:49PM -0500, Bjorn Helgaas wrote:
>> On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:
[...]
>>   
>> +int acpi_pci_bus_domain_nr(struct device *parent)
>> +{
>> +	struct acpi_device *acpi_dev = to_acpi_device(parent);
>> +	unsigned long long segment = 0;
>> +	acpi_status status;
>> +
>> +	/*
>> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
>> +	 * all PCI buses belong to domain 0.
>> +	 */
>> +	status = acpi_evaluate_integer(acpi_dev->handle, METHOD_NAME__SEG, NULL,
>> +				       &segment);
>> We already have code in acpi_pci_root_add() to evaluate _SEG.  We
>> don't want to evaluate it *twice*, do we?
>>
>> I was sort of expecting that if you added it here, we'd remove the
>> existing call, but it looks like you're keeping both?
> We can't remove the existing call, since it is used on X86 and IA64
> to store the segment number that, in the process, is used in their
> pci_domain_nr() arch specific callback to retrieve the domain nr.
>
> On ARM64, that selects PCI_DOMAINS_GENERIC, we have to find a way
> to retrieve the domain number that is not arch dependent, since
> this is generic code, we can't rely on any bus->sysdata format (unless
> we do something like JC did below), therefore the only way is to call
> the _SEG method *again* here, which also forced Tomasz to go through
> the ACPI_COMPANION setting song and dance and pass the parent pointer
> to pci_create_root_bus() (see patch 1), which BTW is a source of
> trouble on its own as you noticed.
What trouble in patch 1 do you mean? I may miss something.

I agree that patch 1 is not necessary if we decide to use sysdata or 
rework root bus scanning to move domain to host bridge. Nevertheless, 
patch 1 is still a cleanup IMO.

Thanks,
Tomasz
