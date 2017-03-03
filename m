From: slash.tmp@free.fr (Mason)
Date: Fri, 3 Mar 2017 18:15:29 +0100
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
Message-ID: <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 18:10, Mason wrote:
> On 03/03/2017 17:18, Mason wrote:
>> Hello,
>>
>> I'm seeing this panic randomly at boot-time, so I want to throw
>> it out there in case someone recognizes the issue off the top of
>> their head.
>>
>> I'm on Linux 4.9, using a USB3 PCIe card. I'm actively working on
>> the PCIe support, so I may be responsible for the crash by virtue
>> of something I did or didn't do (e.g. I haven't set up the IRQs
>> correctly, but I didn't think it would crash the system).
>>
>> [    0.987520] OF: PCI: host bridge /soc/pcie at 50000000 ranges:
>> [    0.993236] OF: PCI:   No bus range found for /soc/pcie at 50000000, using [bus 00-ff]
>> [    1.001034] OF: PCI: Parsing ranges property...
>> [    1.005693] OF: PCI:   MEM 0x90000000..0x9fffffff -> 0x90000000
>> [    1.014791] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
>> [    1.028570] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
>> [    1.035597] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    1.041212] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
>> [    1.048219] pci_bus 0000:00: scanning bus
>> [    1.052376] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
>> [    1.058529] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
>> [    1.065119] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>> [    1.072068] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    1.078415] pci 0000:00:00.0: supports D1 D2
>> [    1.082803] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
>> [    1.088937] pci 0000:00:00.0: PME# disabled
>> [    1.093445] pci_bus 0000:00: fixups for bus
>> [    1.097753] PCI: bus0: Fast back to back transfers disabled
>> [    1.103453] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
>> [    1.110286] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    1.118433] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>> [    1.125385] pci_bus 0000:01: scanning bus
>> [    1.129557] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
>> [    1.135727] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>> [    1.142730] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    1.149150] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [    1.155375] pci 0000:01:00.0: PME# disabled
>> [    1.159976] pci_bus 0000:01: fixups for bus
>> [    1.164305] PCI: bus1: Fast back to back transfers disabled
>> [    1.170002] pci_bus 0000:01: bus scan returning with max=01
>> [    1.175701] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> [    1.182447] pci_bus 0000:00: bus scan returning with max=01
>> [    1.188147] pci 0000:00:00.0: fixup irq: got 0
>> [    1.192707] pci 0000:00:00.0: assigning IRQ 00
>> [    1.197294] pci 0000:01:00.0: fixup irq: got 20
>> [    1.201945] pci 0000:01:00.0: assigning IRQ 20
>> [    1.206533] pci 0000:00:00.0: BAR 0: assigned [mem 0x90000000-0x90ffffff 64bit]
>> [    1.213984] pci 0000:00:00.0: BAR 8: assigned [mem 0x91000000-0x910fffff]
>> [    1.220908] pci 0000:01:00.0: BAR 0: assigned [mem 0x91000000-0x91001fff 64bit]
>> [    1.228363] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    1.233449] pci 0000:00:00.0:   bridge window [mem 0x91000000-0x910fffff]
>> [    1.240419] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
>> [    1.246648] pcieport 0000:00:00.0: enabling bus mastering
>> [    1.252321] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
>> [    1.259077] pci 0000:01:00.0: enabling device (0140 -> 0142)
>> [    1.264893] Unable to handle kernel paging request at virtual address d08664f4
>> [    1.272248] pgd = c0004000
>> [    1.275060] [d08664f4] *pgd=8f804811, *pte=00000000, *ppte=00000000
>> [    1.281476] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>> [    1.286897] Modules linked in:
>> [    1.290053] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #151
>> [    1.296696] Hardware name: Sigma Tango DT
>> [    1.300808] task: cf82c9c0 task.stack: cf838000
>> [    1.305446] PC is at quirk_usb_early_handoff+0x3e8/0x790
>> [    1.310873] LR is at ioremap_page_range+0xf8/0x1a8
>> [    1.315771] pc : [<c039fe8c>]    lr : [<c02d0a10>]    psr: 000e0013
>> [    1.315771] sp : cf839d78  ip : 00000000  fp : cf839e38
>> [    1.327482] r10: c10248a0  r9 : 00000000  r8 : d08664f4
>> [    1.332816] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb5f800
>> [    1.339460] r3 : 000184f4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
>> [    1.346105] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [    1.353361] Control: 10c5387d  Table: 8fa9c04a  DAC: 00000051
>> [    1.359218] Process swapper/0 (pid: 1, stack limit = 0xcf838210)
>> [    1.365339] Stack: (0xcf839d78 to 0xcf83a000)
>> [    1.369800] 9d60:                                                       c058f578 c058b180
>> [    1.378107] 9d80: cfb55240 cf839d98 c0350218 c05adccc cfb5f800 c05adcdc cf838000 00000000
>> [    1.386413] 9da0: 00000000 c10248a0 cf839e38 c030bfa4 cf923b80 c034e69c cf867270 00000000
>> [    1.394719] 9dc0: cfb5f800 cf9ef414 cf9ef400 cf839e30 cf923b80 00000000 cf906010 c02fa484
>> [    1.403025] 9de0: cfb5f800 cf9ef414 cf9ef400 c02fa538 cfb5fc00 cf9ef814 cf9ef800 c02fa56c
>> [    1.411330] 9e00: cf9ef80c cf9ef80c cf9ef800 c031387c cf839e30 cfaa39b0 c05178c8 c10101d8
>> [    1.419636] 9e20: cf881780 00000000 cf906000 c058cd2c cf839e30 cf839e30 50000000 5fffffff
>> [    1.427942] 9e40: cfdf7764 00000200 00000000 00000000 00000000 00000000 c1057de8 cf906010
>> [    1.436248] 9e60: c1010208 cf906044 c1010208 00000000 00000007 00000000 cfffcec0 c0351624
>> [    1.444553] 9e80: c1056fb0 cf906010 cf906044 c03500c0 cf906010 c1010208 cf906044 c10177d0
>> [    1.452859] 9ea0: 00000073 c0350214 00000000 c1010208 c0350150 c034e5e8 cf80545c cf8a60b4
>> [    1.461165] 9ec0: c1010208 cf9b8a00 00000000 c034f72c c058cd84 c0616a64 c0633cb0 c1010208
>> [    1.469471] 9ee0: c0616a64 c0633cb0 c0628834 c0350770 ffffe000 c0616a64 c0633cb0 c0101834
>> [    1.477776] 9f00: c104a354 c100a5c8 00000000 c0220830 00000000 cf87cf00 00000000 c1009370
>> [    1.486082] 9f20: cfffceee c050fa08 00000073 c0132aec c059a1c4 c05da4a4 00000000 00000006
>> [    1.494388] 9f40: 00000006 c05723fc c1009358 c1024880 c1024880 c1024880 c0633cb0 c0628834
>> [    1.502693] 9f60: 00000073 00000007 c062883c c0600db4 00000006 00000006 00000000 c06005ac
>> [    1.510999] 9f80: 1113a9b3 00000000 c049fafc 00000000 00000000 00000000 00000000 00000000
>> [    1.519304] 9fa0: 00000000 c049fb04 00000000 c01077b8 00000000 00000000 00000000 00000000
>> [    1.527609] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    1.535914] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 2338eece a019c832
>> [    1.544236] [<c039fe8c>] (quirk_usb_early_handoff) from [<c030bfa4>] (pci_do_fixups+0xc8/0x158)
>> [    1.553077] [<c030bfa4>] (pci_do_fixups) from [<c02fa484>] (pci_bus_add_device+0x18/0x90)
>> [    1.561386] [<c02fa484>] (pci_bus_add_device) from [<c02fa538>] (pci_bus_add_devices+0x3c/0x80)
>> [    1.570218] [<c02fa538>] (pci_bus_add_devices) from [<c02fa56c>] (pci_bus_add_devices+0x70/0x80)
>> [    1.579140] [<c02fa56c>] (pci_bus_add_devices) from [<c031387c>] (pci_host_common_probe+0xfc/0x324)
>> [    1.588328] [<c031387c>] (pci_host_common_probe) from [<c0351624>] (platform_drv_probe+0x34/0x7c)
>> [    1.597337] [<c0351624>] (platform_drv_probe) from [<c03500c0>] (really_probe+0x1c4/0x254)
>> [    1.605733] [<c03500c0>] (really_probe) from [<c0350214>] (__driver_attach+0xc4/0xc8)
>> [    1.613691] [<c0350214>] (__driver_attach) from [<c034e5e8>] (bus_for_each_dev+0x68/0x9c)
>> [    1.621998] [<c034e5e8>] (bus_for_each_dev) from [<c034f72c>] (bus_add_driver+0x1a0/0x218)
>> [    1.630393] [<c034f72c>] (bus_add_driver) from [<c0350770>] (driver_register+0x78/0xf8)
>> [    1.638527] [<c0350770>] (driver_register) from [<c0101834>] (do_one_initcall+0x44/0x174)
>> [    1.646845] [<c0101834>] (do_one_initcall) from [<c0600db4>] (kernel_init_freeable+0x154/0x1e4)
>> [    1.655678] [<c0600db4>] (kernel_init_freeable) from [<c049fb04>] (kernel_init+0x8/0x10c)
>> [    1.663990] [<c049fb04>] (kernel_init) from [<c01077b8>] (ret_from_fork+0x14/0x3c)
>> [    1.671686] Code: e3500000 e0833100 0affffcb e0878003 (e5982000) 
>> [    1.677929] ---[ end trace f034f5427be1ec2c ]---
>> [    1.682673] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [    1.682673] 
>> [    1.692032] CPU1: stopping
>> [    1.694837] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.9.7-1-rc2 #151
>> [    1.702703] Hardware name: Sigma Tango DT
>> [    1.706831] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
>> [    1.714703] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
>> [    1.722051] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
>> [    1.729571] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
>> [    1.737266] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
>> [    1.744869] Exception stack(0xcf859f98 to 0xcf859fe0)
>> [    1.750028] 9f80:                                                       00000001 00000000
>> [    1.758334] 9fa0: 000017b2 c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
>> [    1.766640] 9fc0: 00000000 00000000 00000001 cf859fe8 c0108220 c0108224 60000013 ffffffff
>> [    1.774946] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
>> [    1.782472] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
>> [    1.790782] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
>> [    1.797867] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Had another one, with a different faulting address:
> 
> [    0.986295] OF: PCI: host bridge /soc/pcie at 50000000 ranges:
> [    0.992004] OF: PCI:   No bus range found for /soc/pcie at 50000000, using [bus 00-ff]
> [    0.999798] OF: PCI: Parsing ranges property...
> [    1.004457] OF: PCI:   MEM 0x90000000..0x9fffffff -> 0x90000000
> [    1.013472] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
> [    1.022605] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
> [    1.029638] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.035250] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
> [    1.042257] pci_bus 0000:00: scanning bus
> [    1.046407] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
> [    1.052560] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
> [    1.059143] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
> [    1.066086] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
> [    1.072428] pci 0000:00:00.0: supports D1 D2
> [    1.076815] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
> [    1.082950] pci 0000:00:00.0: PME# disabled
> [    1.087453] pci_bus 0000:00: fixups for bus
> [    1.091762] PCI: bus0: Fast back to back transfers disabled
> [    1.097463] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
> [    1.104323] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    1.112470] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> [    1.119423] pci_bus 0000:01: scanning bus
> [    1.123593] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
> [    1.129770] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> [    1.136775] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
> [    1.143197] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    1.149421] pci 0000:01:00.0: PME# disabled
> [    1.154024] pci_bus 0000:01: fixups for bus
> [    1.158332] PCI: bus1: Fast back to back transfers disabled
> [    1.164030] pci_bus 0000:01: bus scan returning with max=01
> [    1.169728] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    1.176476] pci_bus 0000:00: bus scan returning with max=01
> [    1.182175] pci 0000:00:00.0: fixup irq: got 0
> [    1.186736] pci 0000:00:00.0: assigning IRQ 00
> [    1.191322] pci 0000:01:00.0: fixup irq: got 20
> [    1.195971] pci 0000:01:00.0: assigning IRQ 20
> [    1.200556] pci 0000:00:00.0: BAR 0: assigned [mem 0x90000000-0x90ffffff 64bit]
> [    1.208009] pci 0000:00:00.0: BAR 8: assigned [mem 0x91000000-0x910fffff]
> [    1.214932] pci 0000:01:00.0: BAR 0: assigned [mem 0x91000000-0x91001fff 64bit]
> [    1.222387] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    1.227473] pci 0000:00:00.0:   bridge window [mem 0x91000000-0x910fffff]
> [    1.234445] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
> [    1.240676] pcieport 0000:00:00.0: enabling bus mastering
> [    1.246350] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
> [    1.253108] pci 0000:01:00.0: enabling device (0140 -> 0142)
> [    1.258926] Unable to handle kernel paging request at virtual address d0863f70
> [    1.266284] pgd = c0004000
> [    1.269097] [d0863f70] *pgd=8f804811, *pte=00000000, *ppte=00000000
> [    1.275512] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> [    1.280933] Modules linked in:
> [    1.284089] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
> [    1.290732] Hardware name: Sigma Tango DT
> [    1.294843] task: cf82c9c0 task.stack: cf838000
> [    1.299482] PC is at quirk_usb_early_handoff+0x3e8/0x790
> [    1.304907] LR is at ioremap_page_range+0xf8/0x1a8
> [    1.309806] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
> [    1.309806] sp : cf839d78  ip : 00000000  fp : cf839e38
> [    1.321517] r10: c10248a0  r9 : 00000000  r8 : d0863f70
> [    1.326851] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb52800
> [    1.333495] r3 : 00015f70  r2 : 00000000  r1 : 91001e13  r0 : d084e000
> [    1.340140] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.347395] Control: 10c5387d  Table: 8faa404a  DAC: 00000051
> [    1.353253] Process swapper/0 (pid: 1, stack limit = 0xcf838210)
> [    1.359373] Stack: (0xcf839d78 to 0xcf83a000)
> [    1.363834] 9d60:                                                       c058f56c c058b174
> [    1.372141] 9d80: cfb48240 cf839d98 c03501cc c05adcc4 cfb52800 c05adcd4 cf838000 00000000
> [    1.380447] 9da0: 00000000 c10248a0 cf839e38 c030bf58 cf884600 c034e650 cf867270 00000000
> [    1.388752] 9dc0: cfb52800 cf9f2414 cf9f2400 cf839e30 cf884600 00000000 cf906010 c02fa484
> [    1.397058] 9de0: cfb52800 cf9f2414 cf9f2400 c02fa538 cfb52c00 cf9f2814 cf9f2800 c02fa56c
> [    1.405364] 9e00: cf9f280c cf9f280c cf9f2800 c0313830 cf839e30 cf9fa9b0 c05178b0 c10101d8
> [    1.413670] 9e20: cf881400 00000000 cf906000 c058cd20 cf839e30 cf839e30 50000000 5fffffff
> [    1.421976] 9e40: cfdf7764 00000200 00000000 00000000 00000000 00000000 c1057de8 cf906010
> [    1.430281] 9e60: c1010208 cf906044 c1010208 00000000 00000007 00000000 cfffcec0 c03515d8
> [    1.438588] 9e80: c1056fb0 cf906010 cf906044 c0350074 cf906010 c1010208 cf906044 c10177d0
> [    1.446894] 9ea0: 00000073 c03501c8 00000000 c1010208 c0350104 c034e59c cf80545c cf8a60b4
> [    1.455200] 9ec0: c1010208 cfa0ef00 00000000 c034f6e0 c058cd78 c0616a64 c0633cb0 c1010208
> [    1.463506] 9ee0: c0616a64 c0633cb0 c0628834 c0350724 ffffe000 c0616a64 c0633cb0 c0101834
> [    1.471811] 9f00: c05da71c cfffcec4 00000000 cfffcec9 00000000 cf839f30 c013291c c0132adc
> [    1.480117] 9f20: cfffceee c050fa08 00000073 c0132aec c059a1b8 c05da49c 00000000 00000006
> [    1.488423] 9f40: 00000006 c05723fc c1009358 c1024880 c1024880 c1024880 c0633cb0 c0628834
> [    1.496728] 9f60: 00000073 00000007 c062883c c0600db4 00000006 00000006 00000000 c06005ac
> [    1.505034] 9f80: aa83c9e6 00000000 c049fab4 00000000 00000000 00000000 00000000 00000000
> [    1.513339] 9fa0: 00000000 c049fabc 00000000 c01077b8 00000000 00000000 00000000 00000000
> [    1.521644] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.529949] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 94c2dc87 babd118e
> [    1.538273] [<c039fe44>] (quirk_usb_early_handoff) from [<c030bf58>] (pci_do_fixups+0xc8/0x158)
> [    1.547113] [<c030bf58>] (pci_do_fixups) from [<c02fa484>] (pci_bus_add_device+0x18/0x90)
> [    1.555423] [<c02fa484>] (pci_bus_add_device) from [<c02fa538>] (pci_bus_add_devices+0x3c/0x80)
> [    1.564255] [<c02fa538>] (pci_bus_add_devices) from [<c02fa56c>] (pci_bus_add_devices+0x70/0x80)
> [    1.573178] [<c02fa56c>] (pci_bus_add_devices) from [<c0313830>] (pci_host_common_probe+0xfc/0x324)
> [    1.582365] [<c0313830>] (pci_host_common_probe) from [<c03515d8>] (platform_drv_probe+0x34/0x7c)
> [    1.591375] [<c03515d8>] (platform_drv_probe) from [<c0350074>] (really_probe+0x1c4/0x254)
> [    1.599770] [<c0350074>] (really_probe) from [<c03501c8>] (__driver_attach+0xc4/0xc8)
> [    1.607728] [<c03501c8>] (__driver_attach) from [<c034e59c>] (bus_for_each_dev+0x68/0x9c)
> [    1.616036] [<c034e59c>] (bus_for_each_dev) from [<c034f6e0>] (bus_add_driver+0x1a0/0x218)
> [    1.624431] [<c034f6e0>] (bus_add_driver) from [<c0350724>] (driver_register+0x78/0xf8)
> [    1.632565] [<c0350724>] (driver_register) from [<c0101834>] (do_one_initcall+0x44/0x174)
> [    1.640882] [<c0101834>] (do_one_initcall) from [<c0600db4>] (kernel_init_freeable+0x154/0x1e4)
> [    1.649716] [<c0600db4>] (kernel_init_freeable) from [<c049fabc>] (kernel_init+0x8/0x10c)
> [    1.658026] [<c049fabc>] (kernel_init) from [<c01077b8>] (ret_from_fork+0x14/0x3c)
> [    1.665722] Code: e3500000 e0833100 0affffcb e0878003 (e5982000) 
> [    1.671965] ---[ end trace 61b8b7d0e0f98e8c ]---
> [    1.676708] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.676708] 
> [    1.686067] CPU1: stopping
> [    1.688872] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.9.7-1-rc2 #157
> [    1.696738] Hardware name: Sigma Tango DT
> [    1.700865] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
> [    1.708738] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
> [    1.716085] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
> [    1.723606] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
> [    1.731301] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
> [    1.738905] Exception stack(0xcf859f98 to 0xcf859fe0)
> [    1.744064] 9f80:                                                       00000001 00000000
> [    1.752370] 9fa0: 000017b0 c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
> [    1.760676] 9fc0: 00000000 00000000 00000001 cf859fe8 c0108220 c0108224 60000013 ffffffff
> [    1.768983] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
> [    1.776510] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
> [    1.784819] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
> [    1.791904] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

