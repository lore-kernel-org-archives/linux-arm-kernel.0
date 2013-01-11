From: agraf@suse.de (Alexander Graf)
Date: Fri, 11 Jan 2013 16:42:55 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <1357866627.27576.21@snotra>
References: <1357866627.27576.21@snotra>
Message-ID: <A6843D28-E2AF-4EFF-8C9B-232B804C01E7@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11.01.2013, at 02:10, Scott Wood wrote:

> On 01/10/2013 06:35:02 PM, Marcelo Tosatti wrote:
>> On Thu, Jan 10, 2013 at 04:40:12PM -0600, Scott Wood wrote:
>> > On 01/10/2013 04:28:01 PM, Marcelo Tosatti wrote:
>> > >Or just have KVM_SET_PPC_DEVICE_ADDRESS. Is there a downside to that?
>> >
>> > Besides the above, and my original complaint that it shouldn't be
>> > specific to addresses?
>> >
>> > -Scott
>> I did not really grasp that ('shouldnt be specific to addresses'), but
>> anyway.
> 
> A device may have other configuration parameters that need to be set,
> besides addresses.  PPC MPIC will require information about the vendor
> and version, for example.
> 
>> OK, can you write down your proposed improvements to the interface?
>> In case you have something ready, otherwise there is time pressure
>> to merge the ARM port.
> 
> My original request was just to change the name to something like
> KVM_SET_DEVICE_CONFIG or KVM_SET_DEVICE_ATTR, and not make the id
> encoding architecture-specific (preferably, separate into a "device id"
> field and an "attribute id" field rather than using bitfields).  Actual
> values for device id could be architecture-specific (or there could be a
> global enumeration), and attribute id values would be device-specific.
> 
> Alex suggested that an ideal interface might accept values larger than 64
> bits, though I think it's good enough -- there are currently no proposed
> uses that need more than 64 bits for a single attribute (unlike ONE_REG),
> and if it is needed, such configuration could be split up between
> multiple attributes, or the attribute could specify that "value" be a
> userspace pointer to the actual data (as with ONE_REG).
> 
> Here's a writeup (the ARM details would go under ARM/vGIC-specific
> documentation):
> 
> 4.80 KVM_SET_DEVICE_ATTR
> 
> Capability: KVM_CAP_SET_DEVICE_ATTR
> Type: vm ioctl
> Parameters: struct kvm_device_attr (in)
> Returns: 0 on success, -1 on error
> Errors:
>  ENODEV: The device id is unknown
>  ENXIO:  Device not supported on current system
>  Other errors may be returned by specific devices and attributes.
> 
> struct kvm_device_attr {
> 	__u32 device;

This needs some semantic specification. Is device a constant value? Is it the return value of CREATE_IRQCHIP?

> 	__u32 attr;
> 	__u64 value;
> };
> 
> Specify an attribute of a device emulated or directly exposed by the
> kernel, which the host kernel needs to know about.  The device field is an
> architecture-specific identifier for a specific device.  The attr field
> is a device-specific identifier for a specific attribute.  Individual
> attributes may have particular requirements for when they can and cannot
> be set.
> 
>> That is, if you have interest/energy to spend in a possibly reusable
>> interface, as long as that does not delay integration of the ARM code,
>> i don't think the ARM people will mind that.
> 
> The impression I've been given is that just about any change will delay
> the integration at this point.  If that's the case, and everyone's OK
> with having an interface that is deprecated on arrival, then fine.

To me it's perfectly fine to merge the patches with the arm specific interface and then push an interface like the above in in the next merge window.


Alex
