From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 20 Apr 2011 23:07:41 +1200
Subject: [RFC PATCH 02/23] at91: Make Ethernet device common
In-Reply-To: <20110420083636.GU31131@pengutronix.de>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
	<20110420083636.GU31131@pengutronix.de>
Message-ID: <4DAEBE7D.90103@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/11 20:36, Uwe Kleine-K?nig wrote:
> Hello Ryan,
> 
> On Wed, Apr 20, 2011 at 01:10:05PM +1200, Ryan Mallon wrote:
>> Replace the individual Ethernet device code for each at91 variant with
>> a single implementation in devices.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>>

<snip>

>> +struct at91_dev_table_ethernet {
>> +	unsigned 		mmio_base;
>> +	int 			irq;
>> +	struct at91_pin_config	*rmii_pins;
>> +	int 			nr_rmii_pins;
>> +	struct at91_pin_config	*mii_pins;
>> +	int 			nr_mii_pins;
>> +};
>> +
>>  struct at91_device_table {
>> +	struct at91_dev_table_ethernet		*ethernet;
>>  };
> I wonder if it's a good idea to collect all data in a single cross-SoC
> table.

The thinking behind using a single large table is that it reduces the
amount of data which needs to be exported, and makes it easy to see
which devices each SoC has. The device table is initdata so it doesn't
stay in memory permanently.

> Consider a new SoC that has a new type of device, then you need
> to expand this struct for only a single user. Moreover expanding this
> struct will result in merge conflicts when >1 patch touches it.

True, but the common code has to live somewhere. You may still get merge
conflicts when more than one SoC adds a new device to the common
devices.c. I don't think that needing to expand the device table struct
is necessarily a bad thing.

> If I understand your approach correctly you will have a single per-SoC
> function that initialises all devices, right? If so, how do you handle
> machines that don't have ethernet or that don't have handshake lines for
> an UART?

Not quite. All of the device structures in the *_devices.c files are
just descriptions of the devices, and are marked initdata so they are
freed later on. Actual initialisation of the device data is handled by
individual functions (e.g. at91_add_device_ethernet) which uses the
device descriptor structure to initialise the device.

I should possibly note in the changelog that this patch does not really
introduce a functional change (boards still initialise devices the same
way as before), it just changes how the initialisation data is stored to
make it easier to consolidate the common parts.

> For mxc I used dedicated functions instead of a generic struct. (This
> isn't optimal also, because there is still a single header file, but
> when the functions are moved near the drivers I think that would be
> fine.) See arch/arm/plat-mxc/include/mach/devices-common.h,
> arch/arm/mach-imx/devices-imx27.h (et al) and
> arch/arm/plat-mxc/devices/* for the details.

Our approaches are actually similar. The functions in the at91 case are
in devices.c (in my patch series), with the data structures passed to
the functions (via the device table) being in the *_devices.c files.

~Ryan
