From: robh@kernel.org (Rob Herring)
Date: Sat, 24 Oct 2015 15:09:06 -0500
Subject: [PATCH v6 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <8510008.IC14Fu2Aos@vostro.rjw.lan>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <10119606.2TraDKGPVy@vostro.rjw.lan>
 <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
 <8510008.IC14Fu2Aos@vostro.rjw.lan>
Message-ID: <562BE562.8090704@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2015 08:55 AM, Rafael J. Wysocki wrote:
> On Thursday, October 22, 2015 03:03:37 PM Tomeu Vizoso wrote:
>> On 22 October 2015 at 03:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Monday, September 21, 2015 04:02:44 PM Tomeu Vizoso wrote:
>>>> Walks the OF tree up and finds the closest ancestor that has a struct
>>>> device associated with it, probing it if isn't bound to a driver yet.
>>>>
>>>> The above should ensure that the dependency represented by the passed OF
>>>> node is available, because probing a device should cause its descendants
>>>> to be probed as well (when they get registered).
>>>>
>>>> Subsystems can use this when looking up resources for drivers, to reduce
>>>> the chances of deferred probes because of the probing order of devices.
>>>>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>> ---
>>>>
>>>> Changes in v5:
>>>> - Move the assignment to device_node->device for AMBA devices to another
>>>>   commit.
>>>> - Hold a reference to the struct device while it's in use in
>>>>   of_device_probe().
>>>>
>>>> Changes in v4:
>>>> - Rename of_platform_probe to of_device_probe
>>>> - Use device_node.device instead of device_node.platform_dev
>>>>
>>>> Changes in v3:
>>>> - Set and use device_node.platform_dev instead of reversing the logic to
>>>>   find the platform device that encloses a device node.
>>>> - Drop the fwnode API to probe firmware nodes and add OF-only API for
>>>>   now. I think this same scheme could be used for machines with ACPI,
>>>>   but I haven't been able to find one that had to defer its probes because
>>>>   of the device probe order.
>>>>
>>>>  drivers/of/device.c       | 61 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/of_device.h |  3 +++
>>>>  2 files changed, 64 insertions(+)
>>>>
>>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>>> index 8b91ea241b10..836be71fc90e 100644
>>>> --- a/drivers/of/device.c
>>>> +++ b/drivers/of/device.c
>>>> @@ -286,3 +286,64 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
>>>>
>>>>       return 0;
>>>>  }
>>>> +
>>>> +/**
>>>> + * of_device_probe() - Probe device associated with OF node
>>>> + * @np: node to probe
>>>> + *
>>>> + * Probe the device associated with the passed device node.
>>>> + */
>>>> +void of_device_probe(struct device_node *np)
>>>
>>> Same question as from Greg: How does a subsystem know whether or not to use
>>> this function?
>>
>> Maybe I don't understand the comment, but as the commit message says,
>> subsystems can use this when looking up resources for drivers. Or you
>> mean that this information should be in the API docs?
> 
> I'm not really sure this is the only case.
> 
> Most likely, you'd end up with that being called by every subsystem using DT
> just in case.

No, it is binding dependent. If a consumer is looking up the provider
from the binding, then yes it needs a call. There may be some cases
where it doesn't make sense. But that is why it is called from the
binding specific code.

> And then each of those subsystems would need to call acpi_device_probe(), and
> then another_platform_firmware_interface_device_probe() and so on.
> 
> Don't you see a problem here?

Only for the 3rd firmware interface. ;)

Let's get agreement on the flow and structure and how to address other
issues like suspend, then we can worry about whether this needs to be
abstracted from subsystems. We can discuss more this week at KS.

Rob