One more for the road:

[    1.261813] Unable to handle kernel paging request at virtual address d08611e4
[    1.269167] pgd = c0004000
[    1.271979] [d08611e4] *pgd=8f804811, *pte=00000000, *ppte=00000000
[    1.278394] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
[    1.283815] Modules linked in:
[    1.286970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
[    1.293614] Hardware name: Sigma Tango DT
[    1.297726] task: cf82c9c0 task.stack: cf838000
[    1.302364] PC is at quirk_usb_early_handoff+0x3e8/0x790
[    1.307790] LR is at ioremap_page_range+0xf8/0x1a8
[    1.312688] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
[    1.312688] sp : cf839d78  ip : 00000000  fp : cf839e38
[    1.324399] r10: c10248a0  r9 : 00000000  r8 : d08611e4
[    1.329733] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
[    1.336377] r3 : 000131e4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
[    1.343022] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.350277] Control: 10c5387d  Table: 8fa2c04a  DAC: 00000051
[    1.356135] Process swapper/0 (pid: 1, stack limit = 0xcf838210)
[    1.362255] Stack: (0xcf839d78 to 0xcf83a000)
[    1.366716] 9d60:                                                       c058f56c c058b174
[    1.375022] 9d80: cfb44240 cf839d98 c03501cc c05adcc4 cfb4e800 c05adcd4 cf838000 00000000
[    1.383328] 9da0: 00000000 c10248a0 cf839e38 c030bf58 cf886900 c034e650 cf867270 00000000
[    1.391633] 9dc0: cfb4e800 cfa3e414 cfa3e400 cf839e30 cf886900 00000000 cf906010 c02fa484
[    1.399939] 9de0: cfb4e800 cfa3e414 cfa3e400 c02fa538 cfb4ec00 cfa3e814 cfa3e800 c02fa56c
[    1.408245] 9e00: cfa3e80c cfa3e80c cfa3e800 c0313830 cf839e30 cf9ee9b0 c05178b0 c10101d8
[    1.416551] 9e20: cf932140 00000000 cf906000 c058cd20 cf839e30 cf839e30 50000000 5fffffff
[    1.424856] 9e40: cfdf7764 00000200 00000000 00000000 00000000 00000000 c1057de8 cf906010
[    1.433162] 9e60: c1010208 cf906044 c1010208 00000000 00000007 00000000 cfffcec0 c03515d8
[    1.441468] 9e80: c1056fb0 cf906010 cf906044 c0350074 cf906010 c1010208 cf906044 c10177d0
[    1.449774] 9ea0: 00000073 c03501c8 00000000 c1010208 c0350104 c034e59c cf80545c cf8a60b4
[    1.458080] 9ec0: c1010208 cfa52480 00000000 c034f6e0 c058cd78 c0616a64 c0633cb0 c1010208
[    1.466386] 9ee0: c0616a64 c0633cb0 c0628834 c0350724 ffffe000 c0616a64 c0633cb0 c0101834
[    1.474692] 9f00: c01017f0 80000013 ffffffff cf839f54 00000000 cf838000 c062883c c010b90c
[    1.482997] 9f20: cfffceee c050fa08 00000073 c0132aec c059a1b8 c05da49c 00000000 00000006
[    1.491303] 9f40: 00000006 c05723fc c062883c c1024880 c1024880 c1024880 c0633cb0 c0628834
[    1.499608] 9f60: 00000073 00000007 c062883c c0600db4 00000006 00000006 00000000 c06005ac
[    1.507914] 9f80: c83b3b47 00000000 c049fab4 00000000 00000000 00000000 00000000 00000000
[    1.516219] 9fa0: 00000000 c049fabc 00000000 c01077b8 00000000 00000000 00000000 00000000
[    1.524524] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.532829] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 9dbaf28f 56839b11
[    1.541152] [<c039fe44>] (quirk_usb_early_handoff) from [<c030bf58>] (pci_do_fixups+0xc8/0x158)
[    1.549992] [<c030bf58>] (pci_do_fixups) from [<c02fa484>] (pci_bus_add_device+0x18/0x90)
[    1.558301] [<c02fa484>] (pci_bus_add_device) from [<c02fa538>] (pci_bus_add_devices+0x3c/0x80)
[    1.567133] [<c02fa538>] (pci_bus_add_devices) from [<c02fa56c>] (pci_bus_add_devices+0x70/0x80)
[    1.576055] [<c02fa56c>] (pci_bus_add_devices) from [<c0313830>] (pci_host_common_probe+0xfc/0x324)
[    1.585243] [<c0313830>] (pci_host_common_probe) from [<c03515d8>] (platform_drv_probe+0x34/0x7c)
[    1.594252] [<c03515d8>] (platform_drv_probe) from [<c0350074>] (really_probe+0x1c4/0x254)
[    1.602647] [<c0350074>] (really_probe) from [<c03501c8>] (__driver_attach+0xc4/0xc8)
[    1.610605] [<c03501c8>] (__driver_attach) from [<c034e59c>] (bus_for_each_dev+0x68/0x9c)
[    1.618912] [<c034e59c>] (bus_for_each_dev) from [<c034f6e0>] (bus_add_driver+0x1a0/0x218)
[    1.627307] [<c034f6e0>] (bus_add_driver) from [<c0350724>] (driver_register+0x78/0xf8)
[    1.635442] [<c0350724>] (driver_register) from [<c0101834>] (do_one_initcall+0x44/0x174)
[    1.643759] [<c0101834>] (do_one_initcall) from [<c0600db4>] (kernel_init_freeable+0x154/0x1e4)
[    1.652592] [<c0600db4>] (kernel_init_freeable) from [<c049fabc>] (kernel_init+0x8/0x10c)
[    1.660904] [<c049fabc>] (kernel_init) from [<c01077b8>] (ret_from_fork+0x14/0x3c)
[    1.668601] Code: e3500000 e0833100 0affffcb e0878003 (e5982000) 
[    1.674843] ---[ end trace 4ba687b661f0690b ]---
[    1.679586] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.679586] 
[    1.688946] CPU1: stopping
[    1.691751] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.9.7-1-rc2 #157
[    1.699617] Hardware name: Sigma Tango DT
[    1.703741] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
[    1.711613] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
[    1.718961] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
[    1.726482] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
[    1.734176] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    1.741780] Exception stack(0xcf859f98 to 0xcf859fe0)
[    1.746939] 9f80:                                                       00000001 00000000
[    1.755245] 9fa0: 00001572 c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
[    1.763550] 9fc0: 00000000 00000000 00000001 cf859fe8 c0108220 c0108224 60000013 ffffffff
[    1.771857] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
[    1.779383] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
[    1.787693] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
[    1.794777] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Next boot didn't tickle the panic...

Regards.
