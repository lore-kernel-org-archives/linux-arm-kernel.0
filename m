From: skrishnakar@gmail.com (srikanth krishnakar)
Date: Tue, 31 Dec 2013 20:01:25 +0530
Subject: U-boot [with DT] for R-Car H1 (R8A7779) Linux-3.10 backport from
 renesas-backport.git
In-Reply-To: <CALDxG5g7mXPYLg7upNds1+UzFw3Z3W--xZ-qK6f_wtbqB9qB4Q@mail.gmail.com>
References: <CALDxG5g7mXPYLg7upNds1+UzFw3Z3W--xZ-qK6f_wtbqB9qB4Q@mail.gmail.com>
Message-ID: <CALDxG5jXMuXbyNiujb5=2QGSnnQMgDEy8owdW+L-d-+vQagvzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was able to boot the 3.10 kernel, with appended DTB method, how
ever, the NFS mount crashes on "Systemd" based root filesystem.

Logs:
Systemd based ROOTFS (over NFS):

--------------------------
## Booting kernel from Legacy Image at 60007fc0 ...
   Image Name:   Linux-3.10.25+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3552040 Bytes = 3.4 MiB
   Load Address: 60008000
   Entry Point:  60008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.25+ (root at lenovo) (gcc version 4.8.1
(Sourcery CodeBench 2013.11-32) ) #1 SMP PREEMPT Tue Dec 31 19:34:03
IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: marzen, model: marzen
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c06952c0,
node_mem_map c09fb000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] PERCPU: Embedded 7 pages/cpu @c1204000 s7360 r8192 d13120 u32768
[    0.000000] pcpu-alloc: s7360 r8192 d13120 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260624
[    0.000000] Kernel command line: console=ttySC2,115200
earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs rw ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
...
...
[    7.681640] VFS: Mounted root (nfs filesystem) on device 0:11.
[    7.688476] devtmpfs: mounted
[    7.691406] Freeing unused kernel memory: 164K (c063a000 - c0663000)
[    7.716796] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000004
[    7.716796]
[    7.722656] CPU: 1 PID: 1 Comm: init Not tainted 3.10.25+ #1
[    7.722656] [<c0013f70>] (unwind_backtrace+0x0/0xf4) from
[<c0011904>] (show_stack+0x10/0x14)
[    7.722656] [<c0011904>] (show_stack+0x10/0x14) from [<c049facc>]
(panic+0xa0/0x1ec)
[    7.742187] [<c049facc>] (panic+0xa0/0x1ec) from [<c0020f70>]
(do_exit+0x858/0x8d0)
[    7.742187] [<c0020f70>] (do_exit+0x858/0x8d0) from [<c0021054>]
(do_group_exit+0x40/0xb0)
[    7.742187] [<c0021054>] (do_group_exit+0x40/0xb0) from
[<c002c2b0>] (get_signal_to_deliver+0x210/0x570)
[    7.742187] [<c002c2b0>] (get_signal_to_deliver+0x210/0x570) from
[<c001109c>] (do_signal+0x108/0x430)
[    7.742187] [<c001109c>] (do_signal+0x108/0x430) from [<c001151c>]
(do_work_pending+0x64/0x9c)
[    7.742187] [<c001151c>] (do_work_pending+0x64/0x9c) from
[<c000e940>] (work_pending+0xc/0x20)
[    7.799804] CPU0: stopping
[    7.799804] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.25+ #1
[    7.799804] [<c0013f70>] (unwind_backtrace+0x0/0xf4) from
[<c0011904>] (show_stack+0x10/0x14)
[    7.799804] [<c0011904>] (show_stack+0x10/0x14) from [<c0012e58>]
(handle_IPI+0x108/0x118)
[    7.799804] [<c0012e58>] (handle_IPI+0x108/0x118) from [<c0009378>]
(gic_handle_irq+0x58/0x5c)
[    7.799804] [<c0009378>] (gic_handle_irq+0x58/0x5c) from
[<c04a6ae0>] (__irq_svc+0x40/0x70)
[    7.799804] Exception stack(0xc0665f68 to 0xc0665fb0)
[    7.799804] 5f60:                   00000000 00000000 0000bc08
00000000 c066c54c c04ac12c
[    7.799804] 5f80: c0664000 c0695e89 c0664000 c0695e89 c0664000
c0664000 00000020 c0665fb0
[    7.799804] 5fa0: c000f4c4 c000f4c8 60000113 ffffffff
[    7.799804] [<c04a6ae0>] (__irq_svc+0x40/0x70) from [<c000f4c8>]
(arch_cpu_idle+0x2c/0x30)
[    7.799804] [<c000f4c8>] (arch_cpu_idle+0x2c/0x30) from
[<c00559f8>] (cpu_startup_entry+0x104/0x150)
[    7.799804] [<c00559f8>] (cpu_startup_entry+0x104/0x150) from
[<c063aa94>] (start_kernel+0x31c/0x328)
[    7.799804] CPU2: stopping
[    7.799804] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.10.25+ #1
[    7.799804] [<c0013f70>] (unwind_backtrace+0x0/0xf4) from
[<c0011904>] (show_stack+0x10/0x14)
[    7.799804] [<c0011904>] (show_stack+0x10/0x14) from [<c0012e58>]
(handle_IPI+0x108/0x118)
[    7.799804] [<c0012e58>] (handle_IPI+0x108/0x118) from [<c0009378>]
(gic_handle_irq+0x58/0x5c)
[    7.799804] [<c0009378>] (gic_handle_irq+0x58/0x5c) from
[<c04a6ae0>] (__irq_svc+0x40/0x70)
[    7.799804] Exception stack(0xef083f98 to 0xef083fe0)
[    7.799804] 3f80:
    00000002 00000000
