From: matthew_minter@xyratex.com (Matthew Minter)
Date: Thu, 3 Apr 2014 09:57:16 +0100
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
Message-ID: <CAFJTrDtm+VBoZCiW8fu6kW7jus1c9epHb5N_BRPzs30zf5esJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, I have managed to gather some more info. The problem of the lost
line was with my serial console acting and losing lines of data oddly
around the time of the the oops and I have indeed gained some extra
info (I logged dmesg to a file while the issue was happening and
pulled the full transcript from there).

It appears the mbus windows are not being changed during the rescan, I
think this is a good thing however as it seems with this hotplug quirk
they seem to be correct to begin with (the bridge windows all seem to
fall within the range of the mbus windows).

Finally I have noticed that I get different results if I first remove
the bridge (by echoing to the remove file) then rescan after that (The
log of that seems to indicate some issue involving the pcieport
driver, please see the end of the email). However I shall continue
working on this issue as it is still oopsing either way, the log has
revealed a little more I think and I will send an update if I find
anything.

Dumps ahead...

Membus debugfs: (Never changes)

[00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 0000000000010000)
[01] disabled
[02] disabled
[03] disabled
[04] disabled
[05] disabled
[06] disabled
[07] disabled
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000e0000000 - 00000000e0d00000 : 0004:00e8
[10] disabled
[11] disabled
[12] disabled
[13] disabled
[14] disabled
[15] disabled
[16] disabled
[17] disabled
[18] disabled
[19] disabled

Unabridged version of crash log (without removing ports):

