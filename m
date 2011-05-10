From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2011 23:44:58 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <FBFC0000E34D487086421780A0F5252A@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105051612.18522.arnd@arndb.de>
	<FBFC0000E34D487086421780A0F5252A@subhasishg>
Message-ID: <201105102344.58598.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2011, Subhasish Ghosh wrote:
> > Instead of passing a configuration file into the MFD driver and
> > calling it a firmware, I can see three other options that I believe
> > would be nicer:
> > 
> > 1. have a single firmware blob that describes the child devices
> > and the code that is to be loaded into both units. If they are
> > acting as one device, either make sure you only create one
> > child node, or create one with a name that no driver binds to.
> > 
> > 2. Call request_firmware separately for the two child devices,
> > and configure them separately based on the information in the
> > firmware files. In the case where they should act as a single
> > device, call the children e.g. "pruss-uart-a" and "pruss-uart-b",
> > then bind to both names in the pruss-uart drivers and only
> > start using the device when you have both nodes for the same
> > parent.
> > 
> > 3. Do the configuration through sysfs files in the MFD device node,
> > which then cause the creation of the child devices. This means you
> > need extra user space scripts to write the addititonal files, but
> > is also the most flexible way.
> > 
> 
> Are you suggesting something like:
> 
> /sys..../pruss/pru0/id
> /sys..../pruss/pru0/fw_name
> /sys..../pruss/pru0/load
> 
> /sys..../pruss/pru1/id
> /sys..../pruss/pru1/fw_name
> /sys..../pruss/pru1/load

No, that is none of the three I suggested.

> I can program these configs and store them in the pru private.
> Then write something into load.
> This can load the PRU based upon the configs.
> But, I am not sure how to do this effectively using sysfs,
> I mean I don't want to end up writing six write and six read
> handlers. 

Please look into implementing one of the three I suggested before
you go off in another direction. In case of the third one, the idea
was to configure the name of the device for each pru using sysfs,
which then gets bound to the driver, which loads its own firmware
as you do today. Only in the first two suggestions, the mfd driver
would be responsible for loading the firmware.

	Arnd
