From: dhdang@apm.com (Duc Dang)
Date: Mon, 20 Jun 2016 12:12:24 -0700
Subject: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling for
 ACPI based PCI host controller
In-Reply-To: <5768252D.7090206@codeaurora.org>
References: <CADaLNDkziZgM-yAiK2MCqfBRzhWpLmCyPmDZEGsvwd-7nfRfLw@mail.gmail.com>
 <20160620094227.GA27594@red-moon> <5768252D.7090206@codeaurora.org>
Message-ID: <CADaLNDme9VCrM0Mk-3eOhai-TSQtzwHfo_CGqO9eLZFkzi1JGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:17 AM, Christopher Covington
<cov@codeaurora.org> wrote:
> Hi Duc,
>
> On 06/20/2016 05:42 AM, Lorenzo Pieralisi wrote:
>> On Fri, Jun 17, 2016 at 02:37:02PM -0700, Duc Dang wrote:
>>> On Thu, Jun 16, 2016 at 10:48 AM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>> On Wed, Jun 15, 2016 at 11:34:11AM -0400, Christopher Covington wrote:
>>>>> From: Tomasz Nowicki <tn@semihalf.com>
>>>>>
>>>>> pci_generic_ecam_ops is used by default. Since there are platforms
>>>>> which have non-compliant ECAM space we need to overwrite these
>>>>> accessors prior to PCI buses enumeration. In order to do that
>>>>> we call pci_mcfg_get_ops to retrieve pci_ecam_ops structure so that
>>>>> we can use proper PCI config space accessors and bus_shift.
>>>>>
>>>>> pci_generic_ecam_ops is still used for platforms free from quirks.
>>>>>
>>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>>> ---
>>>>>  arch/arm64/kernel/pci.c | 7 ++++---
>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>>>> index 94cd43c..a891bda 100644
>>>>> --- a/arch/arm64/kernel/pci.c
>>>>> +++ b/arch/arm64/kernel/pci.c
>>>>> @@ -139,6 +139,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>>>>>       struct pci_config_window *cfg;
>>>>>       struct resource cfgres;
>>>>>       unsigned int bsz;
>>>>> +     struct pci_ecam_ops *ops;
>>>>>
>>>>>       /* Use address from _CBA if present, otherwise lookup MCFG */
>>>>>       if (!root->mcfg_addr)
>>>>> @@ -150,12 +151,12 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>>>>>               return NULL;
>>>>>       }
>>>>>
>>>>> -     bsz = 1 << pci_generic_ecam_ops.bus_shift;
>>>>> +     ops = pci_mcfg_get_ops(root);
>>>>> +     bsz = 1 << ops->bus_shift;
>>>>>       cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>>>>>       cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>>>>>       cfgres.flags = IORESOURCE_MEM;
>>>>> -     cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
>>>>> -                           &pci_generic_ecam_ops);
>>>>> +     cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ops);
>>>>
>>>> Arnd pointed this out already, I think that's the only pending question
>>>> here.
>>>>
>>>> pci_ecam_create() maps ECAM space for config regions retrieved from
>>>> the MCFG, which are *supposed* to be ECAM compliant.
>>>>
>>>> Do we think that's *always* correct/safe regardless of the kind
>>>> of quirk we are currently fixing up ?
>>>>
>>>> Or we do think that configuration space regions should come from
>>>> a different resource declared in the ACPI namespace if the regions
>>>> are not MCFG/ECAM compliant (ie config space is not defined through
>>>> MCFG at all - possibly through a _CRS method for a vendor specific
>>>> _HID under the PNP0A03 node ?)
>>>
>>> Hi Lorenzo,
>>>
>>> For X-Gene: the ECAM space is used to access the configuration space
>>> of PCIe devices, with additional help from controller register to
>>> specify the bus, device and function number. Below is the RFC patch
>>> that implements ECAM fixup for X-Gene PCIe controller on top of this
>>> RFC ECAM quirk v3 for your and others reference.
>>
>> Yes, you have an additional resource in the PNP0A03 _CRS to describe
>> your register that is a deliberate abuse of the ACPI standard in
>> that the _CRS is meant to describe resources that are passed on
>> to secondary buses
>
> A potential alternative came up in an off-list discussion: Would it be
> better to hard code the information in the quirk workaround than look it
> up from a repurposed ACPI resource?

Hi Chris, Lorenzo,

Thanks for looking into this.

Yes, I am open for this approach and I think it may work. I can
+ check the pci_config_window resource start address (cfg->res.start)
to figure out the controller and then get the fixed controller
register address
or
+ using the domain number to identify the controller.

Regards,
Duc Dang.
>
> Supporting quirk workarounds for early, non-compliant hardware is
> helpful and perhaps necessary for bootstrapping the ecosystem in a
> timely manner. But we don't really want to provide an expandable or
> reusable interface that would make it easy for new hardware to remain
> non-compliant.
>
> Regards,
> Cov
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
