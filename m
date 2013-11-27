From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 27 Nov 2013 21:24:47 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131126124003.GA2344@localhost> (Ezequiel Garcia's message of
 "Tue, 26 Nov 2013 09:40:04 -0300")
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
Message-ID: <87zjopd240.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>> But I guess this gives you some hints on possible directions.
>
> Indeed! Thanks a lot for such detailed testings. Can you test this
> branch instead (you will have to add the DTS for your board)?
>
>   https://github.com/MISL-EBU-System-SW/mainline-public/tree/pxa3xx-armada-nand-new-ecc
>
> It's basically v3.13-rc1, plus latest NAND patches (cherry-picked
> from l2-mtd.git), plus a couple more patches to support 2048 pages.
>
> Using this branch you should be able to have detect the device
> and test read/write without any issues. You previous DT node should work:
>
> nand at d0000 {
> 	status = "okay";
> 	num-cs = <1>;
> 	marvell,nand-keep-config;
> 	marvell,nand-enable-arbiter;
> 	nand-on-flash-bbt;
> };

I first did simple raw read and write of a kernel image, which worked
fine:

root at mood:~# dmesg | grep -A 10 -B 10 nand
...
pxa3xx-nand d00d0000.nand: This platform can't do DMA on this device
NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
Bad block table found at page 65472, version 0x01
Bad block table found at page 65408, version 0x01
5 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 5 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x000000180000 : "u-boot"
0x000000180000-0x0000001a0000 : "u-boot-env"
0x000000200000-0x000000800000 : "uImage"
0x000000800000-0x000001800000 : "minirootfs"
0x000001800000-0x000008000000 : "jffs2"
...

root at mood:~# ls /dev/mtd*
/dev/mtd0    /dev/mtd1ro  /dev/mtd3    /dev/mtd4ro     /dev/mtdblock2
/dev/mtd0ro  /dev/mtd2    /dev/mtd3ro  /dev/mtdblock0  /dev/mtdblock3
/dev/mtd1    /dev/mtd2ro  /dev/mtd4    /dev/mtdblock1  /dev/mtdblock4

root at mood:~# dd if=/dev/mtd2ro of=/tmp/foo
12288+0 records in
12288+0 records out
6291456 bytes (6.3 MB) copied, 1.98142 s, 3.2 MB/s

root at mood:~# file /tmp/foo 
/tmp/foo: u-boot legacy uImage, Linux-3.12.0.rn102-10710-gb4789b, Linux/ARM, OS Kernel Image (Not compressed), 4268974 bytes, Mon Nov 25 23:34:01 2013, Load Address: 0x00008000, Entry Point: 0x00008000, Header CRC: 0xB390DB2D, Data CRC: 0x985233AE

root at mood:~# flash_erase /dev/mtd2 0 0 
Erasing 128 Kibyte @ 5e0000 -- 100 % complete 

root at mood:~# nandwrite -p /dev/mtd2 /tmp/test-rn102 
Writing data to block 0 at offset 0x0
Writing data to block 1 at offset 0x20000
Writing data to block 2 at offset 0x40000
Writing data to block 3 at offset 0x60000
Writing data to block 4 at offset 0x80000
Writing data to block 5 at offset 0xa0000
Writing data to block 6 at offset 0xc0000
Writing data to block 7 at offset 0xe0000
Writing data to block 8 at offset 0x100000
Writing data to block 9 at offset 0x120000
Writing data to block 10 at offset 0x140000
Writing data to block 11 at offset 0x160000
Writing data to block 12 at offset 0x180000
Writing data to block 13 at offset 0x1a0000
Writing data to block 14 at offset 0x1c0000
Writing data to block 15 at offset 0x1e0000
Writing data to block 16 at offset 0x200000
Writing data to block 17 at offset 0x220000
Writing data to block 18 at offset 0x240000
Writing data to block 19 at offset 0x260000
Writing data to block 20 at offset 0x280000
Writing data to block 21 at offset 0x2a0000
Writing data to block 22 at offset 0x2c0000
Writing data to block 23 at offset 0x2e0000
Writing data to block 24 at offset 0x300000
Writing data to block 25 at offset 0x320000
Writing data to block 26 at offset 0x340000
Writing data to block 27 at offset 0x360000
Writing data to block 28 at offset 0x380000
Writing data to block 29 at offset 0x3a0000
Writing data to block 30 at offset 0x3c0000
Writing data to block 31 at offset 0x3e0000
Writing data to block 32 at offset 0x400000

