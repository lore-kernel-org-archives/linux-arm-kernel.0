From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Jul 2017 08:41:03 +0200
Subject: [BUG] v4.12 breaks pxa25x
Message-ID: <87inirsgzk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

In current linux master branch, the lubbock board systematically breaks in early
boot stages. That doesn't happen in v4.12.

>From what I got so far as information, I have :
 - the full kernel message in [1]
 - the breakage is between v4.12 and
   568d135d337d ("Merge branch 'upstream' of
   git://git.linux-mips.org/pub/scm/ralf/upstream-linus")
 - pc = 0xc0019e24
   arm-none-linux-gnueabi-addr2line -i -e vmlinux c0019e24
   =>
   /kernel/work/jenkins/jobs/Linux_Kernel/workspace/arch/arm/mm/proc-xscale.S:215
 - gdb
   (gdb) disass __flush_whole_cache   
   Dump of assembler code for function __flush_whole_cache:
   0xc0019e20 <+0>:	ldr	r1, [pc, #788]	; 0xc001a13c <cpu_xscale_set_pte_ext+92>
   0xc0019e24 <+4>:	ldr	r0, [r1]
   (gdb) disass /m paging_init
1411		local_flush_tlb_all();
1412		flush_cache_all();
   0xc049d270 <+1200>:	bl	0xc0019e18 <xscale_flush_user_cache_all>

1413	
1414		/* Enable asynchronous aborts */
1415		early_abt_enable();
   0xc049d274 <+1204>:	bl	0xc049b78c <early_abt_enable>

I have not yet begun the bissection which will be my next task, so this is a
heads up until I find out which commit is triggering this.

-- 
Robert

[1]
Loading ARM Linux zImage '/mnt/tftp/zImage_jenkins'
commandline:  console=ttyS0,115200 earlycon ip=dhcp root=/dev/nfs nfsroot=/home/none/nfsroot/lubbock,v3,tcp mtdparts=application-flash:2048k at 0(nor0.barebox)ro,256k(nor0.barebox-env),256k(nor0.barebox-logo),256k(nor0.barebox-logo2),5120k(nor0.kernel),-(nor0.root)
arch_number: 89
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-11927-g6bf3d68 (jenkins at belgarath) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)) #4582 Mon Jul 17 08:27:18 CEST 2017
[    0.000000] CPU: XScale-PXA255 [69052d06] revision 6 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Intel DBPXA250 Development Platform (aka Lubbock)
[    0.000000] Ignoring tag cmdline (using the default kernel command line)
[    0.000000] earlycon: early_pxa0 at MMIO 0x40100000 (options '')
[    0.000000] bootconsole [early_pxa0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Run Mode clock: 0.00MHz
[    0.000000] Turbo Mode clock: 0.00MHz
[    0.000000] Memory clock: 0.00MHz
[    0.000000] Unhandled fault: alignment exception (0x003) at 0xc06f82cd
[    0.000000] pgd = c0004000
[    0.000000] [c06f82cd] *pgd=a060040e(bad)
[    0.000000] Internal error: : 3 [#1] ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.12.0-11927-g6bf3d68 #4582
[    0.000000] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
[    0.000000] task: c06f6fd8 task.stack: c06f2000
[    0.000000] PC is at __flush_whole_cache+0x4/0x60
[    0.000000] LR is at paging_init+0x4b4/0x590
[    0.000000] pc : [<c0019e24>]    lr : [<c049d274>]    psr: 600000d3
[    0.000000] sp : c06f3f38  ip : 00000000  fp : c0700000
[    0.000000] r10: a4000000  r9 : c06f82c0  r8 : c0723540
[    0.000000] r7 : fe100000  r6 : fe200000  r5 : c06f82a0  r4 : c0705ef4
[    0.000000] r3 : 00000000  r2 : 00000004  r1 : c06f82cd  r0 : c06f82c0
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.000000] Control: 0000397f  Table: a0004000  DAC: 00000053
[    0.000000] Process swapper (pid: 0, stack limit = 0xc06f2190)
[    0.000000] Stack: (0xc06f3f38 to 0xc06f4000)
[    0.000000] 3f20:                                                       000a0000 000a0700
[    0.000000] 3f40: c04b3b38 c0000000 ffff1000 000a3ffd 00001000 00000007 c04b3b38 c04b3b38
[    0.000000] 3f60: c0008000 c06f3fd4 c04b5a28 c04b5a18 c0706084 c0723538 00000000 c049aaac
[    0.000000] 3f80: 0000006c 0000397f 00000000 c004992c c040b5ad c06f3fb4 c06f3fb4 00000000
[    0.000000] 3fa0: c06f5018 c04b5a24 c06f7e68 00000001 c06f5000 a04b3ad0 00000000 c0497904
[    0.000000] 3fc0: 00000000 00000000 00000000 00000000 00000000 c04b5a28 c07234f4 c06f5018
[    0.000000] 3fe0: c04b5a24 c06f7e68 a0004000 69052d06 a04b3ad0 a0008048 00000000 00000000
[    0.000000] Code: e1a0f00e e3a02004 e3a0c000 e59f1314 (e5910000) 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
