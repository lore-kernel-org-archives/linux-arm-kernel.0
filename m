From: agraf@suse.de (Alexander Graf)
Date: Fri, 11 Jan 2013 20:11:16 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <20130111183907.GA15113@amt.cnet>
References: <1357866627.27576.21@snotra>
 <709FA96C-A3EF-489C-B0E9-59EEA7F8E62F@virtualopensystems.com>
 <20130111183907.GA15113@amt.cnet>
Message-ID: <B5FF73B8-DAB5-4B6D-977C-7908483F660B@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11.01.2013, at 19:39, Marcelo Tosatti wrote:

> On Fri, Jan 11, 2013 at 02:26:51AM -0500, Christoffer Dall wrote:
>> On 10/01/2013, at 20.10, Scott Wood <scottwood@freescale.com> wrote:
>> 
>>> On 01/10/2013 06:35:02 PM, Marcelo Tosatti wrote:
>>>> On Thu, Jan 10, 2013 at 04:40:12PM -0600, Scott Wood wrote:
>>>>> On 01/10/2013 04:28:01 PM, Marcelo Tosatti wrote:
>>>>>> Or just have KVM_SET_PPC_DEVICE_ADDRESS. Is there a downside to that?
>>>>> 
>>>>> Besides the above, and my original complaint that it shouldn't be
>>>>> specific to addresses?
>>>>> 
>>>>> -Scott
>>>> I did not really grasp that ('shouldnt be specific to addresses'), but
>>>> anyway.
>>> 
>>> A device may have other configuration parameters that need to be set,
>>> besides addresses.  PPC MPIC will require information about the vendor
>>> and version, for example.
>>> 
>>>> OK, can you write down your proposed improvements to the interface?
>>>> In case you have something ready, otherwise there is time pressure
>>>> to merge the ARM port.
>>> 
>>> My original request was just to change the name to something like
>>> KVM_SET_DEVICE_CONFIG or KVM_SET_DEVICE_ATTR, and not make the id
>>> encoding architecture-specific (preferably, separate into a "device id"
>>> field and an "attribute id" field rather than using bitfields).  Actual
>>> values for device id could be architecture-specific (or there could be a
>>> global enumeration), and attribute id values would be device-specific.
>>> 
>>> Alex suggested that an ideal interface might accept values larger than 64
>>> bits, though I think it's good enough -- there are currently no proposed
>>> uses that need more than 64 bits for a single attribute (unlike ONE_REG),
>>> and if it is needed, such configuration could be split up between
>>> multiple attributes, or the attribute could specify that "value" be a
>>> userspace pointer to the actual data (as with ONE_REG).
>>> 
>>> Here's a writeup (the ARM details would go under ARM/vGIC-specific
>>> documentation):
>>> 
>>> 4.80 KVM_SET_DEVICE_ATTR
>>> 
>>> Capability: KVM_CAP_SET_DEVICE_ATTR
>>> Type: vm ioctl
>>> Parameters: struct kvm_device_attr (in)
>>> Returns: 0 on success, -1 on error
>>> Errors:
>>> ENODEV: The device id is unknown
>>> ENXIO:  Device not supported on current system
>>> Other errors may be returned by specific devices and attributes.
>>> 
>>> struct kvm_device_attr {
>>>   __u32 device;
>>>   __u32 attr;
>>>   __u64 value;
>>> };
>>> 
>>> Specify an attribute of a device emulated or directly exposed by the
>>> kernel, which the host kernel needs to know about.  The device field is an
>>> architecture-specific identifier for a specific device.  The attr field
>>> is a device-specific identifier for a specific attribute.  Individual
>>> attributes may have particular requirements for when they can and cannot
>>> be set.
>>> 
>>>> That is, if you have interest/energy to spend in a possibly reusable
>>>> interface, as long as that does not delay integration of the ARM code,
>>>> i don't think the ARM people will mind that.
>>> 
>>> The impression I've been given is that just about any change will delay
>>> the integration at this point.  If that's the case, and everyone's OK
>>> with having an interface that is deprecated on arrival, then fine.
>> 
>> 
>> That is not entirely the case, but there wasn't event agreement on this revised API, and we didn't want to wait for weeks until a decision was made. Alex suggested we use a DEV_REG API similar to the ONE_REG API, but I am quite strongly against having such an API for this specific purpose as it is too semantically distant to what we do on ARM. (Having a DEV_REG API for other purposes might be fine though). 
>> 
>> So I have no problem with your suggestion, although we could consider having a size and addr field in the struct instead and be slightly more extensible. But I don't feel strongly about it. 
>> 
>> If we can agree on Scott's suggestion or with my modification (Alex, Gleb, Marcelo ?) then I'll change the KVM/ARM patches to use this and resend them right away. But we have to agree now!
>> 
>> If not, I really think we should keep things as they are now, as we're really discussing idealistic scenarios here, and the ARM patches have been out of tree for long enough. As Marcelo pointed out, the benefits of the perfect API are really minimal.
>> 
>> -Christoffer--
> 
> Can you make KVM_SET_ARM_DEVICE address extensible? 
> Add some reserved space and a flags field.

Can't we do this for the new ioctl that we all would agree on rather than the interim one that's only a short term solution for a greater problem?


Alex