[    7.799804] 3fa0: 0000ed24 00000000 c066c54c c04ac12c ef082000
c0695e89 ef082000 c0695e89
[    7.799804] 3fc0: ef082000 ef082000 00000000 ef083fe0 c000f4c4
c000f4c8 60000113 ffffffff
[    7.799804] [<c04a6ae0>] (__irq_svc+0x40/0x70) from [<c000f4c8>]
(arch_cpu_idle+0x2c/0x30)
[    7.799804] [<c000f4c8>] (arch_cpu_idle+0x2c/0x30) from
[<c00559f8>] (cpu_startup_entry+0x104/0x150)
[    7.799804] [<c00559f8>] (cpu_startup_entry+0x104/0x150) from
[<60499244>] (0x60499244)
[    7.799804] CPU3: stopping
[    7.799804] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.10.25+ #1
[    7.799804] [<c0013f70>] (unwind_backtrace+0x0/0xf4) from
[<c0011904>] (show_stack+0x10/0x14)
[    7.799804] [<c0011904>] (show_stack+0x10/0x14) from [<c0012e58>]
(handle_IPI+0x108/0x118)
[    7.799804] [<c0012e58>] (handle_IPI+0x108/0x118) from [<c0009378>]
(gic_handle_irq+0x58/0x5c)
[    7.799804] [<c0009378>] (gic_handle_irq+0x58/0x5c) from
[<c04a6ae0>] (__irq_svc+0x40/0x70)
[    7.799804] Exception stack(0xef085f98 to 0xef085fe0)
[    7.799804] 5f80:
    00000003 00000000
[    7.799804] 5fa0: 0000c9c8 00000000 c066c54c c04ac12c ef084000
c0695e89 ef084000 c0695e89
[    7.799804] 5fc0: ef084000 ef084000 00000000 ef085fe0 c000f4c4
c000f4c8 60000113 ffffffff
[    7.799804] [<c04a6ae0>] (__irq_svc+0x40/0x70) from [<c000f4c8>]
(arch_cpu_idle+0x2c/0x30)
[    7.799804] [<c000f4c8>] (arch_cpu_idle+0x2c/0x30) from
[<c00559f8>] (cpu_startup_entry+0x104/0x150)
[    7.799804] [<c00559f8>] (cpu_startup_entry+0x104/0x150) from
[<60499244>] (0x60499244)
[    7.799804] drm_kms_helper: panic occurred, switching back to text console

