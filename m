From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Jun 2012 10:41:40 +0200
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
Message-ID: <20120615104140.24bf25f3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Fri, 15 Jun 2012 00:53:45 -0400,
Josh Coombs <josh.coombs@gmail.com> a ?crit :

> > Uncompressing Linux... done, booting the kernel.
> >
> > Error: unrecognized/unsupported machine ID (r1 = 0x00000c11).
> >
> > Available machine support:
> >
> > ID (hex) ? ? ? ?NAME
> > ffffffff ? ? ? ?Marvell Kirkwood (Flattened Device Tree)
> >
> > Please check your kernel config and/or bootloader.
> > --------------------------
> 
> I'm still stuck with the same error.  I'm working against 5.2rc2 with
> the Orion/kirkwood printk.c patch.
> 
> I'm not 100% on proper etiquette here so rather than spam first and
> get scolded, I've pastebined the relevant info.
> 
> My current patchset is here: http://pastie.org/4090298
> The stripped kernel conf I'm using is here: http://pastie.org/4090323
> 
> I'm including all but the iconnect flattened tree board types in my
> config, included DTS early testing, and am appending the DTS
> definitions to the end of the kernel as I don't expect my uboot to
> play nice, so I'm rather surprised to not see any of the boards show
> up as supported with that boot error.  I feel like this has got to be
> a kernel conf issue, or I'm missing a step in preparing a DTS based
> kernel.
> 
> I also know my board definition will need cleanup to support both the
> GoFlex Net and Home but went this way just to test the concept first.

Seems like your kernel isn't seeing the appended DTB, and therefore
falls back at looking at r1 for a machine ID. Can you detail the
command line you're using to build your kernel?

What I'm doing is:

 1) Build the zImage

 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j4

 2) Build the DTB

 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- armada-xp-db.dtb

 3) Concatenate zImage+DTB

 arch/arm/boot/zImage arch/arm/boot/armada-xp-db.dtb  > zImage-armada-xp.dtb

 4) Run mkimage on it

 /bin/bash scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n 'Linux-marvell' -d zImage-armada-xp.dtb arch/arm/boot/uImage.armada-xp

 5) Boot arch/arm/boot/uImage.armada-xp

Of course, in the final step, you need to adjust the -a and -e options
as needed for your platform. But apparently, your platform uses the
same addresses.

Are you doing something similar to prepare your uImage? As far as I
know, the kernel build process does not automatically append the DTB,
so you have to do it manually as detailed above.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
