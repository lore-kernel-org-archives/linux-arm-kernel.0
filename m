From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Dec 2015 12:05:16 +0000
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <566B4ACC.3070005@codeaurora.org>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
 <20151211164137.GA23638@leverpostej>
 <566B1F64.9010500@codeaurora.org>
 <20151211193742.GD23638@leverpostej>
 <566B4ACC.3070005@codeaurora.org>
Message-ID: <20151214120339.GA21356@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>> +Required properties:
> >>>> +- compatible: "qcom,hidma-mgmt-1.0";
> >>>> +- reg: Address range for DMA device
> >>>
> >>> Does this cover just the management registers, or those for channels as
> >>> well?
> >>
> >> just management.
> >>
> >>>
> >>>> +- dma-channels: Number of channels supported by this DMA controller.
> >>>
> >>> Surely this is discoverable, or can be derived from the set of channels
> >>> described in the DT?
> >>
> >> No, this is a HW configuration. Each hardware instance supports certain
> >> number of channels based on the HW build. The number of active channels
> >> on the running operating system does not necessarily represent the
> >> maximum possible.
> > 
> > I don't follow.
> > 
> > If you aren't using some channels, why do you need to know about them?
> > 
> 
> I mean the hypervisor OS may not be using the channels. It could be the
> guest machines that are using it. I need the number of the channels not
> the memory addresses where each channel is.

I still don't follow. Knowing the number of channels alone is clearly
insufficient.

The hypervisor is in charge of handing these out to guests. So it needs
to know the set of of channels (i.e. the address of each channel, and
which index the channel has in the control interface). Otherwise it
cannot possibly allocate them to guests, and cannot possibly control
those channels at runtime.

Given the hypervisor is in chage of allocating channels to guests, it
knows which channels are in use, and can decide whether or not to use
channels for its own purposes.