[  191.653052] pci_bus 0000:01: scanning bus
[  191.653094] pcieport 0000:01:00.0: scanning [bus 02-05] behind bridge, pass 0
[  191.653110] pcieport 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[  191.653126] pci_bus 0000:02: scanning bus
[  191.653202] pcieport 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
[  191.653220] pcieport 0000:02:02.0: scanning [bus 04-04] behind bridge, pass 0
[  191.653236] pcieport 0000:02:03.0: scanning [bus 05-05] behind bridge, pass 0
[  191.653251] pcieport 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[  191.653265] pci_bus 0000:03: scanning bus
[  191.653276] pci_bus 0000:03: bus scan returning with max=03
[  191.653288] pci_bus 0000:03: busn_res: [bus 03] end is updated to 03
[  191.653302] pcieport 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
[  191.653315] pci_bus 0000:04: scanning bus
[  191.653361] pci 0000:04:00.0: [144d:a800] type 00 class 0x010601
[  191.653452] pci 0000:04:00.0: reg 0x24: [mem 0x00000000-0x00001fff]
[  191.653472] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[  191.653496] pci 0000:04:00.0: calling pci_fixup_ide_bases+0x0/0x58
[  191.653593] pci 0000:04:00.0: PME# supported from D3hot D3cold
[  191.653611] pci 0000:04:00.0: PME# disabled
[  191.654078] pci_bus 0000:04: bus scan returning with max=04
[  191.654095] pci_bus 0000:04: busn_res: [bus 04] end is updated to 04
[  191.654118] pcieport 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
[  191.654137] pci_bus 0000:05: scanning bus
[  191.654154] pci_bus 0000:05: bus scan returning with max=05
[  191.654169] pci_bus 0000:05: busn_res: [bus 05] end is updated to 05
[  191.654187] pci_bus 0000:02: bus scan returning with max=05
[  191.654198] pci_bus 0000:02: busn_res: [bus 02-05] end is updated to 05
[  191.654211] pci_bus 0000:01: bus scan returning with max=05
[  191.654219] pci_bus 0000:01: busn_res: [bus 01-05] end is updated to 05
[  191.654229] pci_bus 0000:00: bus scan returning with max=05
[  191.654296] pci 0000:04:00.0: BAR 6: assigned [mem
0xe0800000-0xe080ffff pref]
[  191.654306] pci 0000:04:00.0: BAR 5: assigned [mem 0xe0200000-0xe0201fff]
[  191.654321] pci 0000:04:00.0: BAR 5: set to [mem
0xe0200000-0xe0201fff] (PCI address [0xe0200000-0xe0201fff])
[  191.654412] ahci 0000:04:00.0: no of_node; not parsing pinctrl DT
[  191.654444] ahci 0000:04:00.0: version 3.0
[  191.654460] PCI: enabling device 0000:04:00.0 (0000 -> 0002)
[  191.654496] Unhandled fault: external abort on non-linefetch
(0x1008) at 0xf0460004
[  191.654505] Internal error: : 1008 [#1] PREEMPT SMP ARM
[  191.658441] Modules linked in:
[  191.660224] CPU: 0 PID: 1746 Comm: bash Not tainted 3.14.0-rc7 #24
[  191.665122] task: eee9b440 ti: edc38000 task.ti: edc38000
[  191.669243] PC is at ahci_enable_ahci+0x10/0x7c
[  191.672488] LR is at ahci_save_initial_config+0x28/0x24c
[  191.676515] pc : [<c02510e4>]    lr : [<c02512d8>]    psr: 60070013
sp : edc39cb0  ip : edc39cd0  fp : edc39ccc
[  191.685413] r10: 00000000  r9 : 00000000  r8 : 00000000
[  191.689350] r7 : ee7a9c68  r6 : f0460000  r5 : eeca2790  r4 : f0460004
r3 : 00000000  r2 : 00000000  r1 : eeca2790  r0 : f0460000
[  191.699838] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  191.705690] Control: 10c53c7d  Table: 2dc6406a  DAC: 00000015
[  191.710150] Process bash (pid: 1746, stack limit = 0xedc38240)
[  191.714696] Stack: (0xedc39cb0 to 0xedc3a000)
[  191.717765] 9ca0:                                     ee7a9c00
eeca2790 f0460000 ee7a9c68
[  191.724668] 9cc0: edc39cfc edc39cd0 c02512d8 c02510e0 00000000
ee7a9c00 ee7a9c68 eeca27
[  191.731572] 9ce0: 00000000 00000000 eef2a2c8 00000005 edc39d64
edc39d00 c024e7d0 c02512bc
[  191.738475] 9d00: edc39d34 edc39d10 c00fa3ec ee4987e0 c043f20d
edc39d1c 00000000 00060082
[  191.745378] 9d20: 00000000 0000001f 00000000 0000007f c04d3a04
00000000 edc39d64 ee7a9c68
[  191.752285] 9d40: ee7a9c00 c04d36f4 00000000 c04d36c0 eef2a2c8
eef2a2c0 edc39d8c edc39d68
9d60: c01dc230 c024e458 c01dc1d0 ee7a9c68 c04d36f4 00000000 c0218c18 00000002
[  191.766098] 9d80: edc39db4 edc39d90 c0218974 c01dc1dc ee7a9c68
c0218c18 edc39db4 c04d36f4
[  191.773005] 9da0: ee7a9c68 ee7a9c68 edc39dcc edc39db8 c0218c48
c0218850 00000000 edc39dd0
[  191.779911] 9dc0: edc39df4 edc39dd0 c0216d30 c0218c24 eec6c7b0
ee492538 ee7a9c68 ee7a9c9c
9de0: eeecd600 edc39f78 edc39e14 edc39df8 c02187d0 c0216ce8 00000001 ee7a9c00
[  191.793723] 9e00: eeecd614 eeecd600 edc39e2c edc39e18 c01d4810
c021876c 00000000 ee7a9c00
[  191.800629] 9e20: edc39e4c edc39e30 c01d499c c01d47e0 00000004
eed38400 eeecda14 eeecda00
[  191.807533] 9e40: edc39e6c edc39e50 c01d49ec c01d4970 00000004
eed38c00 eeecdc14 eeecdc00
[  191.814439] 9e60: edc39e8c edc39e70 c01d49ec c01d4970 00000004
eeefe000 eeecde14 eeecde00
[  191.821343] 9e80: edc39eac edc39e90 c01d49ec c01d4970 edc39e88
eeecde00 00000005 eef2a840
[  191.828249] 9ea0: edc39ec4 edc39eb0 c037cec0 c01d4970 eeecde00
00000002 edc39ee4 edc39ec8
[  191.835155] 9ec0: c01dd17c c037cea4 00000041 00000001 eec69a68
eef2a840 edc39ef4 edc39ee8
[  191.842058] 9ee0: c0216b00 c01dd140 edc39f0c edc39ef8 c00f6a4c
c0216ae4 00000000 00000000
[  191.848961] 9f00: edc39f44 edc39f10 c00f9cd0 c00f6a14 00000000
00000000 c00a1430 eecb7d40
[  191.855866] 9f20: 00000002 b6f96000 edc39f78 00000002 edc38000
b6f96000 edc39f74 edc39f48
[  191.862769] 9f40: c00a3830 c00f9be8 edc39f74 edc39f58 00000000
00000000 eecb7d40 eecb7d40
[  191.869675] 9f60: 00000002 b6f96000 edc39fa4 edc39f78 c00a3bc8
c00a376c 00000000 00000000
[  191.876581] 9f80: 00000002 b6f96000 b6ed5a78 00000004 c000ed84
00000000 00000000 edc39fa8
[  191.883485] 9fa0: c000ec00 c00a3b90 00000002 b6f96000 00000001
b6f96000 00000002 00000000
[  191.890387] 9fc0: 00000002 b6f96000 b6ed5a78 00000004 00000002
00000002 b6f96000 00000000
[  191.897290] 9fe0: 00000000 bed43a1c b6e15390 b6e66aac 60070010
00000001 00000000 00000000
[  191.904184] Backtrace:
[  191.905365] [<c02510d4>] (ahci_enable_ahci) from [<c02512d8>]
(ahci_save_initial_config+0x28/0x24c)
[  191.913132]  r7:ee7a9c68 r6:f0460000 r5:eeca2790 r4:ee7a9c00
[  191.917582] [<c02512b0>] (ahci_save_initial_config) from
[<c024e7d0>] (ahci_init_one+0x384/0x850)
[  191.925175]  r10:00000005 r9:eef2a2c8 r8:00000000 r7:00000000
r6:eeca2790 r5:ee7a9c68
[  191.931809]  r4:ee7a9c00 r3:00000000
[  191.934137] [<c024e44c>] (ahci_init_one) from [<c01dc230>]
(pci_device_probe+0x60/0xa4)
[  191.940860]  r10:eef2a2c0 r9:eef2a2c8 r8:c04d36c0 r7:00000000
r6:c04d36f4 r5:ee7a9c00
[  191.947497]  r4:ee7a9c68
[  191.948764] [<c01dc1d0>] (pci_device_probe) from [<c0218974>]
(driver_probe_device+0x130/0x340)
[  191.956183]  r8:00000002 r7:c0218c18 r6:00000000 r5:c04d36f4
r4:ee7a9c68 r3:c01dc1d0
[  191.962735] [<c0218844>] (driver_probe_device) from [<c0218c48>]
(__device_attach+0x30/0x4c)
[  191.969892]  r6:ee7a9c68 r5:ee7a9c68 r4:c04d36f4
[  191.973279] [<c0218c18>] (__device_attach) from [<c0216d30>]
(bus_for_each_drv+0x54/0x9c)
[  191.980174]  r5:edc39dd0 r4:00000000
[  191.982501] [<c0216cdc>] (bus_for_each_drv) from [<c02187d0>]
(device_attach+0x70/0x88)
[  191.989224]  r7:edc39f78 r6:eeecd600 r5:ee7a9c9c r4:ee7a9c68
[  191.993673] [<c0218760>] (device_attach) from [<c01d4810>]
(pci_bus_add_device+0x3c/0x68)
[  192.000570]  r6:eeecd600 r5:eeecd614 r4:ee7a9c00 r3:00000001
[  192.005017] [<c01d47d4>] (pci_bus_add_device) from [<c01d499c>]
(pci_bus_add_devices+0x38/0x9c)
[  192.012436]  r4:ee7a9c00 r3:00000000
[  192.014761] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  192.022265]  r6:eeecda00 r5:eeecda14 r4:eed38400 r3:00000004
[  192.026711] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  192.034216]  r6:eeecdc00 r5:eeecdc14 r4:eed38c00 r3:00000004
[  192.038659] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  192.046164]  r6:eeecde00 r5:eeecde14 r4:eeefe000 r3:00000004
[  192.050616] [<c01d4964>] (pci_bus_add_devices) from [<c037cec0>]
(pci_rescan_bus+0x28/0x30)
[  192.057686]  r6:eef2a840 r5:00000005 r4:eeecde00 r3:edc39e88
[  192.062132] [<c037ce98>] (pci_rescan_bus) from [<c01dd17c>]
(bus_rescan_store+0x48/0x70)
[  192.068940]  r5:00000002 r4:eeecde00
[  192.071260] [<c01dd134>] (bus_rescan_store) from [<c0216b00>]
(bus_attr_store+0x28/0x34)
 r5:eef2a840 r4:eec69a68
