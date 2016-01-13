From: Michael.Wang@alliedtelesis.co.nz (Michael Wang)
Date: Wed, 13 Jan 2016 04:13:37 +0000
Subject: mtd: pxa3xx_nand: issue with command time out
Message-ID: <5695CEF0.1080100@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I am currently working with Marvell 98DX4251 switchchip with control and
management subsystem SOC based on ARMADA XP, and after upgrading kernel from
3.16.7 to 4.3, the nand controller command have a high chance of timing out.

I have tried adding my own debugs, which result in the problem going away,
and therefore lead me think it is a timing sensitive issue. After going 
through
git commit history, I have tried reverting this patch:

"mtd: pxa3xx-nand: handle PIO in threaded interrupt"
http://lists.infradead.org/pipermail/linux-mtd/2015-February/057913.html

and this allows the nand controller to work properly again.

In addition, since this problem seems to be timing sensitive, I have 
also tried
increasing the CHIP_DELAY_TIMEOUT value, which also got the NAND controller
working properly without commands timing out.

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 740983a..63a53e2 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -39,7 +39,7 @@

  #include <linux/platform_data/mtd-nand-pxa3xx.h>

-#define        CHIP_DELAY_TIMEOUT      msecs_to_jiffies(200)
+#define        CHIP_DELAY_TIMEOUT      msecs_to_jiffies(300)
  #define NAND_STOP_DELAY                msecs_to_jiffies(40)
  #define PAGE_CHUNK_SIZE                (2048)


So I guess my question is whether the CHIP_DELAY_TIMEOUT should be increased
for 98DX4251, or is this likely to be caused by some other issue?


Another thing I have tried is cherry-picking the following new patches 
in 4.4,
but the command time out issue still exist:
234b0ab mtd: pxa3xx_nand: clean up the pxa3xx timings
dc5f40d mtd: pxa3xx_nand: rework flash detection and timing setup
7bfd112 mtd: pxa3xx_nand: add helpers to setup the timings
05b8cd0 mtd: pxa3xx_nand: fix some compile issues on non-ARM arches
6369e7f mtd: pxa3xx_nand: switch to device PM
16cf509 mtd: pxa3xx_nand: don't duplicate MTD suspend/resume
932fbc8 mtd: nand: pxa3xx_nand: show parent device in sysfs
3819b67 mtd: nand: pxa3xx-nand: prevent DFI bus lockup on removal
c36eb77 mtd: nand: pxa3xx-nand: switch to dmaengine
c141e2c mtd: pxa3xx_nand: Remove unused platform-data flash specification


I found this patch, which sounds very relevant to my issue, and is 
within the
update, but the issue still exists on 98DX4251:
"mtd: nand: pxa3xx-nand: fix random command timeouts"
http://lists.infradead.org/pipermail/linux-mtd/2015-August/061107.html


I have copied portion of the kernel boot log below:

pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x38
nand: Micron MT29F8G08ABABAWP
nand: 1024 MiB, SLC, erase size: 512 KiB, page size: 4096, OOB size: 224
pxa3xx-nand f10d0000.nand: ECC strength 16, ECC step size 2048
Bad block table found at page 262016, version 0x01
Bad block table found at page 261888, version 0x01
2 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 2 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x00003f800000 : "user"
0x00003f800000-0x000040000000 : "errlog"