--------------------------


SYSVINIT ROOTFS: (Mounts fine)
------------------
# dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.25+ (root at lenovo) (gcc version 4.8.1
(Sourcery CodeBench 2013.11-32) ) #1 SMP PREEMPT Tue Dec 31 19:34:03
IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: marzen, model: marzen
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c06952c0,
node_mem_map c09fb000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 67584 pages, LIFO batch:15
[    0.000000] PERCPU: Embedded 7 pages/cpu @c1204000 s7360 r8192 d13120 u32768
...
...
[    1.170898] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    1.179687] IMPX3: Power-off latency exceeded, new value 5888 ns
[    1.185546] VDP1: Power-off latency exceeded, new value 6528 ns
[    1.191406] SGX: Power-off latency exceeded, new value 19520 ns
[    1.192382] smsc911x smsc911x eth0: SMSC911x/921x identified at
0xf0292000, IRQ: 2001
[    1.205078] SH4A: Power-off latency exceeded, new value 6464 ns
[    1.265625] ata1: link resume succeeded after 1 retries
[    1.373046] ata1: SATA link down (SStatus 0 SControl 300)
[    1.205078] Sending DHCP requests ..., OK
[    8.414062] IP-Config: Got DHCP answer from 134.86.60.97, my
address is 134.86.60.116
[    8.421875] IP-Config: Complete:
[    8.424804]      device=eth0, hwaddr=2e:09:0a:00:3d:29,
ipaddr=134.86.60.116, mask=255.255.255.0, gw=134.86.60.97
[    8.435546]      host=134.86.60.116, domain=inp.mentorg.com,
nis-domain=(none)
[    8.442382]      bootserver=134.86.60.97, rootserver=134.86.60.97,
rootpath=/opt/ROOTFS/marzen
[    8.451171]      nameserver0=134.86.60.97
[    8.458984] VFS: Mounted root (nfs filesystem) on device 0:11.
[    8.465820] devtmpfs: mounted
[    8.468750] Freeing unused kernel memory: 164K (c063a000 - c0663000)
[    8.809570] udevd[75]: starting version 181
...
...
[    6.791992] VFS: Mounted root (nfs filesystem) on device 0:11.
[    6.797851] devtmpfs: mounted
[    6.801757] Freeing unused kernel memory: 164K (c063a000 - c0663000)
Starting logging: OK
Populating  using udev: [    7.110351] udevd[75]: starting version 181
done
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists

Welcome to Renesas R-Car H1
rcar login:
------------------


Can anyone let me know, whether I need to modify the kernel config to
support systemd ? I am aware of systemd kernel config dependencies and
IMX6 Linux-3.10 boots and mounts fines on same "systemd" based rootfs,
but not the R-Car H1.

Thanks,
Srikanth

On Mon, Dec 30, 2013 at 3:10 PM, srikanth krishnakar
<skrishnakar@gmail.com> wrote:
> Hello All,
>
> I am trying to boot the renesas-backport
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/
>  kernel from branch backport/3.10.18/for-ltsi. Here the machine
> supports DT boot method, where as I am unable to find corresponding
> u-boot for R-Car H1 (Mazen) board, to boot with DTB (LIBFDT) support.
>
> Board file: https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/tree/arch/arm/mach-shmobile/board-marzen.c?h=backport/3.10.18/for-ltsi
>
> However I found u-boot-sh :
> http://git.denx.de/?p=u-boot/u-boot-sh.git;a=summary, here I don't
> find any marzen specific config file or related files for RA87779
> machine. All I found is from machine R8A7790. They both have two
> different machine files in backported kernel.
>
> Can anyone please let me know the actual u-boot and machine name which
> supports DT enabled boot method for R-Car H1 or R8A7779 machine ?
>
> Appreciate your replies.
>
>
> Regards
> Srikanth



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************
