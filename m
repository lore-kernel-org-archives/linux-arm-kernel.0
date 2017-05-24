From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 25 May 2017 00:36:46 +0200
Subject: pxa3xx-nand failing to find device on linux-next
In-Reply-To: <ebe9d9bca4754d1ba920295f2fdd1359@svr-chch-ex1.atlnz.lc>
References: <b36366e358904310aee4970b77f57dba@svr-chch-ex1.atlnz.lc>
 <2a79405e219b4c37ba00defbe4a0dfe4@svr-chch-ex1.atlnz.lc>
 <20170524132301.12ad33d8@bbrezillon>
 <20170524132508.420614c7@bbrezillon>
 <ebe9d9bca4754d1ba920295f2fdd1359@svr-chch-ex1.atlnz.lc>
Message-ID: <20170525003646.276516d0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 24 May 2017 22:03:52 +0000,
Chris Packham <Chris.Packham@alliedtelesis.co.nz> a ?crit :

> On 24/05/17 23:25, Boris Brezillon wrote:
> > On Wed, 24 May 2017 13:23:01 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >   
> >> Hi Chris,
> >>
> >> On Wed, 24 May 2017 09:36:56 +0000
> >> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>  
> >>> On 23/05/17 17:27, Chris Packham wrote:  
> >>>> Hi,
> >>>>
> >>>> I'm doing some testing on linux-next and I'm finding that my nand flash
> >>>> has disappeared.
> >>>>
> >>>> pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
> >>>> pxa3xx-nand f10d0000.flash: non-supported command ef
> >>>> pxa3xx-nand f10d0000.flash: non-supported command ee
> >>>> pxa3xx-nand f10d0000.flash: non-supported command ef
> >>>> pxa3xx-nand f10d0000.flash: non-supported command ee
> >>>> On-die ECC forcefully enabled, not supported
> >>>> nand: No NAND device found
> >>>> pxa3xx-nand f10d0000.flash: failed to scan nand at cs 0
> >>>>
> >>>> This was working around 4.11. I'll try to do some more digging tomorrow
> >>>> to narrow down a failure point but I thought I'd send this out now just
> >>>> in case it rings any bells.
> >>>>
> >>>> The board I'm using (DB-88F6820-AMC) is unfortunately out-of tree but it
> >>>> should be pretty close to the armada-388-db. I can make my dts available
> >>>> if it's helpful.  
> >>>
> >>> Still works on 4.12-rc2. Fails on next-20170524.
> >>>
> >>> This appears to be due to commit b566d9c055de ("mtd: nand: add support
> >>> for Micron on-die ECC"). Which based on the description seems intentional.
> >>>
> >>> Since I have access to a hardware platform that has a micron flash with
> >>> ECC forcefully enabled how can I help to get this implemented.  
> >>
> >> Can you try with this patch applied [1]?  
> > 
> > Sorry, wrong patch. Can you try this one [1] instead?
> > 
> > [1]http://code.bulix.org/pkfhmi-135875
> >   
> 
> With the patch above the chip is detected but ubifs is unhappy

Hm, weird. And if you revert my both Thomas patch and mine, what do you
get?

BTW, can you paste the full boot logs, not only the failing part?

Thanks,

Boris

> 
> ubi0: attaching mtd0
> random: fast init done
> random: crng init done
> ubi0: scanning is finished
> ubi0: attached mtd0 (name "pxa3xx_nand-0", size 1024 MiB)
> ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
> ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
> ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
> ubi0: good PEBs: 4088, bad PEBs: 8, corrupted PEBs: 0
> ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
> ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence 
> number: 1508037110
> ubi0: available PEBs: 0, total reserved PEBs: 4088, PEBs reserved for 
> bad PEB handling: 72
> ubi0: background thread "ubi_bgt0d" started, PID 597
> UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 601
> UBIFS (ubi0:0): recovery needed
> UBIFS (ubi0:0): recovery completed
> UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "user"
> UBIFS (ubi0:0): LEB size: 253952 bytes (248 KiB), min./max. I/O unit 
> sizes: 4096 bytes/4096 bytes
> UBIFS (ubi0:0): FS size: 1016315904 bytes (969 MiB, 4002 LEBs), journal 
> size 9404416 bytes (8 MiB, 38 LEBs)
> UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
> UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0), UUID 
> 9D7B5AAA-EFDC-41D4-875B-F9CDB457AE9D, small LPT model
> UBIFS error (ubi0:0 pid 599): ubifs_read_node: bad node type (160 but 
> expected 0)
> UBIFS error (ubi0:0 pid 599): ubifs_read_node: bad node at LEB 10:90344, 
> LEB mapping status 1
> Not a node, first 24 bytes:
> 00000000: 00 00 00 00 31 18 10 06 c3 f6 23 f6 3b 00 00 00 00 00 00 00 a0 
> 00 00 00                          ....1.....#.;...........
> CPU: 1 PID: 599 Comm: mount Not tainted 4.12.0-rc2-next-20170524-at1+ #56
> Hardware name: Marvell Armada 380/385 (Device Tree)
> [<801102dc>] (unwind_backtrace) from [<8010b658>] (show_stack+0x10/0x14)
> [<8010b658>] (show_stack) from [<8031aa0c>] (dump_stack+0x88/0x9c)
> [<8031aa0c>] (dump_stack) from [<802aebb8>] (ubifs_read_node+0x130/0x284)
> [<802aebb8>] (ubifs_read_node) from [<802ca2a4>] 
> (ubifs_tnc_read_node+0x4c/0xd4)
> [<802ca2a4>] (ubifs_tnc_read_node) from [<802b1e60>] 
> (ubifs_tnc_locate+0x1c0/0x1c8)
> [<802b1e60>] (ubifs_tnc_locate) from [<802aa15c>] (ubifs_iget+0x78/0x554)
> [<802aa15c>] (ubifs_iget) from [<802aa90c>] (ubifs_mount+0x2d4/0x1524)
> [<802aa90c>] (ubifs_mount) from [<801dfab4>] (mount_fs+0x14/0xa4)
> [<801dfab4>] (mount_fs) from [<801fa6b4>] (vfs_kern_mount+0x4c/0xf4)
> [<801fa6b4>] (vfs_kern_mount) from [<801fd738>] (do_mount+0x154/0xb50)
> [<801fd738>] (do_mount) from [<801fe49c>] (SyS_mount+0x74/0x9c)
> [<801fe49c>] (SyS_mount) from [<801077a0>] (ret_fast_syscall+0x0/0x3c)
> UBIFS error (ubi0:0 pid 599): ubifs_iget: failed to read inode 1, error -22
> UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
> ubi0: detaching mtd0
> ubi0: mtd0 is detached
> ubi0: attaching mtd0
> ubi0: scanning is finished
> ubi0 error: ubi_read_volume_table: the layout volume was not found
> ubi0 error: ubi_attach_mtd_dev: failed to attach mtd0, error -22
> 
