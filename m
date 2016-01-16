From: rabin@rab.in (Rabin Vincent)
Date: Sat, 16 Jan 2016 14:54:23 +0100
Subject: [PATCH V7 02/24] coresight: associating path with session rather
 than tracer
In-Reply-To: <CANLsYkz2t1ytWUiV-i2tfe4J1Yfuyg6fiWL0nrNGA9QCph-XWQ@mail.gmail.com>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
 <20151220152939.GA11552@debian>
 <CANLsYkwhC0fSqrZrHH+P68Dev1j6n19o=2g8kJpZfzBMTbcNdA@mail.gmail.com>
 <20160105131505.GA32528@debian>
 <CANLsYkwN=SOnfDfd8oF-2Z5Ef8oTPao6H_auQhoMpVAnokYkrg@mail.gmail.com>
 <20160110154326.GB13903@debian>
 <CANLsYkz2t1ytWUiV-i2tfe4J1Yfuyg6fiWL0nrNGA9QCph-XWQ@mail.gmail.com>
Message-ID: <20160116135423.GA29682@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 02:47:10PM -0700, Mathieu Poirier wrote:
> On 10 January 2016 at 08:43, Rabin Vincent <rabin@rab.in> wrote:
> >   - There is no reference taken for the csdev when it is assigned as
> >     some other device's child_dev in coresight_orphan_match()
> 
> The only time a device shouldn't be removed is when it is part of an
> active trace session, something that shouldn't happen due to the
> static nature of the coresight devices.

