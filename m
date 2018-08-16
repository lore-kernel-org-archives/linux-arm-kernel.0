From: mh+netdev@zugschlus.de (Marc Haber)
Date: Thu, 16 Aug 2018 22:35:16 +0200
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
Message-ID: <20180816203515.GA7688@torres.zugschlus.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:41:27PM +0100, Peter Robinson wrote:
> So with that and the other fix there was no improvement, with those
> and the BPF JIT disabled it works, I'm not sure if the two patches
> have any effect with the JIT disabled though.

I can confirm the crash with the released 4.18.1 on Banana Pi, and I can
also confirm that disabling BPF JIT makes the Banana Pi work again.,

Greetings
Marc

[    0.004930] /cpus/cpu at 0 missing clock-frequency property
[    0.004965] /cpus/cpu at 1 missing clock-frequency property
[    4.959858] zswap: default zpool zbud not available
[    4.964820] zswap: pool creation failed
  WARNING: Failed to connect to lvmetad. Falling back to device scanning.
  WARNING: Failed to connect to lvmetad. Falling back to device scanning.
[   10.721077] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[   10.722949] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[   10.729288] pgd = (ptrval)
[   10.729299] [0000000c] *pgd=6dc65003, *pmd=00000000
[   10.737464] pgd = (ptrval)
[   10.740176] Internal error: Oops: a06 [#1] SMP ARM
[   10.745056] [0000000c] *pgd=6e72a003
[   10.747742] Modules linked in: ip_tables x_tables autofs4 btrfs
[   10.752561] , *pmd=00000000
[   10.756113]  libcrc32c crc32c_generic xor zstd_decompress zstd_compress xxhash
[   10.764833]  zlib_deflate raid6_pq dm_mod dax axp20x_regulator realtek ahci_sunxi dwmac_sunxi stmmac_platform libahci_platform stmmac i2c_mv64xxx libahci libata scsi_mod ohci_platform ohci_hcd ehci_platform ehci_hcd phy_sun4i_usb sunxi_mmc
[   10.793306] CPU: 1 PID: 238 Comm: systemd-udevd Not tainted 4.18.1-zgbpi-armmp-lpae #3
[   10.801212] Hardware name: Allwinner sun7i (A20) Family
[   10.806448] PC is at sk_filter_trim_cap+0xa0/0x1d4
[   10.811238] LR is at   (null)
[   10.814205] pc : [<c06de388>]    lr : [<00000000>]    psr: 600f0013
[   10.820466] sp : edc7dcf8  ip : 00000000  fp : edc7dd34
[   10.825686] r10: 00000000  r9 : 00000000  r8 : 00000000
[   10.830907] r7 : 00000001  r6 : f0e96000  r5 : c0e04cc8  r4 : 00000000
[   10.837428] r3 : 00000007  r2 : fb5e2d70  r1 : 00000000  r0 : 00000000
[   10.843952] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   10.851081] Control: 30c5387d  Table: 6e6c7580  DAC: 2c983336
[   10.856822] Process systemd-udevd (pid: 238, stack limit = 0x(ptrval))
[   10.863344] Stack: (0xedc7dcf8 to 0xedc7e000)
[   10.867700] dce0:                                                       edc7dd1c edc7dd08
[   10.875873] dd00: c06a41dc c06a4048 ee7d39c0 fb5e2d70 ee479800 ee6c2400 edc33840 c0e6aac0
[   10.884046] dd20: 00000000 00000001 edc7dd8c edc7dd38 c0705884 c06de2f4 edc7de24 00000001
[   10.892219] dd40: c0ec649c ee479864 00000000 00000000 ee7d39c0 00000000 00000000 00000002
[   10.900391] dd60: 00000000 edc7df44 c0e04cc8 ee7d39c0 ee6c2400 00000000 0000008c 00000002
[   10.908565] dd80: edc7ddf4 edc7dd90 c0705ee0 c0705610 006000c0 00000000 00000000 fb5e2d70
[   10.916737] dda0: 00000008 00000000 00000000 ef357c80 00000000 000000ee 00000000 00000000
[   10.924910] ddc0: 00000000 fb5e2d70 0000008c edc7df44 eef08700 00000040 00000000 eef08700
[   10.933083] dde0: 00000000 edc7dedc edc7de0c edc7ddf8 c069b948 c0705b78 edc7df44 c0e04cc8
[   10.941256] de00: edc7df2c edc7de10 c069c2f8 c069b910 c0e04cc8 edc7dec0 00000000 be8dcfac
[   10.949428] de20: 00000028 0186a660 00000064 bf387954 edc7df48 be8dcf80 00000000 00000000
[   10.957602] de40: be8dcf80 b6f19ce8 00000128 40000028 b6e01346 00000000 0000000e 00000010
[   10.965774] de60: 00000000 00000002 00000000 00000000 00000000 00000000 be8dcf80 00000000
[   10.973948] de80: b6f19ce8 00000000 00000000 fb5e2d70 edc7deb4 ffffe000 00000000 c0e04cc8
[   10.982120] dea0: 00000128 c0201204 00000000 00000080 edc7df6c edc7dec0 c02f5e2c c02f5c18
[   10.990293] dec0: 00000000 fb5e2d70 edc7def4 a0010013 c9f1e000 c03f986c edc7df50 00000000
[   10.998466] dee0: 0000000e 00004000 edc7df3c fb5e2d70 c0409c98 c0409d34 edc7df14 fb5e2d70
[   11.006639] df00: c0409d34 c0e04cc8 be8dcf80 00000000 eef08700 c0201204 edc7c000 00000128
[   11.014812] df20: edc7df94 edc7df30 c069d818 c069c0a0 00000000 00000000 c0e04cc8 00000000
[   11.022984] df40: fffffff7 edc7de5c 0000000c 00000001 00000000 00000000 edc7de2c 00000000
[   11.031156] df60: edc7df7c 00000000 00000000 00000040 00000000 fb5e2d70 be8dcf80 b6f19ce8
[   11.039329] df80: 01878670 00000128 edc7dfa4 edc7df98 c069d870 c069d7c4 00000000 edc7dfa8
[   11.047502] dfa0: c02011cc c069d860 be8dcf80 b6f19ce8 0000000e be8dcf80 00000000 00000000
[   11.055675] dfc0: be8dcf80 b6f19ce8 01878670 00000128 00000000 00000064 01878e80 00000000
[   11.063848] dfe0: 00000128 be8dcf50 b6e003e3 b6e01346 200f0030 0000000e 00000000 00000000
[   11.072038] [<c06de388>] (sk_filter_trim_cap) from [<c0705884>] (netlink_broadcast_filtered+0x280/0x460)
[   11.081517] [<c0705884>] (netlink_broadcast_filtered) from [<c0705ee0>] (netlink_sendmsg+0x374/0x3b0)
[   11.090734] [<c0705ee0>] (netlink_sendmsg) from [<c069b948>] (sock_sendmsg+0x44/0x54)
[   11.098567] [<c069b948>] (sock_sendmsg) from [<c069c2f8>] (___sys_sendmsg+0x264/0x278)
[   11.106485] [<c069c2f8>] (___sys_sendmsg) from [<c069d818>] (__sys_sendmsg+0x60/0x9c)
[   11.114315] [<c069d818>] (__sys_sendmsg) from [<c069d870>] (sys_sendmsg+0x1c/0x20)
[   11.121886] [<c069d870>] (sys_sendmsg) from [<c02011cc>] (__sys_trace_return+0x0/0x10)
[   11.129793] Exception stack(0xedc7dfa8 to 0xedc7dff0)
[   11.134845] dfa0:                   be8dcf80 b6f19ce8 0000000e be8dcf80 00000000 00000000
[   11.143019] dfc0: be8dcf80 b6f19ce8 01878670 00000128 00000000 00000064 01878e80 00000000
[   11.151188] dfe0: 00000128 be8dcf50 b6e003e3 b6e01346
[   11.156243] Code: e3130010 e1a0c000 1a000030 e35c0000 (e584900c) 
[   11.162340] Internal error: Oops: a06 [#2] SMP ARM
[   11.162559] ---[ end trace 1b60255ae59ac006 ]---
[   11.167129] Modules linked in: ip_tables x_tables autofs4 btrfs libcrc32c crc32c_generic xor zstd_decompress zstd_compress xxhash zlib_deflate raid6_pq dm_mod dax axp20x_regulator realtek ahci_sunxi dwmac_sunxi stmmac_platform libahci_platform stmmac i2c_mv64xxx libahci libata scsi_mod ohci_platform ohci_hcd ehci_platform ehci_hcd phy_sun4i_usb sunxi_mmc
[   11.185005] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[   11.203186] CPU: 0 PID: 237 Comm: systemd-udevd Tainted: G      D           4.18.1-zgbpi-armmp-lpae #3
[   11.203191] Hardware name: Allwinner sun7i (A20) Family
[   11.203216] PC is at sk_filter_trim_cap+0xa0/0x1d4
[   11.203223] LR is at   (null)
[   11.203229] pc : [<c06de388>]    lr : [<00000000>]    psr: 600f0013
[   11.203234] sp : edc41cf8  ip : 00000000  fp : edc41d34
[   11.203239] r10: 00000000  r9 : 00000000  r8 : 00000000
[   11.203245] r7 : 00000001  r6 : f0e96000  r5 : c0e04cc8  r4 : 00000000
[   11.203250] r3 : 00000007  r2 : fb5e2d70  r1 : 00000000  r0 : 00000000
[   11.203258] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   11.203264] Control: 30c5387d  Table: 6e6c84c0  DAC: fffffffd
[   11.203270] Process systemd-udevd (pid: 237, stack limit = 0x(ptrval))
[   11.203276] Stack: (0xedc41cf8 to 0xedc42000)
[   11.203288] 1ce0:                                                       edc41d1c edc41d08
[   11.211398] pgd = (ptrval)
[   11.220660] 1d00: c06a41dc c06a4048 c9c16cc0 fb5e2d70 ee479800 ee6c6400 c9c16240 c0e6aac0
[   11.220670] 1d20: 00000000 00000001 edc41d8c edc41d38 c0705884 c06de2f4 edc41e24 00000001
[   11.220680] 1d40: c0ec649c ee479864 00000000 00000000 c9c16cc0 00000000 00000000 00000002
[   11.220693] 1d60: 00000000 edc41f44 c0e04cc8 c9c16cc0 ee6c6400 00000000 00000085 00000002
[   11.226034] [0000000c] *pgd=6dc79003
[   11.230697] 1d80: edc41df4 edc41d90 c0705ee0 c0705610 006000c0 00000000 00000000 fb5e2d70
[   11.230707] 1da0: 00000008 00000000 00000000 ef357300 00000000 000000ed 00000000 00000000
[   11.230717] 1dc0: 00000000 fb5e2d70 00000085 edc41f44 ee0591c0 00000040 00000000 ee0591c0
[   11.230730] 1de0: 00000000 edc41edc edc41e0c edc41df8 c069b948 c0705b78 edc41f44 c0e04cc8
[   11.233692] , *pmd=00000000
[   11.239953] 1e00: edc41f2c edc41e10 c069c2f8 c069b910 c0e04cc8 edc41ec0 00000000 be8dcfac
[   11.239963] 1e20: 00000028 0186a660 0000005d bf387954 edc41f48 be8dcf80 00000000 00000000
[   11.239973] 1e40: be8dcf80 b6f19ce8 00000128 40000028 b6e01346 00000000 0000000d 00000010
[   11.239982] 1e60: 00000000 00000002 00000000 00000000 00000000 00000000 be8dcf80 00000000
[   11.239992] 1e80: b6f19ce8 00000000 00000000 fb5e2d70 edc41eb4 ffffe000 00000000 c0e04cc8
[   11.240002] 1ea0: 00000128 c0201204 00000000 00000080 edc41f6c edc41ec0 c02f5e2c c02f5c18
[   11.250433] 1ec0: 00000000 fb5e2d70 edc41ef4 a0010013 c9def000 c03f986c edc41f50 00000000
[   11.250443] 1ee0: 0000000d 00004000 edc41f3c fb5e2d70 c0409c98 c0409d34 edc41f14 fb5e2d70
[   11.250454] 1f00: c0409d34 c0e04cc8 be8dcf80 00000000 ee0591c0 c0201204 edc40000 00000128
[   11.250463] 1f20: edc41f94 edc41f30 c069d818 c069c0a0 00000000 00000000 c0e04cc8 00000000
[   11.451342] 1f40: fffffff7 edc41e5c 0000000c 00000001 00000000 00000000 edc41e2c 00000000
[   11.459515] 1f60: edc41f7c 00000000 00000000 00000040 00000000 fb5e2d70 be8dcf80 b6f19ce8
[   11.467688] 1f80: 0186d740 00000128 edc41fa4 edc41f98 c069d870 c069d7c4 00000000 edc41fa8
[   11.475861] 1fa0: c02011cc c069d860 be8dcf80 b6f19ce8 0000000d be8dcf80 00000000 00000000
[   11.484034] 1fc0: be8dcf80 b6f19ce8 0186d740 00000128 00000000 0000005d 018776c0 00000000
[   11.492207] 1fe0: 00000128 be8dcf50 b6e003e3 b6e01346 200f0030 0000000d 00000000 00000000
[   11.500397] [<c06de388>] (sk_filter_trim_cap) from [<c0705884>] (netlink_broadcast_filtered+0x280/0x460)
[   11.509876] [<c0705884>] (netlink_broadcast_filtered) from [<c0705ee0>] (netlink_sendmsg+0x374/0x3b0)
[   11.519093] [<c0705ee0>] (netlink_sendmsg) from [<c069b948>] (sock_sendmsg+0x44/0x54)
[   11.526925] [<c069b948>] (sock_sendmsg) from [<c069c2f8>] (___sys_sendmsg+0x264/0x278)
[   11.534842] [<c069c2f8>] (___sys_sendmsg) from [<c069d818>] (__sys_sendmsg+0x60/0x9c)
[   11.542673] [<c069d818>] (__sys_sendmsg) from [<c069d870>] (sys_sendmsg+0x1c/0x20)
[   11.550244] [<c069d870>] (sys_sendmsg) from [<c02011cc>] (__sys_trace_return+0x0/0x10)
[   11.558151] Exception stack(0xedc41fa8 to 0xedc41ff0)
[   11.563202] 1fa0:                   be8dcf80 b6f19ce8 0000000d be8dcf80 00000000 00000000
[   11.571375] 1fc0: be8dcf80 b6f19ce8 0186d740 00000128 00000000 0000005d 018776c0 00000000
[   11.579544] 1fe0: 00000128 be8dcf50 b6e003e3 b6e01346
[   11.584600] Code: e3130010 e1a0c000 1a000030 e35c0000 (e584900c) 
[   11.590702] Internal error: Oops: a06 [#3] SMP ARM
[   11.590859] ---[ end trace 1b60255ae59ac007 ]---
[   11.595493] Modules linked in: ip_tables x_tables autofs4 btrfs libcrc32c crc32c_generic xor zstd_decompress zstd_compress xxhash zlib_deflate raid6_pq dm_mod dax axp20x_regulator realtek ahci_sunxi dwmac_sunxi stmmac_platform libahci_platform stmmac i2c_mv64xxx libahci libata scsi_mod ohci_platform ohci_hcd ehci_platform ehci_hcd phy_sun4i_usb sunxi_mmc
[   11.602116] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[   11.631550] CPU: 1 PID: 240 Comm: systemd-udevd Tainted: G      D           4.18.1-zgbpi-armmp-lpae #3
[   11.631555] Hardware name: Allwinner sun7i (A20) Family
[   11.631576] PC is at sk_filter_trim_cap+0xa0/0x1d4
[   11.631582] LR is at   (null)
[   11.631593] pc : [<c06de388>]    lr : [<00000000>]    psr: 600f0013
[   11.639693] pgd = (ptrval)
[   11.648959] sp : edc81cf8  ip : 00000000  fp : edc81d34
[   11.648964] r10: 00000000  r9 : 00000000  r8 : 00000000
[   11.648970] r7 : 00000001  r6 : f0e96000  r5 : c0e04cc8  r4 : 00000000
[   11.648976] r3 : 00000007  r2 : fb5e2d70  r1 : 00000000  r0 : 00000000
[   11.648983] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   11.648990] Control: 30c5387d  Table: 6e71a180  DAC: 2c983336
[   11.654224] [0000000c] *pgd=6dc6e003
[   11.658989] Process systemd-udevd (pid: 240, stack limit = 0x(ptrval))
[   11.658995] Stack: (0xedc81cf8 to 0xedc82000)
[   11.659002] 1ce0:                                                       edc81d1c edc81d08
[   11.659013] 1d00: c06a41dc c06a4048 ee7d36c0 fb5e2d70 ee479800 edc77800 ee7d3d80 c0e6aac0
[   11.661987] , *pmd=00000000
[   11.668231] 1d20: 00000000 00000001 edc81d8c edc81d38 c0705884 c06de2f4 edc81e24 00000001
[   11.668241] 1d40: c0ec649c ee479864 00000000 00000000 ee7d36c0 00000000 00000000 00000002
[   11.668251] 1d60: 00000000 edc81f44 c0e04cc8 ee7d36c0 edc77800 00000000 0000008a 00000002
[   11.676168] 1d80: edc81df4 edc81d90 c0705ee0 c0705610 006000c0 00000000 00000000 fb5e2d70
[   11.676178] 1da0: 00000008 00000000 00000000 ef0ea980 00000000 000000f0 00000000 00000000
[   11.676188] 1dc0: 00000000 fb5e2d70 0000008a edc81f44 ee059a80 00000040 00000000 ee059a80
[   11.789803] 1de0: 00000000 edc81edc edc81e0c edc81df8 c069b948 c0705b78 edc81f44 c0e04cc8
[   11.797977] 1e00: edc81f2c edc81e10 c069c2f8 c069b910 c0e04cc8 edc81ec0 00000000 be8dcfac
[   11.806149] 1e20: 00000028 0186ade8 00000062 bf387954 edc81f48 be8dcf80 00000000 00000000
[   11.814322] 1e40: be8dcf80 b6f19ce8 00000128 40000028 b6e01346 00000000 0000000e 00000010
[   11.822494] 1e60: 00000000 00000002 00000000 00000000 00000000 00000000 be8dcf80 00000000
[   11.830667] 1e80: b6f19ce8 00000000 00000000 fb5e2d70 edc81eb4 ffffe000 00000000 c0e04cc8
[   11.838840] 1ea0: 00000128 c0201204 00000000 00000080 edc81f6c edc81ec0 c02f5e2c c02f5c18
[   11.847013] 1ec0: 00000000 fb5e2d70 edc81ef4 a00b0013 ef3c3000 c03f986c edc81f50 00000000
[   11.855186] 1ee0: 0000000e 00004000 edc81f3c fb5e2d70 c0409c98 c0409d34 edc81f14 fb5e2d70
[   11.863359] 1f00: c0409d34 c0e04cc8 be8dcf80 00000000 ee059a80 c0201204 edc80000 00000128
[   11.871532] 1f20: edc81f94 edc81f30 c069d818 c069c0a0 00000000 00000000 c0e04cc8 00000000
[   11.879705] 1f40: fffffff7 edc81e5c 0000000c 00000001 00000000 00000000 edc81e2c 00000000
[   11.887877] 1f60: edc81f7c 00000000 00000000 00000040 00000000 fb5e2d70 be8dcf80 b6f19ce8
[   11.896051] 1f80: 0186aea0 00000128 edc81fa4 edc81f98 c069d870 c069d7c4 00000000 edc81fa8
[   11.904223] 1fa0: c02011cc c069d860 be8dcf80 b6f19ce8 0000000e be8dcf80 00000000 00000000
[   11.912397] 1fc0: be8dcf80 b6f19ce8 0186aea0 00000128 00000000 00000062 0186b6e8 00000000
[   11.920569] 1fe0: 00000128 be8dcf50 b6e003e3 b6e01346 200f0030 0000000e 00000000 00000000
[   11.928757] [<c06de388>] (sk_filter_trim_cap) from [<c0705884>] (netlink_broadcast_filtered+0x280/0x460)
[   11.938235] [<c0705884>] (netlink_broadcast_filtered) from [<c0705ee0>] (netlink_sendmsg+0x374/0x3b0)
[   11.947452] [<c0705ee0>] (netlink_sendmsg) from [<c069b948>] (sock_sendmsg+0x44/0x54)
[   11.955284] [<c069b948>] (sock_sendmsg) from [<c069c2f8>] (___sys_sendmsg+0x264/0x278)
[   11.963201] [<c069c2f8>] (___sys_sendmsg) from [<c069d818>] (__sys_sendmsg+0x60/0x9c)
[   11.971031] [<c069d818>] (__sys_sendmsg) from [<c069d870>] (sys_sendmsg+0x1c/0x20)
[   11.978602] [<c069d870>] (sys_sendmsg) from [<c02011cc>] (__sys_trace_return+0x0/0x10)
[   11.986509] Exception stack(0xedc81fa8 to 0xedc81ff0)
[   11.991560] 1fa0:                   be8dcf80 b6f19ce8 0000000e be8dcf80 00000000 00000000
[   11.999732] 1fc0: be8dcf80 b6f19ce8 0186aea0 00000128 00000000 00000062 0186b6e8 00000000
[   12.007902] 1fe0: 00000128 be8dcf50 b6e003e3 b6e01346
[   12.012957] Code: e3130010 e1a0c000 1a000030 e35c0000 (e584900c) 
[   12.019056] Internal error: Oops: a06 [#4] SMP ARM
[   12.019171] ---[ end trace 1b60255ae59ac008 ]---


-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