> > The driver seems to assume it can access registers for all (linearly
> > indexed) channels up to the value it read from dt for dma-channels. That
> > doesn't seem right if the driver is not dealing with all of those
> > channels.
> 
> I assume you are talking about this. Feel free to be specific if not
> this one.
> 
> 	for (i = 0; i < mgmtdev->dma_channels; i++) {
> 		u32 weight = mgmtdev->weight[i];
> 		u32 priority = mgmtdev->priority[i];
> 
> 		val = readl(mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
> 		val &= ~(1 << HIDMA_PRIORITY_BIT_POS);
> 		val |= (priority & 0x1) << HIDMA_PRIORITY_BIT_POS;
> 		val &= ~(HIDMA_WEIGHT_MASK << HIDMA_WRR_BIT_POS);
> 		val |= (weight & HIDMA_WEIGHT_MASK) << HIDMA_WRR_BIT_POS;
> 		writel(val, mgmtdev->virtaddr + HIDMA_QOS_N_OFFSET + (4 * i));
> 	}
> 
> The management driver is configuring the priority and weight registers
> inside the management address space. It is not accessing the channel
> address space where data transfer descriptors are set up. There is one
> register for priority & weight of the each channel inside the management
> address space.

My point was that this implies that the driver has no idea as to the
relationship between these configuration registers and the actual
channel address spaces. It has no idea which channel address spaces are
being configured here. That does not seem right.

> >>> Why can this information not be associated with the channel directly?
> >>>
> >> Two reasons:
> >> 1. The channel doesn't have the capability to change the priority and
> >> weight. HW design. Management HW can do this only.
> > 
> > You can describe the channels directly to the hypervisor which talks to
> > the management HW.
> 
> Not a use case, I don't want to allow guest machine to change their
> priority and weight.

I didn't suggest that the guest would. Regardless, it seems these should
be runtime configured anyway, at which point you need to know the
relationship.

> >>> There's no relationship to channels defined here. What happens if/when
> >>> you have a system with multiple instances?
> >>>
> >>
> >> I do support multiple instances. I tested with 4 instances (6 channels
> >> each). This driver is only responsible for management which it can do
> >> through its own dedicated HW interface. It doesn't need access to the
> >> channel address space. There will be 4 HIDMA management instances in
> >> this case.
> > 
> > I don't follow.
> > 
> > How do you know which channels are associated with which management
> > interface?
> 
> The association is the other way around. User need to know the
> management interface for a channel rather than the channel needing to
> know the management interface.
> 
> I'll think about it.

Ok. I agree that's the way the user will look at it.

> > How can your sysfs interface work if that relationship is not described?
> 
> Here is the sysfs documentation. Each management object has one channel
> directory under it. I still don't need to access the channel object in
> order to change its weight and priority.
> 
> What:           /sys/devices/platform/hidma-mgmt*/chan*/priority
>                 /sys/devices/platform/QCOM8060:*/chan*/priority
> Date:           Nov 2015
> KernelVersion:  4.4
> Contact:        "Sinan Kaya <okaya@cudeaurora.org>"
> Description:
>                 Contains either 0 or 1 and indicates if the DMA channel is a
>                 low priority (0) or high priority (1) channel.

What I was trying to ask is: given a write to a channel's priority file,
how do you figure out which bits in which management interface to poke?

As far as I can see, the relationship between a channel and the
management interface is not described in teh DT, so I cannot see how you
figure this out.

> >>> I don't understand why you don't have a single binding for both the
> >>> management interface and channels, e.g.
> >>>
> >>> hidma {
> >>> 	compatible - "qcom,hidma-1.0";
> >>>
> >>> 	/* OPTIONAL management interface registers */
> >>> 	reg = < ... ... >;
> >>>
> >>> 	...
> >>>
> >>> 	channels {
> >>> 		channel0 {
> >>> 			compatible = "qcom,
> >>> 			reg = < ... ... >;
> >>>
> >>> 			...
> >>> 		};
> >>>
> >>> 		...
> >>> 	};
> >>> };
> >>>
> >>> That would be more in keeping with what we do for other componenents
> >>> with hyp control elements (e.g. the GIC) and keeps everything
> >>> associated.
> >>
> >> This was discussed before with the previous versions of the patch. This
> >> split and loose coupling design is on purpose.
> > 
> > I understand it was a deliberate choice. I am disagreeing with that
> > choice.
> > 
> 
> In order to be able to use the same channel driver in the guest machine
> context with the hierarchy you want, I need to create this.
> 
> fake management object {
> 	fake values;

There'd be no fake values here, they'd just be ommitted entirely.

> 	channels {
> 		real DMA channel {
> 			...
> 		}
> 	}
> }
> 
> This looks really ugly to me. I need to deal with a fake management
> driver and object that could be hypervisor specific.

You don't need a fake management driver. I don't understand what you
mean w.r.t. being hypervisor specific.

> Here is a fact:
> 
> QEMU is not capable of generating complex device-tree nodes for platform
> devices that are being virtualized. QEMU only generates a very simple
> device object with compatible ID and memory and interrupt resources. No
> parent, child relationship and no device-specific attributes. Here is an
> example:

So? The above _is_ simple, and trivial to generate.

I've not seen your patches for QEMU, so perhaps I'm missing something.

Regardless, QEMU is not the only thing that matters here. We shouldn't
do something _only_ because it makes a patch to QEMU simpler.

> 
> device {
> 	compatible-id;
> 	reg;
> 	interrupt;
> }
> 
> This is plain and simple. It works too. No need to create some fake device.
> 
> The other issue is the ACPI. I know device-tree has all kinds of nice
> gadgets for traversing the parent/child relationship and object
> pointers. I can't implement this if the solution does not scale to ACPI.

It sounds like ACPI is incapable of describing this device, then.

> > No guest should care which particular physical channels it's provided
> > with.
> > 
> >> Only the hidma channel driver gets executed in the guest machine. There
> >> is no management driver and device entity in the guest. Therefore,
> >> child-parent relationship does not exist.
> > 
> > The management driver needs to know details of the channels it's
> > managing, even if it never accesses them directly. Otherwise how can you
> > allocate a channel to a guest and manage it through the correct portion
> > of the correct management interface?
> 
> I'll add support for both. Both having a parent-child relationship while
> inside the hypervisor and flat hierarchy while running in the guest
> machine for QEMU.

I'm happy with that.

> I just created a child object of the management driver and channel
> driver got probed properly. So, it just a matter of device-tree
> documentation at this point.
> 
> It will be like this though.
> 
> >>> hidma {
> >>> 	compatible - "qcom,hidma-1.0";
> >>>
> >>> 	/* OPTIONAL management interface registers */
> >>> 	reg = < ... ... >;
> >>>
> >>> 	...
> >>>
> >>> 	channel0 {
> >>> 		compatible = "qcom,
> >>> 		reg = < ... ... >;
> >>>
> >>> 		...
> >>> 	};
> >>>
> >>> 	...
> >>> };
> 
> This seems to have worked without requiring any work from me.
> 
> I need to associate sysfs next.

Ok. I look forward to seeing those patches.

Thanks,
Mark.
