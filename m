From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 1 Mar 2016 10:20:57 -0300
Subject: Booting MX7Solo with 4.5-rc6
In-Reply-To: <DBXPR04MB3841C31AD0E7E04F181EB2EAEBB0@DBXPR04MB384.eurprd04.prod.outlook.com>
References: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
 <AMSPR04MB263126AA78BEE3D8818F80388BA0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <CAOMZO5BX4+AB59SGCUGyk2RKyi706wOxgMp15beyGR9Dg6HWPg@mail.gmail.com>
 <DBXPR04MB3841C31AD0E7E04F181EB2EAEBB0@DBXPR04MB384.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5Bcgn8JOcZ-0X_Pwn1TpFeZo6kC313o=ugivJ9teNE25g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 10:55 PM, Hui Liu <jason.hui.liu@nxp.com> wrote:

> Please remove the usleep_range in the function clk_pllv3_wait_lock.

Yes, if I do like this:

--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -63,7 +63,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
                        break;
                if (time_after(jiffies, timeout))
                        break;
-               usleep_range(50, 500);
+               udelay(500);
        } while (1);

        return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;

Then the warning disappears, but the kernel still hangs:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc6-next-20160229-dirty (fabio at fabio-Latitud6
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructie
[    0.000000] Machine model: Warp i.MX7 Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x9f000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 13 pages/cpu @debbe000 s24512 r8192 d20544 u5328
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pa8
[    0.000000] Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk2p2 p
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 482140K/524288K available (8196K kernel code, 460K rwdat)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0bc906c   (12037 kB)
[    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
[    0.000000]       .data : 0xc0d00000 - 0xc0d731a0   ( 461 kB)
[    0.000000]        .bss : 0xc0d75000 - 0xc157d8d0   (8227 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16

So it is something else that is preventing the kernel to boot on a MX7 Solo.
