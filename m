From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Dec 2015 19:37:43 +0000
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <566B1F64.9010500@codeaurora.org>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
 <20151211164137.GA23638@leverpostej>
 <566B1F64.9010500@codeaurora.org>
Message-ID: <20151211193742.GD23638@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> >> new file mode 100644
> >> index 0000000..b632635
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> >> @@ -0,0 +1,61 @@
> >> +Qualcomm Technologies HIDMA Management interface
> >> +
> >> +The Qualcomm Technologies HIDMA device has been designed
> >> +to support virtualization technology. The driver has been
> >> +divided into two to follow the hardware design. The management
> >> +driver is executed in hypervisor context and is the main
> >> +management entity for all channels provided by the device.
> >> +
> >> +Each HIDMA HW consists of multiple channels. These channels
> >> +share some set of common parameters. These parameters are
> >> +initialized by the management driver during power up.
> >> +Same management driver is used for monitoring the execution
> >> +of the channels. Management driver can change the performance
> >> +behavior dynamically such as bandwidth allocation and
> >> +prioritization.
> >> +
> >> +All channel devices get probed in the hypervisor
> >> +context during power up. They show up as DMA engine
> >> +DMA channels. Then, before starting the virtualization; each
> >> +channel device is unbound from the hypervisor by VFIO
> >> +and assign to the guest machine for control.
> >> +
> >> +This management driver will  be used by the system
> >> +admin to monitor/reset the execution state of the DMA
> >> +channels. This will be the management interface.
> > 
> > This is a mixture of hardware and software description (e.g. VFIO has
> > nothing to do wit hteh hardware). We want to capture what is necessary
> > to describe the hardware, not what the software stack above it will look
> > like.
> 
> Another reviewer requested guidance on how to set these parameters.
> That's why, I tried to provide as much data as possible.

It's perfectly fine to have some other document for the driver, but the
binding doc should stick to HW description.

> >> +Required properties:
> >> +- compatible: "qcom,hidma-mgmt-1.0";
> >> +- reg: Address range for DMA device
> > 
> > Does this cover just the management registers, or those for channels as
> > well?
> 
> just management.
> 
> > 
> >> +- dma-channels: Number of channels supported by this DMA controller.
> > 
> > Surely this is discoverable, or can be derived from the set of channels
> > described in the DT?
> 
> No, this is a HW configuration. Each hardware instance supports certain
> number of channels based on the HW build. The number of active channels
> on the running operating system does not necessarily represent the
> maximum possible.

I don't follow.

If you aren't using some channels, why do you need to know about them?

The driver seems to assume it can access registers for all (linearly
indexed) channels up to the value it read from dt for dma-channels. That
doesn't seem right if the driver is not dealing with all of those
channels.

> >> +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
> >> +  fragmented to multiples of this amount.
> >> +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
> >> +  fragmented to multiples of this amount.
> >> +- max-write-transactions: Maximum write transactions to perform in a burst
> >> +- max-read-transactions: Maximum read transactions to perform in a burst
> >> +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
> >> +- channel-priority: Priority of the channel.
> >> +  Each dma channel share the same HW bandwidth with other dma channels.
> >> +  If two requests reach to the HW at the same time from a low priority and
> >> +  high priority channel, high priority channel will claim the bus.
> >> +  0=low priority, 1=high priority
> >> +- channel-weight: Round robin weight of the channel
> >> +  Since there are only two priority levels supported, scheduling among
> >> +  the equal priority channels is done via weights.
> > 
> > Per the example, these last two seem to be arrays, which wasn't clear
> > from the description.
> 
> OK, let me clarify this. New text:
> +- channel-priority: an array of channel priorities.
> +- channel-weight: an array of round robin channel weights
> 
> > 
> > Why can this information not be associated with the channel directly?
> > 
> Two reasons:
> 1. The channel doesn't have the capability to change the priority and
> weight. HW design. Management HW can do this only.

You can describe the channels directly to the hypervisor which talks to
the management HW.

> 2. We are building SW to change the channel priority and weight at
> runtime from the hypervisor through sysfs. The system administrator of
> the server will reallocate resources based on the guest machine
> requirements.

Ok, so these properties are not necessary at all.

They can go, and you can default to a reasonable fair QoS configuration
that the user can override at runtime depending on use-case.

> > How does one choose the right priority and/or weight? These seem like
> > runtime details given that channels are indned to be allocated by
> > software.
> 
> priority = 0..1
> weight = 0...15 (adding max value to the documentation)

My point was more that the value you want depends on your use-case,
which is _not_ a static hardware property, but rather a dynamic run-time
property.

You stated this can be modified at run time. It should not be in the DT.
Please drop it from the binding.

> +  Valid values are 1..15.
> 
> > 
> > There's no relationship to channels defined here. What happens if/when
> > you have a system with multiple instances?
> > 
> 
> I do support multiple instances. I tested with 4 instances (6 channels
> each). This driver is only responsible for management which it can do
> through its own dedicated HW interface. It doesn't need access to the
> channel address space. There will be 4 HIDMA management instances in
> this case.

I don't follow.

How do you know which channels are associated with which management
interface?

How can your sysfs interface work if that relationship is not described?

> > I don't understand why you don't have a single binding for both the
> > management interface and channels, e.g.
> > 
> > hidma {
> > 	compatible - "qcom,hidma-1.0";
> > 
> > 	/* OPTIONAL management interface registers */
> > 	reg = < ... ... >;
> > 
> > 	...
> > 
> > 	channels {
> > 		channel0 {
> > 			compatible = "qcom,
> > 			reg = < ... ... >;
> > 
> > 			...
> > 		};
> > 
> > 		...
> > 	};
> > };
> > 
> > That would be more in keeping with what we do for other componenents
> > with hyp control elements (e.g. the GIC) and keeps everything
> > associated.
> 
> This was discussed before with the previous versions of the patch. This
> split and loose coupling design is on purpose.

I understand it was a deliberate choice. I am disagreeing with that
choice.

> The summary is that for static OS configurations where devices remain
> active for the rest of the OS execution; it makes perfect sense to
> create a device bus or child device object relationship.
> 
> The use case here is virtualization and object lifetime in the
> hypervisor is dynamic. Channel objects get unbound and bound dynamically
> for guest OS control. At any time, the hypervisor may not have any
> channel objects if the administrator decides to give all channels to the
> guest machines.

If the administrator tells the host to give a guest ownership of a
channel, the host knows that it cannot use the channel itself, nor can
it allocate the channel to another guest. Consider PCIe device
passthrough; the host knows that there is a device on the PCIe bus, but
also knows that a guest owns it. The same logic should apply here.

No guest should care which particular physical channels it's provided
with.

> Only the hidma channel driver gets executed in the guest machine. There
> is no management driver and device entity in the guest. Therefore,
> child-parent relationship does not exist.

The management driver needs to know details of the channels it's
managing, even if it never accesses them directly. Otherwise how can you
allocate a channel to a guest and manage it through the correct portion
of the correct management interface?

I am not arguing for the management driver to run in the guest. For the
GIC we have a single binding, yet never run the KVM driver in the guest.
The same split of responsibility can apply to the hidma driver(s).

Thanks,
Mark.
