From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 6 Sep 2016 13:15:46 +0200
Subject: [PATCH V9 1/8] ACPI: I/O Remapping Table (IORT) initial support
In-Reply-To: <a950814b-6bfb-7435-b137-c42cf2c1908c@semihalf.com>
References: <1473105940-9761-1-git-send-email-tn@semihalf.com>
 <1473105940-9761-2-git-send-email-tn@semihalf.com>
 <CAJZ5v0iJGycCVaQ9gdpWL55wFcX5X=RXTze_-Fw+5TaSvjH3yQ@mail.gmail.com>
 <a950814b-6bfb-7435-b137-c42cf2c1908c@semihalf.com>
Message-ID: <CAJZ5v0iSbWr3O5qDpMimNxDSmDHq8yn0TmysPDKj3=k2dSve=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 9:24 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
> Hi Rafael,
>
>
> On 05.09.2016 22:29, Rafael J. Wysocki wrote:
>>
>> On Mon, Sep 5, 2016 at 10:05 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>>

[cut]

> static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>                                             void *context)
> {
>         struct device *dev = context;
>         acpi_status status = AE_NOT_FOUND;
>
>         switch (node->type) {
>         case ACPI_IORT_NODE_NAMED_COMPONENT: {
>                 struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>                 struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>                 struct acpi_iort_named_component *ncomp;
>
>                 if (!adev)
>                         break;
>
>                 status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME,
> &buf);
>                 if (ACPI_FAILURE(status)) {
>                         dev_warn(dev, "Can't get device full path name\n");
>                         break;
>                 }
>
>                 ncomp = (struct acpi_iort_named_component *)node->node_data;
>                 if (!strcmp(ncomp->device_name, buf.pointer))
>                         status = AE_OK;
>
>                 acpi_os_free(buf.pointer);
>                 break;
>         }
>         case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>                 struct acpi_iort_root_complex *pci_rc;
>                 struct pci_bus *bus;
>
>                 bus = to_pci_bus(dev);
>                 pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>
>                 /*
>                  * It is assumed that PCI segment numbers maps one-to-one
>                  * with root complexes. Each segment number can represent
> only
>                  * one root complex.
>                  */
>                 if (pci_rc->pci_segment_number == pci_domain_nr(bus))
>                         status = AE_OK;
>
>                 break;
>         }
>         }
>
>         return status;
> }
>
>>
>>> +               } else {
>>> +                       int match;
>>> +
>>> +                       match = !strcmp(ncomp->device_name,
>>> buffer.pointer);
>>> +                       acpi_os_free(buffer.pointer);
>>> +
>>> +                       if (match)
>>> +                               return AE_OK;
>>> +               }
>>> +
>>> +               break;
>>> +       }
>>> +       case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>>
>>
>> What is the brace for?
>
>
> To create namespace for below local variables. The same for
> ACPI_IORT_NODE_NAMED_COMPONENT case.

This looks weird, though.  At least nest it in a usual way.

And what would be wrong with using if () {} else if () {} instead?

There are two cases only here anyway.

Thanks,
Rafael
