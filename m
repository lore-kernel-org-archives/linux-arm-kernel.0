From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Aug 2012 11:46:30 +0200
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120819012303.GX22226@titan.lakedaemon.net>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120816132839.GO22226@titan.lakedaemon.net>
 <20120816183708.GT22226@titan.lakedaemon.net>
 <20120817152156.4d91ba16@skate>
 <20120819012303.GX22226@titan.lakedaemon.net>
Message-ID: <20120821114630.545fb771@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sat, 18 Aug 2012 21:23:03 -0400,
Jason Cooper <jason@lakedaemon.net> a ?crit :

> On Fri, Aug 17, 2012 at 03:21:56PM +0200, Thomas Petazzoni wrote:
> > Le Thu, 16 Aug 2012 14:37:08 -0400,
> > Jason Cooper <jason@lakedaemon.net> a ?crit :
> > 
> > > > Whole series applied to:
> > > > 
> > > > git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7
> > > 
> > > I'm getting the following build error with orion_nand enabled:
> > > 
> > >   CC      drivers/mtd/nand/orion_nand.o
> > > drivers/mtd/nand/orion_nand.c:24:27: fatal error: mach/hardware.h: No
> > > such file or directory
> > > compilation terminated.
> > 
> > Are you perhaps trying to enable the orion_nand driver for a mach-mvebu
> > platform (Armada 370 or XP)? If it's the case, then yes, this build
> > breakage is expected: we haven't enabled any of the I/O for now, so we
> > don't have hardware.h yet. This is not something that is broken due to
> > the address decoding changes.
> 
> Ok, I've added Arnd and Olof to the CC.  The above is exactly what I
> did.
> 
> Arnd, how extensive is the 'make randconfig' testing in next?  Is this
> something that needs to be fixed before we push?  I found it by a fluke,
> but the right randconfig would light it up as well.

Well, this build failure is not caused by the address decoding changes
themselves. So the breakage you're seeing with that particular
configuration already exists. We would like to get these address
decoding changes merged so that we can make progress on the SMP support.

In parallel to that, we will start enabling the different I/O: network
interfaces, SATA, XOR engines, USB, etc. During this work, we'll
progressively make all these drivers compatible with mach-mvebu and
Armada 370/XP, and therefore fix the build issues like the one you're
seeing.

Or maybe, you want me to change the "depends on PLAT_ORION" of the
Orion NAND driver to "depends on PLAT_ORION_LEGACY" so that this driver
cannot be selected for now with mach-mvebu? As part of the PLAT_ORION
-> PLAT_ORION_LEGACY conversion, it would make sense. Of course, I
would do it for the other drivers as well (crypto, dma, etc.).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
