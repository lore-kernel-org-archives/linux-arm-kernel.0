From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 4 Apr 2016 08:13:00 +0200
Subject: 4.4 BCM5301X ARM regression "External imprecise Data abort"
Message-ID: <CACna6rz=KE_FtNtrSKmcYE514s4-dgrnx=iGbN7JDXkQPd6bTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I got regression reports from Netgear R8000 (BCM4709A0) users and did
some testing & regression tracking with Aditya.

It happens that Linux 4.4 doesn't boot due to the following commits:
bbeb920 ("ARM: 8422/1: enable imprecise aborts during early kernel startup")
9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
937b123 ("ARM: BCM5301X: remove workaround imprecise abort fault handler")

In kernel 4.3 we got that abort workaround which was resulting in:
[    5.007128] Freeing unused kernel memory: 212K (c0435000 - c046a000)
[    5.694632] init: Console is alive
[    5.698169] init: - watchdog -
[    5.701470] External imprecise Data abort at addr=0x0, fsr=0x1406 ignored.
As you can see, this abort was happening soon after freeing unused
memory and ignoring it *once* did the trick. It was never appearing
again.

With 4.4 similar (or the same?) abort happens earlier (during PCI host
driver init) and doesn't get ignored:
[    2.478461] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.483451] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x085fffff]
[    2.599449] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    2.605744] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
[    2.612657] pcie_iproc_bcma bcma0:8: link: UP
[    2.617241] PCI: bus0: Fast back to back transfers disabled
[    2.622845] pci 0001:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.631297] PCI: bus1: Fast back to back transfers disabled
[    2.636887] pci 0001:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.645035] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
(see 4.4.txt for the backtrace)

At first I was hoping that we simply need to re-add the removed
workaround. I tried it but it appeared that one abort is immediately
followed by another:
[    2.936895] pci 0001:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.945053] External imprecise Data abort at addr=0x0, fsr=0x1406 ignored.
[    2.951966] Unhandled fault: imprecise external abort (0x1406) at 0x00000000

So it seems that commits bbeb920 and 9254970 broke something in PCI
host initialization (or maybe just exposed another bug?). Instead of
getting an abort once and late we are getting now many of them and a
bit earlier.

Reverting all three commits from the top of 4.4.6 gives me back a
working & booting kernel.

Do you have any idea how to fix this regression (and hopefully
original problem as well)?

