From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 08:46:33 +0100
Subject: [PATCH V4 4/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
In-Reply-To: <570F4926.9080505@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-5-git-send-email-tn@semihalf.com>
 <570E645A.9010600@arm.com> <570E6794.4080409@semihalf.com>
 <570E6B2C.3060700@arm.com> <570F4926.9080505@semihalf.com>
Message-ID: <570F4AD9.4040007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 08:39, Tomasz Nowicki wrote:
> On 13.04.2016 17:52, Marc Zyngier wrote:
>> On 13/04/16 16:36, Tomasz Nowicki wrote:
>>> On 13.04.2016 17:23, Marc Zyngier wrote:
>>>> On 04/04/16 09:52, Tomasz Nowicki wrote:
>>>>> IORT shows representation of IO topology for ARM based systems.
>>>>> It describes how various components are connected together on
>>>>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>>>>
>>>>> Initial support allows to:
>>>>> - register ITS MSI chip along with ITS translation ID and domain token
>>>>> - deregister ITS MSI chip based on ITS translation ID
>>>>> - find registered domain token based on ITS translation ID
>>>>> - map MSI RID based on PCI device and requester ID
>>>>> - find domain token based on PCI device and requester ID
>>>>>
>>>>> To: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>>> ---
>>>>>    drivers/acpi/Kconfig    |   3 +
>>>>>    drivers/acpi/Makefile   |   1 +
>>>>>    drivers/acpi/iort.c     | 335 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    drivers/irqchip/Kconfig |   1 +
>>>>>    include/linux/iort.h    |  31 +++++
>>>>>    5 files changed, 371 insertions(+)
>>>>>    create mode 100644 drivers/acpi/iort.c
>>>>>    create mode 100644 include/linux/iort.h
>>>>>
>>>>
>>>> [...]
>>>>
>>>>> +static acpi_status
>>>>> +iort_find_dev_callback(struct acpi_iort_node *node, void *context)
>>>>> +{
>>>>> +	struct acpi_iort_root_complex *pci_rc;
>>>>> +	struct device *dev = context;
>>>>> +	struct pci_bus *bus;
>>>>> +
>>>>> +	switch (node->type) {
>>>>> +	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
>>>>> +		bus = to_pci_bus(dev);
>>>>> +		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>>>>> +
>>>>> +		/*
>>>>> +		 * It is assumed that PCI segment numbers maps one-to-one
>>>>> +		 * with root complexes. Each segment number can represent only
>>>>> +		 * one root complex.
>>>>> +		 */
>>>>> +		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
>>>>> +			return AE_OK;
>>>>
>>>> What guarantees that this is ever valid? As far as I know, pci_domain_nr
>>>> is completely arbitrary, and depends both on the probe order and the
>>>> phase of the moon. If you want this to be reliable, you need to allocate
>>>> the domain number from pci_segment_number.
>>>>
>>>> I must be missing something. Care to shed some light on this?
>>>>
>>> Sure. Please see:
>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
>>> 3.1.1.5 PCI root complex node
>>> PCI Segment number -> The PCI segment number, as in MCFG and as
>>> returned by _SEG in the namespace.
>>>
>>> So IORT spec states that pci_segment_number corresponds to the segment
>>> number from MCFG table and _SEG method. Here is my patch which makes
>>> sure pci_domain_nr(bus) is set properly:
>>> https://lkml.org/lkml/2016/2/16/418
>>
>> Lovely. So this series is actually dependent on the PCI one. I guess we
>> need to solve that one first, because IORT seems pretty pointless if we
>> don't have PCI support. What's the plan?
>>
> 
> The plan is to make this series ready for being merged. Once we get PCI 
> series upstream, we can just retest ITS final series and pull it in, if 
> you agree. PCI domain assignment is settled so it will not be the reason 
> for fundamental changes here. What do you think?

As long as you are making progress on the PCI front, and that we
establish that PCI must go in first, I'm OK with that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