# echo 1 > /sys/bus/coresight/devices/54162000.etb/enable_sink
# echo 1 > /sys/bus/coresight/devices/5414c000.ptm/enable_source
[   22.853637] coresight-etb10 54162000.etb: ETB enabled
[   22.859069] coresight-funnel 54164000.funnel: FUNNEL inport 0 enabled
[   22.865814] coresight-replicator 44000000.ocp:replicator: REPLICATOR enabled
[   22.873260] coresight-funnel 54158000.funnel: FUNNEL inport 0 enabled
[   22.880187] coresight-etm3x 5414c000.ptm: ETM tracing enabled
# echo 44000000.ocp\:replicator > /sys/bus/platform/drivers/coresight-replicator/unbind
# echo 0 > /sys/bus/coresight/devices/5414c000.ptm/enable_source
[   37.261840] coresight-etm3x 5414c000.ptm: ETM tracing disabled
[   37.268066] Unable to handle kernel NULL pointer dereference at virtual address 0000023c
[   37.276611] pgd = ec60c000
[   37.279571] [0000023c] *pgd=ac5d6831, *pte=00000000, *ppte=00000000
[   37.286163] Internal error: Oops: 817 [#1] SMP ARM
[   37.291198] Modules linked in:
[   37.294403] CPU: 0 PID: 857 Comm: sh Not tainted 4.4.0-rc8-00063-g15ed5a7c725c #196
[   37.302429] Hardware name: Generic OMAP4 (Flattened Device Tree)
[   37.308715] task: ec873500 ti: ec5a4000 task.ti: ec5a4000
[   37.314392] PC is at coresight_build_paths+0x24/0x324
[   37.319702] LR is at coresight_build_paths+0x84/0x324
[   37.324981] pc : [<c041b7a0>]    lr : [<c041b800>]    psr: 20000013
[   37.324981] sp : ec5a5db0  ip : ec5a5dd8  fp : ec5a5dd4
[   37.337005] r10: ec5a5f80  r9 : ec62b3cc  r8 : 00000000
[   37.342498] r7 : ffffffea  r6 : ec5a5e28  r5 : 00000000  r4 : 00000001
[   37.349334] r3 : 0000023c  r2 : 00000000  r1 : eca231bc  r0 : 00000000
[   37.356170] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   37.363647] Control: 10c5387d  Table: ac60c04a  DAC: 00000051
[   37.369659] Process sh (pid: 857, stack limit = 0xec5a4218)
[   37.375488] Stack: (0xec5a5db0 to 0xec5a6000)
[   37.380065] 5da0:                                     00000001 eca22f80 ec5a5e28 ffffffea
[   37.388641] 5dc0: 00000000 ec62b3cc ec5a5dfc ec5a5dd8 c041b800 c041b788 00000001 eca21300
[   37.397216] 5de0: ec5a5e28 ffffffea 00000000 ec62b3cc ec5a5e24 ec5a5e00 c041b800 c041b788
[   37.405792] 5e00: eca21300 ec5a5e28 00000000 00000000 ec5d7f00 ec62b3cc ec5a5e4c ec5a5e28
[   37.414367] 5e20: c041bb50 c041b788 eca231bc eca2153c ec5a5e4c eca21320 00000002 ec5d7f00
[   37.422912] 5e40: ec5a5e6c ec5a5e50 c041bd74 c041baac c008ca48 00000000 c041bd2c ec62b3c0
[   37.431488] 5e60: ec5a5e84 ec5a5e70 c031118c c041bd38 c031116c ec62b3c0 ec5a5ea4 ec5a5e88
[   37.440063] 5e80: c01db338 c0311178 ec62b3c0 00000002 00000000 00000000 ec5a5edc ec5a5ea8
[   37.448638] 5ea0: c01da8f8 c01db2f4 00000000 00000000 c0830b74 ed62bc00 c01da834 00000002
[   37.457214] 5ec0: ec5a5f80 c0010964 ec5a4000 00000000 ec5a5f4c ec5a5ee0 c016135c c01da840
[   37.465789] 5ee0: ec56253c 00000001 ec5a5f24 ec5a5ef8 c008b0a8 c008afc4 00000001 00000000
[   37.474365] 5f00: c0164988 00000000 ec5a5f4c 00000001 00000002 00000000 ec5a5f4c ec5a5f28
[   37.482910] 5f20: c0164988 c008b05c ed62bc00 00000002 000ab600 ec5a5f80 c0010964 ec5a4000
[   37.491485] 5f40: ec5a5f7c ec5a5f50 c0161c88 c0161334 000ab600 00000002 ec5a5f7c ed62bc00
[   37.500061] 5f60: ed62bc00 000ab600 00000002 c0010964 ec5a5fa4 ec5a5f80 c01624f8 c0161bfc
[   37.508636] 5f80: 00000000 00000000 00000002 000ab600 00000001 00000004 00000000 ec5a5fa8
[   37.517211] 5fa0: c00107c0 c01624b8 00000002 000ab600 00000001 000ab600 00000002 00000000
[   37.525756] 5fc0: 00000002 000ab600 00000001 00000004 00000001 00000002 000a82c8 00000000
[   37.534332] 5fe0: 00000001 beec4650 0000e4f0 b6e94d3c 60000010 00000001 00000000 00000000
[   37.542907] Backtrace: 
[   37.545501] [<c041b77c>] (coresight_build_paths) from [<c041b800>] (coresight_build_paths+0x84/0x324)
[   37.555145]  r9:ec62b3cc r8:00000000 r7:ffffffea r6:ec5a5e28 r5:eca22f80 r4:00000001
[   37.563293] [<c041b77c>] (coresight_build_paths) from [<c041b800>] (coresight_build_paths+0x84/0x324)
[   37.572937]  r9:ec62b3cc r8:00000000 r7:ffffffea r6:ec5a5e28 r5:eca21300 r4:00000001
[   37.581115] [<c041b77c>] (coresight_build_paths) from [<c041bb50>] (coresight_disable+0xb0/0xf8)
[   37.590332]  r9:ec62b3cc r8:ec5d7f00 r7:00000000 r6:00000000 r5:ec5a5e28 r4:eca21300
[   37.598480] [<c041baa0>] (coresight_disable) from [<c041bd74>] (enable_source_store+0x48/0x68)
[   37.607482]  r6:ec5d7f00 r5:00000002 r4:eca21320
[   37.612335] [<c041bd2c>] (enable_source_store) from [<c031118c>] (dev_attr_store+0x20/0x2c)
[   37.621093]  r5:ec62b3c0 r4:c041bd2c
[   37.624847] [<c031116c>] (dev_attr_store) from [<c01db338>] (sysfs_kf_write+0x50/0x54)
[   37.633148]  r5:ec62b3c0 r4:c031116c
[   37.636932] [<c01db2e8>] (sysfs_kf_write) from [<c01da8f8>] (kernfs_fop_write+0xc4/0x1c0)
[   37.645477]  r7:00000000 r6:00000000 r5:00000002 r4:ec62b3c0
[   37.651458] [<c01da834>] (kernfs_fop_write) from [<c016135c>] (__vfs_write+0x34/0xe4)
[   37.659667]  r10:00000000 r9:ec5a4000 r8:c0010964 r7:ec5a5f80 r6:00000002 r5:c01da834
[   37.667877]  r4:ed62bc00
[   37.670562] [<c0161328>] (__vfs_write) from [<c0161c88>] (vfs_write+0x98/0x174)
[   37.678222]  r9:ec5a4000 r8:c0010964 r7:ec5a5f80 r6:000ab600 r5:00000002 r4:ed62bc00
[   37.686370] [<c0161bf0>] (vfs_write) from [<c01624f8>] (SyS_write+0x4c/0xa8)
[   37.693756]  r8:c0010964 r7:00000002 r6:000ab600 r5:ed62bc00 r4:ed62bc00
[   37.700836] [<c01624ac>] (SyS_write) from [<c00107c0>] (ret_fast_syscall+0x0/0x1c)
[   37.708740]  r7:00000004 r6:00000001 r5:000ab600 r4:00000002
[   37.714721] Code: e1a08002 e5911000 e1a05000 e5813004 (e580123c) 
[   37.721160] ---[ end trace 1ba9515a1c17777a ]---
