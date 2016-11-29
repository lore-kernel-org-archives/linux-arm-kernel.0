From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 29 Nov 2016 13:43:48 +0100
Subject: [PATCH V7 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20161129121152.GA32453@red-moon>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
 <1479074375-2629-3-git-send-email-agustinv@codeaurora.org>
 <20161124161548.GA11766@red-moon> <20161125114035.GA13739@red-moon>
 <e12155805a9d92d3f5edc81395a76f48@codeaurora.org>
 <20161129121152.GA32453@red-moon>
Message-ID: <CAJZ5v0guuqb6OzSJgz0L537EhH75EkR--Mmm+QSpKhYXBZxV9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 1:11 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Agustin,
>
> On Mon, Nov 28, 2016 at 05:40:24PM -0500, Agustin Vega-Frias wrote:
>> Hi Rafael,
>>
>> Can you chime in on Lorenzo's feedback and the discussion below?
>> It would be great if you can comment on the reason ACPI does things
>> in a certain way.
>>
>> Hi Lorenzo,
>>
>> On 2016-11-25 06:40, Lorenzo Pieralisi wrote:
>> >Hi Agustin,
>> >
>> >On Thu, Nov 24, 2016 at 04:15:48PM +0000, Lorenzo Pieralisi wrote:
>> >
>> >[...]
>> >
>> >>> @@ -448,6 +449,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>> >>>  {
>> >>>   struct acpi_resource_irq *irq;
>> >>>   struct acpi_resource_extended_irq *ext_irq;
>> >>> + struct fwnode_handle *src;
>> >>>
>> >>>   switch (ares->type) {
>> >>>   case ACPI_RESOURCE_TYPE_IRQ:
>> >>> @@ -460,7 +462,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>> >>>                   acpi_dev_irqresource_disabled(res, 0);
>> >>>                   return false;
>> >>>           }
>> >>> -         acpi_dev_get_irqresource(res, irq->interrupts[index],
>> >>> +         acpi_dev_get_irqresource(res, irq->interrupts[index], NULL,
>> >>>                                    irq->triggering, irq->polarity,
>> >>>                                    irq->sharable, true);
>> >>>           break;
>> >>> @@ -470,7 +472,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>> >>>                   acpi_dev_irqresource_disabled(res, 0);
>> >>>                   return false;
>> >>>           }
>> >>> -         acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>> >>> +         src = acpi_get_irq_source_fwhandle(&ext_irq->resource_source);
>> >>
>> >>Is there a reason why we need to do the domain look-up here ?
>>
>> Because we need to pass the resource down to acpi_dev_get_irqresource
>> which does the mapping through acpi_register_irq/acpi_register_gsi.
>>
>> >>
>> >>I would like to understand if, by reshuffling the code (and by
>> >>returning
>> >>the resource_source to the calling code - somehow), it would be
>> >>possible
>> >>to just mirror what the OF code does in of_irq_get(), namely:
>> >>
>> >>(1) parse the irq entry -> of_irq_parse_one()
>> >>(2) look the domain up -> irq_find_host()
>> >>(3) create the mapping -> irq_create_of_mapping()
>> >>
>> >>You wrote the code already, I think it is just a matter of shuffling
>> >>it around (well, minus returning the resource_source to the caller
>> >>which is phandle equivalent in DT).
>>
>> This is one area in which DT and ACPI are fundamentally different. In DT
>> once the flattened blob is expanded the data is fixed. In ACPI the data
>> returned by a method can change. In reality most methods like CRS return
>> constants, but given that per-spec they are methods the interpreter has
>> to be involved, which makes it an expensive operation. I believe that is
>> the reason the resource parsing code in ACPI attempts all mappings
>> during
>> the bus scan. Rafael can you comment on this?
>>
>> One way to do what you suggest would be to defer IRQ mapping by, e.g.,
>> populating res->start with the HW IRQ number and res->end with the
>> fwnode.
>> That way we can avoid having to walk the resource buffer when a mapping
>> is needed. I don't think that approach would deviate much more from
>> the spec from what the current ahead-of-time mapping does, but it would
>> require more changes in the core code. An alternative would be to do
>> that only for resources that fail to map.
>>
>> >>
>> >>You abstracted away (2) and (3) behind acpi_register_irq(), that
>> >>on anything than does not use ACPI_GENERIC_GSI is just glue code
>> >>to acpi_register_gsi().
>> >>
>> >>Also, it is not a question on this patch but I ask it here because it
>> >>is related. On ACPI you are doing the reverse of what is done in
>> >>DT in platform_get_irq():
>> >>
>> >>- get the resources already parsed -> platform_get_resource()
>> >>- if they are disabled -> acpi_irq_get()
>> >>
>> >>and I think the ordering is tied to my question above because
>> >>you carry out the domain look up in acpi_dev_resource_interrupt()
>> >>so that if for any reason it fails the corresponding resource
>> >>is disabled so that we try to get it again through acpi_irq_get().
>> >>
>> >>I suspect you did it this way to make sure:
>> >>
>> >>a) keep the current ACPI IRQ parsing interface changes to a mininum
>> >>b) avoid changing the behaviour on x86/ia64; in particular, calling
>> >>   acpi_register_gsi() for the _same_ mapping (an IRQ that was already
>> >>   registered at device creation resource parsing) multiple times can
>> >>   trigger issues on x86/ia64
>>
>> You are correct about my reasons. I wanted to keep ACPI core code
>> changes
>> to a minimum, and I also needed to work within the current
>> implementation
>> which uses the pre-converted IRQ resources.
>>
>> >>
>> >>I think that's a reasonable approach but I wanted to get these
>> >>clarifications, I do not think you are far from getting this
>> >>done but since it is a significant change I think it is worth
>> >>discussing the points I raised above because I think the DT code
>> >>sequence in of_irq_get() (1-2-3 above) is cleaner from an IRQ
>> >>layer perspective (instead of having the domain look-up buried
>> >>inside the ACPI IRQ resource parsing API).
>> >
>> >I had another look and to achieve the above one way of doing that is to
>> >implement acpi_irq_get() only for ACPI_GENERIC_GSI and stub it out for
>> >!ACPI_GENERIC_GSI (ie return an error code so that on !ACPI_GENERIC_GSI
>> >we would fall back to current solution for ACPI). Within acpi_irq_get()
>> >you can easily carry out the same steps (1->2->3) above in ACPI
>> >you have
>> >the code already there I think it is easy to change the
>> >acpi_irq_get_cb() interface to return a filled in struct irq_fwspec and
>> >the interface would become identical to of_irq_get() that is an
>> >advantage to maintain it from an IRQ maintainership perspective I
>> >think,
>> >that's my opinion.
>>
>> I think I get what you mean. I'll take a stab at implementing
>> acpi_irq_get()
>> in the way you suggest.
>>
>> >
>> >There is still a nagging snag though. When platform devices are
>> >created, core ACPI code parse the resources through:
>> >
>> >acpi_dev_get_resources()
>> >
>> >and we _have_ to have way to avoid initializing IRQ resources that
>> >have a dependency (ie there is a resource_source pointer that is valid
>> >in their descriptors) that's easy to do if we think that's the right
>> >thing to do and can hardly break current code (which ignores the
>> >resource_source altogether).
>>
>> I'd rather keep the core code as-is with regard to the ahead-of-time
>> conversion. Whether a resource source is available at the time of
>> the bus
>> scan should be transparent to the code in drivers/acpi/resource.c, and
>> we need the initialization as a disabled resource to signal the need
>> to retry anyway.
>
> Yes, exactly that's the nub. Your current code works, I am trying to
> make it more modular and similar to the DT/irqdomain IRQ look-up path,
> which has its advantages.
>
> There are two options IMHO:
>
> - always disable the resource if it has a resource_source dependency and defer
>   its parsing to acpi_irq_get() (where you can easily implement steps 1-2-3 above).
>   What I wanted to say is that, by disabling the resource if it has a
>   resource_source dependency you can't break x86/ia64 (it is ignored at
>   present - hopefully there is nothing that we are not aware of behind
>   that choice). On x86/ia64 acpi_irq_get() would be an empty stub.
>   This way you would keep the irqdomain look-up out of the ACPI resource
>   parsing API, correct ?
> - keep code as-is
>
> Your point on _CRS being _current_ resource setting is perfectly valid
> so platform_get_resource() in platform_get_irq() must always take
> precedence over acpi_irq_get() (which should just apply to disabled
> resources), I am not sure that doing it the other way around is safe.
>
>> Rafael, do you have any other suggestions/feedback on how to go about
>> doing this?
>
> Yes, comments very appreciated, these changes are not trivial and need
> agreement.

So I need more time.

But basically, _CRS can't really change on the fly AFAICS.  I'm not
even sure it is valid for it to change at all after the first
evaluation if _SRS/_PRS are not present.

Thanks,
Rafael
