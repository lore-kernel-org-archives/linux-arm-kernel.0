From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Dec 2017 20:00:56 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171217190746.2a61232c@bbrezillon>
References: <20171217120503.GA3323@1wt.eu>
 <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
 <20171217155305.16c5bb4f@bbrezillon> <20171217150043.GA1403@1wt.eu>
 <CAAEAJfD47bGTSppEqcRszjAgBUjiCevmdYLKfsQTPYMcVu8VDA@mail.gmail.com>
 <20171217162342.GA1833@1wt.eu> <20171217190746.2a61232c@bbrezillon>
Message-ID: <20171217190056.GA1107@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 07:07:46PM +0100, Boris Brezillon wrote:
> > > This would guarantee that devices with factory bad blocks,
> > > (and no BBT), would be OK with this patch.  
> > 
> > I see. I'm fine with trying provided I have reasonably good assurance
> > that I won't have to go through the kwboot pain again :-/
> 
> There's a easy test you can do without scrubing the NAND:
> 1/ comment the nand-on-flash-bbt property in your DT (this will trigger
>    a full scan)
> 2/ from u-boot (before booting the kernel), erase a block that you know
>    contains nothing important
> 3/ during the kernel scan, make sure this block is not reported as bad

OK so I tried and never faced any error. Thus I also attempted to mark
a bad block in u-boot, it appeared in the bad blocks table, then I had
to scrub the whole table to get rid of it. Each time when I booted I
saw the message "Scanning device for bad blocks" but no error ever
happened. So I hope it's OK.

Please find a summary of my tests below.

Marvell>> nand erase 280000 1000

NAND erase: device 0 offset 0x280000, size 0x1000
Erasing at 0x280000 -- 100% complete.
OK

Marvell>> nand dump 280000
Page 00280000 dump:
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
...
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
OOB:
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff

Boot....
# nanddump -c --oob --bb=dumpbad /dev/mtd8 >/tmp/dump-mtd8.txt
=> only ff everywhere

# dmesg
...
pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
nand: AMD/Spansion S34ML01G2
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
pxa3xx-nand f10d0000.flash: ECC strength 16, ECC step size 2048
Scanning device for bad blocks
...


Marvell>> nand markbad 280000
Bad block table written to 0x000007fe0000, version 0x02
Bad block table written to 0x000007fc0000, version 0x02
>>> orion_nfc_wait_for_completion_timeout command timed out!, status  (0x100)
command 19 execution timed out (CS -1, NDCR=0x8104bfff, NDSR=0x100).
block 0x00280000 successfully marked as bad
Marvell>>

Marvell>> nand bad

Device 0 bad blocks:
        280000
       7f00000
       7f20000
       7f40000
       7f60000
       7f80000
       7fa0000
       7fc0000
       7fe0000

Boot...
# dmesg
...
[    0.875117] pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
[    0.881627] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1                                                                                                        
[    0.886697] nand: AMD/Spansion S34ML01G2                                                                                                                                    
[    0.889326] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.895628] pxa3xx-nand f10d0000.flash: ECC strength 16, ECC step size 2048
[    0.901316] Scanning device for bad blocks
...


Marvell>> nand scrub 7f00000 100000
Erasing at 0x7fe0000 -- 100% complete.
Bad block table not found for chip 0
Bad block table not found for chip 0
Bad block table written to 0x000007fe0000, version 0x01
Bad block table written to 0x000007fc0000, version 0x01
OK
Marvell>> nand bad

Device 0 bad blocks:
       7f00000
       7f20000
       7f40000
       7f60000
       7f80000
       7fa0000
       7fc0000
       7fe0000

Boot...
# dmesg
...
[    0.875322] pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
[    0.881834] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.886904] nand: AMD/Spansion S34ML01G2
[    0.889533] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.895835] pxa3xx-nand f10d0000.flash: ECC strength 16, ECC step size 2048
[    0.901524] Scanning device for bad blocks
[    1.202116] ata2: SATA link down (SStatus 0 SControl 300)
[    1.206245] ata1: SATA link down (SStatus 0 SControl 300)
[    1.244449] 10 ofpart partitions found on MTD device pxa3xx_nand-0
[    1.249345] Creating 10 MTD partitions on "pxa3xx_nand-0":
[    1.253551] 0x000000000000-0x000000200000 : "u-boot"
[    1.257523] 0x000000200000-0x000000240000 : "u_env"
[    1.261372] 0x000000240000-0x000000280000 : "s_env"
[    1.265217] 0x000000900000-0x000000a00000 : "devinfo"
[    1.269229] 0x000000a00000-0x000003200000 : "kernel1"
[    1.273326] 0x000001000000-0x000003200000 : "rootfs1"
[    1.277407] 0x000003200000-0x000005a00000 : "kernel2"
[    1.281509] 0x000003800000-0x000005a00000 : "rootfs2"
[    1.285591] 0x000005a00000-0x000008000000 : "syscfg"
[    1.289596] 0x000000280000-0x000000900000 : "unused_area"
...

Willy
