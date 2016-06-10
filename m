From: jcm@redhat.com (Jon Masters)
Date: Fri, 10 Jun 2016 14:54:59 -0400 (EDT)
Subject: [PATCH V8 5/9] pci, acpi: add acpi hook to assign domain number.
In-Reply-To: <20160610181836.GA7843@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-6-git-send-email-tn@semihalf.com>
 <20160608001559.GD4759@localhost> <20160610151458.GA23638@red-moon>
 <20160610154908.GB23638@red-moon> <575AEF9C.4090205@semihalf.com>
 <20160610181836.GA7843@localhost>
Message-ID: <8620FB5B-4A60-48B6-A6E0-38D2007CD360@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Sorry for top posting while on the road. If this refactoring can happen later, is it possible to merge now (well, -next anyway) and explore other work as next steps?

Jon.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 10, 2016, at 13:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> On Fri, Jun 10, 2016 at 06:49:32PM +0200, Tomasz Nowicki wrote:
>>> On 10.06.2016 17:49, Lorenzo Pieralisi wrote:
>>>> On Fri, Jun 10, 2016 at 04:14:58PM +0100, Lorenzo Pieralisi wrote:
>>>> Hi Bjorn, Tomasz,
>>>> 
>>>> On Tue, Jun 07, 2016 at 07:15:59PM -0500, Bjorn Helgaas wrote:
>>>> 
>>>> [...]
>>>> 
>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>> index eb431b5..2b52178 100644
>>>>>> --- a/drivers/pci/pci.c
>>>>>> +++ b/drivers/pci/pci.c
>>>>>> @@ -7,6 +7,7 @@
>>>>>>  *    Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
>>>>>>  */
>>>>>> 
>>>>>> +#include <linux/acpi.h>
>>>>>> #include <linux/kernel.h>
>>>>>> #include <linux/delay.h>
>>>>>> #include <linux/init.h>
>>>>>> @@ -4941,7 +4942,7 @@ int pci_get_new_domain_nr(void)
>>>>>> }
>>>>>> 
>>>>>> #ifdef CONFIG_PCI_DOMAINS_GENERIC
>>>>>> -void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>>>>>> +static int of_pci_bus_domain_nr(struct device *parent)
>>>>> 
>>>>> Can we do a little cleanup before this patch?
>>>>> 
>>>>>  - pci_bus_assign_domain_nr() is only used inside drivers/pci, so
>>>>>    maybe we move the prototype to drivers/pci/pci.h?
>>>>> 
>>>>>  - I don't really like the style of calling a function that
>>>>>    internally assigns bus->domain_nr.  Could we do something like
>>>>>    this instead?
>>>>> 
>>>>>    int pci_bus_domain_nr(...)
>>>>>    {
>>>>>      ...
>>>>>      return domain;
>>>>>    }
>>>>> 
>>>>>    ... pci_create_root_bus(...)
>>>>>    {
>>>>>      ...
>>>>>      b->domain_nr = pci_bus_domain_nr(...);
>>>> 
>>>> We noticed while preparing v9, that this would force us to
>>>> write an empty pci_bus_domain_nr() prototype for
>>>> !PCI_DOMAINS_GENERIC (ie every arch but ARM/ARM64) that should
>>>> return 0 to keep current behaviour unchanged.
>>>> 
>>>> That's why pci_bus_assign_domain_nr() was there, so that it
>>>> was compiled out on !PCI_DOMAINS_GENERIC.
>>>> 
>>>> I really would like v9 to be final so let's fix it before posting it
>>>> shortly please.
>>>> 
>>>> For the above we have three options:
>>>> 
>>>> 1) Leave code as-is in v8
>>>> 
>>>> 2) in pci_create_root_bus():
>>>> #ifdef CONFIG_PCI_DOMAINS_GENERIC
>>>>       b->domain_nr = pci_bus_domain_nr(...);
>>>> #endif
>>>> 
>>>> + other changes requested above
>>>> 
>>>> 3) in pci_create_root_bus()
>>>> 
>>>> b->domain_nr = pci_bus_domain_nr(...);
>>>> 
>>>> unguarded and a stub:
>>>> 
>>>> #ifndef CONFIG_PCI_DOMAINS_GENERIC
>>>> static inline int pci_bus_domain_nr() { return 0; }
>>>> #endif
>>>> 
>>>> + other changes requested above
>>> 
>>> Actually, Tomasz made me notice that pci_bus.domain_nr is
>>> only declared for CONFIG_PCI_DOMAINS_GENERIC so (3) is not
>>> even an option and IMO (2) is not much nicer than code in
>>> v8 as-is with an ifdef in the middle of pci_create_root_bus().
>> 
>> To me (1) is nicer too. Bjorn what is your take on this? This is
>> last bit before sending v9.
> 
> My preference is (2).  The ifdef in pci_create_root_bus() is a little
> ugly, but I like it better because it will fit nicely into Arnd's
> idea of having the native drivers allocate and fill in a host bridge
> structure before calling the PCI core.  The domain is one thing those
> drivers could fill in.  I like that model much better than having the
> PCI core make callbacks to get information that we should have passed
> in to begin with.
> 
> The current code suggests that assigning the domain is the PCI core's
> responsibility, and that's not really the case -- for ACPI it's
> totally up to pci_root.c, for other drivers it comes from the DT, and
> for others it might depend on the driver's knowledge of the hardware
> (I'm thinking of parisc, where, I think we currently put all the
> bridges in the same domain, but IIRC they *could* each be in their own
> domain with a full [bus 00-ff] range for each bridge because each
> bridge has its own config space access mechanism).
> 
> But it's not that big a deal either way -- we could do this bit of
> restructuring later, too.
> 
> Bjorn
