From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 May 2011 16:12:18 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <613E2AF627DE4ABE92AD42D5D9E1BFE5@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CD0B8CC@dbde02.ent.ti.com>
	<613E2AF627DE4ABE92AD42D5D9E1BFE5@subhasishg>
Message-ID: <201105051612.18522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2011, Subhasish Ghosh wrote:
> I am a bit lost,
> 
> If I understand correctly, there are two problems
> 
> 1. In case of udev based driver loading, we will end up
> loading both the drivers and the associated firmware.
> This is not acceptable because both UART & CAN
> use PRU0 & PRU1.
> 
> 2. How do we switch between devices at run time.
> This is required because MFD devices should be
> capable of doing that.
> 
> 
> Ok, if that understanding is somewhat correct, then, what we are
> trying to do is load the firmware from the MFD driver itself.

I would describe the problem differently:

You hardcode the usage of the pruss in the platform code,
even though it is completely defined by the software you
load into it. I think it is essential that all the configuration
of the pruss is dynamic and not hardcoded in the platform
code, so that it is at all possible to load other firmware
into it.

Describing the device in the firmware file instead of the platform
code is one way to get there, but there may be other ways that
you could come up with.

> So, in case of a switch between device, say from UART to CAN,
> all the user has to do is copy a new firmware.
> 
> This firmware should contain some info regarding the device, like
> say, device name & prunum.

Right.

> So, in case a device requires both PRUs, then the firmware would
> download for both PRUs.
> 
> In case a device requires only one PRU, then it can be downloaded
> only into the requested PRU. So, the other PRU remains open for
> any other firmware/device.
> 
> After loading the firmware, the MFD device should create the
> platform devices based upon the firmware.
> 
> So, if only one PRU is used for UART, then the other PRU can be
> used for CAN and the MFD should create two platform_devices.
> 
> If the UART uses both the PRUs, then the MFD should download
> the firmware into both the PRUs but create only one platform_device.

As I mentioned, I did not have a good idea for how to abstract
the fact that there may be either one or two child devices,
depending on the firmware. A possible way to deal with this
would be to have only a single firmware image files that contains
the code for both PRUs, with a header indicating how many devices
there should be and what they are called.

> But, in this case how do we download two different firmware
> on two different PRUs. One way is to keep the firmware files
> as its now, but add another file say firmware-config.txt,
> consisting a list of parameters like,
> 
> START
> MFD_ID0#0
> MFD_ID0_PRU_NUM#PRU0
> MFD_ID1#1
> MFD_ID1_PRU_NUM#PRU1
> END
> 
> OR
> 
> START
> MFD_ID0#0
> MFD_ID0_PRU_NUM#PRU0:PRU1
> END
> 
> So, the MFD driver can do a request_firmware on this file first,
> parse the device info and decide to request the main firmware.
> This becomes something like the devices table that we have on
> PPC.

Yes, this would be another option. I generally don't like
parsing data in the kernel, but it's not completely unrealistic.

> Also, if PRU0 is loaded, we need some way of maintaining the
> usage_count, So that the PRU0 is not loaded again accidently.
> We can increase the usage_count from the MFD driver.
> But, to decrement the usage_count, we can add an API
> which will be called when the CAN or UART driver is rmmod.

Not necesarily. You can make the interface so that the
child device gets registered after the firmware got loaded,
but unregistered if you start loading new firmware. We have
hotplug support for a lot of devices, and it's not hard to
write the serial/can/... drivers in a way that allows the
underlying device to go away.

You should not actually need to unload the device driver.
E.g. when the drivers are built into the kernel, you can still
remove the device and put it back in there using the 
->probe and ->remove callbacks of the platform driver.

> Now how do we handle switch between devices.
> 
> We can either do a rmmod of the MFD driver, then again modprobe it.
> So, the request_firmware is run again and the appropriate device is
> loaded based upon the changed firmware-config.txt.
> 
> But, this does not look good, say what if the MFD driver is in-build.
> Another way is that we can add a sysfs entry, which when written
> with anything can re-evaluate the firmware_config.

Yes, I think that a sysfs entry would be good here, basically
to reset the entire unit and remove the child devices, followed
by a new call to request_firmware.

Instead of passing a configuration file into the MFD driver and
calling it a firmware, I can see three other options that I believe
would be nicer:

1. have a single firmware blob that describes the child devices
and the code that is to be loaded into both units. If they are
acting as one device, either make sure you only create one
child node, or create one with a name that no driver binds to.

2. Call request_firmware separately for the two child devices,
and configure them separately based on the information in the
firmware files. In the case where they should act as a single
device, call the children e.g. "pruss-uart-a" and "pruss-uart-b",
then bind to both names in the pruss-uart drivers and only
start using the device when you have both nodes for the same
parent.

3. Do the configuration through sysfs files in the MFD device node,
which then cause the creation of the child devices. This means you
need extra user space scripts to write the addititonal files, but
is also the most flexible way.


	Arnd
