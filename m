From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 18 Oct 2016 14:08:38 +0200
Subject: [RFC PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <20161018115115.GF1641@makrotopia.org>
References: <20161018090927.1990-1-narmstrong@baylibre.com>
 <20161018110807.GD1641@makrotopia.org>
 <c377cb60-a359-62c1-dc6b-7b0be8b8e228@baylibre.com>
 <20161018115115.GF1641@makrotopia.org>
Message-ID: <ff8fb0cf-a442-12dc-3365-fd3417ae887c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2016 01:51 PM, Daniel Golle wrote:
> Hi Neil,
> 
> On Tue, Oct 18, 2016 at 01:24:22PM +0200, Neil Armstrong wrote:
>> On 10/18/2016 01:08 PM, Daniel Golle wrote:
>>> Hi Neil,
>>>
>>> great to see progress towards supporting OX820!
>>> The NAND driver I hacked up for Kernel 4.1 and 4.4 in OpenWrt/LEDE
>>> looks very similar, see
>>>
>>> https://git.lede-project.org/?p=lede/dangole/staging.git;a=blob;f=target/linux/oxnas/files/drivers/mtd/nand/oxnas_nand.c;h=f5a142950e32227fee304de731e619278350a91b;hb=refs/heads/oxnas-nand
>>>
>>> To me therefore this looks quite good, just one small question below.
>>
>> Hi Daniel,
>>
>> Yes, I work step by step, I hope to have something booting for 4.10 !
>>
>> Indeed, they look identical except the part_probes[] stuff, are they necessary ?
> 
> Nah, this was dropped around kernel 4.7 from most drivers in favour of
> using the default partition probes (ie. cmdline and dt) afaik.
> 
>>
>> My primary source of code was Ma Haiju's tree and OPenWRT's tree, but would some people like to push some of the openwrt driver upstream somehow ?
> 
> I was planning this somehow, but lack the resources to seriously move
> forward. I've mostly been focussing on cleaning up Ma Haiju's code and
> improving support for the SATA driver (ie. adding support for both
> ports) and re-factoring the stmmac-based Ethernet driver to match the
> current kernel driver's style.
> However, I'm still using platform-specific includes (hardware.h) and
> thus look forward to rebase SATA and Ethernet support on top of your
> tree, as that would unluck ox820 support in multi-v6 instead of having
> a platform-specific kernel.

I made a fork of the SATA driver for the OX810SE who needs the external DMA
to work since it lacks the SATA-sgdma as used in OX820.
But it seems having Ethernet support would be easy, I can rework it and post it.

Yes, It would be great to sync with the upstream tree at some point, please tell
me how my work could be useful.

I only own a PogoPlug v3 to support the basic OX820, but I will lack hardware to
support PCIe and the dual SATA setup at some point.

The next work I plan to do once the basic OX820 boot is merged is to push the USB,
and the PLL support in the clock driver. The SATA and PCIe would be a natural following work.

> 
> Currently there are problems with the NAND driver failing to detect the
> chip on non-PCIe platform like the PogoPlug V3 (non-Pro), MitraStar
> STG-212 and probably other non-PCIe boards which I didn't check yet.
> This magically happened when switching from kernel 4.1 to 4.4, I'm
> bisecting this since, but the problem seems to be hidden somewhere
> between the lines (ie. probe-order-related or such)...
> Did you test your NAND driver on any non-PCIe boards and did it work?

Actually I tested only on non-PCIe, since I only own a PogoPlug v3 (non-pro) and the
probe works perfectly on 4.9-rc1 :
[...]
nand: Could not find valid ONFI parameter page; aborting
nand: device found, Manufacturer ID: 0xad, Chip ID: 0xf1
nand: Hynix NAND 128MiB 3,3V 8-bit
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
Scanning device for bad blocks
Bad eraseblock 511 at 0x000003fe0000
2 ofpart partitions found on MTD device 41000000.nand
Creating 2 MTD partitions on "41000000.nand":
0x000000000000-0x000000e00000 : "boot"
0x000000e00000-0x000008000000 : "ubi"
[...]
# ubiattach -p /dev/mtd1
ubi0: attaching mtd1
ubi0: scanning is finished
ubi0 warning: ubi_eba_init: cannot reserve enough PEBs for bad PEB handling, reserved 9, need 19
ubi0: attached mtd1 (name "ubi", size 114 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
ubi0: VID header offset: 512 (aligned 512), data offset: 2048
ubi0: good PEBs: 911, bad PEBs: 1, corrupted PEBs: 0
ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 2/0, WL threshold: 4096, image sequence number: 0
ubi0: available PEBs: 0, total reserved PEBs: 911, PEBs reserved for bad PEB handling: 9
ubi0: background thread "ubi_bgt0d" started, PID 824
UBI device number 0, total 911 LEBs (117540864 bytes, 112.1 MiB), available 0 LEBs (0 bytes), LEB size 129024 bytes (126.0 KiB)
[...]

> 
> 
> For a more or less complete history of the changes I made since
> branching of Ma Haijun's tree, see
> 
> https://git.lede-project.org/?p=lede/dangole/staging.git;a=history;f=target/linux/oxnas;hb=refs/heads/oxnas-nand
> 
> and for the very early history, prior to the merge into the official
> OpenWrt tree, see
> 
> http://gitorious.org/openwrt-oxnas/openwrt-oxnas.git
> 

Great, thanks for the hints.

I did set up a ML for the upstream work at linux-oxnas at lists.tuxfamily.org and a patchwork interface https://patchwork.kernel.org/project/linux-oxnas/list/ if it can be helpful.

I also idle on #linux-oxnas on freenode...

Neil
