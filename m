From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Wed, 29 Jul 2015 02:37:35 +0000
Subject: bug in identity map for 4KB pages?
Message-ID: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our system has RAM at a high address, and previously required using 48-bit VA
in order to have an idmap that covered all of RAM.

In testing on 4.2-rc4, which now contains support for the increased VA range
of the idmap without using 48-bit VA, I'm finding that things work for
64KB pages, but do not for 4KB pages.

Is there any known limitation here with 4KB pages?  Any ideas?

Kernel crash dump I'm getting is below.

Thanks,
Stuart

------------------------------------------------------------------------------

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 4.2.0-rc4+ (b08248 at right) (gcc version 4.8.3 20131202 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.12 - Linaro GCC 2013.11) ) #180 SMP PREEMPT Tue Jul 28 20:51:47 CDT 2015
CPU: AArch64 Processor [411fd071] revision 1
Detected PIPT I-cache on CPU0
alternatives: enabling workaround for ARM erratum 832075
alternatives: detected feature GIC system register CPU interface
earlycon: Early serial console at MMIO 0x21c0600 (options '115200')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
efi: UEFI not found.
cma: Reserved 16 MiB at 0x00000000fec00000
BUG: not creating mapping for 0x0000008080000000 at 0x0000004000000000 - outside kernel range
Unable to handle kernel paging request at virtual address 435ffff000
pgd = ffffffc000924000
[435ffff000] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 96000045 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.2.0-rc4+ #180
Hardware name: Freescale Layerscape 2085a software Simulator model (DT)
task: ffffffc00088cc70 ti: ffffffc000880000 task.ti: ffffffc000880000
PC is at memset+0x16c/0x1c0
LR is at early_alloc+0x70/0x80
pc : [<ffffffc0003250ac>] lr : [<ffffffc00080de50>] pstate: 400002c5
sp : ffffffc000883ea0
x29: ffffffc000883ea0 x28: 00000000a00000dc
x27: ffffffc000081198 x26: 00000083e0000000
x25: ffffffc000000000 x24: ffffffc00089a000
x23: 0000000000000018 x22: 00000000c0000000
x21: 0000008080000000 x20: 000000435ffff000
x19: 0000000000001000 x18: 0000000000000000
x17: 0000000000000006 x16: 00000083e0000000
x15: 0000000000000018 x14: 0000008080000000
x13: ffffffc000900dd0 x12: 0000000000000578
x11: 0000000600000000 x10: 00000083dffff000
x9 : 0000000000000000 x8 : 000000435ffff000
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000
x3 : 0000000000000004 x2 : 0000000000000fc0
x1 : 0000000000000000 x0 : 000000435ffff000

Process swapper (pid: 0, stack limit = 0xffffffc000880020)
Stack: (0xffffffc000883ea0 to 0xffffffc000884000)
3ea0: 00883ec0 ffffffc0 0080df60 ffffffc0 00900200 ffffffc0 00886000 ffffffc0
3ec0: 00883f20 ffffffc0 0080b7ac ffffffc0 00080000 ffffffc0 fa9fa000 ffffffbf
3ee0: 00000040 00000000 00000000 00000000 00886000 ffffffc0 80000000 00000000
3f00: 80921000 00000000 80924000 00000000 00000040 00000000 fa9fa000 ffffffbf
3f20: 00883fa0 ffffffc0 00809690 ffffffc0 00000001 00000000 0083c120 ffffffc0
3f40: 9fffa000 00000000 00000000 00000000 00886000 ffffffc0 80000000 00000000
3f60: 80921000 00000000 80924000 00000000 00000001 00000000 9fffa000 00000000
3f80: 00000000 00000000 00000000 80000000 00000080 00000000 64667467 ff616b73
3fa0: 00000000 00000000 805d3000 00000000 fff9fa40 00000000 00000e12 00000000
3fc0: 9fffa000 00000000 00000000 00000000 00000000 00000000 80000000 00000000
3fe0: 00000000 00000000 0083c948 ffffffc0 00000000 00000000 00000000 00000000
Call trace:
[<ffffffc0003250ac>] memset+0x16c/0x1c0
[<ffffffc00080df5c>] paging_init+0xd0/0x174
[<ffffffc00080b7a8>] setup_arch+0x28c/0x5c4
[<ffffffc00080968c>] start_kernel+0x94/0x3d0
Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
---[ end trace cb88537fdc8fa200 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!
