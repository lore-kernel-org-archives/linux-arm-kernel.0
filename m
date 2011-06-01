From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Jun 2011 10:58:03 -0600
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform bus
	scan
In-Reply-To: <4DE66E39.2070300@gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<201105261511.23659.arnd@arndb.de> <4DDE9F4A.5050507@gmail.com>
	<201105271406.18841.arnd@arndb.de> <4DE66E39.2070300@gmail.com>
Message-ID: <BANLkTimTdVKspjJ8GD4M90wiKCC0SzkgpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 10:52 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 05/27/2011 07:06 AM, Arnd Bergmann wrote:
>>
>> On Thursday 26 May 2011, Rob Herring wrote:
>>>
>>> On 05/26/2011 08:11 AM, Arnd Bergmann wrote:
>>>>
>>>> On Wednesday 25 May 2011, Rob Herring wrote:
>>>> This creates a confusing mix of match table entries: Normally,
>>>> all entries in the match table are meant to identify child buses,
>>>> but if I read your patch correctly, you now also need to match
>>>> on the amba devices themselves, including the creation of
>>>> platform devices for each child device node under an amba
>>>> device.
>>>>
>>> We should only create devices for each matching bus and the immediate
>>> children of each bus. A child device of an amba device would be
>>> something like an i2c bus which we don't want to create devices for. Or
>>> am I missing something?
>>
>> Exactly, that was my point.
>>
>>>> I don't think that was the intention. Maybe we need to pass
>>>> two match tables into of_platform_bus_probe() instead:
>>>> one to identify the buses, and another one that is used
>>>> to create the actual devices.
>>>>
>>> That was my original thinking too, but some reason I had concluded 1
>>> could get by with just 1 table. After more thought, I think you are
>>> right. In fact, I broke platform device creation with this patch. I need
>>> to be able to tell if no match means create a platform device (child of
>>> bus) or not (child of a device).
>>
>> Ok.
>>
>>> @@ -234,18 +237,32 @@ static int of_platform_bus_create(struct
>>> device_node *bus,
>>> ? ? ? ? ? ? ? ?return 0;
>>> ? ? ? ?}
>>>
>>> - ? ? ? dev = of_platform_device_create(bus, NULL, parent);
>>> - ? ? ? if (!dev || !of_match_node(matches, bus))
>>> - ? ? ? ? ? ? ? return 0;
>>> -
>>> - ? ? ? for_each_child_of_node(bus, child) {
>>> - ? ? ? ? ? ? ? pr_debug(" ? create child: %s\n", child->full_name);
>>> - ? ? ? ? ? ? ? rc = of_platform_bus_create(child, matches,&dev->dev,
>>> strict);
>>> - ? ? ? ? ? ? ? if (rc) {
>>> - ? ? ? ? ? ? ? ? ? ? ? of_node_put(child);
>>> - ? ? ? ? ? ? ? ? ? ? ? break;
>>> + ? ? ? id = of_match_node(bus_matches, bus);
>>> + ? ? ? if (id) {
>>> + ? ? ? ? ? ? ? dev = of_platform_device_create(bus, NULL, parent);
>>> + ? ? ? ? ? ? ? if (!dev)
>>> + ? ? ? ? ? ? ? ? ? ? ? return 0;
>>> + ? ? ? ? ? ? ? for_each_child_of_node(bus, child) {
>>> + ? ? ? ? ? ? ? ? ? ? ? pr_debug(" ? create child: %s\n",
>>> child->full_name);
>>> + ? ? ? ? ? ? ? ? ? ? ? rc = of_platform_bus_create(child, bus_matches,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_matches, dev,
>>> strict);
>>> + ? ? ? ? ? ? ? ? ? ? ? if (rc) {
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? of_node_put(child);
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>>> + ? ? ? ? ? ? ? ? ? ? ? }
>>> ? ? ? ? ? ? ? ?}
>>> + ? ? ? ? ? ? ? return rc;
>>> ? ? ? ?}
>>> +
>>> + ? ? ? id = of_match_node(dev_matches, bus);
>>> + ? ? ? mdata = id ? id->data : NULL;
>>> + ? ? ? if (id&& ?mdata&& ?mdata->dev_create)
>>> + ? ? ? ? ? ? ? dev = mdata->dev_create(bus, parent);
>>> + ? ? ? else
>>> + ? ? ? ? ? ? ? dev = of_platform_device_create(bus, NULL, parent);
>>> + ? ? ? if (!dev)
>>> + ? ? ? ? ? ? ? return 0;
>>> +
>>
>> Yes, that looks like it should work.
>>
>> It still feels a bit strange, because it's not exactly how we normally
>> probe devices: In all other cases, we bind a device to a driver when we
>> find it, and that driver in turn scans it, and potentially creates
>> child devices that it finds.
>>
>> What we do here is to let the platform decide how to interpret the
>> data that is coming in. To make the probing more well-behaved, another
>> approach would be:
>>
>> * Bind a platform_driver to compatible="arm,amba" (or whatever we
>> ? had in the binding).
>>
>> * In that driver, do nothing except register an amba_device as a child.
>>
>> This would create a somewhat deeper device hierarchy, but be still
>> completely logical: you have a device that cannot be probed (identified
>> simply by its register space), which can be probed internally because
>> the registers actually have a meaning.
>
> Shouldn't the hierarchy in linux reflect the h/w? It seems a bit pointless
> to me to create a device just to create another device. amba_bus is already
> a bit strange in that it is not really a bus type, but a certain class of
> peripherals.
>
> I'd like to hear Grant's thoughts on this.

AMBA and platform_devices are "special" in that they don't have
requirements on their parent device.  I see absolutely zero issue with
having platform_device and amba_device as siblings.

g.