[  192.080393] [<c0216ad8>] (bus_attr_store) from [<c00f6a4c>]
(sysfs_kf_write+0x44/0x50)
[  192.087037] [<c00f6a08>] (sysfs_kf_write) from [<c00f9cd0>]
(kernfs_fop_write+0xf4/0x148)
[  192.093933]  r5:00000000 r4:00000000
[  192.096255] [<c00f9bdc>] (kernfs_fop_write) from [<c00a3830>]
(vfs_write+0xd0/0x17c)
[  192.102715]  r10:b6f96000 r9:edc38000 r8:00000002 r7:edc39f78
r6:b6f96000 r5:00000002
[  192.109349]  r4:eecb7d40
[  192.110607] [<c00a3760>] (vfs_write) from [<c00a3bc8>] (SyS_write+0x44/0x84)
[  192.116372]  r10:b6f96000 r8:00000002 r7:eecb7d40 r6:eecb7d40
r5:00000000 r4:00000000
[  192.123022] [<c00a3b84>] (SyS_write) from [<c000ec00>]
(ret_fast_syscall+0x0/0x30)
[  192.129309]  r10:00000000 r8:c000ed84 r7:00000004 r6:b6ed5a78
r5:b6f96000 r4:00000002
[  192.135952] Code: e1a0c00d e92dd8f0 e24cb004 e2804004 (e5906004)
[  192.140763] ---[ end trace 2c2666e38d6db7ad ]---


