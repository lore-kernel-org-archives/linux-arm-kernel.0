From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Oct 2011 16:00:03 +0200
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <20111017182542.GB14416@suse.de>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<2152965.Ns7xt0yLIG@wuerfel> <20111017182542.GB14416@suse.de>
Message-ID: <201110181600.03834.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2011, Greg KH wrote:
> > You also commented that the argument to soc_device_unregister should
> > be a soc_device (as, consequently, the return type of soc_device_register).
> > Agree with that comment, but it means that the definition of struct
> > soc_device needs to remain visible in order to be used as the parent
> > for other devices.
> 
> No it doesn't:
>         struct device * soc_device_to_device(struct soc device *soc);

Right, that works of course. I believe the more common way is to
expose the derived type to its users, and it also simplifies the
interface.

> Anyway, what are you using this soc device to be the parent of?

Basically everything. The SoC is probably about 90% of the system in
modern embedded systems. Typically, there are on-chip buses like
AMBA or PLB that contain dozens of internal devices (interrupt
controller, serial, dmaengine, rtc, timer, watchdog, ...) as well
as buses (i2c, spi, mmc, usb, pci, ...) that have off-chip child
devices. You can think of an soc device as a kind of ?ber-MFD
that holds all of these together.

If you remember the early discussions about this patch set, I
specifically asked for making the soc_device be a representation
of the whole soc with a hierarchical view of its child devices
under it, as opposed to having an artificial device node that only
serves to export strings along the lines of /proc/cpuinfo.

See patch 5/6 for the one that moves all platform devices that
are part of the dbx500 soc below the soc_device.

	Arnd
