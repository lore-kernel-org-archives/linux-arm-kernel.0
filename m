From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 May 2015 12:28:20 -0600
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <877fsdtioy.fsf@eliezer.anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
 <55403AD1.4030103@wwwdotorg.org> <87oam6q0v1.fsf@eliezer.anholt.net>
 <55416DA2.5040902@wwwdotorg.org> <87a8x94rk5.fsf@eliezer.anholt.net>
 <555279D7.5020500@wwwdotorg.org> <877fsdtioy.fsf@eliezer.anholt.net>
Message-ID: <555397C4.4080008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 06:38 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 05/12/2015 11:46 AM, Eric Anholt wrote:
>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>
>>>> On 04/29/15 11:51, Eric Anholt wrote:
>>>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>>>
>>>>>> On 04/27/2015 05:14 PM, Eric Anholt wrote:
>>>>>>> This gives us a function for making mailbox property channel requests
>>>>>>> of the firmware, and uses it to control the 3 power domains provided
>>>>>>> by the firmware.
>>>>>>
>>>>>>> diff --git a/arch/arm/mach-bcm/raspberrypi-firmware.c b/arch/arm/mach-bcm/raspberrypi-firmware.c
>>>>>>
>>>>>>> +/*
>>>>>>> + * Submits a set of concatenated tags to the VPU firmware through the
>>>>>>> + * mailbox property interface.
>>>>>>> + *
>>>>>>> + * The buffer header and the ending tag are added by this function and
>>>>>>> + * don't need to be supplied, just the actual tags for your operation.
>>>>>>> + * See struct raspberrypi_firmware_property_tag_header for the per-tag structure.
>>>>>>> + */
>>>>>>> +int raspberrypi_firmware_property(void *data, size_t tag_size)
>>>>>>> +{
>>>>>>> +	size_t size = tag_size + 12;
>>>>>>> +	u32 *buf;
>>>>>>> +	dma_addr_t bus_addr;
>>>>>>> +	int ret = 0;
>>>>>>> +
>>>>>>> +	if (!firmware)
>>>>>>> +		return -EPROBE_DEFER;
>>>>>>
>>>>>> I think it'd make more sense if the clients looked up the firmware
>>>>>> driver via phandle at their probe time. This would mean:
>>>>>>
>>>>>> * No need for global "firmware", since clients could pass the firmware
>>>>>> driver handle into this function.
>>>>>>
>>>>>> * Clients resolve deferred probe at their probe time. That way, they
>>>>>> won't register themselves with subsystems asserting they can provide
>>>>>> services, but find out they can't yet provide the service at that time.
>>>>>
>>>>> The one client so far (vc4) was resolving deferred probe at its probe
>>>>> time, but not taking a reference on the firmware driver.  I figure I'll
>>>>> have it do the phandle lookup and refcount -- do you still want the
>>>>> struct platform_device passed in here?  If we de-global firmware, it's
>>>>> going to mean some faffing in the power domain side of things to find
>>>>> the device again, it seems.
>>>>
>>>> I think I'd expect the API in the firmware driver to require the client
>>>> to pass the client DT node pointer plus a property name, and do all the
>>>> lookup itself. That's what most DT resource lookup APIs in the kernel do
>>>> now.
>>>
>>> I've made this change, but it's not great -- the client has to know some
>>> details of how this driver is structured (that it sets the drvdata) in
>>> order to figure out whether the driver is loaded or not and return
>>> -EPROBE_DEFERRED.  I couldn't find any other existing solutions than
>>> that in the tree.
>>
>> The client shouldn't need to know that.
>>
>> I'd expect the client to pass a DT node pointer to the provider's
>> driver, and that provider driver would know and isolate all the details
>> about its own internals. The provider could return some kind of
>> handler/... to the provider device if required.
>>
>> I would expect any subsystem that supports client->provider references
>> in DT would have an example of this (e.g. IRQs, GPIOs, regulators, ...).
>> However, the code for those can be rather complex to dive into for the
>> first time. For a fairly simple standalone example, check out:
>>
>> Provider:
>> drivers/amba/tegra-ahb.c
>> tegra_ahb_enable_smmu()
>>
>> Consumer:
>> drivers/iommu/tegra-smmu.c
>> tegra_smmu_ahb_enable()
>> (called from tegra_smmu_probe() in the same file)
>
> It's somewhat suspicious to me as an example of how -EPROBE_DEFER ought
> to work, that tegra_ahb_enable_smmu()'s return value isn't being checked
> by tegra_smmu_ahb_enable().

Oh that's certainly a bug, and needs to be fixed; both 
tegra_smmu_ahb_enable() and tegra_smmu_probe() should propagate any 
-EPROBE_DEFERRED out if they happen. I'll file a bug for that internally.

> That said, this looks like this is "Yeah, just call into the producer
> driver to do setup, and if it returns -EPROBE_DEFER, then bail out and
> return -EPROBE_DEFER, yourself."  That's what I was doing in this
> function and its consumers, that you commented on, only I wasn't passing
> in the dt node.  Is that all you wanted changed?

(very briefly looking at the quoted history above) I think the primary 
issue was the -EPROBE_DEFERRED in the patch is returned by a function 
that sends a message, rather than a function which looks up the provider.

There's no general reason to believe that a message will be sent during 
a client driver's probe, so in general a client driver may only notice 
that the firmware provider is missing when the first message is sent, 
which is too late to defer the client driver's probe.

However, any client should always look up any service provider during 
probe, and hence be able to defer its own probe.