root at mood:~# dd if=/dev/mtd2 of=/tmp/foo bs=`wc -c /tmp/test-rn102 | cut -d' ' -f1` count=1
1+0 records in
1+0 records out
4274950 bytes (4.3 MB) copied, 0.345413 s, 12.4 MB/s

root at mood:~# sha256sum /tmp/foo /tmp/test-rn102 
4a923e8ccf0358d9cc70fd82c339eff344986faf3ba37e396b5e635ab8c8d928  /tmp/foo
4a923e8ccf0358d9cc70fd82c339eff344986faf3ba37e396b5e635ab8c8d928  /tmp/test-rn102





Then, I tried and mount the jffs2 partition. This failed with some
errors:

Erasing failed write from 0x6680000 to 0x669ffff
Writing data to block 821 at offset 0x66a0000
[ 1938.054752] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 821, offset 0)
        error 5 (Input/output error)
Erasing failed write from 0x66a0000 to 0x66bffff
Writing data to block 822 at offset 0x66c0000
[ 1938.254753] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 822, offset 0)
        error 5 (Input/output error)
Erasing failed write from 0x66c0000 to 0x66dffff
Writing data to block 823 at offset 0x66e0000
[ 1938.454752] pxa3xx-nand d00d0000.nand: Ready time out!!!
libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 823, offset 0)
        error 5 (Input/output error)
Erasing failed write from 0x66e0000 to 0x66fffff
Writing data to block 824 at offset 0x6700000
Bad block at 6700000, 1 block(s) from 6700000 will be skipped
Writing data to block 825 at offset 0x6720000
Bad block at 6720000, 1 block(s) from 6720000 will be skipped
Writing data to block 826 at offset 0x6740000
Bad block at 6740000, 1 block(s) from 6740000 will be skipped
Writing data to block 827 at offset 0x6760000
Bad block at 6760000, 1 block(s) from 6760000 will be skipped
Writing data to block 828 at offset 0x6780000
Bad block at 6780000, 1 block(s) from 6780000 will be skipped
Writing data to block 829 at offset 0x67a0000
Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
Writing data to block 830 at offset 0x67c0000
Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
Writing data to block 831 at offset 0x67e0000
Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
Writing data to block 832 at offset 0x6800000
libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
nandwrite: error!: /dev/mtd4: MTD get bad block failed
           error 22 (Invalid argument)
nandwrite: error!: Data was only partially written due to error
           error 22 (Invalid argument)



At that point, I though the jffs2 partition was somewhat broken
on my RN102 from previous tests so I decided and try to flash on
it a recovery jffs2 dump I had:


root at mood:~# nandwrite -p /dev/mtd4 /tmp/mtd4ro 

jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x034e0028: 0x55da instead
jffs2: Further such events for this erase block will not be printed
jffs2: mtd->read(0x100 bytes from 0x3500000) returned ECC error
jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x03620000: Read 0xc04c8a8f, calculated 0x8fa1cb40
jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x03840000: Read 0xa5af0f35, calculated 0x6059ed2e
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03820000: read 0x56e035c2, calculated 0x6895725b.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x037e0000: read 0x3f7674d6, calculated 0xf5df9a6e.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03780000: read 0xaefa5c80, calculated 0xea10dc2a.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03740000: read 0x47c3b89b, calculated 0xafaeb853.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03700000: read 0x4583c6cb, calculated 0x13c702d0.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x036c0000: read 0x38df270b, calculated 0xc64fadf.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03680000: read 0x6d69a120, calculated 0xabbd2598.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03640000: read 0xaa02c940, calculated 0x28f6188b.
jffs2: notice: (4553) read_dnode: wrong data CRC in data node at 0x03520000: read 0x7eab8c3b, calculated 0xd5457f42.


