From: alexis.rodet@bvs-tech.com (Alexis RODET)
Date: Fri, 27 Aug 2010 11:24:09 +0200
Subject: unable to use NAND02GR3B2DZA6E on i.MX27 with linux
In-Reply-To: <20100728050108.GD10506@pengutronix.de>
References: <4C4DB6CE.6080709@bvs-tech.com>
	<20100728050108.GD10506@pengutronix.de>
Message-ID: <4C778439.3040707@bvs-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

On 2010-07-28 07:01, Uwe Kleine-K?nig wrote :
> I would start with enabling CONFIG_MTD_DEBUG and setting
> CONFIG_MTD_DEBUG_VERBOSE=3.
>
> Best regards
> Uwe
>
>   
I have set only CONFIG_MTD_DEBUG_VERBOSE=0 with "mxc_nand_command ( ..."
log because others are too noisy.
I got that writing in nand flash crashes Linux for every page address >
0x800. (see log bellow)
Read access is OK as RedBoot partition is well scanned, which is in the
last nand flash page, and all blocks are well scanned during boot (see
attached file).

Is there anything to configure in the platform to allow write access to
bigger nand flash than 4Mb (mine is 256Mb) ?

Best regards,
Alexis RODET

mx27# dd if=test_4k of=/dev/mtd3 bs=2k seek=895 count=2
[11518.850000] MTD_open
[11518.850000] MTD_write
[11518.850000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11518.860000] mxc_nand_command (cmd = 0x80, col = 0x0, page = 0x7ff)
[11518.860000] mxc_nand_command (cmd = 0x10, col = 0xffffffff, page =
0xffffffff)
[11518.880000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11518.890000] MTD_write
[11518.890000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11518.900000] mxc_nand_command (cmd = 0x80, col = 0x0, page = 0x800)
[11518.900000] mxc_nand_command (cmd = 0x10, col = 0xffffffff, page =
0xffffffff)
[11518.920000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11518.920000] MTD_close
2+0 records in
2+0 records out
mx27# dd if=test_4k of=/dev/mtd3 bs=2k seek=896 count=2
[11531.260000] MTD_open
[11531.260000] MTD_write
[11531.260000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11531.270000] mxc_nand_command (cmd = 0x80, col = 0x0, page = 0x800)
[11531.280000] mxc_nand_command (cmd = 0x10, col = 0xffffffff, page =
0xffffffff)
[11531.290000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11531.300000] MTD_write
[11531.300000] mxc_nand_command (cmd = 0x70, col = 0xffffffff, page =
0xffffffff)
[11531.310000] mxc_nand_command (cmd = 0x80, col = 0x0, page = 0x801)
[11531.320000] mxc_nand_command (cmd = 0x10, col = 0xffffffff, page =
0xffffffff)
[11531.330000] Unhandled fault: external abort on non-linefetch (0x808)
at 0xc486ce1c
[11531.340000] Internal error: : 808 [#1]
[11531.340000] last sysfs file:
/sys/devices/platform/imx-i2c.1/i2c-1/1-0050/modalias
[11531.340000] Modules linked in:
[11531.340000] CPU: 0    Not tainted 
(2.6.34.1-bipnet-00007-g7085dc8-dirty #32)
[11531.340000] PC is at send_cmd+0x20/0x34
[11531.340000] LR is at mxc_nand_command+0x334/0x358
[11531.340000] pc : [<c0194208>]    lr : [<c019465c>]    psr: 60000013
[11531.340000] sp : c3e53e20  ip : 00000001  fp : 00000004
[11531.340000] r10: 00000000  r9 : ffffffff  r8 : ffffffff
[11531.340000] r7 : c3d2c000  r6 : c3d2c000  r5 : c3d2c000  r4 : c3d2c000
[11531.340000] r3 : 00000e1c  r2 : 00000001  r1 : c486c000  r0 : c3d2c000
[11531.340000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[11531.340000] Control: 0005317f  Table: a3ed4000  DAC: 00000015
[11531.340000] Process dd (pid: 592, stack limit = 0xc3e52270)
[11531.340000] Stack: (0xc3e53e20 to 0xc3e54000)
[11531.340000] 3e20: 00000004 c019465c 00000070 c3d2c190 c3d2c000
c3e71800 00000801 c3d2c190
[11531.340000] 3e40: c3d2c000 00000800 00000000 c018f064 c3d2c000
c3d2c000 c3d2c190 00000800
[11531.340000] 3e60: 00000000 c3e71800 00000801 c0190044 00000000
00000000 0001ffff 00000000
[11531.340000] 3e80: 00000801 0000003f 00000000 c3e71800 00000000
00000800 c3d2c190 c3d2c000
[11531.340000] 3ea0: c3cffc00 00400800 00000000 c3e52000 0009e4f8
c0190240 c3d2c27c c3dc25a0
[11531.340000] 3ec0: 001c0800 00000000 00000800 c3e53f80 00000000
c0188c74 00000800 c3e53f34
[11531.340000] 3ee0: c3e71800 c3e71800 00000800 c3e71800 00000800
c018aa18 00000800 c3e53f34
[11531.340000] 3f00: c3e71800 00000000 00000001 c3d0c580 00000800
1a606570 00000800 00000000
[11531.340000] 3f20: 00000000 bed13b78 c3e53f48 00000003 00000002
c383e9d0 c3e52000 c3dc25a0
[11531.340000] 3f40: 0009e4f8 00000800 c3e53f80 0009e4f8 c3e52000
00900004 00000002 c0098938
[11531.340000] 3f60: 00000000 00000000 00000000 001c0800 00000000
c3dc25a0 00000800 c0098a6c
[11531.340000] 3f80: 001c0800 00000000 00000001 00000000 00000800
00000800 0009e4f8 00000004
[11531.340000] 3fa0: c00231c4 c00229a0 00000800 00000800 00000004
0009e4f8 00000800 00000000
[11531.340000] 3fc0: 00000800 00000800 0009e4f8 00000004 0009e4f8
00000800 00000000 00000002
[11531.340000] 3fe0: 00000000 bed13bb4 0006cb04 40103e74 60000010
00000004 00000000 00000000
[11531.340000] [<c0194208>] (send_cmd+0x20/0x34) from [<c019465c>]
(mxc_nand_command+0x334/0x358)
[11531.340000] [<c019465c>] (mxc_nand_command+0x334/0x358) from
[<c018f064>] (nand_write_page+0x78/0xc8)
[11531.340000] [<c018f064>] (nand_write_page+0x78/0xc8) from
[<c0190044>] (nand_do_write_ops+0x294/0x31c)
[11531.340000] [<c0190044>] (nand_do_write_ops+0x294/0x31c) from
[<c0190240>] (nand_write+0x8c/0xb0)
[11531.340000] [<c0190240>] (nand_write+0x8c/0xb0) from [<c0188c74>]
(part_write+0x9c/0xa4)
[11531.340000] [<c0188c74>] (part_write+0x9c/0xa4) from [<c018aa18>]
(mtd_write+0x1c8/0x234)
[11531.340000] [<c018aa18>] (mtd_write+0x1c8/0x234) from [<c0098938>]
(vfs_write+0xac/0x128)
[11531.340000] [<c0098938>] (vfs_write+0xac/0x128) from [<c0098a6c>]
(sys_write+0x40/0x6c)
[11531.340000] [<c0098a6c>] (sys_write+0x40/0x6c) from [<c00229a0>]
(ret_fast_syscall+0x0/0x2c)
[11531.340000] Code: e18c10b3 e59012c8 e2833014 e3a0c001 (e181c0b3)
[11531.630000] ---[ end trace 3fef4b18fedccefc ]---
[11531.680000] MTD_close

++
flash_hwr_init(): 0 out of NUM_DEVICES=5, dev id=0xaa20 known id=0x35ec
flash_hwr_init(): 1 out of NUM_DEVICES=5, dev id=0xaa20 known id=0x79ec
flash_hwr_init(): 2 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xf1ec
flash_hwr_init(): 3 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xa120
flash_hwr_init(): 4 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xaa20
flash_hwr_init(): 4 out of NUM_DEVICES=5, id=0xaa20

Error 916: nfc_read_page(addr=0x400000): ECC status=0x8:0x8:0x8:0x8
Warning 510: uncorrectable ECC at addr 0x400000

Found 0 bad blocks

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: log_201008251143.boot
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100827/b1de6274/attachment-0001.ksh>
