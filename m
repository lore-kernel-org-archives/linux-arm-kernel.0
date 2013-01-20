From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 20 Jan 2013 16:03:47 +0100
Subject: Mirabox tree
In-Reply-To: <CAD7Jr4=E9qqzfaLi2RMTrX5ODLH16gUHQ2sk6t9tOc7L2Z=Gew@mail.gmail.com>
References: <CAD7Jr4mveEe0rbDBuBsPmBpx3m4Bat5yipB=KQV9uaG8N+KuJQ@mail.gmail.com>
 <CAD7Jr4mAeXnYfgbs61_jcpT+iVSv1YXLb0h0VxD0SwUDbgfKAA@mail.gmail.com>
 <20130119092637.1f08f752@skate>
 <CAD7Jr4m489bfQQuSNP2s_7E2nfGUMk+Tj11hfQrU+egfjbFX8g@mail.gmail.com>
 <20130119132315.73f18ba3@skate>
 <CAD7Jr4=E9qqzfaLi2RMTrX5ODLH16gUHQ2sk6t9tOc7L2Z=Gew@mail.gmail.com>
Message-ID: <20130120160347.03553c4e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael Lawson,

On Sat, 19 Jan 2013 19:21:12 +0100, Michael Lawson wrote:

> Feel free to tell me to go away. But I am quite keen to get this sd card
> working, so did not snooping around.
> To the mirabox dts file, I added (This I found in a patch somewhere from
> quite recent)
> 
>                 usb at d0050000 {
>                         status = "okay";
>                 };
> 
>                 usb at d0051000 {
>                         status = "okay";
>                 };

This is not sufficient. The nodes must also be added in the
corresponding .dtsi file. You should rather take 3.8-rcX and apply the
Armada 370/XP USB series posted by Ezequiel Garcia on January 15th.

> and then support for ehci in the .config file. This made no difference to
> being able to mount the drive.

Before attempting to mount anything, you should rather have a look at
the output of "lsusb" to see if at least devices are detected. Until
they are detected, it doesn't make sense to go further.

> What I found was that the sd card reader is a pretty standard device,
> root at mirabox-debian:~# lsusb
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 003: ID 05e3:0723 Genesys Logic, Inc. GL827L SD/MMC/MS Flash
> Card Reader
> Bus 001 Device 004: ID 05e3:0723 Genesys Logic, Inc. GL827L SD/MMC/MS Flash
> Card Reader
> Bus 001 Device 002: ID 1a40:0101 TERMINUS TECHNOLOGY INC. USB-2.0 4-Port HUB
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> root at ubuntu:~/mainline-public-marvell-pcie-v1# grep -i -R  -l 05e3 drivers/
> drivers/media/usb/uvc/uvc_driver.c
> drivers/media/usb/gspca/gl860/gl860.c
> drivers/usb/storage/usb-storage.mod.c
> drivers/usb/storage/unusual_devs.h
> drivers/usb/storage/usb-storage.mod.o

I remember we had some discussion with other developers of the Marvell
kernel community, and I think the conclusion was that there wasn't a
kernel driver for the Genesys Logic controller. But I haven't checked
again (and being at the moment in the train with a clumsy Internet
connection makes even a basic Google search impractical).

> It would appear the drivers are included in my kernel. This is where I am
> bit confused, if the usb devices are properly mapped in the dts file, and
> the kernel modules for the flash card reader, and usb_storage are also
> loaded, what is preventing this guy from working.
> 
> How do you guys actually determine the bus addresses to use in the dts
> files? Is this something provided by the hardware supplier, or via another
> way? I have tried hunting for these numbers in U-Boot and the other kernel,
> but cant see much.

You need the Armada 370 datasheet, which for now, is only available
under NDA to selected companies and developers, if I'm correct.
However, as far as USB support on Armada 370 is concerned, the patch
series for Ezequiel Garcia that I mentioned earlier is sufficient.
Then, it is a matter of finding or writing a device driver for the
Genesys Logic USB device.

Hope this helps,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
