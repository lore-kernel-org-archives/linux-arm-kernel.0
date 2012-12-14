From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 14 Dec 2012 16:10:45 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
References: <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 09:42:29PM +0100, Thierry Reding wrote:
> On Thu, Dec 13, 2012 at 11:12:29AM -0700, Stephen Warren wrote:
> > On 12/13/2012 01:23 AM, Thierry Reding wrote:
> > ...
> > > Okay, so I gather that all of the above means that *if* the Tegra
> > > PCIe controller is compliant, it should just work if we remove any
> > > of the special cases. I'm not sure if anybody's actually tested
> > > this or if it just isn't compliant. I'll see if I can find some
> > > time to test this. Obviously it would be a whole lot nicer if the
> > > hardware really was compliant so that we don't have to emulate the
> > > host bridge in software.
> > 
> > A little background here:
> > 
> > IIUC, the Tegra PCIe controller is at least partially derived from
> > previous MCP projects, which I /assume/ must have been fully compliant
> > since they were standard x86 HW. I'm basing the derivation comment on
> > the fact that certain aspects of the HW are the same as previous MCP
> > designs apparently: the configuration space access register fields,
> > and the physical (internal bus) addresses you write into PCIe
> > controller's memory windows.
> > 
> > So, this implies it's entirely possible that the PCIe controller is in
> > fact fully compliant.
> > 
> > That all said, it's quite possible that the parts which made it
> > compliant were stripped out when taking the IP block out of MCP (where
> > the upstream bus was probably HyperTransport?) and dumping it into
> > Tegra, which required different logic to interface to the upstream bus.
> > 
> > Hmmm. I guess all this still means that you just need to try it and
> > see. If you need me to try to track down any answers about the HW, let
> > me know.
> 
> So I tried this today and it breaks horribly. There's some internal
> abort or something. I don't have access to the hardware right now and
> forgot to save the log output, but I can follow up in the morning. Also
> up until the abort, bus 0000:00.0 was identified as the virtual switch
> within the FPGA that's connected to port 0, so that would indicate that
> it isn't in fact compliant and neither root port is reachable via the
> regular mapping.

So here's the output of the crash when removing the special cases that I
promised:

