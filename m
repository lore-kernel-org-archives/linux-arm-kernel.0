From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 May 2011 15:44:19 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <2543A75FDDB244D2A148C14BCAA5FD88@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201104280935.38787.arnd@arndb.de>
	<2543A75FDDB244D2A148C14BCAA5FD88@subhasishg>
Message-ID: <201105041544.19726.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2011, Subhasish Ghosh wrote:
> How about just doing something like:
> 
> #> echo da8xx_pruss_uart >> firmware.bin
> 
> i.e  just append the device name (from the board file) into the firmware
> file.

That sounds fine to me. I would put a header in the beginning, but feel free
to use whatever format you find useful there.

> In the driver probe, we can parse from the bottom, when it reaches
> "da8xx_pruss", the rest of the upper data is the firmware and from
> the full name, we can determine if it's a CAN, UART or any other
> peripheral.
> 
> So, based on the platform_data, which the MFD driver received,
> it can find out which device to initialize.

In my opinion, the MFD driver should not know the possible values
at all, or look at platform_data for the children, but take all
that information from the firmware file.

The only thing that the MFD driver needs to know is how many PRUs
there are and how they are connected to the host bus (memory
regions, irqs, clocks, ...). It can then load firmware files,
either one for the entire MFD or one per PRU core (whatever
works best for you) and create child devices with the information
it finds in there about what code to load into each PRU
and what drivers to load for them.

When you prepend the "da8xx_pruss_" string to the name you find
in the firmware file, the pruss driver can be sure that it does
not accidentally load a different module, e.g. when a malicious
user was able to exchange the firmware file.

> Also, does the line wrapping look any better ?

Looks good now, yes.

	Arnd