-- 
Rafa?
-------------- next part --------------
[    2.478461] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.483451] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x085fffff]
[    2.599449] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    2.605744] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
[    2.612657] pcie_iproc_bcma bcma0:8: link: UP
[    2.617241] PCI: bus0: Fast back to back transfers disabled
[    2.622845] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.631297] PCI: bus1: Fast back to back transfers disabled
[    2.636887] pci 0001:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.645035] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[    2.652103] pgd = c0004000
[    2.654809] [00000000] *pgd=00000000
[    2.658400] Internal error: : 1406 [#1] SMP ARM
[    2.662939] Modules linked in:
[    2.666008] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0 #1
[    2.671852] Hardware name: BCM5301X
[    2.675344] task: c782e000 ti: c7822000 task.ti: c7822000
[    2.680770] PC is at pci_generic_config_read32+0x48/0x74
[    2.686100] LR is at arm_heavy_mb+0x20/0x40
[    2.690291] pc : [<c01ad750>]    lr : [<c001b2ac>]    psr: a0000093
[    2.690291] sp : c7823980  ip : c7823948  fp : c782399c
[    2.701795] r10: 00000000  r9 : 00000000  r8 : c01ad708
[    2.707026] r7 : c7823a0c  r6 : 00000004  r5 : c78239ac  r4 : 00000000
[    2.713563] r3 : c88c4000  r2 : c88c41f8  r1 : 00120000  r0 : c88c41fc
[    2.720100] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.727342] Control: 10c5387d  Table: 0000404a  DAC: 00000051
[    2.733104] Process swapper/0 (pid: 1, stack limit = 0xc7822190)
[    2.739126] Stack: (0xc7823980 to 0xc7824000)
[    2.743492] 3980: c7adda00 00000000 60000013 c7823a0c c78239d4 c78239a0 c01ad5fc c01ad714
[    2.751691] 39a0: c78239ac c01da160 c78239cc 00000000 c7adda00 c7823a0c c7adda00 00000000
[    2.759890] 39c0: 0000ea60 c7add800 c7823a04 c78239d8 c01af0d0 c01ad5a4 00000000 00000000
[    2.768088] 39e0: c7adda00 c7adda00 00000000 00000000 00000000 c7add800 c7823a2c c7823a08
[    2.776288] 3a00: c01b03b0 c01af0b0 c7823a24 c7823a18 c7adda00 c7adda00 00000001 00000000
[    2.784488] 3a20: c7823a4c c7823a30 c01b048c c01b037c c7adda00 00000008 00000001 00000002
[    2.792686] 3a40: c7823a74 c7823a50 c01b122c c01b0434 c7a11c00 c7adda00 00000001 00000002
[    2.800885] 3a60: 00000000 c7add800 c7823ad4 c7823a78 c01b1034 c01b1210 c00531ec c00558a8
[    2.809084] 3a80: c7a11c00 c7823a9c c7823ad4 00000000 00000000 00000000 00000000 00000001
[    2.817283] 3aa0: 00000001 00ff0201 c7823ad4 c7add800 c7a11c00 00000001 00000001 c7add814
[    2.825482] 3ac0: c7add400 00000000 c7823afc c7823ad8 c01b128c c01b0d24 c7a11800 c7add800
[    2.833682] 3ae0: 00000000 00000001 00000000 c7add400 c7823b5c c7823b00 c01b1034 c01b1210
[    2.841881] 3b00: c00531ec c00558a8 c7a11800 c7823b24 c7823b5c 00000000 00000000 00000000
[    2.850080] 3b20: 00000000 00000001 00010001 00ff0100 c7823b5c c7add400 c7a11800 00000001
[    2.858279] 3b40: 00000000 c7add414 c04416ac 00000000 c7823b84 c7823b60 c01b128c c01b0d24
[    2.866478] 3b60: c7a3f550 c7add400 00000000 00000330 00000000 c04416ac c7823bec c7823b88
[    2.874678] 3b80: c01c0b2c c01b1210 c7823bf4 c7abda10 00000000 c04416ac c7823bbc c7823bf4
[    2.882878] 3ba0: c0024e20 90120190 c7823bf4 c7823bfc c7823bdc c7823bc0 01060400 c0024e10
[    2.891075] 3bc0: c7a3f550 c7a3f550 c7823bf4 c7abda00 c7abda10 00000000 c04416ac 00000000
[    2.899275] 3be0: c7823c34 c7823bf0 c01c0d28 c01c05b0 c7abda10 c7823bf4 c7823bf4 40000000
[    2.907474] 3c00: 47ffffff c03b9da1 00000200 c7823c18 c0104d78 c0104c90 c7abda10 c047be58
[    2.915674] 3c20: 00000000 c047be54 c7823c44 c7823c38 c0231cb4 c01c0c9c c7823c6c c7823c48
[    2.923873] 3c40: c01dddf4 c0231c98 c04416ac c7823cb8 c7abda10 c7abda44 00000000 c04363c8
[    2.932071] 3c60: c7823c8c c7823c70 c01de0bc c01ddd00 00000000 c7823cb8 c01de030 c7abda44
[    2.940271] 3c80: c7823cb4 c7823c90 c01dc6c4 c01de03c c7889870 c788c2b8 00000000 c7abda10
[    2.948470] 3ca0: c0448434 00000001 c7823cdc c7823cb8 c01ddc5c c01dc644 c7abda10 00000001
[    2.956669] 3cc0: c7abda10 c0448434 c7abda10 c7883c10 c7823cec c7823ce0 c01de1f4 c01ddbe8
[    2.964868] 3ce0: c7823d0c c7823cf0 c01dd380 c01de1ec c7abda10 c7abda18 00000000 c7883c10
[    2.973068] 3d00: c7823d54 c7823d10 c01db70c c01dd35c c001b9a8 c017d1ac 00000000 c78a26f0
[    2.981267] 3d20: c78a2830 dc8ba600 c7abda10 c7abda10 c7abda10 c78a2810 0000052d 0000082c
[    2.989467] 3d40: c04485d0 00000000 c7823d6c c7823d58 c01db97c c01db468 c7abda00 c7abda10
[    2.997666] 3d60: c7823d8c c7823d70 c0231f14 c01db96c c78a2810 c7abda00 c78a2830 0000052d
[    3.005864] 3d80: c7823db4 c7823d90 c0232654 c0231f00 c78a2810 c6de9bd4 c7883c00 c047be54
[    3.014063] 3da0: 00000000 c04485d0 c7823dd4 c7823db8 c02375c8 c0232320 c7883c10 c04485d0
[    3.022263] 3dc0: 00000000 c047be54 c7823dec c7823dd8 c01df56c c0237564 c7883c10 c047be58
[    3.030462] 3de0: c7823e14 c7823df0 c01dddf4 c01df538 c7883c10 c7883c44 c04485d0 c04423e8
[    3.038662] 3e00: c04363c8 00000000 c7823e34 c7823e18 c01ddfc8 c01ddd00 00000000 c04485d0
[    3.046861] 3e20: c01ddf58 c04423e8 c7823e5c c7823e38 c01dc5f0 c01ddf64 c7810a5c c7891134
[    3.055059] 3e40: c7810a70 c04485d0 00000000 c7902980 c7823e6c c7823e60 c01dd990 c01dc588
[    3.063258] 3e60: c7823e94 c7823e70 c01dd59c c01dd97c c03c818d c7823e80 c04485d0 c0415bb8
[    3.071458] 3e80: c04399c8 c04399c8 c7823eac c7823e98 c01de654 c01dd4d4 c7903940 c0415bb8
[    3.079657] 3ea0: c7823ebc c7823eb0 c01df518 c01de5bc c7823ecc c7823ec0 c0415cd8 c01df4ec
[    3.087857] 3ec0: c7823edc c7823ed0 c0415bd4 c0415ccc c7823f5c c7823ee0 c001393c c0415bc4
[    3.096055] 3ee0: c00fab44 c00fa808 00000000 c043bfbc c7823f14 c7823f00 c0038a28 c00389bc
[    3.104254] 3f00: c7ffc755 00000000 c7823f5c c7823f18 c0038c8c c03fe5ec 00000006 00000006
[    3.112454] 3f20: 00000035 c03fc020 c03fc444 00000000 00000000 dc8ba600 00000006 00000035
[    3.120653] 3f40: c0425834 c042eb24 c044d958 c044d950 c7823f94 c7823f60 c03fee80 c001379c
[    3.128852] 3f60: 00000006 00000006 00000000 c03fe5e0 00000000 c000e2e8 00000000 00000000
[    3.137051] 3f80: 00000000 00000000 c7823fac c7823f98 c000e2f8 c03fed68 00000000 c000e2e8
[    3.145249] 3fa0: 00000000 c7823fb0 c00097b8 c000e2f4 00000000 00000000 00000000 00000000
[    3.153449] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.161648] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 c7823ff4 00000000
[    3.169841] Backtrace: 
[    3.172309] [<c01ad708>] (pci_generic_config_read32) from [<c01ad5fc>] (pci_bus_read_config_dword+0x64/0x8c)
[    3.182159]  r7:c7823a0c r6:60000013 r5:00000000 r4:c7adda00
[    3.187871] [<c01ad598>] (pci_bus_read_config_dword) from [<c01af0d0>] (pci_bus_read_dev_vendor_id+0x2c/0xe8)
[    3.197809]  r9:c7add800 r8:0000ea60 r7:00000000 r6:c7adda00 r5:c7823a0c r4:c7adda00
[    3.205615] [<c01af0a4>] (pci_bus_read_dev_vendor_id) from [<c01b03b0>] (pci_scan_single_device+0x40/0xb8)
[    3.215285]  r9:c7add800 r8:00000000 r7:00000000 r6:00000000 r5:c7adda00 r4:c7adda00
[    3.223090] [<c01b0370>] (pci_scan_single_device) from [<c01b048c>] (pci_scan_slot+0x64/0xe4)
[    3.231632]  r7:00000000 r6:00000001 r5:c7adda00 r4:c7adda00
[    3.237339] [<c01b0428>] (pci_scan_slot) from [<c01b122c>] (pci_scan_child_bus+0x28/0xa8)
[    3.245532]  r7:00000002 r6:00000001 r5:00000008 r4:c7adda00
[    3.251239] [<c01b1204>] (pci_scan_child_bus) from [<c01b1034>] (pci_scan_bridge+0x31c/0x4ec)
[    3.259781]  r9:c7add800 r8:00000000 r7:00000002 r6:00000001 r5:c7adda00 r4:c7a11c00
[    3.267584] [<c01b0d18>] (pci_scan_bridge) from [<c01b128c>] (pci_scan_child_bus+0x88/0xa8)
[    3.275952]  r10:00000000 r9:c7add400 r8:c7add814 r7:00000001 r6:00000001 r5:c7a11c00
[    3.283838]  r4:c7add800
[    3.286385] [<c01b1204>] (pci_scan_child_bus) from [<c01b1034>] (pci_scan_bridge+0x31c/0x4ec)
[    3.294927]  r9:c7add400 r8:00000000 r7:00000001 r6:00000000 r5:c7add800 r4:c7a11800
[    3.302732] [<c01b0d18>] (pci_scan_bridge) from [<c01b128c>] (pci_scan_child_bus+0x88/0xa8)
[    3.311100]  r10:00000000 r9:c04416ac r8:c7add414 r7:00000000 r6:00000001 r5:c7a11800
[    3.318984]  r4:c7add400
[    3.321540] [<c01b1204>] (pci_scan_child_bus) from [<c01c0b2c>] (iproc_pcie_setup+0x588/0x690)
[    3.330170]  r9:c04416ac r8:00000000 r7:00000330 r6:00000000 r5:c7add400 r4:c7a3f550
[    3.337977] [<c01c05a4>] (iproc_pcie_setup) from [<c01c0d28>] (iproc_pcie_bcma_probe+0x98/0xd0)
[    3.346690]  r10:00000000 r9:c04416ac r8:00000000 r7:c7abda10 r6:c7abda00 r5:c7823bf4
[    3.354576]  r4:c7a3f550
[    3.357133] [<c01c0c90>] (iproc_pcie_bcma_probe) from [<c0231cb4>] (bcma_device_probe+0x28/0x34)
[    3.365935]  r7:c047be54 r6:00000000 r5:c047be58 r4:c7abda10
[    3.371648] [<c0231c8c>] (bcma_device_probe) from [<c01dddf4>] (driver_probe_device+0x100/0x264)
[    3.380460] [<c01ddcf4>] (driver_probe_device) from [<c01de0bc>] (__device_attach_driver+0x8c/0x98)
[    3.389523]  r9:c04363c8 r8:00000000 r7:c7abda44 r6:c7abda10 r5:c7823cb8 r4:c04416ac
[    3.397328] [<c01de030>] (__device_attach_driver) from [<c01dc6c4>] (bus_for_each_drv+0x8c/0x9c)
[    3.406130]  r7:c7abda44 r6:c01de030 r5:c7823cb8 r4:00000000
[    3.411839] [<c01dc638>] (bus_for_each_drv) from [<c01ddc5c>] (__device_attach+0x80/0xd4)
[    3.420030]  r6:00000001 r5:c0448434 r4:c7abda10
[    3.424684] [<c01ddbdc>] (__device_attach) from [<c01de1f4>] (device_initial_probe+0x14/0x18)
[    3.433225]  r7:c7883c10 r6:c7abda10 r5:c0448434 r4:c7abda10
[    3.438934] [<c01de1e0>] (device_initial_probe) from [<c01dd380>] (bus_probe_device+0x30/0x88)
[    3.447567] [<c01dd350>] (bus_probe_device) from [<c01db70c>] (device_add+0x2b0/0x504)
[    3.455498]  r7:c7883c10 r6:00000000 r5:c7abda18 r4:c7abda10
[    3.461205] [<c01db45c>] (device_add) from [<c01db97c>] (device_register+0x1c/0x20)
[    3.468877]  r10:00000000 r9:c04485d0 r8:0000082c r7:0000052d r6:c78a2810 r5:c7abda10
[    3.476762]  r4:c7abda10
[    3.479311] [<c01db960>] (device_register) from [<c0231f14>] (bcma_register_core+0x20/0x54)
[    3.487678]  r5:c7abda10 r4:c7abda00
[    3.491280] [<c0231ef4>] (bcma_register_core) from [<c0232654>] (bcma_bus_register+0x340/0x360)
[    3.499994]  r7:0000052d r6:c78a2830 r5:c7abda00 r4:c78a2810
[    3.505705] [<c0232314>] (bcma_bus_register) from [<c02375c8>] (bcma_host_soc_probe+0x70/0x94)
[    3.514329]  r9:c04485d0 r8:00000000 r7:c047be54 r6:c7883c00 r5:c6de9bd4 r4:c78a2810
[    3.522137] [<c0237558>] (bcma_host_soc_probe) from [<c01df56c>] (platform_drv_probe+0x40/0x74)
[    3.530849]  r7:c047be54 r6:00000000 r5:c04485d0 r4:c7883c10
[    3.536558] [<c01df52c>] (platform_drv_probe) from [<c01dddf4>] (driver_probe_device+0x100/0x264)
[    3.545446]  r5:c047be58 r4:c7883c10
[    3.549048] [<c01ddcf4>] (driver_probe_device) from [<c01ddfc8>] (__driver_attach+0x70/0x94)
[    3.557500]  r9:00000000 r8:c04363c8 r7:c04423e8 r6:c04485d0 r5:c7883c44 r4:c7883c10
[    3.565306] [<c01ddf58>] (__driver_attach) from [<c01dc5f0>] (bus_for_each_dev+0x74/0x98)
[    3.573499]  r7:c04423e8 r6:c01ddf58 r5:c04485d0 r4:00000000
[    3.579207] [<c01dc57c>] (bus_for_each_dev) from [<c01dd990>] (driver_attach+0x20/0x28)
[    3.587225]  r6:c7902980 r5:00000000 r4:c04485d0
[    3.591880] [<c01dd970>] (driver_attach) from [<c01dd59c>] (bus_add_driver+0xd4/0x1f0)
[    3.599818] [<c01dd4c8>] (bus_add_driver) from [<c01de654>] (driver_register+0xa4/0xe8)
[    3.607836]  r7:c04399c8 r6:c04399c8 r5:c0415bb8 r4:c04485d0
[    3.613545] [<c01de5b0>] (driver_register) from [<c01df518>] (__platform_driver_register+0x38/0x4c)
[    3.622607]  r5:c0415bb8 r4:c7903940
[    3.626212] [<c01df4e0>] (__platform_driver_register) from [<c0415cd8>] (bcma_host_soc_register_driver+0x18/0x20)
[    3.636505] [<c0415cc0>] (bcma_host_soc_register_driver) from [<c0415bd4>] (bcma_modinit+0x1c/0x50)
[    3.645580] [<c0415bb8>] (bcma_modinit) from [<c001393c>] (do_one_initcall+0x1ac/0x1ec)
[    3.653615] [<c0013790>] (do_one_initcall) from [<c03fee80>] (kernel_init_freeable+0x124/0x1f8)
[    3.662331]  r9:c044d950 r8:c044d958 r7:c042eb24 r6:c0425834 r5:00000035 r4:00000006
[    3.670145] [<c03fed5c>] (kernel_init_freeable) from [<c000e2f8>] (kernel_init+0x10/0x104)
[    3.678426]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c000e2e8 r4:00000000
[    3.686232] [<c000e2e8>] (kernel_init) from [<c00097b8>] (ret_from_fork+0x14/0x3c)
[    3.693814]  r5:c000e2e8 r4:00000000
[    3.697414] Code: e5853000 e89da8f0 e5901000 f57ff04f (e3560002) 
[    3.703537] ---[ end trace 207d6bff1aec485f ]---
[    3.708194] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    3.708194] 
[    3.717354] CPU1: stopping
[    3.720071] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.4.0 #1
[    3.727133] Hardware name: BCM5301X
[    3.730624] Backtrace: 
[    3.733094] [<c0017050>] (dump_backtrace) from [<c001724c>] (show_stack+0x18/0x1c)
[    3.740677]  r7:c7857f60 r6:00000000 r5:60000193 r4:00000000
[    3.746392] [<c0017234>] (show_stack) from [<c017b928>] (dump_stack+0x84/0xa4)
[    3.753635] [<c017b8a4>] (dump_stack) from [<c0018a34>] (handle_IPI+0xf4/0x19c)
[    3.760956]  r5:00000001 r4:c044daa8
[    3.764558] [<c0018940>] (handle_IPI) from [<c0009488>] (gic_handle_irq+0x7c/0x98)
[    3.772142]  r7:c0440e6c r6:c7857f60 r5:c0436708 r4:c8802100
[    3.777848] [<c000940c>] (gic_handle_irq) from [<c000a074>] (__irq_svc+0x54/0x70)
[    3.785347] Exception stack(0xc7857f60 to 0xc7857fa8)
[    3.790409] 7f60: 00000000 00000b80 c6dda254 c000ae20 c042f224 c0436498 10c0387d c044dab0
[    3.798608] 7f80: 0000406a 413fc090 00000000 c7857fbc c7857fc0 c7857fb0 c001453c c0014540
[    3.806803] 7fa0: 60000013 ffffffff
[    3.810291]  r9:413fc090 r8:0000406a r7:c7857f94 r6:ffffffff r5:60000013 r4:c0014540
[    3.818101] [<c001450c>] (arch_cpu_idle) from [<c004f944>] (default_idle_call+0x30/0x34)
[    3.826218] [<c004f914>] (default_idle_call) from [<c004fa78>] (cpu_startup_entry+0x130/0x194)
[    3.834852] [<c004f948>] (cpu_startup_entry) from [<c0018740>] (secondary_start_kernel+0x10c/0x128)
[    3.843921] [<c0018634>] (secondary_start_kernel) from [<0000954c>] (0x954c)
[    3.850982]  r5:00000051 r4:0783c06a
[    3.854580] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.6 (zajec at linux-samsung.lan) (gcc version 5.3.0 (OpenWrt GCC 5.3.0 r48934) ) #3 SMP Fri Apr 1 21:16:56 UTC 2016
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Netgear R8000 (BCM4709)
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 11 pages/cpu @c6dcf000 s12928 r8192 d23936 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65280
[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 254852K/262144K available (3154K kernel code, 101K rwdata, 1180K rodata, 216K init, 280K bss, 7292K reserved, 0K cma-reserved, 131072K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0443e54   (4336 kB)
[    0.000000]       .init : 0xc0444000 - 0xc047a000   ( 216 kB)
[    0.000000]       .data : 0xc047a000 - 0xc04934ac   ( 102 kB)
[    0.000000]        .bss : 0xc04934ac - 0xc04d966c   ( 281 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: DT/platform modifies aux control register: 0x0a130000 -> 0x0a530000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e530001
[    0.000011] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps every 4398046511103ns
[    0.008129] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns: 881590485102 ns
[    0.019397] Calibrating delay loop... 1987.37 BogoMIPS (lpj=9936896)
[    0.082228] pid_max: default: 32768 minimum: 301
[    0.087001] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.093727] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.101260] CPU: Testing write buffer coherency: ok
[    0.106440] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.112278] Setting up static identity map for 0x82a0 - 0x82d4
[    0.179378] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.179442] Brought up 2 CPUs
[    0.188261] SMP: Total of 2 processors activated (3981.31 BogoMIPS).
[    0.194730] CPU: All CPU(s) started in SVC mode.
[    0.200936] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.210968] pinctrl core: initialized pinctrl subsystem
[    0.216630] NET: Registered protocol family 16
[    0.221774] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.261181] clocksource: Switched to clocksource arm_global_timer
[    0.268207] NET: Registered protocol family 2
[    0.273132] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.280273] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.286742] TCP: Hash tables configured (established 1024 bind 1024)
[    0.293268] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.299227] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.305795] NET: Registered protocol family 1
[    0.311088] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.321658] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.327611] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.338806] bounce: pool size: 64 pages
[    0.342777] io scheduler noop registered
[    0.346799] io scheduler deadline registered (default)
[    0.352424] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.359486] console [ttyS0] disabled
[    0.363188] 18000300.serial: ttyS0 at MMIO 0x18000300 (irq = 18, base_baud = 7812500) is a 16550
[    0.372116] console [ttyS0] enabled
[    0.372116] console [ttyS0] enabled
[    0.379191] bootconsole [earlycon0] disabled
[    0.379191] bootconsole [earlycon0] disabled
[    0.388922] nand: Could not find valid ONFI parameter page; aborting
[    0.395380] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.401777] nand: AMD/Spansion NAND 128MiB 3,3V 8-bit
[    0.406847] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.414473] iproc_nand 18028000.nand: detected 128MiB total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
[    0.424433] Scanning device for bad blocks
[    1.054143] random: nonblocking pool is initialized
[    1.634046] mtd_read error while parsing (offset: 0x7580000): -74
[    1.640538] mtd_read error while parsing (offset: 0x75A0000): -74
[    1.647011] mtd_read error while parsing (offset: 0x75C0000): -74
[    1.653498] mtd_read error while parsing (offset: 0x75E0000): -74
[    1.659980] mtd_read error while parsing (offset: 0x7600000): -74
[    1.666456] mtd_read error while parsing (offset: 0x7620000): -74
[    1.672940] mtd_read error while parsing (offset: 0x7640000): -74
[    1.679417] mtd_read error while parsing (offset: 0x7660000): -74
[    1.685892] mtd_read error while parsing (offset: 0x7680000): -74
[    1.692376] mtd_read error while parsing (offset: 0x76A0000): -74
[    1.698853] mtd_read error while parsing (offset: 0x76C0000): -74
[    1.705338] mtd_read error while parsing (offset: 0x76E0000): -74
[    1.711825] mtd_read error while parsing (offset: 0x7700000): -74
[    1.718296] mtd_read error while parsing (offset: 0x7720000): -74
[    1.724782] mtd_read error while parsing (offset: 0x7740000): -74
[    1.731265] mtd_read error while parsing (offset: 0x7760000): -74
[    1.737742] mtd_read error while parsing (offset: 0x7780000): -74
[    1.744228] mtd_read error while parsing (offset: 0x77A0000): -74
[    1.750709] mtd_read error while parsing (offset: 0x77C0000): -74
[    1.757187] mtd_read error while parsing (offset: 0x77E0000): -74
[    1.763671] mtd_read error while parsing (offset: 0x7800000): -74
[    1.770154] mtd_read error while parsing (offset: 0x7820000): -74
[    1.776631] mtd_read error while parsing (offset: 0x7840000): -74
[    1.783115] mtd_read error while parsing (offset: 0x7860000): -74
[    1.789599] mtd_read error while parsing (offset: 0x7880000): -74
[    1.796076] mtd_read error while parsing (offset: 0x78A0000): -74
[    1.802562] mtd_read error while parsing (offset: 0x78C0000): -74
[    1.809036] mtd_read error while parsing (offset: 0x78E0000): -74
[    1.815526] mtd_read error while parsing (offset: 0x7900000): -74
[    1.822015] mtd_read error while parsing (offset: 0x7920000): -74
[    1.828490] mtd_read error while parsing (offset: 0x7940000): -74
[    1.834974] mtd_read error while parsing (offset: 0x7960000): -74
[    1.841460] mtd_read error while parsing (offset: 0x7980000): -74
[    1.847935] mtd_read error while parsing (offset: 0x79A0000): -74
[    1.854419] mtd_read error while parsing (offset: 0x79C0000): -74
[    1.860902] mtd_read error while parsing (offset: 0x79E0000): -74
[    1.867378] mtd_read error while parsing (offset: 0x7A00000): -74
[    1.873865] mtd_read error while parsing (offset: 0x7A20000): -74
[    1.880347] mtd_read error while parsing (offset: 0x7A40000): -74
[    1.886824] mtd_read error while parsing (offset: 0x7A60000): -74
[    1.893309] mtd_read error while parsing (offset: 0x7A80000): -74
[    1.899791] mtd_read error while parsing (offset: 0x7AA0000): -74
[    1.906267] mtd_read error while parsing (offset: 0x7AC0000): -74
[    1.912753] mtd_read error while parsing (offset: 0x7AE0000): -74
[    1.919231] mtd_read error while parsing (offset: 0x7B00000): -74
[    1.925714] mtd_read error while parsing (offset: 0x7B20000): -74
[    1.932198] mtd_read error while parsing (offset: 0x7B40000): -74
[    1.938673] mtd_read error while parsing (offset: 0x7B60000): -74
[    1.945162] mtd_read error while parsing (offset: 0x7B80000): -74
[    1.951643] mtd_read error while parsing (offset: 0x7BA0000): -74
[    1.958118] mtd_read error while parsing (offset: 0x7BC0000): -74
[    1.964603] mtd_read error while parsing (offset: 0x7BE0000): -74
[    1.971087] mtd_read error while parsing (offset: 0x7C00000): -74
[    1.977564] mtd_read error while parsing (offset: 0x7C20000): -74
[    1.984048] mtd_read error while parsing (offset: 0x7C40000): -74
[    1.990532] mtd_read error while parsing (offset: 0x7C60000): -74
[    1.997008] mtd_read error while parsing (offset: 0x7C80000): -74
[    2.003494] mtd_read error while parsing (offset: 0x7CA0000): -74
[    2.009976] mtd_read error while parsing (offset: 0x7CC0000): -74
[    2.016453] mtd_read error while parsing (offset: 0x7CE0000): -74
[    2.022940] mtd_read error while parsing (offset: 0x7D00000): -74
[    2.029414] mtd_read error while parsing (offset: 0x7D20000): -74
[    2.035890] mtd_read error while parsing (offset: 0x7D40000): -74
[    2.042374] mtd_read error while parsing (offset: 0x7D60000): -74
[    2.048848] mtd_read error while parsing (offset: 0x7D80000): -74
[    2.055333] mtd_read error while parsing (offset: 0x7DA0000): -74
[    2.061838] mtd_read error while parsing (offset: 0x7DC0000): -74
[    2.068323] mtd_read error while parsing (offset: 0x7DE0000): -74
[    2.074813] mtd_read error while parsing (offset: 0x7E00000): -74
[    2.081298] mtd_read error while parsing (offset: 0x7E20000): -74
[    2.087773] mtd_read error while parsing (offset: 0x7E40000): -74
[    2.094260] mtd_read error while parsing (offset: 0x7E60000): -74
[    2.100741] mtd_read error while parsing (offset: 0x7E80000): -74
[    2.107218] mtd_read error while parsing (offset: 0x7EA0000): -74
[    2.113704] mtd_read error while parsing (offset: 0x7EC0000): -74
[    2.120186] mtd_read error while parsing (offset: 0x7EE0000): -74
[    2.126665] mtd_read error while parsing (offset: 0x7F00000): -74
[    2.133147] mtd_read error while parsing (offset: 0x7F20000): -74
[    2.139625] mtd_read error while parsing (offset: 0x7F40000): -74
[    2.146099] mtd_read error while parsing (offset: 0x7F60000): -74
[    2.152585] mtd_read error while parsing (offset: 0x7F80000): -74
[    2.159059] mtd_read error while parsing (offset: 0x7FA0000): -74
[    2.166209] mtd_read error while parsing (offset: 0x7FE0000): -74
[    2.173320] 17 bcm47xxpart partitions found on MTD device brcmnand.0
[    2.179691] Creating 17 MTD partitions on "brcmnand.0":
[    2.184928] 0x000000000000-0x000000080000 : "boot"
[    2.190501] 0x000000080000-0x000000200000 : "nvram"
[    2.196046] 0x000000200000-0x000002600000 : "firmware"
[    2.202246] 0x00000020001c-0x000000600000 : "linux"
[    2.207829] 0x000000600000-0x000002600000 : "ubi"
[    2.213290] 0x000002600000-0x000002680000 : "board_data"
[    2.219286] 0x000002680000-0x0000026a0000 : "POT"
[    2.224721] 0x0000026a0000-0x000002780000 : "POT"
[    2.230178] 0x000002780000-0x0000027a0000 : "POT"
[    2.235564] 0x0000027a0000-0x000002e00000 : "POT"
[    2.241093] 0x000002e00000-0x000002e80000 : "ML"
[    2.246384] 0x000002e80000-0x000002f00000 : "ML"
[    2.251743] 0x000002f00000-0x000002f80000 : "ML"
[    2.257036] 0x000002f80000-0x000003000000 : "ML"
[    2.262425] 0x000003000000-0x000003080000 : "ML"
[    2.267740] 0x000003080000-0x000003100000 : "ML"
[    2.273108] 0x000003100000-0x000008000000 : "ML"
[    2.279048] libphy: Fixed MDIO Bus: probed
[    2.283255] bgmac: Broadcom 47xx GBit MAC driver loaded
[    2.288648] bcma: bus0: Found chip with id 53010, rev 0x00 and package 0x00
[    2.295703] bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x2A, class 0x0)
[    2.304344] bcma: bus0: Core 1 found: Chipcommon B (manuf 0x4BF, id 0x50B, rev 0x01, class 0x0)
[    2.313153] bcma: bus0: Core 2 found: DMA (manuf 0x4BF, id 0x502, rev 0x01, class 0x0)
[    2.321181] bcma: bus0: Core 3 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.329636] bcma: bus0: Core 4 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.338075] bcma: bus0: Core 5 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.346533] bcma: bus0: Core 6 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.354957] bcma: bus0: Core 7 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.363563] bcma: bus0: Core 8 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.372175] bcma: bus0: Core 9 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.380806] bcma: bus0: Core 10 found: ARM Cortex A9 core (ihost) (manuf 0x4BF, id 0x510, rev 0x01, class 0x0)
[    2.390898] bcma: bus0: Core 11 found: USB 2.0 (manuf 0x4BF, id 0x504, rev 0x01, class 0x0)
[    2.399332] bcma: bus0: Core 12 found: USB 3.0 (manuf 0x4BF, id 0x505, rev 0x01, class 0x0)
[    2.407797] bcma: bus0: Core 13 found: SDIO3 (manuf 0x4BF, id 0x503, rev 0x01, class 0x0)
[    2.416075] bcma: bus0: Core 14 found: I2S (manuf 0x4BF, id 0x834, rev 0x03, class 0x0)
[    2.424178] bcma: bus0: Core 15 found: ARM Cortex A9 JTAG (manuf 0x4BF, id 0x506, rev 0x01, class 0x0)
[    2.433586] bcma: bus0: Core 16 found: Denali DDR2/DDR3 memory controller (manuf 0x4BF, id 0x507, rev 0x01, class 0x0)
[    2.444385] bcma: bus0: Core 17 found: ROM (manuf 0x4BF, id 0x508, rev 0x01, class 0x0)
[    2.452486] bcma: bus0: Core 18 found: NAND flash controller (manuf 0x4BF, id 0x509, rev 0x01, class 0x0)
[    2.462172] bcma: bus0: Core 19 found: SPI flash controller (manuf 0x4BF, id 0x50A, rev 0x01, class 0x0)
[    2.471702] bcma: bus0: Flash type not supported
[    2.477323] bcm53xxspiflash spi32766.0: unrecognized JEDEC id bytes: ff, ff, ff
[    2.484714] bcm53xxspiflash: probe of spi32766.0 failed with error -2
[    2.524325] bgmac bcma0:3: Invalid MAC addr: 00:00:00:00:00:00
[    2.530214] bgmac bcma0:3: Using random MAC: 3e:01:a7:0f:e8:2f
[    2.536096] bgmac bcma0:3: Found PHY addr: 30 (NOREGS)
[    2.542074] bgmac bcma0:3: Support for Roboswitch not implemented
[    2.549690] b53_common: found switch: BCM53012, rev 5
[    2.555365] bgmac bcma0:4: Invalid MAC addr: 00:00:00:00:00:00
[    2.561260] bgmac bcma0:4: Using random MAC: 92:78:1c:7e:7d:42
[    2.567140] bgmac bcma0:4: Found PHY addr: 30 (NOREGS)
[    2.573128] bgmac bcma0:4: Support for Roboswitch not implemented
[    2.580183] bgmac bcma0:5: Found PHY addr: 30 (NOREGS)
[    2.586147] bgmac bcma0:5: Support for Roboswitch not implemented
[    2.593138] bgmac: Unsupported core_unit 3
[    2.597261] bgmac: probe of bcma0:6 failed with error -524
[    2.709449] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    2.715744] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    2.722659] pcie_iproc_bcma bcma0:7: link: UP
[    2.727253] PCI: bus0: Fast back to back transfers disabled
[    2.732862] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.741315] PCI: bus1: Fast back to back transfers disabled
[    2.746958] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x085fffff]
[    2.753793] pci 0000:01:00.0: BAR 2: assigned [mem 0x08000000-0x083fffff 64bit]
[    2.761142] pci 0000:01:00.0: BAR 0: assigned [mem 0x08400000-0x08407fff 64bit]
[    2.768477] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.773466] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x085fffff]
[    2.889438] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    2.895733] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
[    2.902646] pcie_iproc_bcma bcma0:8: link: UP
[    2.907227] PCI: bus0: Fast back to back transfers disabled
[    2.912834] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.921276] PCI: bus1: Fast back to back transfers disabled
[    2.926866] pci 0001:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.935051] pci 0001:02:00.0: unknown header type 12, ignoring device
[    2.942154] pci 0001:02:03.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    2.949595] pci 0001:02:03.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    2.957014] pci 0001:02:03.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    2.964449] pci 0001:02:03.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    2.971879] pci 0001:02:03.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    2.979304] pci 0001:02:03.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    2.986904] pci 0001:02:04.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    2.994343] pci 0001:02:04.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.001779] pci 0001:02:04.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.009203] pci 0001:02:04.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.016636] pci 0001:02:04.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.024073] pci 0001:02:04.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.031667] pci 0001:02:05.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.039094] pci 0001:02:05.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.046532] pci 0001:02:05.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.053967] pci 0001:02:05.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.061408] pci 0001:02:05.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.068834] pci 0001:02:05.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.076448] pci 0001:02:06.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.083891] pci 0001:02:06.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.091326] pci 0001:02:06.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.098750] pci 0001:02:06.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.106185] pci 0001:02:06.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.113615] pci 0001:02:06.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.121218] pci 0001:02:07.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.128641] pci 0001:02:07.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.136080] pci 0001:02:07.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.143514] pci 0001:02:07.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.150949] pci 0001:02:07.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.158372] pci 0001:02:07.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.165985] pci 0001:02:08.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.173428] pci 0001:02:08.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.180853] pci 0001:02:08.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.188271] pci 0001:02:08.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.195704] pci 0001:02:08.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.203136] pci 0001:02:08.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.210738] pci 0001:02:09.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.218160] pci 0001:02:09.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.225599] pci 0001:02:09.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.233026] pci 0001:02:09.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.240458] pci 0001:02:09.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.247884] pci 0001:02:09.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.255505] pci 0001:02:0a.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.262943] pci 0001:02:0a.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.270374] pci 0001:02:0a.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.277800] pci 0001:02:0a.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.285237] pci 0001:02:0a.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.292666] pci 0001:02:0a.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.300267] pci 0001:02:0b.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.307690] pci 0001:02:0b.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.315129] pci 0001:02:0b.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.322563] pci 0001:02:0b.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.329995] pci 0001:02:0b.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.337413] pci 0001:02:0b.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.345024] pci 0001:02:0c.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.352462] pci 0001:02:0c.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.359895] pci 0001:02:0c.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.367320] pci 0001:02:0c.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.374754] pci 0001:02:0c.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.382186] pci 0001:02:0c.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.389794] pci 0001:02:0d.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.397219] pci 0001:02:0d.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.404657] pci 0001:02:0d.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.412090] pci 0001:02:0d.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.419517] pci 0001:02:0d.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.426943] pci 0001:02:0d.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.434541] pci 0001:02:0e.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.441980] pci 0001:02:0e.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.449406] pci 0001:02:0e.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.456832] pci 0001:02:0e.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.464265] pci 0001:02:0e.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.471698] pci 0001:02:0e.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.479302] pci 0001:02:0f.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.486739] pci 0001:02:0f.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.494173] pci 0001:02:0f.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.501605] pci 0001:02:0f.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.509029] pci 0001:02:0f.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.516462] pci 0001:02:0f.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.524069] pci 0001:02:10.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.531509] pci 0001:02:10.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.538929] pci 0001:02:10.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.546370] pci 0001:02:10.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.553804] pci 0001:02:10.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.561235] pci 0001:02:10.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.568835] pci 0001:02:11.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.576279] pci 0001:02:11.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.583713] pci 0001:02:11.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.591145] pci 0001:02:11.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.598568] pci 0001:02:11.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.606000] pci 0001:02:11.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.613602] pci 0001:02:12.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.621040] pci 0001:02:12.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.628466] pci 0001:02:12.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.635900] pci 0001:02:12.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.643332] pci 0001:02:12.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.650764] pci 0001:02:12.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.658363] pci 0001:02:13.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.665805] pci 0001:02:13.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.673243] pci 0001:02:13.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.680671] pci 0001:02:13.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.688088] pci 0001:02:13.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.695522] pci 0001:02:13.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.703128] pci 0001:02:14.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.710567] pci 0001:02:14.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.717988] pci 0001:02:14.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.725422] pci 0001:02:14.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.732852] pci 0001:02:14.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.740285] pci 0001:02:14.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.747883] pci 0001:02:15.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.755327] pci 0001:02:15.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.762761] pci 0001:02:15.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.770191] pci 0001:02:15.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.777610] pci 0001:02:15.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.785041] pci 0001:02:15.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.792650] pci 0001:02:16.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.800091] pci 0001:02:16.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.807517] pci 0001:02:16.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.814953] pci 0001:02:16.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.822382] pci 0001:02:16.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.829814] pci 0001:02:16.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.837419] pci 0001:02:17.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.844857] pci 0001:02:17.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.852291] pci 0001:02:17.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.859721] pci 0001:02:17.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.867148] pci 0001:02:17.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.874580] pci 0001:02:17.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.882189] pci 0001:02:18.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.889627] pci 0001:02:18.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.897046] pci 0001:02:18.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.904482] pci 0001:02:18.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.911912] pci 0001:02:18.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.919343] pci 0001:02:18.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.926936] pci 0001:02:19.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.934379] pci 0001:02:19.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.941814] pci 0001:02:19.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.949235] pci 0001:02:19.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    3.956668] pci 0001:02:19.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    3.964100] pci 0001:02:19.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    3.971717] pci 0001:02:1a.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    3.979142] pci 0001:02:1a.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    3.986582] pci 0001:02:1a.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    3.994017] pci 0001:02:1a.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.001450] pci 0001:02:1a.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.008874] pci 0001:02:1a.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.016481] pci 0001:02:1b.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.023924] pci 0001:02:1b.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    4.031358] pci 0001:02:1b.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    4.038781] pci 0001:02:1b.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.046216] pci 0001:02:1b.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.053647] pci 0001:02:1b.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.061273] pci 0001:02:1c.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.068698] pci 0001:02:1c.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    4.076138] pci 0001:02:1c.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    4.083573] pci 0001:02:1c.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.091003] pci 0001:02:1c.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.098421] pci 0001:02:1c.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.106037] pci 0001:02:1d.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.113478] pci 0001:02:1d.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    4.120912] pci 0001:02:1d.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    4.128337] pci 0001:02:1d.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.135770] pci 0001:02:1d.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.143202] pci 0001:02:1d.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.150820] pci 0001:02:1e.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.158244] pci 0001:02:1e.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    4.165684] pci 0001:02:1e.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    4.173120] pci 0001:02:1e.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.180550] pci 0001:02:1e.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.187968] pci 0001:02:1e.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.195592] pci 0001:02:1f.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.203034] pci 0001:02:1f.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
[    4.210467] pci 0001:02:1f.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
[    4.217893] pci 0001:02:1f.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
[    4.225325] pci 0001:02:1f.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
[    4.232758] pci 0001:02:1f.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
[    4.240541] PCI: bus2: Fast back to back transfers disabled
[    4.246133] pci 0001:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.254178] pci 0001:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.262764] PCI: bus3: Fast back to back transfers disabled
[    4.268888] PCI: bus4: Fast back to back transfers disabled
[    4.274895] pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x40ffffff]
[    4.281720] pci 0001:00:00.0: BAR 9: assigned [mem 0x41000000-0x411fffff 64bit pref]
[    4.289564] pci 0001:01:00.0: BAR 8: assigned [mem 0x40000000-0x40dfffff]
[    4.296370] pci 0001:01:00.0: BAR 9: assigned [mem 0x41000000-0x411fffff 64bit pref]
[    4.304145] pci 0001:01:00.0: BAR 0: assigned [mem 0x40e00000-0x40e03fff]
[    4.310959] pci 0001:01:00.0: BAR 7: no space for [io  size 0x1000]
[    4.317241] pci 0001:01:00.0: BAR 7: failed to assign [io  size 0x1000]
[    4.323889] pci 0001:01:00.0: BAR 7: no space for [io  size 0x1000]
[    4.330182] pci 0001:01:00.0: BAR 7: failed to assign [io  size 0x1000]
[    4.336890] pci 0001:02:01.0: BAR 8: assigned [mem 0x40000000-0x407fffff]
[    4.343704] pci 0001:02:02.0: BAR 8: assigned [mem 0x40800000-0x40dfffff]
[    4.350516] pci 0001:02:01.0: BAR 9: assigned [mem 0x41000000-0x411fffff 64bit pref]
[    4.358281] pci 0001:02:01.0: BAR 7: no space for [io  size 0x1000]
[    4.364572] pci 0001:02:01.0: BAR 7: failed to assign [io  size 0x1000]
[    4.371216] pci 0001:02:01.0: BAR 7: no space for [io  size 0x1000]
[    4.377499] pci 0001:02:01.0: BAR 7: failed to assign [io  size 0x1000]
[    4.384144] pci 0001:03:00.0: BAR 2: assigned [mem 0x40000000-0x403fffff 64bit]
[    4.391494] pci 0001:03:00.0: BAR 0: assigned [mem 0x40400000-0x40407fff 64bit]
[    4.398838] pci 0001:02:01.0: PCI bridge to [bus 03]
[    4.403824] pci 0001:02:01.0:   bridge window [mem 0x40000000-0x407fffff]
[    4.410634] pci 0001:02:01.0:   bridge window [mem 0x41000000-0x411fffff 64bit pref]
[    4.418407] pci 0001:04:00.0: BAR 2: assigned [mem 0x40800000-0x40bfffff 64bit]
[    4.425761] pci 0001:04:00.0: BAR 0: assigned [mem 0x40c00000-0x40c07fff 64bit]
[    4.433113] pci 0001:02:02.0: PCI bridge to [bus 04]
[    4.438092] pci 0001:02:02.0:   bridge window [mem 0x40800000-0x40dfffff]
[    4.444920] pci 0001:01:00.0: PCI bridge to [bus 02-04]
[    4.450174] pci 0001:01:00.0:   bridge window [mem 0x40000000-0x40dfffff]
[    4.456977] pci 0001:01:00.0:   bridge window [mem 0x41000000-0x411fffff 64bit pref]
[    4.464752] pci 0001:00:00.0: PCI bridge to [bus 01-04]
[    4.469995] pci 0001:00:00.0:   bridge window [mem 0x40000000-0x40ffffff]
[    4.476803] pci 0001:00:00.0:   bridge window [mem 0x41000000-0x411fffff 64bit pref]
[    4.589461] pcie_iproc_bcma bcma0:9: PCI host bridge to bus 0002:00
[    4.595756] pci_bus 0002:00: root bus resource [mem 0x48000000-0x4fffffff]
[    4.602664] pcie_iproc_bcma bcma0:9: PHY or data link is INACTIVE!
[    4.608858] pcie_iproc_bcma bcma0:9: no PCIe EP device detected
[    4.614867] pcie_iproc_bcma bcma0:9: PCIe controller setup failed
[    4.621987] bcm47xx-wdt bcm47xx-wdt.0: BCM47xx Watchdog Timer enabled (30 seconds, Software Timer)
[    4.631008] bcma: bus0: Bus registered
[    4.635741] NET: Registered protocol family 10
[    4.641193] NET: Registered protocol family 17
[    4.645687] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    4.658364] 8021q: 802.1Q VLAN Support v1.8
[    4.662644] Registering SWP/SWPB emulation handler
[    4.669580] UBI: auto-attach mtd4
[    4.672740] ubi0: attaching mtd4
[    4.770231] ubi0: scanning is finished
[    4.799366] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 207 LEBs
[    4.806359] ubi0: attached mtd4 (name "ubi", size 32 MiB)
[    4.811803] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    4.818694] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    4.825511] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
[    4.832497] ubi0: good PEBs: 256, bad PEBs: 0, corrupted PEBs: 0
[    4.838513] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    4.845763] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence number: 1099897776
[    4.854927] ubi0: available PEBs: 0, total reserved PEBs: 256, PEBs reserved for bad PEB handling: 20
[    4.864202] ubi0: background thread "ubi_bgt0d" started, PID 406
[    4.871189] block ubiblock0_0: created from ubi0:0(rootfs)
[    4.876716] ubiblock: device ubiblock0_0 (rootfs) set to be root filesystem
[    4.898368] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    4.905830] Freeing unused kernel memory: 216K (c0444000 - c047a000)
[    5.198026] External imprecise Data abort at addr=0xb6ff22c1, fsr=0x1406 ignored.
[    5.362814] init: Console is alive
[    5.366399] init: - watchdog -
