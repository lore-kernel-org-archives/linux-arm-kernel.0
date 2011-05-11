From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2011 22:03:54 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <82D549BB195345A1A189D569952B387C@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105102344.58598.arnd@arndb.de>
	<82D549BB195345A1A189D569952B387C@subhasishg>
Message-ID: <201105112203.54838.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2011, Subhasish Ghosh wrote:
> > Please look into implementing one of the three I suggested before
> > you go off in another direction. In case of the third one, the idea
> > was to configure the name of the device for each pru using sysfs,
> > which then gets bound to the driver, which loads its own firmware
> > as you do today. Only in the first two suggestions, the mfd driver
> > would be responsible for loading the firmware.
> 
> Ok, thanks for the clarification.
> Instead of passing the device name, will it be ok to pass the mfd_id.
> The benefit will be that I can use the ID directly as an array
> index for the mfd_cell entries.

I think a device name would be clearer here, especially in order
to avoid conflicts when the list gets extended in different ways
depending on which kernel runs.

We had a little discussion at the Linaro Developer Summit about your
driver and mfd drivers in general. There was a general feeling among
some people (including me) that by the point you dynamically create
the subdevices, MFD is probably not the right abstraction any more,
as it does not provide any service that you need.

Instead, maybe you can simply call platform_device_register
at that stage to create the children and not use MFD at all.

Samuel, can you comment on this as well? Do you still see pruss
as an MFD driver when the uses are completely dynamic and determined
by the firmware loaded into it?

> Just to verify my understanding, all that's needs to be done is add
> a sysfs entry at 
> /sys/devices/platform/pruss_mfd/mfd_id
> 
> Writing to this entry would create the respective device.
> Rewriting would unload the old (mfd_remove_device)
> and reload the new device.

Yes

> Reading may return the various devices and their name
> aliases.

I would just return the current value. You might want to have two
files in sysfs, one per PRU, so you can set them individually.

	Arnd