And then trying to mount the fs (I guess I should have mounted it RO,
but I don't even know if it would have prevent the bad block table to
be filled)

jffs2: marking eraseblock at 046c0000 as bad
Bad block table written to 0x000007fe0000, version 0xA2
Bad block table written to 0x000007fc0000, version 0xA2
jffs2: Read of newly-erased block at 0x046a0000 failed: -117. Putting on bad_list
jffs2: Read of newly-erased block at 0x046a0000 failed: -117. Putting on bad_list
jffs2: marking eraseblock at 046a0000 as bad
Bad block table written to 0x000007fe0000, version 0xA3
Bad block table written to 0x000007fc0000, version 0xA3
jffs2: Read of newly-erased block at 0x04680000 failed: -117. Putting on bad_list
jffs2: Read of newly-erased block at 0x04680000 failed: -117. Putting on bad_list
jffs2: marking eraseblock at 04680000 as bad
Bad block table written to 0x000007fe0000, version 0xA4


And then during boot, here is what I now get when u-boot loads :-)

NAND:  (ID 0xf1ad)	128 MiB
Bad block table found at page 65472, version 0xA4
Bad block table found at page 65408, version 0xA4
nand_read_bbt: Bad block at 0x000005e80000
nand_read_bbt: Bad block at 0x000005ea0000
nand_read_bbt: Bad block at 0x000005ec0000
nand_read_bbt: Bad block at 0x000005ee0000
nand_read_bbt: Bad block at 0x000005f00000
nand_read_bbt: Bad block at 0x000005f20000
nand_read_bbt: Bad block at 0x000005f40000
nand_read_bbt: Bad block at 0x000005f60000
nand_read_bbt: Bad block at 0x000005f80000
nand_read_bbt: Bad block at 0x000005fa0000
nand_read_bbt: Bad block at 0x000005fc0000
nand_read_bbt: Bad block at 0x000005fe0000
nand_read_bbt: Bad block at 0x000006000000
nand_read_bbt: Bad block at 0x000006020000
nand_read_bbt: Bad block at 0x000006040000
nand_read_bbt: Bad block at 0x000006060000
nand_read_bbt: Bad block at 0x000006080000
nand_read_bbt: Bad block at 0x0000060a0000
nand_read_bbt: Bad block at 0x0000060c0000
nand_read_bbt: Bad block at 0x0000060e0000
nand_read_bbt: Bad block at 0x000006100000
nand_read_bbt: Bad block at 0x000006120000
nand_read_bbt: Bad block at 0x000006140000
nand_read_bbt: Bad block at 0x000006160000
nand_read_bbt: Bad block at 0x000006180000
nand_read_bbt: Bad block at 0x0000061a0000
nand_read_bbt: Bad block at 0x0000061c0000
nand_read_bbt: Bad block at 0x0000061e0000
nand_read_bbt: Bad block at 0x000006200000
nand_read_bbt: Bad block at 0x000006220000
nand_read_bbt: Bad block at 0x000006240000
nand_read_bbt: Bad block at 0x000006260000
nand_read_bbt: Bad block at 0x000006280000
nand_read_bbt: Bad block at 0x0000062a0000
nand_read_bbt: Bad block at 0x0000062c0000
nand_read_bbt: Bad block at 0x0000062e0000
nand_read_bbt: Bad block at 0x000006300000
nand_read_bbt: Bad block at 0x000006320000
nand_read_bbt: Bad block at 0x000006340000
nand_read_bbt: Bad block at 0x000006360000
nand_read_bbt: Bad block at 0x000006380000
nand_read_bbt: Bad block at 0x0000063a0000
nand_read_bbt: Bad block at 0x0000063c0000
nand_read_bbt: Bad block at 0x0000063e0000
nand_read_bbt: Bad block at 0x000006400000
nand_read_bbt: Bad block at 0x000006420000
nand_read_bbt: Bad block at 0x000006440000
nand_read_bbt: Bad block at 0x000006460000
nand_read_bbt: Bad block at 0x000006480000
nand_read_bbt: Bad block at 0x0000064a0000
nand_read_bbt: Bad block at 0x0000064c0000
nand_read_bbt: Bad block at 0x0000064e0000
nand_read_bbt: Bad block at 0x000006500000
nand_read_bbt: Bad block at 0x000006520000
nand_read_bbt: Bad block at 0x000006540000
nand_read_bbt: Bad block at 0x000006560000
nand_read_bbt: Bad block at 0x000006580000
nand_read_bbt: Bad block at 0x0000065a0000
nand_read_bbt: Bad block at 0x0000065c0000
nand_read_bbt: Bad block at 0x0000065e0000
nand_read_bbt: Bad block at 0x000006600000
nand_read_bbt: Bad block at 0x000006620000
nand_read_bbt: Bad block at 0x000006640000
nand_read_bbt: Bad block at 0x000006660000
nand_read_bbt: Bad block at 0x000006680000
nand_read_bbt: Bad block at 0x0000066a0000
nand_read_bbt: Bad block at 0x0000066c0000
nand_read_bbt: Bad block at 0x0000066e0000
nand_read_bbt: Bad block at 0x000006700000
nand_read_bbt: Bad block at 0x000006720000
nand_read_bbt: Bad block at 0x000006740000
nand_read_bbt: Bad block at 0x000006760000
nand_read_bbt: Bad block at 0x000006780000
nand_read_bbt: Bad block at 0x0000067a0000
nand_read_bbt: Bad block at 0x0000067c0000
nand_read_bbt: Bad block at 0x0000067e0000
nand_read_bbt: Bad block at 0x000006800000
nand_read_bbt: Bad block at 0x000006820000
nand_read_bbt: Bad block at 0x000006840000
nand_read_bbt: Bad block at 0x000006860000
nand_read_bbt: Bad block at 0x000006880000
nand_read_bbt: Bad block at 0x0000068a0000
nand_read_bbt: Bad block at 0x0000068c0000
nand_read_bbt: Bad block at 0x0000068e0000
nand_read_bbt: Bad block at 0x000006900000
nand_read_bbt: Bad block at 0x000006920000
nand_read_bbt: Bad block at 0x000006940000
nand_read_bbt: Bad block at 0x000006960000
nand_read_bbt: Bad block at 0x000006980000
nand_read_bbt: Bad block at 0x0000069a0000
nand_read_bbt: Bad block at 0x0000069c0000
nand_read_bbt: Bad block at 0x0000069e0000
nand_read_bbt: Bad block at 0x000006a00000
nand_read_bbt: Bad block at 0x000006a20000
nand_read_bbt: Bad block at 0x000006a40000
nand_read_bbt: Bad block at 0x000006a60000
nand_read_bbt: Bad block at 0x000006a80000
nand_read_bbt: Bad block at 0x000006aa0000
nand_read_bbt: Bad block at 0x000006ac0000
nand_read_bbt: Bad block at 0x000006ae0000
nand_read_bbt: Bad block at 0x000006b00000
nand_read_bbt: Bad block at 0x000006b20000
nand_read_bbt: Bad block at 0x000006b40000
nand_read_bbt: Bad block at 0x000006b60000
nand_read_bbt: Bad block at 0x000006b80000
nand_read_bbt: Bad block at 0x000006ba0000
nand_read_bbt: Bad block at 0x000006bc0000
nand_read_bbt: Bad block at 0x000006be0000
nand_read_bbt: Bad block at 0x000006c00000
nand_read_bbt: Bad block at 0x000006c20000
nand_read_bbt: Bad block at 0x000006c40000
nand_read_bbt: Bad block at 0x000006c60000
nand_read_bbt: Bad block at 0x000006c80000
nand_read_bbt: Bad block at 0x000006ca0000
nand_read_bbt: Bad block at 0x000006cc0000
nand_read_bbt: Bad block at 0x000006ce0000
nand_read_bbt: Bad block at 0x000006d00000
nand_read_bbt: Bad block at 0x000006d20000
nand_read_bbt: Bad block at 0x000006d40000
nand_read_bbt: Bad block at 0x000006d60000
nand_read_bbt: Bad block at 0x000006d80000
nand_read_bbt: Bad block at 0x000006da0000
nand_read_bbt: Bad block at 0x000006dc0000
nand_read_bbt: Bad block at 0x000006de0000
nand_read_bbt: Bad block at 0x000006e00000
nand_read_bbt: Bad block at 0x000006e20000
nand_read_bbt: Bad block at 0x000006e40000
nand_read_bbt: Bad block at 0x000006e60000
nand_read_bbt: Bad block at 0x000006e80000
nand_read_bbt: Bad block at 0x000006ea0000
nand_read_bbt: Bad block at 0x000006ec0000
nand_read_bbt: Bad block at 0x000006ee0000
nand_read_bbt: Bad block at 0x000006f00000
nand_read_bbt: Bad block at 0x000006f20000
nand_read_bbt: Bad block at 0x000006f40000
nand_read_bbt: Bad block at 0x000006f60000
nand_read_bbt: Bad block at 0x000006f80000
nand_read_bbt: Bad block at 0x000006fa0000
nand_read_bbt: Bad block at 0x000006fc0000
nand_read_bbt: Bad block at 0x000006fe0000
nand_read_bbt: Bad block at 0x000007000000
nand_read_bbt: Bad block at 0x000007020000
nand_read_bbt: Bad block at 0x000007040000
nand_read_bbt: Bad block at 0x000007060000
nand_read_bbt: Bad block at 0x000007080000
nand_read_bbt: Bad block at 0x0000070a0000
nand_read_bbt: Bad block at 0x0000070c0000
nand_read_bbt: Bad block at 0x0000070e0000
nand_read_bbt: Bad block at 0x000007100000
nand_read_bbt: Bad block at 0x000007120000
nand_read_bbt: Bad block at 0x000007140000
nand_read_bbt: Bad block at 0x000007160000
nand_read_bbt: Bad block at 0x000007180000
nand_read_bbt: Bad block at 0x0000071a0000
nand_read_bbt: Bad block at 0x0000071c0000
nand_read_bbt: Bad block at 0x0000071e0000
nand_read_bbt: Bad block at 0x000007200000
nand_read_bbt: Bad block at 0x000007220000
nand_read_bbt: Bad block at 0x000007240000
nand_read_bbt: Bad block at 0x000007260000
nand_read_bbt: Bad block at 0x000007280000
nand_read_bbt: Bad block at 0x0000072a0000
nand_read_bbt: Bad block at 0x0000072c0000
FPU not initialized
USB 0: Host Mode
USB 1: Host Mode
Shutting down unused interfaces:
       GBE0
       SDIO
       AUDIO
       TDM
Modules/Interfaces Detected:
       RGMII1 Phy
       PEX0 (Lane 0)
       PEX1 (Lane 1)
       SATA0 (Lane 2)
       SATA1 (Lane 3)
Power On!

MMC:   MRVL_MMC: 0
Net:   egiga1 [PRIME]
Hit any key to stop autoboot:  0
Marvell>> 


I hope the error messages produced during the session will somehow help
find were the issue comes from. I somewhat suspects some chip delay or
CRC issue (those errors appear above).

Well, I guess the bad block the driver put in the bbt are not that bad
in practice, i.e. they were mistakenly marked that way. I also
guess^Whope there is a some low level command I could use to simply
clear the bbt (the NAND had no bad block prior to the test). Any help
would be appreciated on that point.

Anyway, I have somehow decided to delay the test on my RN2120 (dual-core)
for now ;-)

Cheers,

a+
