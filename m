From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 May 2013 20:55:21 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522181953.GD12320@obsidianresearch.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522181953.GD12320@obsidianresearch.com>
Message-ID: <20130522185521.GR26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Just to chime in a bit here.. We also hit this problem on Kirkwood,
> and fixed it in the bootloader. The power on default for Kirkwood
> chips is 0xd0000000 and Linux has long required the bootloader to move
> it.. Not sure why 370/XP dropped this.
> 
> Also, can you talk abit more about how this works to give more low DDR
> memory? The docs say you can't overlap windows, and DDR CS's have a
> power of two size/alignment requirement.
> 
> Does this mean the desire is to place a DDR CS from 3G -> 3.5G?
> 
> > For example, I'm currently booting alternatively with an old and a new
> > bootloader (to test that things work properly), and in both cases I'm
> > booting old style, DTB-appended, with ATAGs.
> 
> IMHO the DTB must match both the hardware *and* the bootloader. The
> bootloader is setting the address map, the DTB contains that address
> map, they must all match together.
> 
> Using a DTB property really is the right way to go.

Interesting you said that, yet for your kirkwood, you hacked your
bootloader rather than Linux.

I think in practice, it is not going to be easy to match the DTB to
the hardware and the bootloader. Look at debians flash-kernel, used to
prepare the kernel for an embedded system. For each target it has a
database entry:

Machine: Globalscale Technologies Dreamplug
Kernel-Flavors: kirkwood
DTB-Id: kirkwood-dreamplug.dtb
DTB-Append: yes
U-Boot-Kernel-Address: 0x00008000
U-Boot-Initrd-Address: 0x0
Boot-Device: /dev/sda1
Boot-Kernel-Path: uImage
Boot-Initrd-Path: uInitrd
Boot-DTB-Path: dtb
Required-Packages: u-boot-tools
Bootloader-sets-root: no

So it appends the kirkwood-dreamplug.dtb blob to the kernel.  What you
are saying is that it also needs to somehow query the version of uboot
running on the hardware so it can pick the correct dtb blob from a
collection of kirkwood-dreamplug.dtb blobs and append it to the
kernel.

Is it even possible to query the uboot version from Linux?

To keep the problems tractable, we should not really be dependent on
the bootloader version.

    Andrew
