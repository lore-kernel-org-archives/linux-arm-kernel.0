From: robherring2@gmail.com (Rob Herring)
Date: Mon, 22 Sep 2014 12:18:42 -0500
Subject: [PATCH v11 04/10] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
In-Reply-To: <20140922153207.GA1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
 <541DBA57.2000903@gmail.com>
 <20140922153207.GA1994@e106497-lin.cambridge.arm.com>
Message-ID: <CAL_JsqL9heHCEyXV5e4pOS3iWN51Q7KAQ-FxW_rzcWudqjwcdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 10:32 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Sat, Sep 20, 2014 at 06:33:11PM +0100, Rob Herring wrote:
>> On 09/17/2014 08:30 PM, Liviu Dudau wrote:
>> > The ranges property for a host bridge controller in DT describes
>> > the mapping between the PCI bus address and the CPU physical address.
>> > The resources framework however expects that the IO resources start
>> > at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
>> > The conversion from pci ranges to resources failed to take that into account.

[...]

>> >               if ((range.flags & IORESOURCE_MEM) &&
>> >                       (range.flags & IORESOURCE_PREFETCH)) {
>> >                       pre_mem_pci = range.pci_addr;
>> >                       pre_mem_pci_sz = range.size;
>> > -                     of_pci_range_to_resource(&range, np, &pre_mem);
>> > +                     ret = of_pci_range_to_resource(&range, np, &pre_mem);
>> >                       pre_mem.name = "PCIv3 prefetched mem";
>> >               }
>> > -     }
>> >
>> > -     if (!conf_mem.start || !io_mem.start ||
>> > -         !non_mem.start || !pre_mem.start) {
>> > -             dev_err(&pdev->dev, "missing ranges in device node\n");
>> > -             return -EINVAL;
>> > +             if (ret < 0) {
>> > +                     dev_err(&pdev->dev, "missing ranges in device node\n");
>> > +                     return -EINVAL;
>>
>> You should return ret rather than potentially changing the return value.
>
> I was trying to keep the existing behaviour, which was to return -EINVAL if the
> parsing has failed. But I can return ret and propagate the original error code.

A valid concern, but I checked and I believe the return from
of_pci_range_to_resource is currently -EINVAL.

>> > +int of_pci_range_to_resource(struct of_pci_range *range,
>> > +     struct device_node *np, struct resource *res)
>> > +{
>> > +     int err;
>> > +     res->flags = range->flags;
>> > +     res->parent = res->child = res->sibling = NULL;
>> > +     res->name = np->full_name;
>> > +
>> > +     if (res->flags & IORESOURCE_IO) {
>> > +             unsigned long port = -1;
>>
>> Assigning a signed value to unsigned...
>
> Ooops, sorry about that. Removed the initialisation now.
>
>>
>> Does port need to be 64-bit on 64-bit hosts?
>
> I'm following existing APIs. Basically my function is a variant of __of_address_to_resource()

Okay.

Rob
