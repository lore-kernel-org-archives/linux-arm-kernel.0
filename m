From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Feb 2016 08:48:12 +0100
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <56C0ECDA.1000203@roeck-us.net>
Message-ID: <20160215074812.GC12289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guenter,

On Sun, Feb 14, 2016 at 01:08:42PM -0800, Guenter Roeck wrote:
> On 02/14/2016 11:55 AM, Uwe Kleine-K?nig wrote:
> >[adding lakml and rmk to Cc]
[adding some more people to Cc]

> >On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
> >>Your patch 'driver-core: platform: probe of-devices only using list of
> >>compatibles' causes the following qemu tests to crash in -next.

For the new readers, that is 67d02a1bbb334558e9380409a3cd426b36d4578b.

The original idea of this commit was to not bind a device created from
device tree when its name matches the driver name but none of the
driver's compatibles which might yield some surprises.

> >>arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
> >>arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
> >>arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
> >>arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
> >>
> >>Crash log:
> >>
> >>VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
> >>Please append a correct "root=" boot option; here are the available partitions:
> >>1f00          131072 mtdblock0  (driver?)
> >>1f01           32768 mtdblock1  (driver?)
> >>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> >>
> >>ie the mmc driver no longer instantiates. Reverting the patch fixes the problem.
> >
> >The driver is drivers/mmc/host/mmci.c, right? and the relevant device
> >tree snippet is:
> >
> >	mmci at 05000 {
> >		compatible = "arm,pl180", "arm,primecell";
> >		...
> >	};
> >
> 
> Yes, I think so, or one of the many other similar mmc entries.

So the driver in question is an amba_driver and it fails to bind because

	static int platform_match(struct device *dev, struct device_driver *drv)
	
was changed. This is the platform bus type's match function. Why is this
called for amba devices (that I would expect to use amba_bustype and so
amba_match)?

The driver isn't matched by of_driver_match_device, so the
following code must yield 1 for the mmci device:

        /* Then try ACPI style match */
        if (acpi_driver_match_device(dev, drv))
                return 1;

        /* Then try to match against the id table */
        if (pdrv->id_table)
                return platform_match_id(pdrv->id_table, pdev) != NULL;

        /* fall-back to driver name match */
        return (strcmp(pdev->name, drv->name) == 0);

acpi seems unlikely, and the other two match by the device's name which
feels wrong. And I also wonder, what drv is here, because platform_match
assumes it is a platform_driver, not an amba_driver.

> >? So the unexpected abnormality here is that even though this device is
> >instantiated by dt, the driver doesn't provide any compatibles.
> >Either my expectation is wrong, then 67d02a1bbb33455 should be reverted
> >(or handle this case in a different way), or the mmci driver should
> >declare compatibles (but then it needs to be a platform driver and not
> >an amba driver?).
> 
> No idea what the correct solution would be. I do see
> 
>         if (of_device_is_compatible(bus, "arm,primecell")) {
>                 /*
>                  * Don't return an error here to keep compatibility with older
>                  * device tree files.
>                  */
>                 of_amba_device_create(bus, bus_id, platform_data, parent);
>                 return 0;
>         }

So there is a new (and better?) way to instantiate amba devices?

> in drivers/of/platform.c, which suggests some special handling for amba
> devices. No idea if and how that is related, but I do have some concern
> that fixing the problem for mmc alone might not fix it for all the other
> devices instantiated with "arm,primecell". After all, my boot tests are
> really rudimentary (it boots, therefore it works).

I don't see the right thing to do either. Maybe someone else can shed
some light on this issue?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
