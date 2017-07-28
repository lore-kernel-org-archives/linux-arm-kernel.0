From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Jul 2017 15:09:56 +0100
Subject: [PATCH 0/4] ACPI: DMA ranges management
In-Reply-To: <eb81a7c6-b62b-8e02-8f22-a7fda7e403ce@arm.com>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <7df11172-5a40-685f-5202-9a0bceb6e19b@codeaurora.org>
 <c09352cc-e1a2-a494-c457-dc3ea275f504@arm.com>
 <20170726153519.GA4696@red-moon>
 <eb81a7c6-b62b-8e02-8f22-a7fda7e403ce@arm.com>
Message-ID: <20170728140956.GA21569@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 02:08:01PM +0100, Robin Murphy wrote:

[...]

> >>> To ensure that dma_set_mask() and friends actually respect _DMA, would
> >>> you consider introducing a dma_supported() callback to check the input
> >>> dma_mask against the FW defined limits? This would end up aggressively
> >>> clipping the dma_mask to 32-bits for devices like the above if the _DMA
> >>> limit was less than 64-bits, but that is probably preferable to the
> >>> controller accessing unintended addresses.
> >>>
> >>> Also, how would you feel about adding support for the IORT named_node
> >>> memory_address_limit field?
> >>
> >> We will certainly need that for some platform devices, so if you fancy
> >> giving it a go before Lorenzo or I get there, feel free!
> > 
> > I can do it for v2 but I would like to understand why using _DMA is
> > not good enough for named components - having two bindings describing
> > the same thing is not ideal and I'd rather avoid it - if there is
> > a reason I am happy to add the necessary code.
> 
> My interpretation of "_DMA is only defined under devices that represent
> buses." (ACPI 6.0, section 6.2.4) is that "devices that represent buses"
> are those that have other device objects as children.

Well if that was the case we would not be able to use _DMA for
eg PNP0A03 PCI host bridges that have no child ACPI devices, which
defeats the whole purpose of what I am doing.

The question here is what the _DMA object binding exactly means when
it refers to a "bus" and that's something I will figure out (and possibly
change) ASAP.

> In other words (excuse my novice pseudo-ASL), this would be valid:
> 
> Scope(_SB)
> {
> 	Device (Bus)
> 	{
> 		...
> 		Method (_DMA ... )
> 		Device (Dev1)
> 		{
> 			...
> 		}
> 	}
> }
> 
> but this should be invalid:
> 
> Scope(_SB)
> {
> 	Device (Dev2)
> 	{
> 		...
> 		Method (_DMA ... )
> 	}
> }

Not sure about that (see above) and I agree that's what needs
clarification.

> Thus in the case where Dev2 is wired directly to an SMMU input, but
> fewer address bits are wired up between the two than both the device and
> SMMU interfaces are capable of, memory address limit is enough to
> describe that without having to insert a fake "bus" object above it just
> to hold the _DMA method.

BTW, how would you describe that in DT ? A "dma-ranges" property in the
device DT node right ? Arguably "dma-ranges" was not meant to be used
like that either ;-)

Long and short of it is: I do not like having two ways of describing
the same thing. I agree that the _DMA object usage requires
clarifications from a spec point of view but I want to do that before
plugging in code that may use bindings inconsistently.

I will flag this up at ACPI spec level as soon as possible and get this
sorted.

Thanks,
Lorenzo
