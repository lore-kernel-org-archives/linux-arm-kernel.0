From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Feb 2016 15:39:12 -0800
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <56B077D4.3030902@gmail.com>
References: <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
 <20160121091437.GT7192@pali> <56B077D4.3030902@gmail.com>
Message-ID: <20160202233911.GB19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160202 01:34]:
> On 21.01.2016 11:14, Pali Roh?r wrote:
> >On Saturday 09 January 2016 02:23:26 Ivaylo Dimitrov wrote:
> >>The key word here is "sometimes". i.e sometimes it hapens on normal reboot,
> >>sometimes it happens on oops.
> >
> >So where is problem? In omap-gpmc? mtd? onenand? or ubifs? Or in
> >different component? Do we know at least this?
> >
> 
> I think I made some progress on the issue, it seems I have to have *both*
> e7b11dc7b77bfce0a351230a5feeadc1d0bba997
> (e7b11dc7b77bfce0a351230a5feeadc1d0bba997) reverted *and*
> HWMOD_INIT_NO_RESET restored in omap3xxx_gpmc_hwmod flags to have working
> onenand.

That is strange. This is what I get with omap2plus_defconfig and
omap-for-v4.5/fixes-rc1 after flashing the rootfs and booting kernel
like you suggested on irc:

# dmesg | grep -i -e ubi -e onenand
[    2.502899] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x01000000, virtual base d0940000, freq 83 MHz
[    2.514373] OneNAND Manufacturer: Numonyx (0x20)
[    2.519287] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    2.524444] OneNAND version = 0x0031
[    2.671966] 6 ofpart partitions found on MTD device omap2-onenand
[    2.678436] Creating 6 MTD partitions on "omap2-onenand":
[    3.414764] ubi0: attaching mtd5
[    3.668212] ubi0: scanning is finished
[    3.716552] ubi0: attached mtd5 (name "rootfs", size 251 MiB)
[    3.722839] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[    3.730194] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[    3.737304] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[    3.744537] ubi0: good PEBs: 2010, bad PEBs: 0, corrupted PEBs: 0
[    3.751037] ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
[    3.758697] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence number: 0
[    3.767578] ubi0: available PEBs: 0, total reserved PEBs: 2010, PEBs reserved for bad PEB handling: 40
[    3.923980] ubi0: background thread "ubi_bgt0d" started, PID 85
[    3.980529] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 87
[    3.996337] UBIFS (ubi0:0): recovery needed
[    4.079925] UBIFS (ubi0:0): recovery completed
[    4.085876] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "rootfs"
[    4.093780] UBIFS (ubi0:0): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    4.104339] UBIFS (ubi0:0): FS size: 252241920 bytes (240 MiB, 1955 LEBs), journal size 9033728 bytes (8 MiB, 71 LEBs)
[    4.115722] UBIFS (ubi0:0): reserved for root: 4190434 bytes (4092 KiB)
[    4.122772] UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID 8F30A88A-F605-4291-9927-00CF3A2AE119, small LPT model
[    4.136077] VFS: Mounted root (ubifs filesystem) on device 0:15.

I copied over the modules to this rootfs too :) But in general onenand
seems to behave for me.

> Tony, shall I hardcode GPMC_CS_CONFIG4 OEONTIME to be the same as NOLO's or
> it does not make sense?

Not sure what is still wrong. But yeah some borderline GPMC timing
differences could affect it.

Regards,

Tony
