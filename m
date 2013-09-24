From: olof@lixom.net (Olof Johansson)
Date: Tue, 24 Sep 2013 00:17:18 -0700
Subject: "ASoC: ab8500: Convert register I/O to regmap" breaks snowball
Message-ID: <20130924071718.GA12019@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark, Lee,

[I wasn't subscribed to alsa-devel when the patch was posted, so I'm
sending this as a standalone email instead of as a reply to that]


linux-next 20130924 fails to boot on snowball (u8500_defconfig, non-DT boot):

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc1-00003-gff795d6 #135
task: ef060000 ti: ef064000 task.ti: ef064000
PC is at 0x0
LR is at snd_soc_update_bits+0x4c/0x88
pc : [<00000000>]    lr : [<c02d4f98>]    psr: 60000013
sp : ef065d48  ip : 00000020  fp : ef0d054c
r10: 00000000  r9 : ef3c0810  r8 : 00000000
r7 : 00000014  r6 : 00000000  r5 : 00000007  r4 : ef36ea00
r3 : 00000000  r2 : 00000007  r1 : 00000014  r0 : ef36ea00
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5787d  Table: 0000404a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xef064240)
Stack: (0xef065d48 to 0xef066000)
5d40:                   ef153410 c0550bb8 ef153410 ef36ea00 c053dc64 ef36ea00
5d60: c053dc64 c03d5e0c ef36eaac c02e4144 00000000 02000000 ef36ea00 00000000
5d80: c055a688 ef17bc10 ef0a7b00 c02e4358 00000000 00000000 00000000 ef36ea00
5da0: c055a5dc c055a688 c055daa4 c055aa0c ef36eaac c02d74fc c03d592c c055a678
5dc0: ee8115c8 c055daa4 ef0d00c0 00000000 00000000 c055a668 c03d5bf4 c02d8258
5de0: c055dab4 00000000 00000004 eec2d990 c055db7c ef0d0780 c055dbac c055db9c
5e00: c055a6a8 ef36ea30 ef36ea00 ef0d087c ef0d084c ef36ea30 c04a98f4 c055dac4
5e20: c021ce54 c055daa4 000005b8 c053f7f0 c055da64 c051dde8 00000069 ef064028
5e40: 00000000 c02d8ef0 00000000 c055da50 00000000 c02e684c c05924fc c053f7f0
5e60: 00000000 c055da64 c051dde8 c021bc88 c021bc70 c021aa94 00000000 c053f7f0
5e80: c055da64 c053f824 00000000 c021ac80 00000000 c055da64 c021abf4 c0218f6c
5ea0: ef03265c ef1b6734 c055da64 ef192500 c054fea8 c021a220 c0475770 c055da64
5ec0: 00000006 c055da64 00000006 c0563c80 c0563c80 c021b25c 00000000 c052c5f4
5ee0: 00000006 c0008798 ef010900 c04787e4 ef09c100 c03ac5e0 00000000 00000001
5f00: 000014dc c0540b9c 60000013 00000001 00000003 00000000 c0da19bd c03bf6b0
5f20: 00000069 c0036aa4 c04de34c 00000006 c0da19c8 00000006 00000000 c052c5f4
5f40: 00000006 c0563c80 c0563c80 c05014dc 00000069 c0523fec c0523fe0 c0501bc4
5f60: 00000006 00000006 c05014dc 00000000 88000000 00000000 00000000 00000000
5f80: c03a14ec 00000000 00000000 00000000 00000000 00000000 00000000 c03a14f4
5fa0: 00000000 00000000 c03a14ec c000e438 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 20000000
[<c02d4f98>] (snd_soc_update_bits+0x4c/0x88) from [<c02e4144>] (ab8500_audio_setup_mics+0xc8/0x118)
[<c02e4144>] (ab8500_audio_setup_mics+0xc8/0x118) from [<c02e4358>] (ab8500_codec_probe+0x180/0x374)
[<c02e4358>] (ab8500_codec_probe+0x180/0x374) from [<c02d74fc>] (soc_probe_codec+0x178/0x2f4)
[<c02d74fc>] (soc_probe_codec+0x178/0x2f4) from [<c02d8258>] (snd_soc_instantiate_card+0x794/0x11c0)
[<c02d8258>] (snd_soc_instantiate_card+0x794/0x11c0) from [<c02d8ef0>] (snd_soc_register_card+0x26c/0x324)
[<c02d8ef0>] (snd_soc_register_card+0x26c/0x324) from [<c02e684c>] (mop500_probe+0xd0/0x118)
[<c02e684c>] (mop500_probe+0xd0/0x118) from [<c021bc88>] (platform_drv_probe+0x18/0x1c)
[<c021bc88>] (platform_drv_probe+0x18/0x1c) from [<c021aa94>] (driver_probe_device+0x10c/0x228)
...


I bisected it down to:

commit ff795d614bfa62a3c6fc0bcb75cb8842e5a87892
Author: Mark Brown <broonie@linaro.org>
Date:   Fri Sep 20 10:38:16 2013 +0100

    ASoC: ab8500: Convert register I/O to regmap
    
    As part of a general push to eliminate the duplicated register I/O support
    in ASoC convert ab8500 to use regmap.
    
    Signed-off-by: Mark Brown <broonie@linaro.org>
    Acked-by: Lee Jones <lee.jones@linaro.org>


... but I didn't look closer at what was actually broken.



-Olof
