From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 28 Jun 2010 16:47:49 -0700
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <87fx06viuc.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<87fx06viuc.fsf@deeprootsystems.com>
Message-ID: <AANLkTimgPdrhpDKxd9YhficNddzLEbw_hxkM6_6rh4Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 28, 2010 at 4:27 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
> [...]
>
>>
>>> This affects many aspects of all drivers, from register and probe (for
>>> early devices/drivers too!) to all the plaform_get_resource() usage, all
>>> of which assumes a platform_driver and platform_device. ?I didn't look
>>> closely, but I didn't see if (or how) OF was handling early devices.
>>
>> You don't have to reimplement the entire platform bus. ?You could
>> simply create a new bus type, but reuse all the existing platform bus
>> code. ?All that changes is the bus type that the device and the driver
>> gets registered on. ?Then you could easily replace only the functions
>> that matter. ?(do a git grep platform_bus_type to see how few
>> references there actually are. ?It looks like there are only 5
>> references to it in drivers/base/platform.c that you'd need to work
>> around; in platform_device_add(), platform_driver_register(), 2 in
>> platform_driver_probe(), and the register in platform_bus_init(). ?You
>> may not even need to reimplement platform_driver_probe().
>>
>> It might even be as simple as doing this:
>> - ? ? ? ?pdev->dev.bus = &platform_bus_type;
>> + ? ? ? if (!pdev->dev.bus)
>> + ? ? ? ? ? ? ? ?pdev->dev.bus = &platform_bus_type;
>>
>> So that a different bus type can be selected at device registration
>> time
>
> just FYI...
>
> as a quick proof of concept, I've done a quick hack just to prove to
> myself that I could use platform_devices on a custom bus, and it indeed
> works. ?The small patch below[1] shows the changes required to the
> platform code.
>
> Next step was to hack up minimal custom bus code. ?The quickest (and
> dirtiest) way was to simply memcpy platform_bus_type into my new
> omap_bus_type and then override the few dev_pm_ops functions I needed[2].
>
> So, with these in place, and using the dev_pm_ops functions from
> $SUBJECT patch, I was able register a platform_device and
> platform_driver onto my custom bus and see my custom dev_pm_ops
> functions being used as expected.

Nice!

> While admittedly a bit hacky, at least this paves the way in my head
> that this is indeed do-able, and I can take my vacation in peace without
> this particular problem haunting me (too much.)

indeed.  It could be less hacky also by adding a
platform_bus_type_init() function to the common platform code.

Cheers,
g.