Crash log (When removing ports):

[  190.947343] pci_bus 0000:00: scanning bus
[  190.947389] pci 0000:00:01.0: scanning [bus 01-05] behind bridge, pass 0
[  190.947402] pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 1
[  190.947413] pci_bus 0000:01: scanning bus
[  190.947453] pci 0000:01:00.0: [10b5:8617] type 01 class 0x060400
[  190.947484] pci 0000:01:00.0: reg 0x10: [mem 0xe0c00000-0xe0c1ffff]
[  190.947538] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x58
[  190.947556] pci 0000:01:00.0: calling quirk_hotplug_bridge+0x0/0x1c
[  190.947635] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[  190.947646] pci 0000:01:00.0: PME# disabled
[  190.948056] pci 0000:01:00.0: scanning [bus 02-05] behind bridge, pass 0
[  190.948073] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[  190.948529] pci_bus 0000:02: busn_res: can not insert [bus 02-ff]
under [bus 01-05] (conflicts with (null) [bus 01-05])
[  190.948540] pci_bus 0000:02: scanning bus
[  190.948575] pci 0000:02:01.0: [10b5:8617] type 01 class 0x060400
[  190.948644] pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x58
[  190.948660] pci 0000:02:01.0: calling quirk_hotplug_bridge+0x0/0x1c
[  190.948730] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[  190.948741] pci 0000:02:01.0: PME# disabled
[  190.963600] pci 0000:02:02.0: [10b5:8617] type 01 class 0x060400
[  190.963693] pci 0000:02:02.0: calling pci_fixup_ide_bases+0x0/0x58
[  190.963717] pci 0000:02:02.0: calling quirk_hotplug_bridge+0x0/0x1c
[  190.963804] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[  190.963819] pci 0000:02:02.0: PME# disabled
[  190.977971] pci 0000:02:03.0: [10b5:8617] type 01 class 0x060400
[  190.978060] pci 0000:02:03.0: calling pci_fixup_ide_bases+0x0/0x58
[  190.978090] pci 0000:02:03.0: calling quirk_hotplug_bridge+0x0/0x1c
[  190.978177] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[  190.978193] pci 0000:02:03.0: PME# disabled
[  190.979859] pci_bus 0000:02: fixups for bus
[  190.979895] PCI: bus2: Fast back to back transfers disabled
[  190.979908] pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
[  190.979925] pci 0000:02:02.0: scanning [bus 04-04] behind bridge, pass 0
[  190.979940] pci 0000:02:03.0: scanning [bus 05-05] behind bridge, pass 0
[  190.979955] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[  190.988273] pci_bus 0000:03: scanning bus
[  190.988291] pci_bus 0000:03: fixups for bus
[  190.988298] PCI: bus3: Fast back to back transfers enabled
[  190.988306] pci_bus 0000:03: bus scan returning with max=03
[  190.988318] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[  190.988335] pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
[  190.994159] pci_bus 0000:04: scanning bus
[  190.994220] pci 0000:04:00.0: [144d:a800] type 00 class 0x010601
[  190.994321] pci 0000:04:00.0: reg 0x24: [mem 0x00000000-0x00001fff]
[  190.994348] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[  190.994377] pci 0000:04:00.0: calling pci_fixup_ide_bases+0x0/0x58
[  190.994474] pci 0000:04:00.0: PME# supported from D3hot D3cold
[  190.994492] pci 0000:04:00.0: PME# disabled
[  191.003803] pci_bus 0000:04: fixups for bus
[  191.003824] PCI: bus4: Fast back to back transfers disabled
[  191.003832] pci_bus 0000:04: bus scan returning with max=04
[  191.003845] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[  191.003861] pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
[  191.009765] pci 0000:02:02.0: BAR 7: assigned [io  0x11000-0x11fff]
[  191.009773] pci 0000:02:03.0: BAR 7: assigned [io  0x12000-0x12fff]
[  191.009785] pci 0000:02:02.0: BAR 8: assigned [mem 0xe0300000-0xe03fffff]
[  191.009794] pci 0000:02:02.0: BAR 9: assigned [mem
0xe0100000-0xe01fffff pref]
[  191.009803] pci 0000:02:03.0: BAR 8: assigned [mem 0xe0400000-0xe05fffff]
[  191.009813] pci 0000:02:03.0: BAR 9: assigned [mem
0xe0600000-0xe07fffff 64bit pref]
[  191.009821] pci 0000:02:02.0: BAR 8: can't assign mem (size 0x100000)
[  191.009829] pci 0000:02:02.0: failed to add 200000 res[8]=[mem
0xe0300000-0xe03fffff]
[  191.009839] pci 0000:02:02.0: BAR 9: can't assign mem pref (size 0x100000)
[  191.009847] pci 0000:02:02.0: failed to add 200000 res[9]=[mem
0xe0100000-0xe01fffff pref]
[  191.009856] pci 0000:02:01.0: BAR 8: assigned [mem 0xe0800000-0xe09fffff]
[  191.009865] pci 0000:02:01.0: BAR 9: can't assign mem pref (size 0x200000)
[  191.009873] pci 0000:02:01.0: PCI bridge to [bus 03]
[  191.009885] pci 0000:02:01.0:   bridge window [io  0x10000-0x10fff]
[  191.009899] pci 0000:02:01.0:   bridge window [mem 0xe0800000-0xe09fffff]
[  191.009920] pci 0000:04:00.0: BAR 6: assigned [mem
0xe0100000-0xe010ffff pref]
[  191.009929] pci 0000:04:00.0: BAR 5: assigned [mem 0xe0300000-0xe0301fff]
[  191.009944] pci 0000:04:00.0: BAR 5: set to [mem
0xe0300000-0xe0301fff] (PCI address [0xe0300000-0xe0301fff])
[  191.009951] pci 0000:02:02.0: PCI bridge to [bus 04]
[  191.009960] pci 0000:02:02.0:   bridge window [io  0x11000-0x11fff]
[  191.009971] pci 0000:02:02.0:   bridge window [mem 0xe0300000-0xe03fffff]
[  191.009982] pci 0000:02:02.0:   bridge window [mem
0xe0100000-0xe01fffff pref]
[  191.009994] pci 0000:02:03.0: PCI bridge to [bus 05]
[  191.010003] pci 0000:02:03.0:   bridge window [io  0x12000-0x12fff]
[  191.010014] pci 0000:02:03.0:   bridge window [mem 0xe0400000-0xe05fffff]
[  191.010024] pci 0000:02:03.0:   bridge window [mem
0xe0600000-0xe07fffff 64bit pref]
[  191.010037] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[  191.010045] pci 0000:01:00.0:   bridge window [io  0x10000-0x12fff]
[  191.010057] pci 0000:01:00.0:   bridge window [mem 0xe0300000-0xe09fffff]
[  191.010067] pci 0000:01:00.0:   bridge window [mem
0xe0100000-0xe01fffff pref]
[  191.010135] pcieport 0000:01:00.0: no of_node; not parsing pinctrl DT
[  191.010177] pcieport 0000:01:00.0: enabling bus mastering
[  191.020457] pcieport 0000:02:01.0: no of_node; not parsing pinctrl DT
[  191.020506] pcieport 0000:02:01.0: enabling bus mastering
[  191.031349] pcieport 0000:02:02.0: no of_node; not parsing pinctrl DT
[  191.031408] pcieport 0000:02:02.0: enabling bus mastering
[  191.032829] pcieport 0000:02:03.0: no of_node; not parsing pinctrl DT
[  191.032876] pcieport 0000:02:03.0: enabling bus mastering
[  191.041427] ahci 0000:04:00.0: no of_node; not parsing pinctrl DT
[  191.041459] ahci 0000:04:00.0: version 3.0
[  191.041474] PCI: enabling device 0000:04:00.0 (0140 -> 0142)
[  191.041510] Unhandled fault: external abort on non-linefetch
(0x1008) at 0xf0460004
[  191.041521] Internal error: : 1008 [#1] PREEMPT SMP ARM
[  191.045460] Modules linked in:
[  191.047237] CPU: 0 PID: 1746 Comm: bash Not tainted 3.14.0-rc7 #24
[  191.052133] task: ee58b440 ti: ee760000 task.ti: ee760000
PC is at ahci_enable_ahci+0x10/0x7c
[  191.059501] LR is at ahci_save_initial_config+0x28/0x24c
[  191.063529] pc : [<c02510e4>]    lr : [<c02512d8>]    psr: 60070013
sp : ee761cb0  ip : ee761cd0  fp : ee761ccc
[  191.072429] r10: 00000000  r9 : 00000000  r8 : 00000000
[  191.076370] r7 : ee6ca468  r6 : f0460000  r5 : eee0dd10  r4 : f0460004
[  191.081613] r3 : 00000000  r2 : 00000000  r1 : eee0dd10  r0 : f0460000
[  191.086859] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  191.092714] Control: 10c53c7d  Table: 2e6e006a  DAC: 00000015
[  191.097177] Process bash (pid: 1746, stack limit = 0xee760240)
[  191.101725] Stack: (0xee761cb0 to 0xee762000)
[  191.104795] 1ca0:                                     ee6ca400
eee0dd10 f0460000 ee6ca468
[  191.111699] 1cc0: ee761cfc ee761cd0 c02512d8 c02510e0 00000000
ee6ca400 ee6ca468 eee0dd10
[  191.118602] 1ce0: 00000000 00000000 ee7e4ec8 00000005 ee761d64
ee761d00 c024e7d0 c02512bc
[  191.125508] 1d00: ee761d34 ee761d10 c00fa3ec eedd67e0 c043f20d
ee761d1c 00000000 00060082
[  191.132411] 1d20: 00000000 0000001f 00000000 0000007f c04d3a04
00000000 ee761d64 ee6ca468
[  191.139316] 1d40: ee6ca400 c04d36f4 00000000 c04d36c0 ee7e4ec8
ee7e4ec0 ee761d8c ee761d68
[  191.146220] 1d60: c01dc230 c024e458 c01dc1d0 ee6ca468 c04d36f4
00000000 c0218c18 00000002
[  191.153124] 1d80: ee761db4 ee761d90 c0218974 c01dc1dc ee6ca468
c0218c18 ee761db4 c04d36f4
[  191.160032] 1da0: ee6ca468 ee6ca468 ee761dcc ee761db8 c0218c48
c0218850 00000000 ee761dd0
[  191.166936] 1dc0: ee761df4 ee761dd0 c0216d30 c0218c24 eec6c7b0
eedd0538 ee6ca468 ee6ca49c
[  191.173840] 1de0: eee95a00 ee761f78 ee761e14 ee761df8 c02187d0
c0216ce8 00000001 ee6ca400
[  191.180745] 1e00: eee95a14 eee95a00 ee761e2c ee761e18 c01d4810
c021876c 00000000 ee6ca400
[  191.187651] 1e20: ee761e4c ee761e30 c01d499c c01d47e0 00000004
ee5fa400 eee95814 eee95800
[  191.194556] 1e40: ee761e6c ee761e50 c01d49ec c01d4970 00000004
eeec8000 eee95c14 eee95c00
1e60: ee761e8c ee761e70 c01d49ec c01d4970 00000004 eed4e000 eee95e14 eee95e00
[  191.208369] 1e80: ee761eac ee761e90 c01d49ec c01d4970 ee761e88
eee95e00 00000005 eee962c0
[  191.215275] 1ea0: ee761ec4 ee761eb0 c037cec0 c01d4970 eee95e00
00000002 ee761ee4 ee761ec8
[  191.222180] 1ec0: c01dd17c c037cea4 00000041 00000001 eec69a68
eee962c0 ee761ef4 ee761ee8
[  191.229088] 1ee0: c0216b00 c01dd140 ee761f0c ee761ef8 c00f6a4c
c0216ae4 00000000 00000000
[  191.235993] 1f00: ee761f44 ee761f10 c00f9cd0 c00f6a14 00000000
00000000 c00a1430 ee480140
[  191.242898] 1f20: 00000002 b6f9e000 ee761f78 00000002 ee760000
b6f9e000 ee761f74 ee761f48
[  191.249807] 1f40: c00a3830 c00f9be8 ee761f74 ee761f58 00000000
00000000 ee480140 ee480140
[  191.256712] 1f60: 00000002 b6f9e000 ee761fa4 ee761f78 c00a3bc8
c00a376c 00000000 00000000
[  191.263614] 1f80: 00000002 b6f9e000 b6edda78 00000004 c000ed84
00000000 00000000 ee761fa8
[  191.270520] 1fa0: c000ec00 c00a3b90 00000002 b6f9e000 00000001
b6f9e000 00000002 00000000
[  191.277424] 1fc0: 00000002 b6f9e000 b6edda78 00000004 00000002
00000002 b6f9e000 00000000
[  191.284330] 1fe0: 00000000 bed35a1c b6e1d390 b6e6eaac 60070010
00000001 00000000 00000000
[  191.291225] Backtrace:
[  191.292402] [<c02510d4>] (ahci_enable_ahci) from [<c02512d8>]
(ahci_save_initial_config+0x28/0x24c)
[  191.300171]  r7:ee6ca468 r6:f0460000 r5:eee0dd10 r4:ee6ca400
[  191.304623] [<c02512b0>] (ahci_save_initial_config) from
[<c024e7d0>] (ahci_init_one+0x384/0x850)
[  191.312216]  r10:00000005 r9:ee7e4ec8 r8:00000000 r7:00000000
r6:eee0dd10 r5:ee6ca468
[  191.318850]  r4:ee6ca400 r3:00000000
[  191.321177] [<c024e44c>] (ahci_init_one) from [<c01dc230>]
(pci_device_probe+0x60/0xa4)
[  191.327900]  r10:ee7e4ec0 r9:ee7e4ec8 r8:c04d36c0 r7:00000000
r6:c04d36f4 r5:ee6ca400
[  191.334530]  r4:ee6ca468
[  191.335792] [<c01dc1d0>] (pci_device_probe) from [<c0218974>]
(driver_probe_device+0x130/0x340)
[  191.343211]  r8:00000002 r7:c0218c18 r6:00000000 r5:c04d36f4
r4:ee6ca468 r3:c01dc1d0
[  191.349766] [<c0218844>] (driver_probe_device) from [<c0218c48>]
(__device_attach+0x30/0x4c)
[  191.356923]  r6:ee6ca468 r5:ee6ca468 r4:c04d36f4
[  191.360307] [<c0218c18>] (__device_attach) from [<c0216d30>]
(bus_for_each_drv+0x54/0x9c)
[  191.367204]  r5:ee761dd0 r4:00000000
[  191.369531] [<c0216cdc>] (bus_for_each_drv) from [<c02187d0>]
(device_attach+0x70/0x88)
[  191.376254]  r7:ee761f78 r6:eee95a00 r5:ee6ca49c r4:ee6ca468
[  191.380700] [<c0218760>] (device_attach) from [<c01d4810>]
(pci_bus_add_device+0x3c/0x68)
[  191.387595]  r6:eee95a00 r5:eee95a14 r4:ee6ca400 r3:00000001
[  191.392044] [<c01d47d4>] (pci_bus_add_device) from [<c01d499c>]
(pci_bus_add_devices+0x38/0x9c)
[  191.399463]  r4:ee6ca400 r3:00000000
[  191.401787] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  191.409293]  r6:eee95800 r5:eee95814 r4:ee5fa400 r3:00000004
[  191.413738] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  191.421244]  r6:eee95c00 r5:eee95c14 r4:eeec8000 r3:00000004
[  191.425692] [<c01d4964>] (pci_bus_add_devices) from [<c01d49ec>]
(pci_bus_add_devices+0x88/0x9c)
[  191.433198]  r6:eee95e00 r5:eee95e14 r4:eed4e000 r3:00000004
[  191.437643] [<c01d4964>] (pci_bus_add_devices) from [<c037cec0>]
(pci_rescan_bus+0x28/0x30)
[  191.444714]  r6:eee962c0 r5:00000005 r4:eee95e00 r3:ee761e88
[  191.449161] [<c037ce98>] (pci_rescan_bus) from [<c01dd17c>]
(bus_rescan_store+0x48/0x70)
[  191.455971]  r5:00000002 r4:eee95e00
[  191.458292] [<c01dd134>] (bus_rescan_store) from [<c0216b00>]
(bus_attr_store+0x28/0x34)
[  191.465102]  r5:eee962c0 r4:eec69a68
[  191.467429] [<c0216ad8>] (bus_attr_store) from [<c00f6a4c>]
(sysfs_kf_write+0x44/0x50)
[  191.474076] [<c00f6a08>] (sysfs_kf_write) from [<c00f9cd0>]
(kernfs_fop_write+0xf4/0x148)
[  191.480973]  r5:00000000 r4:00000000
[  191.483302] [<c00f9bdc>] (kernfs_fop_write) from [<c00a3830>]
(vfs_write+0xd0/0x17c)
[  191.489764]  r10:b6f9e000 r9:ee760000 r8:00000002 r7:ee761f78
r6:b6f9e000 r5:00000002
[  191.496397]  r4:ee480140
[  191.497655] [<c00a3760>] (vfs_write) from [<c00a3bc8>] (SyS_write+0x44/0x84)
[  191.503419]  r10:b6f9e000 r8:00000002 r7:ee480140 r6:ee480140
r5:00000000 r4:00000000
[  191.510063] [<c00a3b84>] (SyS_write) from [<c000ec00>]
(ret_fast_syscall+0x0/0x30)
[  191.516350]  r10:00000000 r8:c000ed84 r7:00000004 r6:b6edda78
r5:b6f9e000 r4:00000002
[  191.522994] Code: e1a0c00d e92dd8f0 e24cb004 e2804004 (e5906004)
[  191.527805] ---[ end trace cab2b46318ba201a ]---



