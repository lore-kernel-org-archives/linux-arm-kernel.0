From: eric@anholt.net (Eric Anholt)
Date: Tue, 12 May 2015 10:46:34 -0700
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <55416DA2.5040902@wwwdotorg.org>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
 <55403AD1.4030103@wwwdotorg.org> <87oam6q0v1.fsf@eliezer.anholt.net>
 <55416DA2.5040902@wwwdotorg.org>
Message-ID: <87a8x94rk5.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 04/29/15 11:51, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>
>>> On 04/27/2015 05:14 PM, Eric Anholt wrote:
>>>> This gives us a function for making mailbox property channel requests
>>>> of the firmware, and uses it to control the 3 power domains provided
>>>> by the firmware.
>>>
>>>> diff --git a/arch/arm/mach-bcm/raspberrypi-firmware.c b/arch/arm/mach-bcm/raspberrypi-firmware.c
>>>
>>>> +/*
>>>> + * Submits a set of concatenated tags to the VPU firmware through the
>>>> + * mailbox property interface.
>>>> + *
>>>> + * The buffer header and the ending tag are added by this function and
>>>> + * don't need to be supplied, just the actual tags for your operation.
>>>> + * See struct raspberrypi_firmware_property_tag_header for the per-tag structure.
>>>> + */
>>>> +int raspberrypi_firmware_property(void *data, size_t tag_size)
>>>> +{
>>>> +	size_t size = tag_size + 12;
>>>> +	u32 *buf;
>>>> +	dma_addr_t bus_addr;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!firmware)
>>>> +		return -EPROBE_DEFER;
>>>
>>> I think it'd make more sense if the clients looked up the firmware
>>> driver via phandle at their probe time. This would mean:
>>>
>>> * No need for global "firmware", since clients could pass the firmware
>>> driver handle into this function.
>>>
>>> * Clients resolve deferred probe at their probe time. That way, they
>>> won't register themselves with subsystems asserting they can provide
>>> services, but find out they can't yet provide the service at that time.
>>
>> The one client so far (vc4) was resolving deferred probe at its probe
>> time, but not taking a reference on the firmware driver.  I figure I'll
>> have it do the phandle lookup and refcount -- do you still want the
>> struct platform_device passed in here?  If we de-global firmware, it's
>> going to mean some faffing in the power domain side of things to find
>> the device again, it seems.
>
> I think I'd expect the API in the firmware driver to require the client 
> to pass the client DT node pointer plus a property name, and do all the 
> lookup itself. That's what most DT resource lookup APIs in the kernel do 
> now.

I've made this change, but it's not great -- the client has to know some
details of how this driver is structured (that it sets the drvdata) in
order to figure out whether the driver is loaded or not and return
-EPROBE_DEFERRED.  I couldn't find any other existing solutions than
that in the tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/8ec643cb/attachment.sig>
