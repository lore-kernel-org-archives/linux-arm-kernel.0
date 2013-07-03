From: w@1wt.eu (Willy Tarreau)
Date: Thu, 4 Jul 2013 00:23:15 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703211450.GJ16785@1wt.eu>
References: <20130702153825.139a93a5@skate>
 <20130702134421.GC17110@titan.lakedaemon.net> <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net> <87y59ows4n.fsf@natisbad.org>
 <20130702220936.GC10215@1wt.eu> <20130703202105.GE27003@titan.lakedaemon.net>
 <20130703203541.GI16785@1wt.eu> <20130703204451.GF27003@titan.lakedaemon.net>
 <20130703211450.GJ16785@1wt.eu>
Message-ID: <20130703222315.GK16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 11:14:50PM +0200, Willy Tarreau wrote:
> OK fixed the driver. The problem was the hard-coded internal register
> address which was 0xfeb00000 in previous versions and is 0xfec00000
> now.
> 
> Now I'm getting this upon modprobe :
> 
> calling drivers/mtd/nand/armada_nand.c:3227 orion_nfc_probe
> armada-nand d00d0000.nand: Initialize HAL based NFC in 8bit mode with DMA Disabled using BCH 4bit ECC
> drivers/mtd/nand/armada_nand.c:3318:orion_nfc_probe irq=105
> drivers/mtd/nand/armada_nand.c:3324:orion_nfc_probe irq=105
> drivers/mtd/nand/armada_nand.c:3332:orion_nfc_probe mmio_base=fecd0000
> drivers/mtd/nand/armada_nand.c:3338:orion_nfc_probe base=fecd0000
> drivers/mtd/nand/armada_nand.c:1531:setNANDClock nVal=0428040a
> drivers/mtd/nand/armada_nand.c:1539:setNANDClock nVal=0428080a
> drivers/mtd/nand/armada_nand.c:1544:setNANDClock nVal=ff000002
> drivers/mtd/nand/armada_nand.c:1552:setNANDClock nVal=ff000002
> drivers/mtd/nand/armada_nand.c:1531:setNANDClock nVal=0428080a
> drivers/mtd/nand/armada_nand.c:1539:setNANDClock nVal=0428050a
> drivers/mtd/nand/armada_nand.c:1544:setNANDClock nVal=ff000002
> drivers/mtd/nand/armada_nand.c:1552:setNANDClock nVal=ff000002
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0x38 (Micron NAND 1GiB 1,8V 8-bit), 1024MiB, page size: 4096, OOB size: 128
> Bad block table found at page 262016, version 0x01
> Bad block table found at page 261888, version 0x01
> 6 cmdlinepart partitions found on MTD device armada-nand
> Creating 6 MTD partitions on "armada-nand":
> 0x000000000000-0x000000400000 : "uboot"
> 0x000000400000-0x000000800000 : "config"
> 0x000000800000-0x000001000000 : "kernel"
> 0x000001000000-0x000002000000 : "initrd"
> 0x000002000000-0x000020000000 : "rootfs"
> 0x000020000000-0x000040000000 : "pad"
> root at mirabox:~# 
> 
> I'll tidy up a little bit this ugly thing and resend something to use
> as a basis to work on.

The patch it too large (150kB), last time I received a warning from the ML
because of its size. So I'm putting it here instead :

   http://linux.1wt.eu/kernel/armada-nand/3.10-armada_nand.patch

I've tested it on both my mirabox and the xp-gp board, the same flash is
detected (Micron 1GB) and works on both boards. (BTW, Florian if you read
this, your board has already served its intended purpose :-)).

Among the important things to do that immediately come to mind :

  - implement the READID command as explained by Ezequiel to stop
    patching nand_ids.h

  - remove the hard-coded dependency on INTERNAL_REGS_BASE and
    replace all calls to MV_REG_* with their cleaner equivalents
    found in mvneta.c. This will require passing the nfcCtrl
    pointer all along to have the mmio_base pointer I guess.

  - check if include/linux/mtd/nand.h really needs to be patched
    or if the information put there can be moved somewhere else.

And probably try to help Ezequiel finish the work he began by using
this work as documentation rather than the other way around.

Feel free to host this driver anywhere if you like, I don't have the
time to maintain it, and I don't want to see it merged into the kernel,
we have enough crap and this one certainly qualifies as such.

Oh last important point, I found it in the 2.6.35.9-LSP-1.0.2_gw patch.
If someone finds a more recent one in a more recent kernel, it might be
worth comparing them.

Best regards,
Willy
