From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 Jun 2010 16:30:56 -0600
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <87wrtmepum.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<87wrtmepum.fsf@deeprootsystems.com>
Message-ID: <AANLkTimcN6APawXLTzGIBUJ6DeGv8B0MEhbeJFkO59R-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 3:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>> Yes, I've got patches which merge of_platform_bus_type with the
>> platform bus. ?This was an easy decision to make because the
>> of-specific bits (specifically, matching an of_device_id table with a
>> device tree node) are applicable to all bus types; i2c, spi, mdio,
>> platform, etc). ?The needed OF data structures have been moved into
>> struct device and struct device_driver so that of_platform_bus_type no
>> longer has anything different.
>>
>> The drivers still need to care about OF when extra platform data needs
>> to be extracted from the DT node, but for IRQs and register ranges it
>> is automatic.
>
> Does that mean the drivers are still doing platform_get_resource() for
> either platform devices or OF devices, or are does the driver have to
> know which bus it was on and call accordingly. ?It's the latter that I
> want to stay away from.

platform_get_resource() works for OF and non-OF platform devices with
no extra code needed in the OF case.

It's the other data that requires special code because it is provided
in the device tree instead of in a platform_data structure.  A driver
that normally uses platform_data will need extra code early in the
probe hook to go and parse the device tree and populate the private
data structures accordingly.  This behaviour has to be handled in the
driver because every driver uses a different platform_data structure.
It cannot be generic code.  The rest of the driver can remain
untouched.

In the old (bad) way, the bus type was entirely different, and drivers
used by both platform_bus_type and of_platform_bus_type needed to have
entirely separate device_driver structures and probe() hooks for each
bus type.

[...]
>> So, instead of having all the platform_bus_type devices as children of
>> the "platform" device (/sys/devices/platform/*), you could set the
>> omap devices to be children of an omap bus device
>> (/sys/devices/omap/*). ?Different busses can also implement different
>> behaviour by using a different parent device. ?For example:
>>
>> /sys/devices/platform
>> /sys/devices/omap-bus-a
>> /sys/devices/omap-bus-a/omap-bus-b
>>
>> Thoughts?
>
> Hmm, I like this idea. ?This is certainly worth exploring as a first
> pass.
>
> Thanks for the idea,

:-)
g.
