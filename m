From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 01 Nov 2018 11:15:51 +0000
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <f7b6d570-a8f4-6f8b-7995-eac69fef8fa1@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
 <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
 <86va5myz7t.wl-marc.zyngier@arm.com>
 <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
 <49029695-79a0-141b-a9da-9764cb0ed60f@ti.com>
 <86bm792mv2.wl-marc.zyngier@arm.com>
 <f7b6d570-a8f4-6f8b-7995-eac69fef8fa1@ti.com>
Message-ID: <8636slf3q0.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, 01 Nov 2018 09:14:15 +0000,
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> Hi Marc,
> 
> On 11/1/18 11:00 AM, Marc Zyngier wrote:
> > On Thu, 01 Nov 2018 07:55:12 +0000,
> > Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>
> >> Lokesh,
> >>
> >> On 10/29/18 3:04 PM, Lokesh Vutla wrote:
> >>>>> With the above information, linux should send a message to
> >>>>> system-controller using TISCI protocol. After policing the given
> >>>>> information, system-controller does the following:
> >>>>> - Attaches the interrupt(INTA input) to the device resource index
> >>>>> - Muxes the interrupt(INTA input) to corresponding vint(INTA output)
> >>>>> - Muxes the vint(INTR input) to GIC irq(INTR output).
> >>>>
> >>>> Isn't there a 1:1 mapping between *used* INTR inputs and outputs?
> >>>> Since INTR is a router, there is no real muxing. I assume that the
> >>>> third point above is just a copy-paste error.
> >>>
> >>> Right, my bad. INTR is just a router and no read muxing.
> >>
> >> INTR can mux M interrupt inputs to N interrupt outputs.
> >> One selects which interrupt input is outputted on the given interrupt
> >> output.
> >> It is perfectly valid (but not sane) to select the same interrupt input
> >> to be routed to _all_ interrupt output for example.
> >>
> >> Not sure if we are going to use this for anything but 1:1 mapping, but
> >> might worth keeping in mind...
> > 
> > It's not obvious how you'd use this "feature". Interrupt replicator,
> > should one of the output be tied to another part of the system? Or
> > maybe that's just the result of reusing some generic block...
> 
> I think the intention is that different virtualized OS would got
> assigned with different range of NAVSS GIC irqs and there might be a
> case when more than one virtualized environment need to get a GIC irq
> for the same virt. Timer interrupts comes to mind first, but there could
> be other cases when the same virt should trigger on multiple GIC line.

That would be strange. SPIs seen by a guest are always virtual, and
the hypervisor must handle the physical interrupt to inject the
virtual counterpart. By duplicating the interrupt, you double the
overhead at the hypervisor level. It would be much cheaper to just
inject the interrupt twice.

On top of that, this only works for edge interrupts, and breaks badly
for level signalling: who talks to the device to lower the line?

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
