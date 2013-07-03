From: w@1wt.eu (Willy Tarreau)
Date: Wed, 3 Jul 2013 23:14:50 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703204451.GF27003@titan.lakedaemon.net>
References: <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate> <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org> <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130703202105.GE27003@titan.lakedaemon.net> <20130703203541.GI16785@1wt.eu>
 <20130703204451.GF27003@titan.lakedaemon.net>
Message-ID: <20130703211450.GJ16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 04:44:51PM -0400, Jason Cooper wrote:
> > What makes me uncomfortable is that we have guys who have started
> > some clean work and in parallel we're doing some crap which will
> > discourage Marvell from reprioritizing their work. I'd rather keep
> > that as an out of tree patch so that nobody there claims that the
> > NAND driver already exists in the kernel.
> 
> Good point.  I was thinking the exact opposite :-P  "The in tree driver
> is crap, we'd better re-prioritize our work before people default to the
> crap driver"

Do you really think that people who provide bogus kernel patches to
vendors who sell hardware with unmaintained outdated kernels and many
bugs have anything to care about the quality of the in-kernel driver ?

I'm afraid they simply don't care a dime. I bricked my mirabox a few
days after using it, I hoped to find some JTAG info to write an openocd
driver and found nothing. I asked to apply for an NDA to get access to
this precious data (Most likely the hardware is still in beta and they
don't want the remaining flaws to be unveiled). I did this exactly one
year ago and nothing moved after maybe 20 repeated attempts, nothing
moved. Finally I managed to unbrick it by reversing the boot loader
code and their image generator.

The reality is that they absolutely don't care about their hardware
being supported by mainline since they already have enough customers
who buy their crippled LSP kernel.

> However, I agree that your more cynical pov is probably more correct.
> 
> I'd love to see the mirabox etc supported by mainline debian et al, but
> it'll have to wait.

I would love it too. The platform is good. The mirabox is small and
powerful. The AX3 is absolutely marvelous (no pun intended). I would
love that they once for all understand that they just need to let
developers do the work they barely drafted with their crappy LSP and
become one of the best linux platforms for many SOHO usages. Their
marketing would be better done by their end users and community...
But at the moment, all the makers of these devices have to live with
the idea that their devices are limited by bogus and unstable code
and that their sales suffer from this. Pfff....

OK fixed the driver. The problem was the hard-coded internal register
address which was 0xfeb00000 in previous versions and is 0xfec00000
now.

Now I'm getting this upon modprobe :

calling drivers/mtd/nand/armada_nand.c:3227 orion_nfc_probe
armada-nand d00d0000.nand: Initialize HAL based NFC in 8bit mode with DMA Disabled using BCH 4bit ECC
drivers/mtd/nand/armada_nand.c:3318:orion_nfc_probe irq=105
drivers/mtd/nand/armada_nand.c:3324:orion_nfc_probe irq=105
drivers/mtd/nand/armada_nand.c:3332:orion_nfc_probe mmio_base=fecd0000
drivers/mtd/nand/armada_nand.c:3338:orion_nfc_probe base=fecd0000
drivers/mtd/nand/armada_nand.c:1531:setNANDClock nVal=0428040a
drivers/mtd/nand/armada_nand.c:1539:setNANDClock nVal=0428080a
drivers/mtd/nand/armada_nand.c:1544:setNANDClock nVal=ff000002
drivers/mtd/nand/armada_nand.c:1552:setNANDClock nVal=ff000002
drivers/mtd/nand/armada_nand.c:1531:setNANDClock nVal=0428080a
drivers/mtd/nand/armada_nand.c:1539:setNANDClock nVal=0428050a
drivers/mtd/nand/armada_nand.c:1544:setNANDClock nVal=ff000002
drivers/mtd/nand/armada_nand.c:1552:setNANDClock nVal=ff000002
NAND device: Manufacturer ID: 0x2c, Chip ID: 0x38 (Micron NAND 1GiB 1,8V 8-bit), 1024MiB, page size: 4096, OOB size: 128
Bad block table found at page 262016, version 0x01
Bad block table found at page 261888, version 0x01
6 cmdlinepart partitions found on MTD device armada-nand
Creating 6 MTD partitions on "armada-nand":
0x000000000000-0x000000400000 : "uboot"
0x000000400000-0x000000800000 : "config"
0x000000800000-0x000001000000 : "kernel"
0x000001000000-0x000002000000 : "initrd"
0x000002000000-0x000020000000 : "rootfs"
0x000020000000-0x000040000000 : "pad"
root at mirabox:~# 

I'll tidy up a little bit this ugly thing and resend something to use
as a basis to work on.

Best regards,
Willy
