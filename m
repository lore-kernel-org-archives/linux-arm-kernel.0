From: pbrobinson@gmail.com (Peter Robinson)
Date: Wed, 5 Aug 2015 11:01:01 +0100
Subject: arm kernel oops in highmem.c with 4.2
Message-ID: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Fedora 23 with recent 4.2 kernels we're seeing a crash (below) in
highmem.c on a fairly regular occurrence across a number of different
SoCs, I've seen it with at least AllWinner A20, i.MX6Q, Tegra2 and 124
with both a LPAE and non LPAE kernel, seen it happen when doing a
number of different things but regenerating a initrd, applying updates
(dnf/yum) and starting X are all pretty good triggers.

I've not seen anyone else report anything similar so I'm wondering if
anyone can give me some assistance and direction in getting to the
bottom of this.

Peter

[71751.658105] ------------[ cut here ]------------
[71751.658153] kernel BUG at arch/arm/mm/highmem.c:114!
[71751.658176] Internal error: Oops - BUG: 0 [#1] SMP ARM
[71751.658200] Modules linked in: fuse ofpart snd_soc_tegra30_i2s
snd_soc_tegra_pcm m25p80 spi_nor mtd snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev
snd_usb_audio snd_usbmidi_lib media snd_rawmidi snd_hda_tegra
snd_soc_rt5640 snd_soc_tegra_rt5640 snd_soc_tegra_utils snd_hda_codec
snd_soc_rl6231 snd_hda_core snd_hwdep snd_soc_tegra30_ahub
snd_soc_core snd_compress snd_pcm_dmaengine ac97_bus snd_seq
snd_seq_device snd_pcm snd_timer snd soundcore tegra_soctherm r8169
nouveau lm90 mii at24 i2c_algo_bit spi_tegra114 ttm tegra_devfreq nfsd
uas usb_storage mmc_block as3722_regulator ehci_tegra gpio_keys
phy_tegra_usb sdhci_tegra sdhci_pltfm sdhci mmc_core ahci_tegra
libahci_platform rtc_tegra i2c_tegra tegra_drm drm_kms_helper
syscopyarea sysfillrect sysimgblt
[71751.659048]  drm host1x
[71751.659099] CPU: 0 PID: 7723 Comm: applydeltarpm Not tainted
4.2.0-0.rc5.git0.1.fc23.armv7hl #1
[71751.659122] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[71751.659148] task: e3482280 ti: e33a8000 task.ti: e33a8000
[71751.659189] PC is at __kunmap_atomic+0x54/0x178
[71751.659222] LR is at copy_page_to_iter+0x15c/0x258
[71751.659246] pc : [<c0222f84>]    lr : [<c052dcf0>]    psr: 800d0013
               sp : e33a9e58  ip : 0000000c  fp : 014791d4
[71751.659269] r10: e33a9f0c  r9 : e33a9f14  r8 : 00001000
[71751.659290] r7 : ffee0000  r6 : 00000000  r5 : c0d48554  r4 : ffedf000
[71751.659310] r3 : fffff000  r2 : fff00000  r1 : 2d84a000  r0 : ffedf000
[71751.659335] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[71751.659360] Control: 10c5387d  Table: ab7fc06a  DAC: 00000015
[71751.659385] Process applydeltarpm (pid: 7723, stack limit = 0xe33a8220)
[71751.659406] Stack: (0xe33a9e58 to 0xe33aa000)
[71751.659428] 9e40:
    e33a9f0c 0000152c
[71751.659454] 9e60: 00000000 c052dcf0 ef43fd1c ffedf000 00001000
00000002 e3451e40 dcc22164
[71751.659482] 9e80: ef43fd1c 00000000 00001000 e33a9f28 0000052c
c032ad54 00000008 00000002
[71751.659506] 9ea0: e33a9f14 00000001 00000000 dcc22078 e3451ea8
00000004 0000f51e 00000000
[71751.659528] 9ec0: ecc67c38 c08d8fd4 c0514dcc c02a6040 ec856e88
00000000 ee5a8480 e3451e40
[71751.659548] 9ee0: 00000000 e33a9f88 00002000 c020fae4 e33a8000
00000000 00000000 c037fe88
[71751.659571] 9f00: 00002000 c020fae4 e33a8000 01478ca8 00002000
00000000 0000052c 00001ad4
[71751.659593] 9f20: e33a9f0c 00000001 e3451e40 00000000 00001ad4
00000000 00000000 00000000
[71751.659615] 9f40: 00000000 00000000 00da0d20 01478ca8 e3451e40
e33a9f88 00002000 c0380550
[71751.659638] 9f60: e3451e40 01478ca8 00002000 e3451e40 e3451e40
01478ca8 00002000 c020fae4
[71751.659660] 9f80: e33a8000 c0380e04 00001ad4 00000000 00002000
01434260 01478ca8 00002000
[71751.659682] 9fa0: 00000003 c020f960 01434260 01478ca8 0000000d
01478ca8 00002000 01478c78
[71751.659706] 9fc0: 01434260 01478ca8 00002000 00000003 00001ad4
00000000 00024000 00000000
[71751.659729] 9fe0: 00000000 be984f14 00015724 b6e435b0 600f0010
0000000d 00000000 00000000
[71751.659782] [<c0222f84>] (__kunmap_atomic) from [<c052dcf0>]
(copy_page_to_iter+0x15c/0x258)
[71751.659822] [<c052dcf0>] (copy_page_to_iter) from [<c032ad54>]
(generic_file_read_iter+0x370/0x5dc)
[71751.659857] [<c032ad54>] (generic_file_read_iter) from [<c037fe88>]
(__vfs_read+0xb0/0xd8)
[71751.659885] [<c037fe88>] (__vfs_read) from [<c0380550>] (vfs_read+0x8c/0x13c)
[71751.659906] [<c0380550>] (vfs_read) from [<c0380e04>] (SyS_read+0x48/0x88)
[71751.659938] [<c0380e04>] (SyS_read) from [<c020f960>]
(ret_fast_syscall+0x0/0x3c)
[71751.659965] Code: e1a03603 e0632002 e1540002 0a000000 (e7f001f2)
[71751.659992] ---[ end trace 701c1dbef773d4cc ]---
[71756.135495] ------------[ cut here ]------------
[71756.135540] kernel BUG at arch/arm/mm/highmem.c:114!
[71756.135562] Internal error: Oops - BUG: 0 [#2] SMP ARM
[71756.135582] Modules linked in: fuse ofpart snd_soc_tegra30_i2s
snd_soc_tegra_pcm m25p80 spi_nor mtd snd_hda_codec_hdmi uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common videodev
snd_usb_audio snd_usbmidi_lib media snd_rawmidi snd_hda_tegra
snd_soc_rt5640 snd_soc_tegra_rt5640 snd_soc_tegra_utils snd_hda_codec
snd_soc_rl6231 snd_hda_core snd_hwdep snd_soc_tegra30_ahub
snd_soc_core snd_compress snd_pcm_dmaengine ac97_bus snd_seq
snd_seq_device snd_pcm snd_timer snd soundcore tegra_soctherm r8169
nouveau lm90 mii at24 i2c_algo_bit spi_tegra114 ttm tegra_devfreq nfsd
uas usb_storage mmc_block as3722_regulator ehci_tegra gpio_keys
phy_tegra_usb sdhci_tegra sdhci_pltfm sdhci mmc_core ahci_tegra
libahci_platform rtc_tegra i2c_tegra tegra_drm drm_kms_helper
syscopyarea sysfillrect sysimgblt
[71756.136307]  drm host1x
[71756.136347] CPU: 1 PID: 7707 Comm: dnf Tainted: G      D
4.2.0-0.rc5.git0.1.fc23.armv7hl #1
[71756.136365] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[71756.136386] task: ea187300 ti: e3386000 task.ti: e3386000
[71756.136439] PC is at __kunmap_atomic+0x54/0x178
[71756.136470] LR is at copy_page_to_iter+0x15c/0x258
[71756.136490] pc : [<c0222f84>]    lr : [<c052dcf0>]    psr: 800d0013
               sp : e3387e58  ip : 000000ef  fp : be81f8a4
[71756.136511] r10: e3387f0c  r9 : e3387f14  r8 : 000002cc
[71756.136530] r7 : ffecf2cc  r6 : 00000000  r5 : c0d48554  r4 : ffecf000
[71756.136545] r3 : 0000f000  r2 : ffef0000  r1 : 2d856000  r0 : ffecf000
[71756.136567] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[71756.136587] Control: 10c5387d  Table: a33cc06a  DAC: 00000015
[71756.136605] Process dnf (pid: 7707, stack limit = 0xe3386220)
[71756.136620] Stack: (0xe3387e58 to 0xe3388000)
[71756.136638] 7e40:
    e3387f0c 000002cc
[71756.136660] 7e60: 00000000 c052dcf0 ef4047c0 ffecf000 000002cc
00000041 ea5a5300 dcc98184
[71756.136682] 7e80: ef4047c0 00000000 000002cc e3387f28 00000000
c032ad54 edfb61c0 c04b6784
[71756.136703] 7ea0: e3387f14 00000040 00000000 dcc98098 ea5a5368
00000042 000412cb 00000000
[71756.136724] 7ec0: 00000000 00000000 ee5b8180 0000b661 edfb6208
00000000 edfb61c0 ea5a5300
[71756.136744] 7ee0: 00000000 e3387f88 00000800 c020fae4 e3386000
00000000 00000004 c037fe88
[71756.136762] 7f00: 00000800 c020fae4 e3386000 be81f8a4 00000800
00000000 00000000 00000800
[71756.136781] 7f20: e3387f0c 00000001 ea5a5300 00000000 00041000
00000000 00000000 00000000
[71756.136803] 7f40: 00000000 00000000 dcc98098 be81f8a4 ea5a5300
e3387f88 00000800 c0380550
[71756.136821] 7f60: ea5a5300 be81f8a4 00000800 ea5a5300 ea5a5302
be81f8a4 00000800 c020fae4
[71756.136841] 7f80: e3386000 c0380e04 00041000 00000000 00000800
be81f8a4 800cb0b8 00000015
[71756.136861] 7fa0: 00000003 c020f960 be81f8a4 800cb0b8 00000015
be81f8a4 00000800 b84c5a6d
[71756.136879] 7fc0: be81f8a4 800cb0b8 00000015 00000003 00000001
b6f97c80 7fe6d3e8 00000004
[71756.136899] 7fe0: 00000000 be81f850 b6f94860 b6d0cad8 800f0010
00000015 00000000 00000000
[71756.136944] [<c0222f84>] (__kunmap_atomic) from [<c052dcf0>]
(copy_page_to_iter+0x15c/0x258)
[71756.136985] [<c052dcf0>] (copy_page_to_iter) from [<c032ad54>]
(generic_file_read_iter+0x370/0x5dc)
[71756.137020] [<c032ad54>] (generic_file_read_iter) from [<c037fe88>]
(__vfs_read+0xb0/0xd8)
[71756.137045] [<c037fe88>] (__vfs_read) from [<c0380550>] (vfs_read+0x8c/0x13c)
[71756.137069] [<c0380550>] (vfs_read) from [<c0380e04>] (SyS_read+0x48/0x88)
[71756.137102] [<c0380e04>] (SyS_read) from [<c020f960>]
(ret_fast_syscall+0x0/0x3c)
[71756.137127] Code: e1a03603 e0632002 e1540002 0a000000 (e7f001f2)
[71756.137151] ---[ end trace 701c1dbef773d4cd ]---