[    2.662948] tegra-pcie 80003000.pcie-controller: PCI host bridge to bus 0000:00
[    2.670271] pci_bus 0000:00: root bus resource [io  0x82000000-0x8200ffff]
[    2.687624] pci_bus 0000:00: root bus resource [mem 0x81000000-0xa7ffffff]
[    2.696002] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xb7ffffff pref]
[    2.708361] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.746728] pci 0000:00:00.0: [1556:4711] type 01 class 0x060400
[    2.754366] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    2.764883] Unhandled fault: imprecise external abort (0x406) at 0x000492f4
[    2.771845] Internal error: : 406 [#1] PREEMPT SMP ARM
[    2.776976] Modules linked in:
[    2.780040] CPU: 0    Not tainted  (3.7.0-next-20121213-00089-gc99c049-dirty #26)
[    2.787522] PC is at tegra_pcie_read_conf+0x50/0xa4
[    2.792407] LR is at pci_bus_read_config_dword+0x68/0x88
[    2.797723] pc : [<c0024974>]    lr : [<c02055e0>]    psr: 80000093
[    2.797723] sp : da8a3d08  ip : e1000000  fp : c06a9064
[    2.809193] r10: 00000000  r9 : da8a3de0  r8 : dab8d800
[    2.814413] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000800
[    2.820931] r3 : 00000004  r2 : 00000000  r1 : e1000800  r0 : ffffffff
[    2.827451] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.834836] Control: 10c5387d  Table: 1a10804a  DAC: 00000015
[    2.840574] Process kworker/u:3 (pid: 55, stack limit = 0xda8a2238)
[    2.846833] Stack: (0xda8a3d08 to 0xda8a4000)
[    2.851191] 3d00:                   dab8d800 da8a3d6c 60000013 00000008 da8a3d2c c020a920
[    2.859362] 3d20: 00000000 00000008 dae99c00 00000000 00000000 da8a3d6c 0000ea60 c0206c10
[    2.867533] 3d40: c06ae404 00000008 00000000 dab8d800 00000008 00000000 00000000 da8a3de0
[    2.875704] 3d60: 00000000 c04a0538 fee00000 47111556 beffffff 00000010 dab8d800 00000008
[    2.883875] 3d80: 00000000 c0207fcc 00000010 dab8d800 da8dd790 00000000 00000000 c0208a5c
[    2.892047] 3da0: dab8d800 dab8e840 da8dd790 00000000 00000000 c002535c dab8e860 dab8e840
[    2.900218] 3dc0: dab8e840 dab8e860 da8a3e3c c001309c 00000000 da82e8d0 da8dd790 00000083
[    2.908389] 3de0: da8a3de0 da8a3de0 db4a3e10 00000000 db4a3e10 da8dd790 00000000 dae0c150
[    2.916560] 3e00: c0690434 dae0c350 0000008c c00264bc 00000000 c059f6f8 da8dd790 c011ce0c
[    2.924732] 3e20: dae0c2b4 00000034 da8dc990 00000001 db4a3e10 da8dd830 da8dd790 00000000
[    2.932902] 3e40: 00000001 da8a3e38 c0025398 c00252e0 00000000 00000000 00000000 c0024ac8
[    2.941074] 3e60: db4a3e10 c0714d08 db4a3e10 c024de98 c06a3ef4 00000000 dae0ee00 c024d654
[    2.949245] 3e80: c06f41cc c024eeb0 c024ee98 c024dc70 00000000 00000000 db4a3e10 c024de98
[    2.957415] 3ea0: 00000000 c024c3e0 db46faf4 db5b9df8 db4a3e10 db4a3e44 00000000 c024dbc4
[    2.965587] 3ec0: db46fa80 db4a3e10 db4a3e10 c06b7ce8 00000000 c024d248 db4a3e10 c06b7c80
[    2.973758] 3ee0: c06b7c64 c024d6b4 c06b7c9c da7a5680 c06f40c0 c003fd8c 00000001 db481ea8
[    2.981930] 3f00: 00000000 00000000 c0051880 c06f41cc da7a5690 da8a2000 c06f40c0 c0691510
[    2.990102] 3f20: 677d46cf c06f4080 da7a5680 c00403d4 c004026c da8a2000 c0686c00 c0686c00
[    2.998273] 3f40: c004026c db481e90 00000000 da7a5680 c004026c 00000000 00000000 00000000
[    3.006443] 3f60: 00000000 c00445cc 6b6b6b6b 00000000 6b6b6b6b da7a5680 00000000 00000000
[    3.014615] 3f80: da8a3f80 da8a3f80 00000000 00000000 da8a3f90 da8a3f90 da8a3fac db481e90
[    3.022785] 3fa0: c0044528 00000000 00000000 c000e418 00000000 00000000 00000000 00000000
[    3.030955] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.039126] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 6b6b6b6b a56b6b6b
[    3.047309] [<c0024974>] (tegra_pcie_read_conf+0x50/0xa4) from [<da8a3d2c>] (0xda8a3d2c)
[    3.055395] Code: e0811000 e08c1001 e5910000 f57ff04f (e3530001) 
[    3.061484] ---[ end trace 218fc1c8f4f9d245 ]---
[    3.066098] note: kworker/u:3[55] exited with preempt_count 1
[    3.071966] tegra-pcie 80003000.pcie-controller: AXI response decoding error, signature: ff000801
[    3.081021] Unable to handle kernel paging request at virtual address ffffffec
[    3.088239] pgd = c0004000
[    3.090945] [ffffffec] *pgd=1ffdd821, *pte=00000000, *ppte=00000000
[    3.097234] Internal error: Oops: 17 [#2] PREEMPT SMP ARM
[    3.102622] Modules linked in:
[    3.105685] CPU: 0    Tainted: G      D       (3.7.0-next-20121213-00089-gc99c049-dirty #26)
[    3.114132] PC is at kthread_data+0x4/0xc
[    3.118142] LR is at wq_worker_sleeping+0xc/0xe4
[    3.122758] pc : [<c0044900>]    lr : [<c0040784>]    psr: 00000193
[    3.122758] sp : da8a3aa8  ip : 00000000  fp : da8a3b5c
[    3.134218] r10: da8a2000  r9 : c0686c40  r8 : da8e4814
[    3.139436] r7 : c0b2bc40  r6 : 00000000  r5 : 00000000  r4 : da8e4890
[    3.145953] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : da8e45c0
[    3.152472] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    3.159684] Control: 10c5387d  Table: 1a10804a  DAC: 00000015
[    3.165421] Process kworker/u:3 (pid: 55, stack limit = 0xda8a2238)
[    3.171679] Stack: (0xda8a3aa8 to 0xda8a4000)
[    3.176036] 3aa0:                   da8e4890 00000000 da8e45c0 c04ab0d4 db450e10 db41c990
[    3.184208] 3ac0: db404900 c00c5694 35040002 00000035 00000002 c0686c40 c0686c40 c0686c40
[    3.192379] 3ae0: c0686c40 c0686c40 00000000 c0685700 c0685700 c00c58cc da8e45c0 dab91280
[    3.200550] 3b00: 00000002 da8e45c0 c0685700 c002d000 da8a3b4c c000e000 c068a040 c0685700
[    3.208722] 3b20: 00000002 c0b2afd8 da8e4814 c0084860 da8e45c0 00000000 da8e4814 00000001
[    3.216893] 3b40: da8e45b8 da8e45c0 da8e45b8 da8e4814 db44ba40 c0024976 da8e4814 c002e23c
[    3.225064] 3b60: 60000193 da8a3b78 da8a2000 00000001 c0024978 da8e485c 00520052 da8a3b78
[    3.233236] 3b80: da8a2000 c06d11d8 da8a2000 c0694ae8 60000193 0000000b 00000001 c0024976
[    3.241407] 3ba0: c0024978 c0011a98 da8a2238 0000000b c06d273e da8a2000 00000000 00000008
[    3.249579] 3bc0: 65000000 31313830 20303030 63383065 31303031 39356520 30303031 35662030
[    3.257751] 3be0: 30666637 28206634 33353365 31303030 c0002029 c04a5c70 c059cb74 00000406
[    3.265922] 3c00: 00000007 c0695668 000492f4 da8a3cc0 da8a3de0 00000000 c06a9064 c0008604
[    3.274093] 3c20: 00000000 c0686c40 00000007 00000000 00030003 000492f4 c0b2bc40 c0686c40
[    3.282264] 3c40: fe000100 00000000 da8a3c5c c004f5bc c0b2bc40 da8a2000 c0686514 00000000
[    3.290435] 3c60: fe000100 00000000 00000000 c0030308 00000000 c00138a4 fe00010c c0690458
[    3.298607] 3c80: da8a3ca0 c0008700 c0205680 c04ac168 60000013 ffffffff da8a3cd4 c000e000
[    3.306778] 3ca0: c0712fb8 60000013 c0024974 80000093 ffffffff da8a3cf4 dab8d800 c000df98
[    3.314949] 3cc0: ffffffff e1000800 00000000 00000004 00000800 00000000 00000000 00000000
[    3.323120] 3ce0: dab8d800 da8a3de0 00000000 c06a9064 e1000000 da8a3d08 c02055e0 c0024974
[    3.331292] 3d00: 80000093 ffffffff dab8d800 da8a3d6c 60000013 00000008 da8a3d2c c020a920
[    3.339463] 3d20: 00000000 00000008 dae99c00 00000000 00000000 da8a3d6c 0000ea60 c0206c10
[    3.347633] 3d40: c06ae404 00000008 00000000 dab8d800 00000008 00000000 00000000 da8a3de0
[    3.355804] 3d60: 00000000 c04a0538 fee00000 47111556 beffffff 00000010 dab8d800 00000008
[    3.363975] 3d80: 00000000 c0207fcc 00000010 dab8d800 da8dd790 00000000 00000000 c0208a5c
[    3.372146] 3da0: dab8d800 dab8e840 da8dd790 00000000 00000000 c002535c dab8e860 dab8e840
[    3.380317] 3dc0: dab8e840 dab8e860 da8a3e3c c001309c 00000000 da82e8d0 da8dd790 00000083
[    3.388488] 3de0: da8a3de0 da8a3de0 db4a3e10 00000000 db4a3e10 da8dd790 00000000 dae0c150
[    3.396660] 3e00: c0690434 dae0c350 0000008c c00264bc 00000000 c059f6f8 da8dd790 c011ce0c
[    3.404830] 3e20: dae0c2b4 00000034 da8dc990 00000001 db4a3e10 da8dd830 da8dd790 00000000
[    3.413001] 3e40: 00000001 da8a3e38 c0025398 c00252e0 00000000 00000000 00000000 c0024ac8
[    3.421173] 3e60: db4a3e10 c0714d08 db4a3e10 c024de98 c06a3ef4 00000000 dae0ee00 c024d654
[    3.429345] 3e80: c06f41cc c024eeb0 c024ee98 c024dc70 00000000 00000000 db4a3e10 c024de98
[    3.437516] 3ea0: 00000000 c024c3e0 db46faf4 db5b9df8 db4a3e10 db4a3e44 00000000 c024dbc4
[    3.445688] 3ec0: db46fa80 db4a3e10 db4a3e10 c06b7ce8 00000000 c024d248 db4a3e10 c06b7c80
[    3.453860] 3ee0: c06b7c64 c024d6b4 c06b7c9c da7a5680 c06f40c0 c003fd8c 00000001 db481ea8
[    3.462030] 3f00: 00000000 00000000 c0051880 c06f41cc da7a5690 da8a2000 c06f40c0 c0691510
[    3.470203] 3f20: 677d46cf c06f4080 da7a5680 c00403d4 c004026c da8a2000 c0686c00 c0686c00
[    3.478373] 3f40: c004026c db481e90 00000000 da7a5680 c004026c 00000000 00000000 00000000
[    3.486544] 3f60: 00000000 c00445cc 6b6b6b6b 00000000 6b6b6b6b da7a5680 00000000 00000000
[    3.494715] 3f80: da8a3f80 da8a3f80 00000001 00010001 da8a3f90 da8a3f90 da8a3fac db481e90
[    3.502886] 3fa0: c0044528 00000000 00000000 c000e418 00000000 00000000 00000000 00000000
[    3.511056] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.519227] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 6b6b6b6b a56b6b6b
[    3.527412] [<c0044900>] (kthread_data+0x4/0xc) from [<c0040784>] (wq_worker_sleeping+0xc/0xe4)
[    3.536114] [<c0040784>] (wq_worker_sleeping+0xc/0xe4) from [<c04ab0d4>] (__schedule+0x4d4/0x6b0)
[    3.544995] [<c04ab0d4>] (__schedule+0x4d4/0x6b0) from [<c002e23c>] (do_exit+0x578/0x834)
[    3.553186] [<c002e23c>] (do_exit+0x578/0x834) from [<c0011a98>] (die+0x1e0/0x398)
[    3.560758] [<c0011a98>] (die+0x1e0/0x398) from [<c0008604>] (do_DataAbort+0x88/0x98)
[    3.568586] [<c0008604>] (do_DataAbort+0x88/0x98) from [<c000df98>] (__dabt_svc+0x38/0x60)
[    3.576836] Exception stack(0xda8a3cc0 to 0xda8a3d08)
[    3.581887] 3cc0: ffffffff e1000800 00000000 00000004 00000800 00000000 00000000 00000000
[    3.590059] 3ce0: dab8d800 da8a3de0 00000000 c06a9064 e1000000 da8a3d08 c02055e0 c0024974
[    3.598223] 3d00: 80000093 ffffffff
[    3.601718] [<c000df98>] (__dabt_svc+0x38/0x60) from [<c0024974>] (tegra_pcie_read_conf+0x50/0xa4)
[    3.610673] [<c0024974>] (tegra_pcie_read_conf+0x50/0xa4) from [<da8a3d2c>] (0xda8a3d2c)
[    3.618758] Code: e513001c e7e00150 e12fff1e e59032a4 (e5130014) 
[    3.624847] ---[ end trace 218fc1c8f4f9d246 ]---
[    3.629456] Fixing recursive fault but reboot is needed!

That doesn't look good, does it?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/2fe0b2fe/attachment.sig>
