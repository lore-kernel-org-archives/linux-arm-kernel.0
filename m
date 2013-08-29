From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Thu, 29 Aug 2013 10:59:46 +0200
Subject: [problem] atmel_nand 40000000.nand: PMECC: Too many errors
Message-ID: <521F0D82.7030005@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I discovered problem with writing to root UBIFS on NAND. I have tried kernels 3.9.7, 3.10.9 and the one from 
git://github.com/linux4sam/linux-at91.git.
I write ubi.img in u-boot, every think is ok, booting kernel with read only root is ok. Booting with rw first time is ok 
too. But, probably after some writes, booting next time goes bad and after more boots fails totally. If I write ubi.img 
again in u-boot, first boot is ok. I have tried every settings, googling a lot, but without any improvement.
I append truncated boot log of 3.10.9 kernel:
...
[    0.562500] ssc f0010000.ssc: Atmel SSC device at 0xc8850000 (irq 22)
[    0.578125] atmel_nand 40000000.nand: No DMA support for NAND access.
[    0.585937] ONFI param page 0 valid
[    0.593750] ONFI flash detected
[    0.593750] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xaa (Micron MT29F2G08ABBEAH4), 256MiB, page size: 2048, OOB 
size: 64
[    0.601562] atmel_nand 40000000.nand: ONFI params, minimum required ECC: 4 bits in 512 bytes
[    0.609375] atmel_nand 40000000.nand: Initialize PMECC params, cap: 4, sector: 512
[    0.617187] Scanning device for bad blocks
[    0.750000] 5 ofpart partitions found on MTD device atmel_nand
[    0.750000] Creating 5 MTD partitions on "atmel_nand":
[    0.757812] 0x000000000000-0x000000040000 : "bootstrap"
[    0.765625] 0x000000040000-0x000000100000 : "uboot"
[    0.773437] 0x000000100000-0x000000140000 : "ubootenv"
[    0.781250] 0x000000140000-0x000000600000 : "kernel"
[    0.789062] 0x000000600000-0x000010000000 : "root"
[    0.804687] libphy: MACB_mii_bus: probed
...
[    1.101562] NET: Registered protocol family 17
[    1.109375] UBI: attaching mtd4 to ubi0
[    1.203125] atmel_nand 40000000.nand: Bit flip in data area, byte_pos: 1069, bit_pos: 0, 0xfe -> 0xff
[    1.875000] UBI: scanning is finished
[    1.898437] UBI: attached mtd4 (name "root", size 250 MiB) to ubi0
[    1.898437] UBI: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    1.906250] UBI: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    1.914062] UBI: VID header offset: 2048 (aligned 2048), data offset: 4096
[    1.921875] UBI: good PEBs: 2000, bad PEBs: 0, corrupted PEBs: 0
[    1.921875] UBI: user volume: 1, internal volumes: 1, max. volumes count: 128
[    1.929687] UBI: max/mean erase counter: 1/0, WL threshold: 256, image sequence number: 30979213
[    1.937500] UBI: available PEBs: 0, total reserved PEBs: 2000, PEBs reserved for bad PEB handling: 40
[    1.945312] at91_rtc fffffeb0.rtc: setting system clock to 2007-01-01 00:00:17 UTC (1167609617)
[    1.953125] atmel_mci f0008000.mmc: version: 0x504
[    1.953125] atmel_mci f0008000.mmc: using dma0chan0 for DMA transfers
[    1.960937] UBI: background thread "ubi_bgt0d" started, PID 386
[    2.015625] atmel_mci f0008000.mmc: Atmel MCI controller at 0xf0008000 irq 23, 1 slots
[    2.023437] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.039062] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 3:4096, read only 
126976 bytes, retry
[    2.046875] UBIFS: background thread "ubifs_bgt0_0" started, PID 391
[    2.054687] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.070312] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 3:4096, read only 
126976 bytes, retry
[    2.078125] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.093750] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 3:4096, read only 
126976 bytes, retry
[    2.101562] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.117187] UBI error: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 3:4096, read 126976 bytes
[    2.125000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.9cdung #20
[    2.132812] [<c000d558>] (unwind_backtrace+0x0/0xe4) from [<c000bca4>] (show_stack+0x10/0x14)
[    2.140625] [<c000bca4>] (show_stack+0x10/0x14) from [<c01de3b8>] (ubi_io_read+0x1d0/0x294)
[    2.148437] [<c01de3b8>] (ubi_io_read+0x1d0/0x294) from [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc)
[    2.156250] [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc) from [<c01db234>] (ubi_leb_read+0xd4/0x128)
[    2.164062] [<c01db234>] (ubi_leb_read+0xd4/0x128) from [<c01202c0>] (ubifs_leb_read+0x24/0x84)
[    2.171875] [<c01202c0>] (ubifs_leb_read+0x24/0x84) from [<c0127828>] (ubifs_start_scan+0x6c/0xe8)
[    2.179687] [<c0127828>] (ubifs_start_scan+0x6c/0xe8) from [<c0127b34>] (ubifs_scan+0x20/0x2d8)
[    2.187500] [<c0127b34>] (ubifs_scan+0x20/0x2d8) from [<c01267fc>] (ubifs_read_master+0x40/0xd30)
[    2.195312] [<c01267fc>] (ubifs_read_master+0x40/0xd30) from [<c011df2c>] (ubifs_mount+0xd8c/0x1560)
[    2.203125] [<c011df2c>] (ubifs_mount+0xd8c/0x1560) from [<c007d450>] (mount_fs+0x10/0xbc)
[    2.210937] [<c007d450>] (mount_fs+0x10/0xbc) from [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0)
[    2.218750] [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0) from [<c00929f0>] (do_mount+0x6e4/0x804)
[    2.226562] [<c00929f0>] (do_mount+0x6e4/0x804) from [<c0092b94>] (SyS_mount+0x84/0xb8)
[    2.234375] [<c0092b94>] (SyS_mount+0x84/0xb8) from [<c03d9d4c>] (mount_block_root+0x114/0x2c0)
[    2.242187] [<c03d9d4c>] (mount_block_root+0x114/0x2c0) from [<c03da0e0>] (prepare_namespace+0x88/0x1a4)
[    2.250000] [<c03da0e0>] (prepare_namespace+0x88/0x1a4) from [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac)
[    2.257812] [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac) from [<c02d7c00>] (kernel_init+0x8/0xe4)
[    2.265625] [<c02d7c00>] (kernel_init+0x8/0xe4) from [<c0009370>] (ret_from_fork+0x14/0x24)
[    2.273437] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.289062] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 4:4096, read only 
126976 bytes, retry
[    2.296875] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.312500] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 4:4096, read only 
126976 bytes, retry
[    2.320312] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.335937] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 4:4096, read only 
126976 bytes, retry
[    2.343750] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.359375] UBI error: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 4:4096, read 126976 bytes
[    2.367187] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.9cdung #20
[    2.375000] [<c000d558>] (unwind_backtrace+0x0/0xe4) from [<c000bca4>] (show_stack+0x10/0x14)
[    2.382812] [<c000bca4>] (show_stack+0x10/0x14) from [<c01de3b8>] (ubi_io_read+0x1d0/0x294)
[    2.390625] [<c01de3b8>] (ubi_io_read+0x1d0/0x294) from [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc)
[    2.398437] [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc) from [<c01db234>] (ubi_leb_read+0xd4/0x128)
[    2.406250] [<c01db234>] (ubi_leb_read+0xd4/0x128) from [<c01202c0>] (ubifs_leb_read+0x24/0x84)
[    2.414062] [<c01202c0>] (ubifs_leb_read+0x24/0x84) from [<c0127828>] (ubifs_start_scan+0x6c/0xe8)
[    2.421875] [<c0127828>] (ubifs_start_scan+0x6c/0xe8) from [<c0127b34>] (ubifs_scan+0x20/0x2d8)
[    2.429687] [<c0127b34>] (ubifs_scan+0x20/0x2d8) from [<c0126864>] (ubifs_read_master+0xa8/0xd30)
[    2.437500] [<c0126864>] (ubifs_read_master+0xa8/0xd30) from [<c011df2c>] (ubifs_mount+0xd8c/0x1560)
[    2.445312] [<c011df2c>] (ubifs_mount+0xd8c/0x1560) from [<c007d450>] (mount_fs+0x10/0xbc)
[    2.453125] [<c007d450>] (mount_fs+0x10/0xbc) from [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0)
[    2.460937] [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0) from [<c00929f0>] (do_mount+0x6e4/0x804)
[    2.468750] [<c00929f0>] (do_mount+0x6e4/0x804) from [<c0092b94>] (SyS_mount+0x84/0xb8)
[    2.476562] [<c0092b94>] (SyS_mount+0x84/0xb8) from [<c03d9d4c>] (mount_block_root+0x114/0x2c0)
[    2.484375] [<c03d9d4c>] (mount_block_root+0x114/0x2c0) from [<c03da0e0>] (prepare_namespace+0x88/0x1a4)
[    2.492187] [<c03da0e0>] (prepare_namespace+0x88/0x1a4) from [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac)
[    2.500000] [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac) from [<c02d7c00>] (kernel_init+0x8/0xe4)
[    2.507812] [<c02d7c00>] (kernel_init+0x8/0xe4) from [<c0009370>] (ret_from_fork+0x14/0x24)
[    2.515625] UBIFS: recovery needed
[    2.523437] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.531250] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.546875] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 5:4096, read only 
126976 bytes, retry
[    2.554687] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.562500] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.578125] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 5:4096, read only 
126976 bytes, retry
[    2.593750] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.593750] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.609375] UBI warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 5:4096, read only 
126976 bytes, retry
[    2.617187] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.617187] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.640625] UBI error: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 5:4096, read 126976 bytes
[    2.648437] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.9cdung #20
[    2.656250] [<c000d558>] (unwind_backtrace+0x0/0xe4) from [<c000bca4>] (show_stack+0x10/0x14)
[    2.664062] [<c000bca4>] (show_stack+0x10/0x14) from [<c01de3b8>] (ubi_io_read+0x1d0/0x294)
[    2.671875] [<c01de3b8>] (ubi_io_read+0x1d0/0x294) from [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc)
[    2.679687] [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc) from [<c01db234>] (ubi_leb_read+0xd4/0x128)
[    2.687500] [<c01db234>] (ubi_leb_read+0xd4/0x128) from [<c01202c0>] (ubifs_leb_read+0x24/0x84)
[    2.695312] [<c01202c0>] (ubifs_leb_read+0x24/0x84) from [<c0127828>] (ubifs_start_scan+0x6c/0xe8)
[    2.703125] [<c0127828>] (ubifs_start_scan+0x6c/0xe8) from [<c0127b34>] (ubifs_scan+0x20/0x2d8)
[    2.710937] [<c0127b34>] (ubifs_scan+0x20/0x2d8) from [<c0128244>] (ubifs_replay_journal+0x190/0x142c)
[    2.718750] [<c0128244>] (ubifs_replay_journal+0x190/0x142c) from [<c011e0c0>] (ubifs_mount+0xf20/0x1560)
[    2.726562] [<c011e0c0>] (ubifs_mount+0xf20/0x1560) from [<c007d450>] (mount_fs+0x10/0xbc)
[    2.734375] [<c007d450>] (mount_fs+0x10/0xbc) from [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0)
[    2.742187] [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0) from [<c00929f0>] (do_mount+0x6e4/0x804)
[    2.750000] [<c00929f0>] (do_mount+0x6e4/0x804) from [<c0092b94>] (SyS_mount+0x84/0xb8)
[    2.757812] [<c0092b94>] (SyS_mount+0x84/0xb8) from [<c03d9d4c>] (mount_block_root+0x114/0x2c0)
[    2.765625] [<c03d9d4c>] (mount_block_root+0x114/0x2c0) from [<c03da0e0>] (prepare_namespace+0x88/0x1a4)
[    2.773437] [<c03da0e0>] (prepare_namespace+0x88/0x1a4) from [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac)
[    2.781250] [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac) from [<c02d7c00>] (kernel_init+0x8/0xe4)
[    2.789062] [<c02d7c00>] (kernel_init+0x8/0xe4) from [<c0009370>] (ret_from_fork+0x14/0x24)
[    2.804687] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.812500] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.820312] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.828125] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.835937] UBI warning: ubi_io_read: error -74 (ECC error) while reading 40960 bytes from PEB 237:90112, read only 
40960 bytes, retry
[    2.843750] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.851562] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.859375] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.859375] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.867187] UBI warning: ubi_io_read: error -74 (ECC error) while reading 40960 bytes from PEB 237:90112, read only 
40960 bytes, retry
[    2.875000] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.882812] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.882812] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.890625] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.898437] UBI warning: ubi_io_read: error -74 (ECC error) while reading 40960 bytes from PEB 237:90112, read only 
40960 bytes, retry
[    2.906250] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.906250] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.914062] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.921875] atmel_nand 40000000.nand: PMECC: Too many errors
[    2.929687] UBI error: ubi_io_read: error -74 (ECC error) while reading 40960 bytes from PEB 237:90112, read 40960 bytes
[    2.937500] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.9cdung #20
[    2.945312] [<c000d558>] (unwind_backtrace+0x0/0xe4) from [<c000bca4>] (show_stack+0x10/0x14)
[    2.953125] [<c000bca4>] (show_stack+0x10/0x14) from [<c01de3b8>] (ubi_io_read+0x1d0/0x294)
[    2.960937] [<c01de3b8>] (ubi_io_read+0x1d0/0x294) from [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc)
[    2.968750] [<c01dbd5c>] (ubi_eba_read_leb+0x2d4/0x3dc) from [<c01db234>] (ubi_leb_read+0xd4/0x128)
[    2.976562] [<c01db234>] (ubi_leb_read+0xd4/0x128) from [<c01202c0>] (ubifs_leb_read+0x24/0x84)
[    2.984375] [<c01202c0>] (ubifs_leb_read+0x24/0x84) from [<c0127828>] (ubifs_start_scan+0x6c/0xe8)
[    2.992187] [<c0127828>] (ubifs_start_scan+0x6c/0xe8) from [<c01379f0>] (ubifs_recover_leb+0x54/0x6ac)
[    3.000000] [<c01379f0>] (ubifs_recover_leb+0x54/0x6ac) from [<c012882c>] (ubifs_replay_journal+0x778/0x142c)
[    3.007812] [<c012882c>] (ubifs_replay_journal+0x778/0x142c) from [<c011e0c0>] (ubifs_mount+0xf20/0x1560)
[    3.015625] [<c011e0c0>] (ubifs_mount+0xf20/0x1560) from [<c007d450>] (mount_fs+0x10/0xbc)
[    3.023437] [<c007d450>] (mount_fs+0x10/0xbc) from [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0)
[    3.031250] [<c0090ce8>] (vfs_kern_mount+0x4c/0xc0) from [<c00929f0>] (do_mount+0x6e4/0x804)
[    3.039062] [<c00929f0>] (do_mount+0x6e4/0x804) from [<c0092b94>] (SyS_mount+0x84/0xb8)
[    3.046875] [<c0092b94>] (SyS_mount+0x84/0xb8) from [<c03d9d4c>] (mount_block_root+0x114/0x2c0)
[    3.054687] [<c03d9d4c>] (mount_block_root+0x114/0x2c0) from [<c03da0e0>] (prepare_namespace+0x88/0x1a4)
[    3.062500] [<c03da0e0>] (prepare_namespace+0x88/0x1a4) from [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac)
[    3.070312] [<c03d9aec>] (kernel_init_freeable+0x168/0x1ac) from [<c02d7c00>] (kernel_init+0x8/0xe4)
[    3.078125] [<c02d7c00>] (kernel_init+0x8/0xe4) from [<c0009370>] (ret_from_fork+0x14/0x24)
[    3.148437] UBIFS: recovery completed
[    3.148437] UBIFS: mounted UBI device 0, volume 0, name "root"
[    3.156250] UBIFS: LEB size: 126976 bytes (124 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    3.164062] UBIFS: FS size: 246968320 bytes (235 MiB, 1945 LEBs), journal size 9023488 bytes (8 MiB, 72 LEBs)
[    3.171875] UBIFS: reserved for root: 0 bytes (0 KiB)
[    3.179687] UBIFS: media format: w4/r0 (latest is w4/r0), UUID 787BCA8A-D4DB-4306-874F-5C478BFC4132, small LPT model
[    3.187500] VFS: Mounted root (ubifs filesystem) on device 0:11.
[    3.195312] Freeing unused kernel memory: 128K (c03d9000 - c03f9000)
init started: BusyBox v1.18.4 (2012-07-19 15:43:05 CEST)
Initializing mdev dynamic device directory ... done
...

Thank for any help.
