From: olof@lixom.net (Olof Johansson)
Date: Tue, 30 Jul 2013 22:36:23 -0700
Subject: New dapm panic on beaver with next-20130730
Message-ID: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Lars-Peter,

I noticed the below panic on beaver (Tegra30). Seems like seaboard
(Tegra20) is fine. This is with next-20130730, tegra_defconfig.

I noticed a bunch of recent dapm changes in the asoc tree on the 29th,
and I was able to bisect it down to:

commit 5106b92f80a2cd37c52cffed80b4f5acfb77ccfd
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Mon Jul 29 17:14:00 2013 +0200

    ASoC: dapm: Keep a list of paths per kcontrol

    Currently we store for each path which control (if any at all) is associated
    with that control. But we are only ever interested in the reverse
relationship,
    i.e. we want to know all the paths a certain control is associated
with. This is
    currently implemented by always iterating over all paths. This
patch updates the
    code to keep a list for each control which contains all the paths that are
    associated with that control. This improves the run time of e.g.
    soc_dapm_mixer_update_power() and soc_dapm_mux_update_power() from
O(n) (with n
    being the number of paths for the card) to O(1).

    Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
    Signed-off-by: Mark Brown <broonie@linaro.org>


Panic output is below. I need to figure out why I'm not actually
getting a backtrace in panics any more as well so this is of somewhat
limited use, unfortuantely.

Running a brute force function lookup on all words on the stack gives
a rough idea of call path though:

c03b1bb4   dapm_clear_walk_output
c03b3450   dapm_generic_check_power
c03b56b0   dapm_power_widgets
c03b608c   snd_soc_dapm_new_widgets
[c069f8f8   kallsyms_token_index]
c03ae9fc   soc_post_component_init
c03b0dd0   soc_probe_link_dais
c069abb0   kallsyms_token_index
[c029ac24   devm_kzalloc_release]
c03b1870   snd_soc_register_card
c03c3964   tegra_rt5640_probe
c0707b74   tegra_rt5640_driver_init
c02999e0   platform_drv_probe
c02999c8   platform_drv_probe
c029878c   driver_probe_device


[    1.845620] Unable to handle kernel paging request at virtual
address 6b6b6bd3
[    1.852855] pgd = c0004000
[    1.855552] [6b6b6bd3] *pgd=00000000
[    1.859125] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.864422] Modules linked in:
[    1.867473] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.11.0-rc3-next-20130730 #42
[    1.875023] task: ef064a40 ti: ef074000 task.ti: ef074000
[    1.880421] PC is at dapm_clear_walk_output+0x8/0x68
[    1.885371] LR is at dapm_clear_walk_output+0x54/0x68
[    1.890408] pc : [<c03bb77c>]    lr : [<c03bb7c8>]    psr: 20000113
[    1.890408] sp : ef075ce8  ip : 00000000  fp : 00000010
[    1.901858] r10: ef075d2c  r9 : c076dd00  r8 : c076dbf8
[    1.907066] r7 : ef075d34  r6 : eeb490b8  r5 : 6b6b6bd3  r4 : ef39c4b0
[    1.913574] r3 : 00000069  r2 : 00000192  r1 : 6b6b6bd3  r0 : eeb490b8
[    1.920084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    1.927372] Control: 10c5387d  Table: 8000404a  DAC: 00000015
[    1.933101] Process swapper/0 (pid: 1, stack limit = 0xef074238)
[    1.939090] Stack: (0xef075ce8 to 0xef076000)
[    1.943434] 5ce0:                   ef39c4b0 ef3ad728 eeb490b8
c03bb7c8 ef3ad6c0 00000000
[    1.951591] 5d00: 00000000 c03bd074 c076dcf8 ef3ad6c0 ef075d3c
c03bf310 00000000 c076dcf8
[    1.959747] 5d20: 00000000 eec537f0 c077ca0c ef075d2c ef075d2c
ef075d34 ef075d34 ef075d3c
[    1.967904] 5d40: ef075d3c c01c298c eec66734 ef3ad584 c076dcd4
000000f0 ef3ad5a0 c076dce8
[    1.976060] 5d60: c0587888 00000005 00000010 c03bfcd8 c0587888
00000000 c076dbf8 c076dc34
[    1.984216] 5d80: 00000000 eeb56010 eeb49000 c076dbf8 00000000
c06ab0f8 c076dda8 00000000
[    1.992374] 5da0: 00000002 c03b8618 00000000 00000000 00000000
eeb56010 00000000 ef21e3c0
[    2.000531] 5dc0: c076dbf8 c076dda8 ef21e0c0 00000000 00000002
c03ba9e4 c076dc08 000000d0
[    2.008688] 5de0: ef000500 c076a5a8 c076dd08 00000000 ef21e184
c076dcf8 c076a5ec eeb49000
[    2.016844] 5e00: c076dce0 c076a5a8 ef3b1e8c eeb49034 c06a63ac
c076dc18 c02a2a24 c076dbf8
[    2.025001] 5e20: 000005d4 ef369a90 c17dd4f4 00000000 000000b3
ef074028 00000000 c03bb484
[    2.033157] 5e40: c17dba28 c076db24 ef18ae10 c03cd59c c07bffd8
ef18ae10 00000000 c076db38
[    2.041315] 5e60: c0712a54 c02a17e0 c02a17c8 c02a058c 00000000
ef18ae10 c076db38 ef18ae44
[    2.049471] 5e80: 00000000 c02a0778 00000000 c076db38 c02a06ec
c029eac8 ef06d0e0 ef181d74
[    2.057627] 5ea0: c076db38 ef3af840 c07526d8 c029fd44 c06ab0d4
c076db38 00000006 c076db38
[    2.065783] 5ec0: 00000006 c0777a40 c0777a40 c02a0d54 c07277c0
00000006 c0777a40 c0777a40
[    2.073941] 5ee0: c0712a54 c00089f8 ef025900 c0659cf4 ef1160c0
c053b498 00000000 00000001
[    2.082098] 5f00: 0000027c c073bd78 c17dd77b c0550080 000000b3
c003d884 00000000 c071d9dc
[    2.090254] 5f20: c06937c8 c06ed458 00000006 00000006 c003d198
c003d1f0 00000000 c07277c0
[    2.098411] 5f40: 00000006 c0777a40 c0777a40 c06f027c 000000b3
c071d9dc c071d9d0 c06f0970
[    2.106569] 5f60: 00000006 00000006 c06f027c ffffbfc7 ff7ffffd
fffff7ff 9fffffff 00000000
[    2.114726] 5f80: c0526f58 00000000 00000000 00000000 00000000
00000000 00000000 c0526f60
[    2.122884] 5fa0: 00000000 00000000 c0526f58 c000e578 00000000
00000000 00000000 00000000
[    2.131040] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.139198] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 bf7fcdff eefffeff
[    2.147359] Code: 1affffe1 eafffff5 e92d4070 e1a05001 (e5914000)
[    2.153588] ---[ end trace a5214c5b7e3cefc9 ]---
[    2.158220] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