ubi0: attaching mtd0
random: nonblocking pool is initialized
ubi0: scanning is finished
ubi0 warning: print_rsvd_warning: cannot reserve enough PEBs for bad PEB 
handling, reserved 24, need 40
ubi0: attached mtd0 (name "user", size 1016 MiB)
ubi0: PEB size: 524288 bytes (512 KiB), LEB size: 516096 bytes
ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
ubi0: good PEBs: 2032, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 140/75, WL threshold: 4096, image sequence 
number: 581719033
ubi0: available PEBs: 0, total reserved PEBs: 2032, PEBs reserved for 
bad PEB handling: 24
ubi0: background thread "ubi_bgt0d" started, PID 715
UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 720
UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "user"
UBIFS (ubi0:0): LEB size: 516096 bytes (504 KiB), min./max. I/O unit 
sizes: 4096 bytes/4096 bytes
UBIFS (ubi0:0): FS size: 1029095424 bytes (981 MiB, 1994 LEBs), journal 
size 10452992 bytes (9 MiB, 21 LEBs)
UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID 
A12323F1-CA09-47D2-BDD4-50807C99149A, small LPT model
pxa3xx-nand f10d0000.nand: Wait time out!!!
UBIFS error (ubi0:0 pid 724): ubifs_read_node: bad node type (255 but 
expected 1)
pxa3xx-nand f10d0000.nand: handle_data_pio: invalid state 0
------------[ cut here ]------------
kernel BUG at 
/home/maker/jenkins/workspace/1901_linux_upgrade_continuous_build_targets/TARGET/SBx81CFC960/label/i7/lin
ux/drivers/mtd/nand/pxa3xx_nand.c:553!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 434 Comm: irq/28-f10d0000 Not tainted 4.3.0-at1 #1
Hardware name: Marvell Armada 370/XP (Device Tree)
task: bc378900 ti: bd350000 task.ti: bd350000
PC is at pxa3xx_nand_irq_thread+0x40/0x12c
LR is at pxa3xx_nand_irq_thread+0x40/0x12c
pc : [<802f2a28>]    lr : [<802f2a28>]    psr: 60000013
sp : bd351f20  ip : 00000000  fp : 00000000
r10: 00000001  r9 : bc0d1ad8  r8 : 00000000
r7 : 80065a8c  r6 : bd2497c0  r5 : 00000800  r4 : bc249810
r3 : bd350000  r2 : 806a6cf4  r1 : 60000013  r0 : 0000003b
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 3d54006a  DAC: 00000051
Process irq/28-f10d0000 (pid: 434, stack limit = 0xbd350220)
Stack: (0xbd351f20 to 0xbd352000)
1f20: 802f29e8 bd2497c0 bc0d1a80 80065aa8 bd2497e0 bc0d1a80 bd2497c0 
80065878
1f40: 00000000 800659c4 bd249800 00000000 bd2497c0 8006574c 00000000 
00000000
1f60: 00000000 8003be24 e08f3003 00000000 e28330c0 bd2497c0 00000000 
00000000
1f80: bd351f80 bd351f80 00000000 00000000 bd351f90 bd351f90 bd351fac 
bd249800
1fa0: 8003bd4c 00000000 00000000 8000f6b8 00000000 00000000 00000000 
00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 000033fc 
00003414
[<802f2a28>] (pxa3xx_nand_irq_thread) from [<80065aa8>] 
(irq_thread_fn+0x1c/0x40)
[<80065aa8>] (irq_thread_fn) from [<80065878>] (irq_thread+0x12c/0x178)
[<80065878>] (irq_thread) from [<8003be24>] (kthread+0xd8/0xf4)
[<8003be24>] (kthread) from [<8000f6b8>] (ret_from_fork+0x14/0x3c)
Code: e59f20ec e59f10ec e2800010 ebfeefd5 (e7f001f2)
---[ end trace dce614962c53f62c ]---
Unable to handle kernel paging request at virtual address ffffffec
pgd = 80004000
[ffffffec] *pgd=3fffd861, *pte=00000000, *ppte=00000000
Internal error: Oops: 37 [#2] SMP ARM
Modules linked in:
CPU: 0 PID: 434 Comm: irq/28-f10d0000 Tainted: G      D 4.3.0-at1 #1
Hardware name: Marvell Armada 370/XP (Device Tree)
task: bc378900 ti: bd350000 task.ti: bd350000
PC is at kthread_data+0x4/0xc
LR is at irq_thread_dtor+0x28/0xc8
pc : [<8003c404>]    lr : [<800659ec>]    psr: 20000093
sp : bd351da8  ip : bd351f84  fp : 00000001
r10: bd351dd4  r9 : 60000093  r8 : bc378900
r7 : 806d232c  r6 : 00000000  r5 : bc378900  r4 : bc378c94
r3 : 00000000  r2 : bd351da8  r1 : 000039a2  r0 : bc378900
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 3d54006a  DAC: 00000051
Process irq/28-f10d0000 (pid: 434, stack limit = 0xbd350220)
Stack: (0xbd351da8 to 0xbd352000)
1da0:                   800659c4 bc378c94 bc378900 8003a81c 00000000 
bc378900
1dc0: 00000000 80591d94 806a3cdc 80024e64 806d3a38 00000002 806a6cd4 
80063f9c
1de0: 00000000 806d14c4 0000000b 80591d94 806a3cdc bc378900 60000093 
00000000
1e00: 00000000 80012ca8 bd350220 0000000b bd351ed0 802f2a28 e7f001f2 
00000000
1e20: e7100000 80013660 bd350000 800090bc 00000006 6f667461 00000004 
00000000
1e40: 00030001 802f2a28 3a6d726f 64303166 30303030 6e616e2e 00000064 
0000002e
1e60: bffcb278 00000008 00000003 00000020 11e2054f 00000000 00000000 
00000002
1e80: bffceb80 cb550fa0 00000002 bc01f500 1dcd6500 bffceb80 000004a8 
bffceb80
1ea0: 806d2940 bffcecb0 00000000 bd351f04 bc16fa10 00000003 80065a8c 
802f2a2c
1ec0: 00000000 80013a98 00000000 80013660 0000003b 60000013 806a6cf4 
bd350000
1ee0: bc249810 00000800 bd2497c0 80065a8c 00000000 bc0d1ad8 00000001 
00000000
1f00: 00000000 bd351f20 802f2a28 802f2a28 60000013 ffffffff 00000051 
00000000
1f20: 802f29e8 bd2497c0 bc0d1a80 80065aa8 bd2497e0 bc0d1a80 bd2497c0 
80065878
1f40: 00000000 800659c4 bd249800 00000000 bd2497c0 8006574c 00000000 
00000000
1f60: 00000000 8003be24 e08f3003 00000000 e28330c0 bd2497c0 00000000 
00000000
1f80: bd351f80 bd351f80 00000001 00010001 bd351f90 bd351f90 bd351fac 
bd249800
1fa0: 8003bd4c 00000000 00000000 8000f6b8 00000000 00000000 00000000 
00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 000033fc 
00003414
[<8003c404>] (kthread_data) from [<800659ec>] (irq_thread_dtor+0x28/0xc8)
[<800659ec>] (irq_thread_dtor) from [<8003a81c>] (task_work_run+0x88/0xbc)
[<8003a81c>] (task_work_run) from [<80024e64>] (do_exit+0x2fc/0x940)
[<80024e64>] (do_exit) from [<80012ca8>] (die+0x214/0x2e8)
[<80012ca8>] (die) from [<800090bc>] (do_undefinstr+0xb8/0x220)
[<800090bc>] (do_undefinstr) from [<80013660>] (__und_svc_finish+0x0/0x20)
Exception stack(0xbd351ed0 to 0xbd351f18)
1ec0:                                     0000003b 60000013 806a6cf4 
bd350000
1ee0: bc249810 00000800 bd2497c0 80065a8c 00000000 bc0d1ad8 00000001 
00000000
1f00: 00000000 bd351f20 802f2a28 802f2a28 60000013 ffffffff
[<80013660>] (__und_svc_finish) from [<802f2a28>] 
(pxa3xx_nand_irq_thread+0x40/0x12c)
[<802f2a28>] (pxa3xx_nand_irq_thread) from [<80065aa8>] 
(irq_thread_fn+0x1c/0x40)
[<80065aa8>] (irq_thread_fn) from [<80065878>] (irq_thread+0x12c/0x178)
[<80065878>] (irq_thread) from [<8003be24>] (kthread+0xd8/0xf4)
[<8003be24>] (kthread) from [<8000f6b8>] (ret_from_fork+0x14/0x3c)
Code: 012fff1e e241101c eaffffbe e59032a0 (e5130014)
---[ end trace dce614962c53f62d ]---


Any suggestion, help or hint will be very much appreciated.

Thanks,
Michael
