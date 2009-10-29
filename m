From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 29 Oct 2009 11:36:50 +0200
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <200910291014.05981.dk-arm-linux@gmx.de>
References: <200910290936.40397.dk-arm-linux@gmx.de>
	<20091029085236.GN14091@buzzloop.caiaq.de>
	<200910291014.05981.dk-arm-linux@gmx.de>
Message-ID: <200910291036.51048.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Maybe helpful additional information:
It makes no difference if I connect a PCI device behind my bridge or not.
The trace is exactly the same.

Dieter

> Am Donnerstag 29 Oktober 2009 09:52:36 schrieb Daniel Mack:
> Hi Daniel,
> 
> 
> > On Thu, Oct 29, 2009 at 10:36:40AM +0200, Dieter Kiermaier wrote:
> > > ## Booting kernel from Legacy Image at 00800000 ...
> > >    Image Name:   Linux-2.6.32-rc5-00081-g964fe08-
> > >    Image Type:   ARM Linux Kernel Image (uncompressed)
> > >    Data Size:    2390056 Bytes =  2.3 MB
> > >    Load Address: 00008000
> > >    Entry Point:  00008000
> > >    Verifying Checksum ... OK
> > >    Loading Kernel Image ... OK
> > > OK
> > > 
> > > Starting kernel ...
> > > 
> > > Uncompressing Linux............................................................................................................................................................ done.
> > 
> > The problem most probably is that your kernel dies before the console is
> > enabled, and hence you're not pointed to the actual problem.
> > 
> > Try the patch below - printk() messages are not buffered but sent out
> > directly to the lowlevel UART functions with this hack. CONFIG_DEBUG_LL
> > must be enabled for this.
> 
> I think your patch leads us to the root but I fear I don't know about PCI / Kernel programming to fix it :(
> Here is my start log:
> 
> Hopefully someone can see what is going wrong?
> 
> Starting kernel ...
> 
> Uncompressing Linux............................................................................................................................................................ done.
> <5>Linux version 2.6.32-rc5-00081-g964fe08-dirty (dieter at dk1-linux) (gcc version 4.2.0 20070413 (prerelease)) #7 PREEMPT Thu Oct 29 10:05:02 CET 2009
> CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Marvell OpenRD Base Board
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 131072
> <7>free_area_init_node: node 0, pgdat c04c5dec, node_mem_map c058d000
> <7>  Normal zone: 1024 pages used for memmap
> <7>  Normal zone: 0 pages reserved
> <7>  Normal zone: 130048 pages, LIFO batch:31
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> <5>Kernel command line: console=ttyS0,115200 mtdparts=nand_mtd:0x400000 at 0x100000(uImage),0x1fb00000 at 0x500000(rootfs) rw root=/dev/nfs rw nfsroot=192.168.2.251:/home/dieter/ArtistaNt
> <6>PID hash table entries: 2048 (order: 1, 8192 bytes)
> <6>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> <6>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> <6>Memory: 256MB 256MB = 512MB total
> <5>Memory: 513920KB available (4420K code, 961K data, 120K init, 0K highmem)
> <6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> <6>Hierarchical RCU implementation.
> <6>NR_IRQS:114
> Console: colour dummy device 80x30
> <6>Calibrating delay loop... <c>1199.30 BogoMIPS (lpj=5996544)
> Mount-cache hash table entries: 512
> <6>CPU: Testing write buffer coherency: ok
> <6>NET: Registered protocol family 16
> <6>Kirkwood: MV88F6281-A0, TCLK=200000000.
> <6>Feroceon L2: Cache support initialised.
> <7>initial MPP regs: 01111111 11113311 33331111 33103333 42222033 22244444 00000022
> <7>  final MPP regs: 01111111 11113311 33331111 33003333 42222033 22244444 00000022
> <7>PCI: Scanning bus 0000:00
> <7>pci 0000:00:00.0: found [11ab:6281] class 000580 header type 00
> <7>pci 0000:00:00.0: reg 10 64bit mmio pref: [0xd0000000-0xd00fffff]
> <7>pci 0000:00:00.0: reg 18 32bit mmio: [0x000000-0x1fffffff]
> <7>pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x44
> <7>pci 0000:00:00.0: calling rc_pci_fixup+0x0/0x40
> <7>pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x19c
> <7>pci 0000:00:00.0: supports D1 D2
> <7>pci 0000:00:01.0: found [11ab:2211] class 000604 header type 01
> <7>pci 0000:00:01.0: calling pci_fixup_ide_bases+0x0/0x44
> <7>pci 0000:00:01.0: calling rc_pci_fixup+0x0/0x40
> <7>pci 0000:00:01.0: calling quirk_resource_alignment+0x0/0x19c
> <7>pci 0000:00:01.0: supports D1 D2
> <6>pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> <6>pci 0000:00:01.0: PME# disabled
> <7>PCI: Fixups for bus 0000:00
> <6>PCI: bus0: Fast back to back transfers disabled
> <7>pci 0000:00:01.0: scanning behind bridge, config 000000, pass 0
> <7>pci 0000:00:01.0: bus configuration invalid, reconfiguring
> <7>pci 0000:00:01.0: scanning behind bridge, config 000000, pass 1
> <7>PCI: Scanning bus 0000:01
> <1>Unhandled fault: external abort on non-linefetch (0x028) at 0xfee418fc
> <0>Internal error: : 28 [#1] PREEMPT
> <0>last sysfs file:
> <d>Modules linked in:
> CPU: 0    Not tainted  (2.6.32-rc5-00081-g964fe08-dirty #7)
> PC is at orion_pcie_rd_conf+0x48/0x98
> LR is at 0x0
> pc : [<c002fc10>]    lr : [<00000000>]    psr: 20000093
> sp : df835e58  ip : 00000004  fp : 00000000
> r10: df835e94  r9 : 00000000  r8 : 00000000
> r7 : 00000000  r6 : 00000004  r5 : df81b800  r4 : 00000000
> r3 : 000018fc  r2 : 00000000  r1 : 80010000  r0 : fee40000
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0005317f  Table: 00004000  DAC: 00000017
> <0>Process swapper (pid: 1, stack limit = 0xdf834270)
> <0>Stack: (0xdf835e58 to 0xdf836000)
> <0>5e40:                                                       20000093 c002f944
> <0>5e60: 00000004 df835e94 0000000f 60000013 df81b800 df835eb4 df81b800 00000000
> <0>5e80: 00000000 c01c1e90 df835e94 00000000 00000000 00000000 df835eb4 00000000
> <0>5ea0: df81b800 c036c7e0 c049f634 df81b800 00000000 00000001 df81b800 00000008
> <0>5ec0: 00000000 df81b800 df81b600 00000000 00000000 c01c3d74 60000013 df81b800
> <0>5ee0: 00000008 00000001 00000001 c036ded8 df830800 df81b800 00000000 00000001
> <0>5f00: df81b600 c036dd48 00000001 00000000 c040abbc c040abbc 00ff0100 00219f00
> <0>5f20: 00000000 df81b600 df830800 00000000 00000001 df81b614 00000000 c04c9f00
> <0>5f40: 00000000 c036df48 df81b600 00000001 c0022198 df834000 00000040 c036dfa8
> <0>5f60: df807b00 c000c638 df807b00 c000a3ac c0009a4c c01f0e94 df8007c0 c00205e0
> <0>5f80: c00209bc 00000000 00000000 00000000 00000000 c04c9f00 c000cbfc c000cc1c
> <0>5fa0: c001a7c8 c00263b8 df835fb6 c006f770 df809ae0 00000001 00000033 00000000
> <0>5fc0: 00000000 c00205e0 c00209bc 00000000 00000000 00000000 00000000 00000000
> <0>5fe0: 00000000 c000888c 00000000 00000000 00000000 c00273dc ffff0000 ffff0000
> [<c002fc10>] (orion_pcie_rd_conf+0x48/0x98) from [<c002f944>] (pcie_rd_conf+0x7c/0xb8)
> [<c002f944>] (pcie_rd_conf+0x7c/0xb8) from [<c01c1e90>] (pci_bus_read_config_dword+0x58/0x98)
> [<c01c1e90>] (pci_bus_read_config_dword+0x58/0x98) from [<c036c7e0>] (pci_scan_single_device+0x3c/0x150)
> [<c036c7e0>] (pci_scan_single_device+0x3c/0x150) from [<c01c3d74>] (pci_scan_slot+0x14/0x7c)
> [<c01c3d74>] (pci_scan_slot+0x14/0x7c) from [<c036ded8>] (pci_scan_child_bus+0x30/0xec)
> [<c036ded8>] (pci_scan_child_bus+0x30/0xec) from [<c036dd48>] (pci_scan_bridge+0x1a8/0x308)
> [<c036dd48>] (pci_scan_bridge+0x1a8/0x308) from [<c036df48>] (pci_scan_child_bus+0xa0/0xec)
> [<c036df48>] (pci_scan_child_bus+0xa0/0xec) from [<c036dfa8>] (pci_scan_bus_parented+0x14/0x20)
> [<c036dfa8>] (pci_scan_bus_parented+0x14/0x20) from [<c000c638>] (kirkwood_pcie_scan_bus+0x1c/0x48)
> [<c000c638>] (kirkwood_pcie_scan_bus+0x1c/0x48) from [<c000a3ac>] (pci_common_init+0x120/0x20c)
> [<c000a3ac>] (pci_common_init+0x120/0x20c) from [<c000cc1c>] (openrd_base_pci_init+0x20/0x34)
> [<c000cc1c>] (openrd_base_pci_init+0x20/0x34) from [<c00263b8>] (do_one_initcall+0x58/0x1a4)
> [<c00263b8>] (do_one_initcall+0x58/0x1a4) from [<c000888c>] (kernel_init+0x90/0x104)
> [<c000888c>] (kernel_init+0x90/0x104) from [<c00273dc>] (kernel_thread_exit+0x0/0x8)
> <0>Code: e59f3054 e7801003 e2833004 e59dc008 (e7902003)
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <6>note: swapper[1] exited with preempt_count 3
> <0>Kernel panic - not syncing: Attempted to kill init!
> [<c002b96c>] (unwind_backtrace+0x0/0xd8) from [<c003b140>] (panic+0x58/0x12c)
> [<c003b140>] (panic+0x58/0x12c) from [<c003e104>] (do_exit+0x64/0x6d0)
> [<c003e104>] (do_exit+0x64/0x6d0) from [<c002a054>] (die+0x174/0x198)
> [<c002a054>] (die+0x174/0x198) from [<c002a11c>] (dump_stack+0x0/0xc)
> 
> 
> 
> > 
> > Daniel
> > 
> > 
> > diff --git a/kernel/printk.c b/kernel/printk.c
> > index b4d97b5..7919751 100644
> > --- a/kernel/printk.c
> > +++ b/kernel/printk.c
> > @@ -686,6 +686,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
> >  	printed_len += vscnprintf(printk_buf + printed_len,
> >  				  sizeof(printk_buf) - printed_len, fmt, args);
> >  
> > +{ extern void printascii(const char *); printascii(printk_buf); }
> >  
> >  	p = printk_buf;
> >  
> > 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
