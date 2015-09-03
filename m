From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Sep 2015 09:18:45 +0100
Subject: [PATCH v2 1/4] of/pci: Add of_pci_check_probe_only to parse
 "linux, pci-probe-only"
In-Reply-To: <20150902222325.GD829@google.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
 <CAL_JsqL7VPB6nc-zRYm_73ZSgYVq_+a6sW_XZZ_LRaUXf4jTng@mail.gmail.com>
 <20150902222325.GD829@google.com>
Message-ID: <55E80265.3050701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/15 23:23, Bjorn Helgaas wrote:
> On Fri, Aug 14, 2015 at 04:08:10PM -0500, Rob Herring wrote:
>> On Fri, Aug 14, 2015 at 11:19 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
>>> to engage the PCI_PROBE_ONLY mode, and both have a subtle bug that
>>> can be triggered if the property has no parameter.
>>
>> Humm, I bet we could break a lot of machines if we fixed the core code
>> to properly make pp->value NULL when there is no value.
>>
>>> Provide a generic implementation that can be used by both.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  drivers/of/of_pci.c    | 30 ++++++++++++++++++++++++++++++
>>>  include/linux/of_pci.h |  3 +++
>>>  2 files changed, 33 insertions(+)
>>>
>>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>>> index 5751dc5..a4e29ff 100644
>>> --- a/drivers/of/of_pci.c
>>> +++ b/drivers/of/of_pci.c
>>> @@ -118,6 +118,36 @@ int of_get_pci_domain_nr(struct device_node *node)
>>>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>>>
>>>  /**
>>> + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
>>> + *                           is present and valid
>>> + *
>>> + * @node: device tree node that may contain the property (usually "chosen")
>>> + *
>>> + */
>>> +void of_pci_check_probe_only(struct device_node *node)
>>> +{
>>> +       const int *prop;
>>> +       int len;
>>> +
>>> +       if (!node)
>>> +               return;
>>> +
>>> +       prop = of_get_property(node, "linux,pci-probe-only", &len);
>>
>> It is preferred to use of_property_read_u32 to avoid just these types
>> of problems.
> 
> I don't know enough OF to really understand this, but I infer that
> this is a suggestion for improving the patch.  Should I be waiting for
> a v3 series?

Yes, I'll post an update very shortly. Thanks for reminding me!

	M.
-- 
Jazz is not dead. It just smells funny...
