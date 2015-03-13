From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Mar 2015 23:03:12 +0800
Subject: [PATCH 1/2] ARM: imx6: Warn when an old DT is detected
In-Reply-To: <20150313081311.1ebfe8e2@arm.com>
References: <1426149637-22062-1-git-send-email-marc.zyngier@arm.com>
 <1426149637-22062-2-git-send-email-marc.zyngier@arm.com>
 <20150313032139.GN20455@dragon> <20150313081311.1ebfe8e2@arm.com>
Message-ID: <20150313150309.GA20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 08:13:11AM +0000, Marc Zyngier wrote:
> On Fri, 13 Mar 2015 03:21:41 +0000
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > On Thu, Mar 12, 2015 at 08:40:36AM +0000, Marc Zyngier wrote:
> > > Now that the GPC has been converted to be a full blown irqchip
> > > (and not a mole on the side of the GIC), booting a new kernel
> > > with an old DT is likely to result in a rough ride for the user.
> > > 
> > > This patch makes sure such a situation is promptly detected and
> > > the user made aware that a DT update is in order.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > >  arch/arm/mach-imx/pm-imx6.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/pm-imx6.c
> > > b/arch/arm/mach-imx/pm-imx6.c index 6a7c6fc..f03f30f0 100644
> > > --- a/arch/arm/mach-imx/pm-imx6.c
> > > +++ b/arch/arm/mach-imx/pm-imx6.c
> > > @@ -554,11 +554,17 @@ put_node:
> > >  static void __init imx6_pm_common_init(const struct imx6_pm_socdata
> > >  					*socdata)
> > >  {
> > > +	struct device_node *np;
> > >  	struct regmap *gpr;
> > >  	int ret;
> > >  
> > >  	WARN_ON(!ccm_base);
> > >  
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
> > > +	if (WARN_ON(!np ||
> > > +		    !of_find_property(np, "interrupt-controller",
> > > NULL)))
> > > +		pr_warn("Outdated DT detected, suspend/resume will
> > > NOT work\n"); +
> > 
> > Can this be done in imx_gpc_init() instead?
> 
> Unfortunately not, as imx_gpc_init() is only called if the above
> properties are satisfied (that's exactly the case we want to detect: if
> imx_gpc_init is called, we're already in a pretty good shape).

Ah, yes.  I forgot that the way imx_gpc_init() is called has been
changed.

I just gave the patch a go with an old DTB, and found that the kernel
stops booting before we can even see this fat warning (see log below).
It seems detecting at .init_machine time is too late.  I tried to move
the code to the beginning of function imx6q_init_irq(), and found it
works as expected.

Shawn

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.0-rc1-00056-gd8b16e70e2e9 (r65073 at dragon) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #543 SMP Fri Mar 13 22:47:53 CST 2015
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Freescale i.MX6 Quad SABRE Smart Device Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat 80a11d40, node_mem_map be7ef000
[    0.000000]   Normal zone: 2048 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 262144 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 11 pages/cpu @be799000 s12352 r8192 d24512 u45056
[    0.000000] pcpu-alloc: s12352 r8192 d24512 u45056 alloc=11*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
[    0.000000] Kernel command line: console=ttymxc0,115200 debug earlyprintk no_console_suspend root=/dev/nfs ip=dhcp nfsroot=192.168.1.108:/home/r65073/nfs/debian,v3,tcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1004116K/1048576K available (7023K kernel code, 387K rwdata, 2488K rodata, 380K init, 8345K bss, 28076K reserved, 16384K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
[    0.000000]       .text : 0x80008000 - 0x8095201c   (9513 kB)
[    0.000000]       .init : 0x80953000 - 0x809b2000   ( 380 kB)
[    0.000000]       .data : 0x809b2000 - 0x80a12dc0   ( 388 kB)
[    0.000000]        .bss : 0x80a12dc0 - 0x812394b8   (8346 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76070001
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[    0.000000] pgd = 80004000
[    0.000000] [00000008] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.0.0-rc1-00056-gd8b16e70e2e9 #543
[    0.000000] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.000000] task: 809b80b8 ti: 809b2000 task.ti: 809b2000
[    0.000000] PC is at imx_gpc_hwirq_unmask+0x20/0x3c
[    0.000000] LR is at imx6q_set_lpm+0x70/0xfc
[    0.000000] pc : [<80026b28>]    lr : [<800279a4>]    psr: 800001d3
[    0.000000] sp : 809b3eb0  ip : 809b3ec0  fp : 809b3ebc
[    0.000000] r10: c0810078  r9 : 80a138e8  r8 : c0810074
[    0.000000] r7 : 80a138e8  r6 : 809a9328  r5 : 80a143c0  r4 : 00000078
[    0.000000] r3 : 00000008  r2 : 00000000  r1 : 809b3e30  r0 : 00000000
[    0.000000] Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387d  Table: 1000404a  DAC: 00000015
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x809b2210)
[    0.000000] Stack: (0x809b3eb0 to 0x809b4000)
[    0.000000] 3ea0:                                     809b3ed4 809b3ec0 800279a4 80026b14
[    0.000000] 3ec0: 80a138e8 80a138e8 809b3f64 809b3ed8 80969808 80027940 c0810060 00000018
[    0.000000] 3ee0: 00000000 809ba848 00000000 809ba848 0000001a be7d0160 c081003c c0810020
[    0.000000] 3f00: c0810024 c0810028 c0810034 c0810048 c0810060 c0810038 c081002c c0810068
[    0.000000] 3f20: c0810030 c0810014 c081001c c081006c c0810018 c0810080 016e3600 00000001
[    0.000000] 3f40: be7d0160 be002680 80a02214 00000000 80a0210c 80a0221c 809b3fa4 809b3f68
[    0.000000] 3f60: 80991834 80966034 00000008 00000001 00000000 00000000 00000000 00000000
[    0.000000] 3f80: 00000001 ffffffff 80a12dc0 8099fc18 412fc09a befff9c0 809b3fb4 809b3fa8
[    0.000000] 3fa0: 80957624 8099176c 809b3ff4 809b3fb8 80953b9c 80957604 ffffffff ffffffff
[    0.000000] 3fc0: 809536d4 00000000 00000000 8099fc18 80a13054 809b496c 8099fc14 809b9824
[    0.000000] 3fe0: 1000406a 00000000 00000000 809b3ff8 10008074 8095395c 00000000 00000000
[    0.000000] Backtrace: 
[    0.000000] [<80026b08>] (imx_gpc_hwirq_unmask) from [<800279a4>] (imx6q_set_lpm+0x70/0xfc)
[    0.000000] [<80027934>] (imx6q_set_lpm) from [<80969808>] (imx6q_clocks_init+0x37e0/0x37e8)
[    0.000000]  r5:80a138e8 r4:80a138e8
[    0.000000] [<80966028>] (imx6q_clocks_init) from [<80991834>] (of_clk_init+0xd4/0x1a0)
[    0.000000]  r10:80a0221c r9:80a0210c r8:00000000 r7:80a02214 r6:be002680 r5:be7d0160
[    0.000000]  r4:00000001
[    0.000000] [<80991760>] (of_clk_init) from [<80957624>] (time_init+0x2c/0x38)
[    0.000000]  r10:befff9c0 r9:412fc09a r8:8099fc18 r7:80a12dc0 r6:ffffffff r5:00000001
[    0.000000]  r4:00000000
[    0.000000] [<809575f8>] (time_init) from [<80953b9c>] (start_kernel+0x24c/0x3dc)
[    0.000000] [<80953950>] (start_kernel) from [<10008074>] (0x10008074)
[    0.000000]  r10:00000000 r8:1000406a r7:809b9824 r6:8099fc14 r5:809b496c r4:80a13054
[    0.000000] Code: e1a032a0 e2833002 e5922010 e0823103 (e5932000) 
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