On 1 April 2014 17:41, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
>
> On Mon, Mar 31, 2014 at 03:17:24PM +0100, Matthew Minter wrote:
> > Just to give an update of what I have tried. I noticed that there was
> > a PCI quirk available for a similar PLX chip which forced the kernel
> > to see the slots as hot-plug slots (unfortunately some PLX chips
> > falsely report themselves to be non hotplug capable bridges from my
> > understanding). I tried extending this quirk to run on my chip also.
> > This significantly changed the results in that along with the use of
> > pci=hpmemsize=xM I managed to force the chip to pre-allocate some
> > memory for the hotplug slot. Specifically I added this line:
> > DECLARE_PCI_FIXUP_HEADER(0x10b5, 0x8617, quirk_hotplug_bridge);
> > to linux-3.14-rc7/drivers/pci/quirks.c
>
> This all sounds right to me, it is probably the proper approach,
> things could be refined a bit by adding a DT property to indicate hot
> plug, but that won't help your oops.
>
> The oops kinda looks like something went wrong during a PCI memory
> read.
>
> > Internal error: : 1008 [#1] PREEMPT SMP ARM
>
> Which is a call to die, but the string that should tell us where is ""
> There are cases like that in the kernel, but all are prefixed by
> another line - did a line go missing (Unhandled Fault perhaps?)
>
> First guess would be something went wrong when the mbus windows were
> created after the rescan. Some debugging prints from that part of the
> flow might be informative, as well as a dump from the mbus debugfs..
>
> Second guess, something went wrong during the hot plug, and the PLX is
> not forwarding TLPs.. lpsci -v might give a clue.
>
> > I am currently working on a way to modify the scan order as Jason as
> > suggested, as soon as I have worked out exactly how the scan order is
> > determined I will try modifying the DT or any code needed to force the
> > port with the PLX chip to be scanned last. However I first need to
> > read some more of the code to understand what it orders on, eg: order
> > in DT, bus number, memory address.
>
> That suggestion was a hack, you have found the 'proper' way to do hot
> plug. If you can resolve this oops you should be golden :)
>
> Jason

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
