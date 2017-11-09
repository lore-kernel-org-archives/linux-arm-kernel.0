From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Thu, 09 Nov 2017 17:01:35 +0200
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <CAEzXK1odLNgPTG_cAEqg8d2r_WbnqnVcCvAYQCHkRr4DgAHvhQ@mail.gmail.com>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
 <20171109082317.predibr5vv2d33i2@phenom.ffwll.local>
 <20171109093122.GA12318@n2100.armlinux.org.uk> <87inejaiij.fsf@intel.com>
 <CAEzXK1qHEcB6f_uGPJk9RxSd+tP5rNuiutBN1FAkEv-nU1k5Ug@mail.gmail.com>
 <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
 <87efp7abwi.fsf@intel.com>
 <CAEzXK1odLNgPTG_cAEqg8d2r_WbnqnVcCvAYQCHkRr4DgAHvhQ@mail.gmail.com>
Message-ID: <878tffa434.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Nov 2017, Lu?s Mendes <luis.p.mendes@gmail.com> wrote:
> Hi Jani,
>
> I tried:
> git clone git://people.freedesktop.org/~airlied/linux -b drm-next
> --depth=1 --single-branch
>
> I got this:
> EDID isn't loaded from file
>
> # cat /proc/cmdline
> console=ttymxc0,115200 root=/dev/sda2 rw video=HDMI-A-1:1920x1080M at 60
> drm.edid_firmware=edid/ktc_edid.bin dw_hdmi.dyndbg=+pfl cma=128M

Please try adding D at the end of your video= parameter to force
connector on. Otherwise it'll do a ddc probe which apparently fails with
your display.

BR,
Jani.

>
> #zcat /proc/config.gz  | grep EDID
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_FIRMWARE_EDID is not set
>
> #cat /sys/class/drm/card1-HDMI-A-1/edid
> <empty>
>
> dmesg output follows below...
>
> Regards,
> Lu?s Mendes
>
> [    7.381500] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller
> v1.30a with HDCP (DWC HDMI 3D TX PHY)
> [    7.409108] hdmi_set_clk_regenerator:521: dwhdmi-imx 120000.hdmi:
> hdmi_set_clk_regenerator: fs=48000Hz ftdms=74.250MHz N=6144 cts=74250
> [    7.411001] dw_hdmi_irq:2146: dwhdmi-imx 120000.hdmi: EVENT=plugin
> [    7.421524] imx-drm display-subsystem: bound 120000.hdmi (ops
> dw_hdmi_imx_ops [dw_hdmi_imx])
> [    7.481948] dw_hdmi_connector_get_modes:1917: dwhdmi-imx
> 120000.hdmi: failed to get edid
> [    7.537018] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
> [    7.549254] ------------[ cut here ]------------
> [    7.549303] WARNING: CPU: 2 PID: 219 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    7.549308] This function requires support for accurate vblank timestamps.
> [    7.549312] Modules linked in: snd_soc_imx_spdif(+)
> snd_soc_fsl_asoc_card(+) snd_ac97_codec coda videobuf2_dma_contig
> imx_vdoa v4l2_mem2mem videobuf2_vmalloc videobuf2_memops dw_hdmi_imx
> imxdrm(+) dw_hdmi cec etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev
> lp parport
> [    7.549396] CPU: 2 PID: 219 Comm: systemd-udevd Tainted: G        W
>       4.14.0-rc7-gd65d313-dirty #1
> [    7.549401] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    7.549405] Backtrace:
> [    7.549427] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    7.549436]  r7:c106eed0 r6:00000000 r5:600d0193 r4:c106eed0
> [    7.549465] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    7.549486] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    7.549496]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    7.549501]  r4:edd15688 r3:00000000
> [    7.549514] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    7.549523]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    7.549535] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    7.549540]  r3:00000000 r2:c0d50064
> [    7.549544]  r4:edc2f000
> [    7.549553] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    7.549560]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:eeb3e400
> [    7.549614] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    7.549620]  r5:eeb3e680 r4:edc2b018
> [    7.549653] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    7.549660]  r5:eeb3e680 r4:00000018
> [    7.549682] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    7.549691]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:eeb3e680 r5:bf0ab088
> [    7.549695]  r4:eeb3e680
> [    7.549723] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    7.549732]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    7.549737]  r4:eeb3e680 r3:bf0a8174
> [    7.549762] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    7.549780]  r5:00000000 r4:eeb3e680
> [    7.549820] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    7.549843]  r7:eeb3e680 r6:edc2f000 r5:eeb3e680 r4:00000000
> [    7.549865] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    7.549874]  r7:eeb3e680 r6:00000001 r5:0000003f r4:000000a0
> [    7.549886] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c0501724>] (restore_fbdev_mode+0x30/0x168)
> [    7.549895]  r10:edf57800 r9:c17e5a70 r8:00000000 r7:edf56e00
> r6:c17e5bc8 r5:edf56ed0
> [    7.549899]  r4:edf56e00
> [    7.549914] [<c05016f4>] (restore_fbdev_mode) from [<c0504740>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8+0x28/0x7c)
> [    7.549925]  r10:edf57800 r9:c17e5a70 r8:00000000 r7:c1022ed8
> r6:c17e5bc8 r5:edf56ed0
> [    7.549931]  r4:edf56e00
> [    7.549943] [<c0504718>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8) from [<c0504834>]
> (drm_fb_helper_set_par+0x5c/0x8c)
> [    7.549950]  r7:c1022ed8 r6:c17e5bc8 r5:edfe3400 r4:00000000
> [    7.549972] [<c05047d8>] (drm_fb_helper_set_par) from [<c0496768>]
> (fbcon_init+0x564/0x5b0)
> [    7.549977]  r5:edfe3400 r4:ee808c00
> [    7.549992] [<c0496204>] (fbcon_init) from [<c04daae8>]
> (visual_init+0xcc/0x114)
> [    7.550001]  r10:00000001 r9:ee808c00 r8:c17ebfb4 r7:00000000
> r6:ee808e08 r5:00000000
> [    7.550005]  r4:ee808c00
> [    7.550016] [<c04daa1c>] (visual_init) from [<c04dc12c>]
> (do_bind_con_driver+0x1b4/0x394)
> [    7.550023]  r7:00000000 r6:00000000 r5:c17ebea0 r4:c0b3e0dc
> [    7.550033] [<c04dbf78>] (do_bind_con_driver) from [<c04dc700>]
> (do_take_over_console+0x15c/0x1c4)
> [    7.550041]  r10:00000001 r9:0000003e r8:00000000 r7:c17ebeb0
> r6:00000000 r5:00000000
> [    7.550045]  r4:00000000
> [    7.550057] [<c04dc5a4>] (do_take_over_console) from [<c0496830>]
> (do_fbcon_takeover+0x7c/0xd4)
> [    7.550065]  r10:edfe3694 r9:edfe3400 r8:00000000 r7:00000000
> r6:00000005 r5:c17e5a70
> [    7.550069]  r4:c1022ed8
> [    7.550080] [<c04967b4>] (do_fbcon_takeover) from [<c049a2d0>]
> (fbcon_event_notify+0x8c8/0x908)
> [    7.550086]  r5:c1022ed8 r4:c17e5a70
> [    7.550105] [<c0499a08>] (fbcon_event_notify) from [<c0147b5c>]
> (notifier_call_chain+0x4c/0x8c)
> [    7.550114]  r10:edfe3694 r9:edfe340c r8:00000000 r7:00000000
> r6:00000005 r5:edd15ab0
> [    7.550118]  r4:ffffffff
> [    7.550129] [<c0147b10>] (notifier_call_chain) from [<c0147fec>]
> (__blocking_notifier_call_chain+0x50/0x68)
> [    7.550138]  r9:edfe340c r8:c17e5a38 r7:ffffffff r6:edd15ab0
> r5:c1022cfc r4:00000005
> [    7.550150] [<c0147f9c>] (__blocking_notifier_call_chain) from
> [<c0148024>] (blocking_notifier_call_chain+0x20/0x28)
> [    7.550156]  r7:00000000 r6:c1007f10 r5:edfe3400 r4:c1007f10
> [    7.550178] [<c0148004>] (blocking_notifier_call_chain) from
> [<c048b8fc>] (fb_notifier_call_chain+0x20/0x24)
> [    7.550188] [<c048b8dc>] (fb_notifier_call_chain) from [<c048d8a0>]
> (register_framebuffer+0x1f8/0x2ac)
> [    7.550206] [<c048d6a8>] (register_framebuffer) from [<c05043f4>]
> (__drm_fb_helper_initial_config_and_unlock+0x220/0x414)
> [    7.550214]  r10:bf0a855c r9:00000000 r8:00000000 r7:c1031728
> r6:edc2f000 r5:edfe3400
> [    7.550218]  r4:edf56e00
> [    7.550230] [<c05041d4>]
> (__drm_fb_helper_initial_config_and_unlock) from [<c0504628>]
> (drm_fb_helper_initial_config+0x40/0x44)
> [    7.550238]  r10:bf0a855c r9:c1031d28 r8:00000010 r7:c0b450e0
> r6:edc2f000 r5:00000010
> [    7.550242]  r4:edf56e00
> [    7.550253] [<c05045e8>] (drm_fb_helper_initial_config) from
> [<c0504a9c>] (drm_fbdev_cma_init_with_funcs+0x88/0x100)
> [    7.550258]  r5:00000000 r4:edf56e00
> [    7.550269] [<c0504a14>] (drm_fbdev_cma_init_with_funcs) from
> [<c0504b28>] (drm_fbdev_cma_init+0x14/0x1c)
> [    7.550277]  r9:c1031d28 r8:00000000 r7:ed638c90 r6:eea12010
> r5:bf0ac000 r4:edc2f000
> [    7.550314] [<c0504b14>] (drm_fbdev_cma_init) from [<bf0a83e4>]
> (imx_drm_bind+0xf4/0x178 [imxdrm])
> [    7.550346] [<bf0a82f0>] (imx_drm_bind [imxdrm]) from [<c0532e7c>]
> (try_to_bring_up_master+0x25c/0x2dc)
> [    7.550355]  r9:c1031d28 r8:ed638450 r7:ed638940 r6:00000008
> r5:000000a0 r4:ed4d9580
> [    7.550367] [<c0532c20>] (try_to_bring_up_master) from [<c0532fac>]
> (component_add+0xb0/0x178)
> [    7.550375]  r10:00000000 r9:bf0ac160 r8:00000000 r7:ed638ac0
> r6:c1031d20 r5:00000000
> [    7.550380]  r4:ed638940
> [    7.550412] [<c0532efc>] (component_add) from [<bf0a8f2c>]
> (ipu_drm_probe+0x80/0xa4 [imxdrm])
> [    7.550439]  r9:bf0ac160 r8:00000000 r7:fffffdfb r6:bf0ac160
> r5:eddcfc10 r4:eddcfde0
> [    7.550499] [<bf0a8eac>] (ipu_drm_probe [imxdrm]) from [<c053b140>]
> (platform_drv_probe+0x58/0xb8)
> [    7.550508]  r5:ffffffed r4:eddcfc10
> [    7.550522] [<c053b0e8>] (platform_drv_probe) from [<c053926c>]
> (driver_probe_device+0x2d0/0x47c)
> [    7.550529]  r7:c17ee208 r6:c1075608 r5:c17ee204 r4:eddcfc10
> [    7.550542] [<c0538f9c>] (driver_probe_device) from [<c0539524>]
> (__driver_attach+0x10c/0x128)
> [    7.550551]  r10:bf0ac280 r9:c053b0e8 r8:00000000 r7:c1075530
> r6:bf0ac160 r5:eddcfc44
> [    7.550555]  r4:eddcfc10
> [    7.550564] [<c0539418>] (__driver_attach) from [<c0537160>]
> (bus_for_each_dev+0x70/0xa4)
> [    7.550572]  r7:c1075530 r6:c0539418 r5:bf0ac160 r4:00000000
> [    7.550582] [<c05370f0>] (bus_for_each_dev) from [<c0538a58>]
> (driver_attach+0x24/0x28)
> [    7.550588]  r6:c1032490 r5:edd76c00 r4:bf0ac160
> [    7.550598] [<c0538a34>] (driver_attach) from [<c0538438>]
> (bus_add_driver+0x1ac/0x26c)
> [    7.550611] [<c053828c>] (bus_add_driver) from [<c0539f80>]
> (driver_register+0x80/0xfc)
> [    7.550618]  r8:c053b0a4 r7:c053aa50 r6:c1075830 r5:00000001 r4:bf0ac160
> [    7.550629] [<c0539f00>] (driver_register) from [<c053b2ac>]
> (__platform_register_drivers+0x80/0x164)
> [    7.550634]  r5:00000001 r4:bf0ab090
> [    7.550664] [<c053b22c>] (__platform_register_drivers) from
> [<bf0b0020>] (imx_drm_init+0x20/0x1000 [imxdrm])
> [    7.550672]  r10:edd15f40 r9:edeb9070 r8:bf0ac2c8 r7:edeb9980
> r6:00000000 r5:bf0b0000
> [    7.550676]  r4:ffffe000
> [    7.550701] [<bf0b0000>] (imx_drm_init [imxdrm]) from [<c0101ba4>]
> (do_one_initcall+0x4c/0x174)
> [    7.550717] [<c0101b58>] (do_one_initcall) from [<c01b0880>]
> (do_init_module+0x68/0x1fc)
> [    7.550725]  r9:edeb9070 r8:bf0ac2c8 r6:bf0ac280 r5:00000001 r4:bf0ac280
> [    7.550735] [<c01b0818>] (do_init_module) from [<c01af89c>]
> (load_module+0x2064/0x270c)
> [    7.550741]  r7:edeb9040 r6:bf0ac280 r5:00000001 r4:00000001
> [    7.550750] [<c01ad838>] (load_module) from [<c01b01c4>]
> (SyS_finit_module+0xbc/0xf8)
> [    7.550759]  r10:00000000 r9:edd14000 r8:c0108da4 r7:0000017b
> r6:b6e24d40 r5:0000000f
> [    7.550764]  r4:00000000
> [    7.550776] [<c01b0108>] (SyS_finit_module) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    7.550781]  r6:00000000 r5:bebb39f4 r4:7778f500
> [    7.550790] ---[ end trace 3e19c988c4369e1b ]---
> [    7.590815] imx-spdif sound-spdif: snd-soc-dummy-dai <->
> 2004000.spdif mapping ok
> [    7.616586] dw_hdmi_setup:1679: dwhdmi-imx 120000.hdmi: Non-CEA
> mode used in HDMI
> [    7.616616] hdmi_av_composer:1495: dwhdmi-imx 120000.hdmi: final
> pixclk = 173106000
> [    7.616670] dw_hdmi_phy_power_off:1096: dwhdmi-imx 120000.hdmi: PHY
> powered down in 0 iterations
> [    7.678961] dw_hdmi_phy_power_on:1133: dwhdmi-imx 120000.hdmi: PHY
> PLL locked 1 iterations
> [    7.678991] dw_hdmi_phy_power_off:1096: dwhdmi-imx 120000.hdmi: PHY
> powered down in 0 iterations
> [    7.733710] dw_hdmi_phy_power_on:1133: dwhdmi-imx 120000.hdmi: PHY
> PLL locked 1 iterations
> [    7.733749] dw_hdmi_setup:1744: dwhdmi-imx 120000.hdmi:
> dw_hdmi_setup DVI mode
> [    7.734455] ------------[ cut here ]------------
> [    7.734483] WARNING: CPU: 2 PID: 219 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    7.734491] This function requires support for accurate vblank timestamps.
> [    7.734495] Modules linked in: snd_soc_imx_sgtl5000
> snd_soc_imx_spdif snd_soc_fsl_asoc_card snd_ac97_codec coda
> videobuf2_dma_contig imx_vdoa v4l2_mem2mem videobuf2_vmalloc
> videobuf2_memops dw_hdmi_imx imxdrm(+) dw_hdmi cec etnaviv imx_ipu_v3
> binfmt_misc parport_pc ppdev lp parport
> [    7.734575] CPU: 2 PID: 219 Comm: systemd-udevd Tainted: G        W
>       4.14.0-rc7-gd65d313-dirty #1
> [    7.734580] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    7.734584] Backtrace:
> [    7.734601] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    7.734609]  r7:c106eed0 r6:00000000 r5:600f0093 r4:c106eed0
> [    7.734627] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    7.734643] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    7.734652]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    7.734657]  r4:edd15520 r3:00000000
> [    7.734667] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    7.734675]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    7.734686] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    7.734691]  r3:00000000 r2:c0d50064
> [    7.734695]  r4:edc2f000
> [    7.734705] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    7.734711]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:edeb5b00
> [    7.734751] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    7.734757]  r5:edeb5700 r4:edc2b018
> [    7.734785] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    7.734791]  r5:edeb5700 r4:00000018
> [    7.734811] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    7.734821]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:edeb5700 r5:bf0ab088
> [    7.734825]  r4:edeb5700
> [    7.734848] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    7.734857]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    7.734862]  r4:edeb5700 r3:bf0a8174
> [    7.734872] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    7.734878]  r5:00000000 r4:edeb5700
> [    7.734895] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    7.734902]  r7:edeb5700 r6:edc2f000 r5:edeb5700 r4:00000000
> [    7.734916] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    7.734922]  r7:edeb5700 r6:00000001 r5:0000003f r4:000000a0
> [    7.734933] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    7.734942]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    7.734946]  r4:edf56e00
> [    7.734966] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    7.734974]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    7.734979]  r4:edfe3400 r3:00000000
> [    7.734993] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    7.735002]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    7.735007]  r4:edf57800 r3:c049a648
> [    7.735017] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    7.735022]  r5:edfe3400 r4:ee808dc8
> [    7.735034] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    7.735043]  r10:00000000 r9:00000000 r8:fffffe20 r7:00000001
> r6:00000000 r5:00000000
> [    7.735047]  r4:ee808c00
> [    7.735056] [<c04db4cc>] (redraw_screen) from [<c0496174>]
> (fbcon_prepare_logo+0x354/0x3e4)
> [    7.735064]  r8:fffffe20 r7:00000043 r6:00000000 r5:00000000 r4:ee808c00
> [    7.735076] [<c0495e20>] (fbcon_prepare_logo) from [<c04965d4>]
> (fbcon_init+0x3d0/0x5b0)
> [    7.735084]  r10:edf57800 r9:c17e5a70 r8:c17e5bc8 r7:c1022ed8
> r6:c17e5bc8 r5:edfe3400
> [    7.735088]  r4:ee808c00
> [    7.735097] [<c0496204>] (fbcon_init) from [<c04daae8>]
> (visual_init+0xcc/0x114)
> [    7.735105]  r10:00000001 r9:ee808c00 r8:c17ebfb4 r7:00000000
> r6:ee808e08 r5:00000000
> [    7.735109]  r4:ee808c00
> [    7.735118] [<c04daa1c>] (visual_init) from [<c04dc12c>]
> (do_bind_con_driver+0x1b4/0x394)
> [    7.735125]  r7:00000000 r6:00000000 r5:c17ebea0 r4:c0b3e0dc
> [    7.735135] [<c04dbf78>] (do_bind_con_driver) from [<c04dc700>]
> (do_take_over_console+0x15c/0x1c4)
> [    7.735143]  r10:00000001 r9:0000003e r8:00000000 r7:c17ebeb0
> r6:00000000 r5:00000000
> [    7.735147]  r4:00000000
> [    7.735156] [<c04dc5a4>] (do_take_over_console) from [<c0496830>]
> (do_fbcon_takeover+0x7c/0xd4)
> [    7.735164]  r10:edfe3694 r9:edfe3400 r8:00000000 r7:00000000
> r6:00000005 r5:c17e5a70
> [    7.735168]  r4:c1022ed8
> [    7.735178] [<c04967b4>] (do_fbcon_takeover) from [<c049a2d0>]
> (fbcon_event_notify+0x8c8/0x908)
> [    7.735183]  r5:c1022ed8 r4:c17e5a70
> [    7.735200] [<c0499a08>] (fbcon_event_notify) from [<c0147b5c>]
> (notifier_call_chain+0x4c/0x8c)
> [    7.735208]  r10:edfe3694 r9:edfe340c r8:00000000 r7:00000000
> r6:00000005 r5:edd15ab0
> [    7.735212]  r4:ffffffff
> [    7.735223] [<c0147b10>] (notifier_call_chain) from [<c0147fec>]
> (__blocking_notifier_call_chain+0x50/0x68)
> [    7.735232]  r9:edfe340c r8:c17e5a38 r7:ffffffff r6:edd15ab0
> r5:c1022cfc r4:00000005
> [    7.735242] [<c0147f9c>] (__blocking_notifier_call_chain) from
> [<c0148024>] (blocking_notifier_call_chain+0x20/0x28)
> [    7.735248]  r7:00000000 r6:c1007f10 r5:edfe3400 r4:c1007f10
> [    7.735260] [<c0148004>] (blocking_notifier_call_chain) from
> [<c048b8fc>] (fb_notifier_call_chain+0x20/0x24)
> [    7.735272] [<c048b8dc>] (fb_notifier_call_chain) from [<c048d8a0>]
> (register_framebuffer+0x1f8/0x2ac)
> [    7.735289] [<c048d6a8>] (register_framebuffer) from [<c05043f4>]
> (__drm_fb_helper_initial_config_and_unlock+0x220/0x414)
> [    7.735297]  r10:bf0a855c r9:00000000 r8:00000000 r7:c1031728
> r6:edc2f000 r5:edfe3400
> [    7.735301]  r4:edf56e00
> [    7.735315] [<c05041d4>]
> (__drm_fb_helper_initial_config_and_unlock) from [<c0504628>]
> (drm_fb_helper_initial_config+0x40/0x44)
> [    7.735323]  r10:bf0a855c r9:c1031d28 r8:00000010 r7:c0b450e0
> r6:edc2f000 r5:00000010
> [    7.735327]  r4:edf56e00
> [    7.735339] [<c05045e8>] (drm_fb_helper_initial_config) from
> [<c0504a9c>] (drm_fbdev_cma_init_with_funcs+0x88/0x100)
> [    7.735345]  r5:00000000 r4:edf56e00
> [    7.735356] [<c0504a14>] (drm_fbdev_cma_init_with_funcs) from
> [<c0504b28>] (drm_fbdev_cma_init+0x14/0x1c)
> [    7.735364]  r9:c1031d28 r8:00000000 r7:ed638c90 r6:eea12010
> r5:bf0ac000 r4:edc2f000
> [    7.735394] [<c0504b14>] (drm_fbdev_cma_init) from [<bf0a83e4>]
> (imx_drm_bind+0xf4/0x178 [imxdrm])
> [    7.735422] [<bf0a82f0>] (imx_drm_bind [imxdrm]) from [<c0532e7c>]
> (try_to_bring_up_master+0x25c/0x2dc)
> [    7.735431]  r9:c1031d28 r8:ed638450 r7:ed638940 r6:00000008
> r5:000000a0 r4:ed4d9580
> [    7.735441] [<c0532c20>] (try_to_bring_up_master) from [<c0532fac>]
> (component_add+0xb0/0x178)
> [    7.735449]  r10:00000000 r9:bf0ac160 r8:00000000 r7:ed638ac0
> r6:c1031d20 r5:00000000
> [    7.735453]  r4:ed638940
> [    7.735473] [<c0532efc>] (component_add) from [<bf0a8f2c>]
> (ipu_drm_probe+0x80/0xa4 [imxdrm])
> [    7.735482]  r9:bf0ac160 r8:00000000 r7:fffffdfb r6:bf0ac160
> r5:eddcfc10 r4:eddcfde0
> [    7.735510] [<bf0a8eac>] (ipu_drm_probe [imxdrm]) from [<c053b140>]
> (platform_drv_probe+0x58/0xb8)
> [    7.735516]  r5:ffffffed r4:eddcfc10
> [    7.735530] [<c053b0e8>] (platform_drv_probe) from [<c053926c>]
> (driver_probe_device+0x2d0/0x47c)
> [    7.735537]  r7:c17ee208 r6:c1075608 r5:c17ee204 r4:eddcfc10
> [    7.735548] [<c0538f9c>] (driver_probe_device) from [<c0539524>]
> (__driver_attach+0x10c/0x128)
> [    7.735556]  r10:bf0ac280 r9:c053b0e8 r8:00000000 r7:c1075530
> r6:bf0ac160 r5:eddcfc44
> [    7.735560]  r4:eddcfc10
> [    7.735570] [<c0539418>] (__driver_attach) from [<c0537160>]
> (bus_for_each_dev+0x70/0xa4)
> [    7.735577]  r7:c1075530 r6:c0539418 r5:bf0ac160 r4:00000000
> [    7.735586] [<c05370f0>] (bus_for_each_dev) from [<c0538a58>]
> (driver_attach+0x24/0x28)
> [    7.735594]  r6:c1032490 r5:edd76c00 r4:bf0ac160
> [    7.735604] [<c0538a34>] (driver_attach) from [<c0538438>]
> (bus_add_driver+0x1ac/0x26c)
> [    7.735614] [<c053828c>] (bus_add_driver) from [<c0539f80>]
> (driver_register+0x80/0xfc)
> [    7.735621]  r8:c053b0a4 r7:c053aa50 r6:c1075830 r5:00000001 r4:bf0ac160
> [    7.735632] [<c0539f00>] (driver_register) from [<c053b2ac>]
> (__platform_register_drivers+0x80/0x164)
> [    7.735637]  r5:00000001 r4:bf0ab090
> [    7.735663] [<c053b22c>] (__platform_register_drivers) from
> [<bf0b0020>] (imx_drm_init+0x20/0x1000 [imxdrm])
> [    7.735671]  r10:edd15f40 r9:edeb9070 r8:bf0ac2c8 r7:edeb9980
> r6:00000000 r5:bf0b0000
> [    7.735675]  r4:ffffe000
> [    7.735698] [<bf0b0000>] (imx_drm_init [imxdrm]) from [<c0101ba4>]
> (do_one_initcall+0x4c/0x174)
> [    7.735715] [<c0101b58>] (do_one_initcall) from [<c01b0880>]
> (do_init_module+0x68/0x1fc)
> [    7.735723]  r9:edeb9070 r8:bf0ac2c8 r6:bf0ac280 r5:00000001 r4:bf0ac280
> [    7.735732] [<c01b0818>] (do_init_module) from [<c01af89c>]
> (load_module+0x2064/0x270c)
> [    7.735739]  r7:edeb9040 r6:bf0ac280 r5:00000001 r4:00000001
> [    7.735748] [<c01ad838>] (load_module) from [<c01b01c4>]
> (SyS_finit_module+0xbc/0xf8)
> [    7.735757]  r10:00000000 r9:edd14000 r8:c0108da4 r7:0000017b
> r6:b6e24d40 r5:0000000f
> [    7.735761]  r4:00000000
> [    7.735776] [<c01b0108>] (SyS_finit_module) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    7.735782]  r6:00000000 r5:bebb39f4 r4:7778f500
> [    7.735788] ---[ end trace 3e19c988c4369e1c ]---
> [    7.748484] Console: switching to colour frame buffer device 240x67
> [    7.799927] ------------[ cut here ]------------
> [    7.799956] WARNING: CPU: 2 PID: 219 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    7.799962] This function requires support for accurate vblank timestamps.
> [    7.799966] Modules linked in: snd_soc_imx_sgtl5000
> snd_soc_imx_spdif snd_soc_fsl_asoc_card snd_ac97_codec coda
> videobuf2_dma_contig imx_vdoa v4l2_mem2mem videobuf2_vmalloc
> videobuf2_memops dw_hdmi_imx imxdrm(+) dw_hdmi cec etnaviv imx_ipu_v3
> binfmt_misc parport_pc ppdev lp parport
> [    7.800052] CPU: 2 PID: 219 Comm: systemd-udevd Tainted: G        W
>       4.14.0-rc7-gd65d313-dirty #1
> [    7.800057] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    7.800061] Backtrace:
> [    7.800081] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    7.800090]  r7:c106eed0 r6:00000000 r5:600f0093 r4:c106eed0
> [    7.800115] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    7.800134] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    7.800143]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    7.800148]  r4:edd155f0 r3:00000000
> [    7.800158] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    7.800166]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    7.800177] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    7.800182]  r3:00000000 r2:c0d50064
> [    7.800186]  r4:edc2f000
> [    7.800196] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    7.800203]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:edd94900
> [    7.800249] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    7.800257]  r5:edeb6480 r4:edc2b018
> [    7.800304] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    7.800323]  r5:edeb6480 r4:00000018
> [    7.800360] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    7.800374]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:edeb6480 r5:bf0ab088
> [    7.800386]  r4:edeb6480
> [    7.800424] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    7.800446]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    7.800459]  r4:edeb6480 r3:bf0a8174
> [    7.800471] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    7.800477]  r5:00000000 r4:edeb6480
> [    7.800497] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    7.800513]  r7:edeb6480 r6:edc2f000 r5:edeb6480 r4:00000000
> [    7.800541] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    7.800559]  r7:edeb6480 r6:00000001 r5:0000003f r4:000000a0
> [    7.800579] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    7.800601]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    7.800617]  r4:edf56e00
> [    7.800661] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    7.800688]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    7.800700]  r4:edfe3400 r3:00000000
> [    7.800727] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    7.800746]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    7.800763]  r4:edf57800 r3:c049a648
> [    7.800793] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    7.800810]  r5:edfe3400 r4:ee808dc8
> [    7.800836] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    7.800846]  r10:c17ebe94 r9:00000000 r8:c0d3ede8 r7:00000001
> r6:00000000 r5:00000000
> [    7.800857]  r4:ee808c00
> [    7.800883] [<c04db4cc>] (redraw_screen) from [<c04dc234>]
> (do_bind_con_driver+0x2bc/0x394)
> [    7.800902]  r8:c0d3ede8 r7:00000001 r6:00000000 r5:c17ebe94 r4:00000000
> [    7.800926] [<c04dbf78>] (do_bind_con_driver) from [<c04dc700>]
> (do_take_over_console+0x15c/0x1c4)
> [    7.800949]  r10:00000001 r9:0000003e r8:00000000 r7:c17ebeb0
> r6:00000000 r5:00000000
> [    7.800957]  r4:00000000
> [    7.800969] [<c04dc5a4>] (do_take_over_console) from [<c0496830>]
> (do_fbcon_takeover+0x7c/0xd4)
> [    7.800979]  r10:edfe3694 r9:edfe3400 r8:00000000 r7:00000000
> r6:00000005 r5:c17e5a70
> [    7.800983]  r4:c1022ed8
> [    7.800994] [<c04967b4>] (do_fbcon_takeover) from [<c049a2d0>]
> (fbcon_event_notify+0x8c8/0x908)
> [    7.801000]  r5:c1022ed8 r4:c17e5a70
> [    7.801028] [<c0499a08>] (fbcon_event_notify) from [<c0147b5c>]
> (notifier_call_chain+0x4c/0x8c)
> [    7.801049]  r10:edfe3694 r9:edfe340c r8:00000000 r7:00000000
> r6:00000005 r5:edd15ab0
> [    7.801060]  r4:ffffffff
> [    7.801090] [<c0147b10>] (notifier_call_chain) from [<c0147fec>]
> (__blocking_notifier_call_chain+0x50/0x68)
> [    7.801110]  r9:edfe340c r8:c17e5a38 r7:ffffffff r6:edd15ab0
> r5:c1022cfc r4:00000005
> [    7.801123] [<c0147f9c>] (__blocking_notifier_call_chain) from
> [<c0148024>] (blocking_notifier_call_chain+0x20/0x28)
> [    7.801130]  r7:00000000 r6:c1007f10 r5:edfe3400 r4:c1007f10
> [    7.801143] [<c0148004>] (blocking_notifier_call_chain) from
> [<c048b8fc>] (fb_notifier_call_chain+0x20/0x24)
> [    7.801155] [<c048b8dc>] (fb_notifier_call_chain) from [<c048d8a0>]
> (register_framebuffer+0x1f8/0x2ac)
> [    7.801173] [<c048d6a8>] (register_framebuffer) from [<c05043f4>]
> (__drm_fb_helper_initial_config_and_unlock+0x220/0x414)
> [    7.801182]  r10:bf0a855c r9:00000000 r8:00000000 r7:c1031728
> r6:edc2f000 r5:edfe3400
> [    7.801187]  r4:edf56e00
> [    7.801200] [<c05041d4>]
> (__drm_fb_helper_initial_config_and_unlock) from [<c0504628>]
> (drm_fb_helper_initial_config+0x40/0x44)
> [    7.801209]  r10:bf0a855c r9:c1031d28 r8:00000010 r7:c0b450e0
> r6:edc2f000 r5:00000010
> [    7.801213]  r4:edf56e00
> [    7.801225] [<c05045e8>] (drm_fb_helper_initial_config) from
> [<c0504a9c>] (drm_fbdev_cma_init_with_funcs+0x88/0x100)
> [    7.801230]  r5:00000000 r4:edf56e00
> [    7.801241] [<c0504a14>] (drm_fbdev_cma_init_with_funcs) from
> [<c0504b28>] (drm_fbdev_cma_init+0x14/0x1c)
> [    7.801249]  r9:c1031d28 r8:00000000 r7:ed638c90 r6:eea12010
> r5:bf0ac000 r4:edc2f000
> [    7.801283] [<c0504b14>] (drm_fbdev_cma_init) from [<bf0a83e4>]
> (imx_drm_bind+0xf4/0x178 [imxdrm])
> [    7.801314] [<bf0a82f0>] (imx_drm_bind [imxdrm]) from [<c0532e7c>]
> (try_to_bring_up_master+0x25c/0x2dc)
> [    7.801323]  r9:c1031d28 r8:ed638450 r7:ed638940 r6:00000008
> r5:000000a0 r4:ed4d9580
> [    7.801333] [<c0532c20>] (try_to_bring_up_master) from [<c0532fac>]
> (component_add+0xb0/0x178)
> [    7.801341]  r10:00000000 r9:bf0ac160 r8:00000000 r7:ed638ac0
> r6:c1031d20 r5:00000000
> [    7.801345]  r4:ed638940
> [    7.801366] [<c0532efc>] (component_add) from [<bf0a8f2c>]
> (ipu_drm_probe+0x80/0xa4 [imxdrm])
> [    7.801374]  r9:bf0ac160 r8:00000000 r7:fffffdfb r6:bf0ac160
> r5:eddcfc10 r4:eddcfde0
> [    7.801400] [<bf0a8eac>] (ipu_drm_probe [imxdrm]) from [<c053b140>]
> (platform_drv_probe+0x58/0xb8)
> [    7.801406]  r5:ffffffed r4:eddcfc10
> [    7.801417] [<c053b0e8>] (platform_drv_probe) from [<c053926c>]
> (driver_probe_device+0x2d0/0x47c)
> [    7.801424]  r7:c17ee208 r6:c1075608 r5:c17ee204 r4:eddcfc10
> [    7.801443] [<c0538f9c>] (driver_probe_device) from [<c0539524>]
> (__driver_attach+0x10c/0x128)
> [    7.801455]  r10:bf0ac280 r9:c053b0e8 r8:00000000 r7:c1075530
> r6:bf0ac160 r5:eddcfc44
> [    7.801460]  r4:eddcfc10
> [    7.801480] [<c0539418>] (__driver_attach) from [<c0537160>]
> (bus_for_each_dev+0x70/0xa4)
> [    7.801496]  r7:c1075530 r6:c0539418 r5:bf0ac160 r4:00000000
> [    7.801522] [<c05370f0>] (bus_for_each_dev) from [<c0538a58>]
> (driver_attach+0x24/0x28)
> [    7.801536]  r6:c1032490 r5:edd76c00 r4:bf0ac160
> [    7.801548] [<c0538a34>] (driver_attach) from [<c0538438>]
> (bus_add_driver+0x1ac/0x26c)
> [    7.801566] [<c053828c>] (bus_add_driver) from [<c0539f80>]
> (driver_register+0x80/0xfc)
> [    7.801585]  r8:c053b0a4 r7:c053aa50 r6:c1075830 r5:00000001 r4:bf0ac160
> [    7.801611] [<c0539f00>] (driver_register) from [<c053b2ac>]
> (__platform_register_drivers+0x80/0x164)
> [    7.801626]  r5:00000001 r4:bf0ab090
> [    7.801665] [<c053b22c>] (__platform_register_drivers) from
> [<bf0b0020>] (imx_drm_init+0x20/0x1000 [imxdrm])
> [    7.801678]  r10:edd15f40 r9:edeb9070 r8:bf0ac2c8 r7:edeb9980
> r6:00000000 r5:bf0b0000
> [    7.801682]  r4:ffffe000
> [    7.801721] [<bf0b0000>] (imx_drm_init [imxdrm]) from [<c0101ba4>]
> (do_one_initcall+0x4c/0x174)
> [    7.801759] [<c0101b58>] (do_one_initcall) from [<c01b0880>]
> (do_init_module+0x68/0x1fc)
> [    7.801787]  r9:edeb9070 r8:bf0ac2c8 r6:bf0ac280 r5:00000001 r4:bf0ac280
> [    7.801815] [<c01b0818>] (do_init_module) from [<c01af89c>]
> (load_module+0x2064/0x270c)
> [    7.801835]  r7:edeb9040 r6:bf0ac280 r5:00000001 r4:00000001
> [    7.801859] [<c01ad838>] (load_module) from [<c01b01c4>]
> (SyS_finit_module+0xbc/0xf8)
> [    7.801882]  r10:00000000 r9:edd14000 r8:c0108da4 r7:0000017b
> r6:b6e24d40 r5:0000000f
> [    7.801896]  r4:00000000
> [    7.801927] [<c01b0108>] (SyS_finit_module) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    7.801940]  r6:00000000 r5:bebb39f4 r4:7778f500
> [    7.801947] ---[ end trace 3e19c988c4369e1d ]---
> [    7.885327] imx-drm display-subsystem: fb0:  frame buffer device
> [    7.937166] [drm] Initialized imx-drm 1.0.0 20120507 for
> display-subsystem on minor 1
> [    8.694540] ------------[ cut here ]------------
> [    8.694576] WARNING: CPU: 0 PID: 464 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    8.694583] This function requires support for accurate vblank timestamps.
> [    8.694587] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [    8.694682] CPU: 0 PID: 464 Comm: setfont Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [    8.694687] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    8.694692] Backtrace:
> [    8.694713] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    8.694722]  r7:c106eed0 r6:00000000 r5:60080093 r4:c106eed0
> [    8.694747] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    8.694766] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    8.694777]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    8.694783]  r4:ed5ab9f0 r3:00000000
> [    8.694797] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    8.694809]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    8.694824] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    8.694831]  r3:00000000 r2:c0d50064
> [    8.694835]  r4:edc2f000
> [    8.694847] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    8.694856]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:edd94880
> [    8.694906] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    8.694916]  r5:edd94300 r4:edc2b018
> [    8.694946] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    8.694951]  r5:edd94300 r4:00000018
> [    8.694969] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    8.694980]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:edd94300 r5:bf0ab088
> [    8.694984]  r4:edd94300
> [    8.695007] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    8.695016]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    8.695021]  r4:edd94300 r3:bf0a8174
> [    8.695031] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    8.695037]  r5:00000000 r4:edd94300
> [    8.695054] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    8.695060]  r7:edd94300 r6:edc2f000 r5:edd94300 r4:00000000
> [    8.695075] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    8.695082]  r7:edd94300 r6:00000001 r5:0000003f r4:000000a0
> [    8.695093] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    8.695101]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    8.695106]  r4:edf56e00
> [    8.695129] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    8.695138]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    8.695143]  r4:edfe3400 r3:00000000
> [    8.695160] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    8.695168]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    8.695173]  r4:edf57800 r3:c049a648
> [    8.695183] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    8.695188]  r5:edfe3400 r4:ee808dc8
> [    8.695205] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    8.695213]  r10:00000000 r9:edfe3400 r8:00000008 r7:00000001
> r6:c17e5a70 r5:00000000
> [    8.695217]  r4:ee808c00
> [    8.695230] [<c04db4cc>] (redraw_screen) from [<c0498c50>]
> (fbcon_do_set_font+0x1e0/0x27c)
> [    8.695238]  r8:00000008 r7:c17e5bc8 r6:c17e5a70 r5:00000000 r4:ee808c00
> [    8.695248] [<c0498a70>] (fbcon_do_set_font) from [<c0498ff0>]
> (fbcon_set_font+0x208/0x224)
> [    8.695256]  r10:00001000 r9:0000003e r8:ed5abdd8 r7:20135b36
> r6:c17ec890 r5:0000003f
> [    8.695260]  r4:c17e7854
> [    8.695272] [<c0498de8>] (fbcon_set_font) from [<c04e0824>]
> (con_font_op+0x438/0x4f0)
> [    8.695282]  r10:00000000 r9:010719c8 r8:00000000 r7:ee808c00
> r6:00000001 r5:ee808c00
> [    8.695285]  r4:ed5abe40
> [    8.695304] [<c04e03ec>] (con_font_op) from [<c04d3694>]
> (vt_ioctl+0x14a0/0x199c)
> [    8.695312]  r10:00000000 r9:ee808dc8 r8:00000000 r7:00000051
> r6:00000001 r5:ee808c00
> [    8.695316]  r4:bee8a33c
> [    8.695336] [<c04d21f4>] (vt_ioctl) from [<c04c4c6c>] (tty_ioctl+0x190/0xbcc)
> [    8.695345]  r10:00000000 r9:ed5aa000 r8:edfe9c00 r7:bee8a33c
> r6:ededf400 r5:edfe9c00
> [    8.695349]  r4:00004b72
> [    8.695363] [<c04c4adc>] (tty_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [    8.695374]  r9:ed5aa000 r8:00000003 r7:c023f474 r6:ededf400
> r5:ee90b3a8 r4:bee8a33c
> [    8.695382] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [    8.695390]  r10:00000000 r9:ed5aa000 r8:bee8a33c r7:00004b72
> r6:ededf400 r5:00000003
> [    8.695394]  r4:ededf400
> [    8.695411] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    8.695420]  r9:ed5aa000 r8:c0108da4 r7:00000036 r6:00000010
> r5:00000008 r4:00027128
> [    8.695425] ---[ end trace 3e19c988c4369e1e ]---
> [    8.732040] ------------[ cut here ]------------
> [    8.732072] WARNING: CPU: 1 PID: 469 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    8.732077] This function requires support for accurate vblank timestamps.
> [    8.732083] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [    8.732168] CPU: 1 PID: 469 Comm: setfont Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [    8.732175] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    8.732179] Backtrace:
> [    8.732196] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    8.732206]  r7:c106eed0 r6:00000000 r5:60080093 r4:c106eed0
> [    8.732226] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    8.732246] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    8.732255]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    8.732260]  r4:ed0cd9f0 r3:00000000
> [    8.732271] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    8.732280]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    8.732297] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    8.732302]  r3:00000000 r2:c0d50064
> [    8.732306]  r4:edc2f000
> [    8.732316] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    8.732323]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:edc80680
> [    8.732361] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    8.732367]  r5:ed1cdc00 r4:edc2b018
> [    8.732392] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    8.732397]  r5:ed1cdc00 r4:00000018
> [    8.732415] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    8.732426]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed1cdc00 r5:bf0ab088
> [    8.732430]  r4:ed1cdc00
> [    8.732454] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    8.732463]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    8.732467]  r4:ed1cdc00 r3:bf0a8174
> [    8.732477] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    8.732482]  r5:00000000 r4:ed1cdc00
> [    8.732497] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    8.732504]  r7:ed1cdc00 r6:edc2f000 r5:ed1cdc00 r4:00000000
> [    8.732519] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    8.732526]  r7:ed1cdc00 r6:00000001 r5:0000003f r4:000000a0
> [    8.732537] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    8.732546]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    8.732550]  r4:edf56e00
> [    8.732568] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    8.732578]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    8.732583]  r4:edfe3400 r3:00000000
> [    8.732600] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    8.732615]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    8.732621]  r4:edf57800 r3:c049a648
> [    8.732638] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    8.732645]  r5:edfe3400 r4:ee808dc8
> [    8.732663] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    8.732674]  r10:00000000 r9:edfe3400 r8:00000008 r7:00000001
> r6:c17e5a70 r5:00000000
> [    8.732678]  r4:ee808c00
> [    8.732694] [<c04db4cc>] (redraw_screen) from [<c0498c50>]
> (fbcon_do_set_font+0x1e0/0x27c)
> [    8.732703]  r8:00000008 r7:c17e5bc8 r6:c17e5a70 r5:ee39c010 r4:ee808c00
> [    8.732715] [<c0498a70>] (fbcon_do_set_font) from [<c0498ff0>]
> (fbcon_set_font+0x208/0x224)
> [    8.732726]  r10:c17e5bc8 r9:0000003e r8:ed0cddd8 r7:20135b36
> r6:c17ebfb4 r5:00000000
> [    8.732730]  r4:c17e5bc8
> [    8.732744] [<c0498de8>] (fbcon_set_font) from [<c04e0824>]
> (con_font_op+0x438/0x4f0)
> [    8.732755]  r10:00000000 r9:008379c8 r8:00000000 r7:ee808c00
> r6:00000001 r5:ee808c00
> [    8.732759]  r4:ed0cde40
> [    8.732777] [<c04e03ec>] (con_font_op) from [<c04d3694>]
> (vt_ioctl+0x14a0/0x199c)
> [    8.732788]  r10:00000000 r9:ee808dc8 r8:00000000 r7:00000051
> r6:00000001 r5:ee808c00
> [    8.732793]  r4:bed9434c
> [    8.732810] [<c04d21f4>] (vt_ioctl) from [<c04c4c6c>] (tty_ioctl+0x190/0xbcc)
> [    8.732823]  r10:00000000 r9:ed0cc000 r8:edfe9c00 r7:bed9434c
> r6:ed0dbcc0 r5:edfe9c00
> [    8.732828]  r4:00004b72
> [    8.732847] [<c04c4adc>] (tty_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [    8.732856]  r9:ed0cc000 r8:00000003 r7:c023f474 r6:ed0dbcc0
> r5:ee90b3a8 r4:bed9434c
> [    8.732867] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [    8.732877]  r10:00000000 r9:ed0cc000 r8:bed9434c r7:00004b72
> r6:ed0dbcc0 r5:00000003
> [    8.732882]  r4:ed0dbcc0
> [    8.732898] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    8.732909]  r9:ed0cc000 r8:c0108da4 r7:00000036 r6:00000010
> r5:00000008 r4:00027128
> [    8.732914] ---[ end trace 3e19c988c4369e1f ]---
> [    8.903802] ------------[ cut here ]------------
> [    8.903857] WARNING: CPU: 2 PID: 483 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    8.903867] This function requires support for accurate vblank timestamps.
> [    8.903878] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [    8.904099] CPU: 2 PID: 483 Comm: setfont Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [    8.904110] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    8.904114] Backtrace:
> [    8.904145] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    8.904165]  r7:c106eed0 r6:00000000 r5:60080093 r4:c106eed0
> [    8.904209] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    8.904238] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    8.904249]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    8.904255]  r4:ed0e39f0 r3:00000000
> [    8.904266] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    8.904274]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    8.904287] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    8.904293]  r3:00000000 r2:c0d50064
> [    8.904297]  r4:edc2f000
> [    8.904307] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    8.904314]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:edef7d00
> [    8.904349] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    8.904354]  r5:ed787480 r4:edc2b018
> [    8.904389] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    8.904407]  r5:ed787480 r4:00000018
> [    8.904444] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    8.904466]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed787480 r5:bf0ab088
> [    8.904474]  r4:ed787480
> [    8.904502] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    8.904511]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    8.904516]  r4:ed787480 r3:bf0a8174
> [    8.904529] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    8.904534]  r5:00000000 r4:ed787480
> [    8.904552] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    8.904561]  r7:ed787480 r6:edc2f000 r5:ed787480 r4:00000000
> [    8.904574] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    8.904581]  r7:ed787480 r6:00000001 r5:0000003f r4:000000a0
> [    8.904594] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    8.904603]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    8.904607]  r4:edf56e00
> [    8.904635] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    8.904643]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    8.904648]  r4:edfe3400 r3:00000000
> [    8.904665] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    8.904673]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    8.904678]  r4:edf57800 r3:c049a648
> [    8.904690] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    8.904695]  r5:edfe3400 r4:ee808dc8
> [    8.904713] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    8.904722]  r10:00000000 r9:edfe3400 r8:00000008 r7:00000001
> r6:c17e5a70 r5:00000000
> [    8.904726]  r4:ee808c00
> [    8.904737] [<c04db4cc>] (redraw_screen) from [<c0498c50>]
> (fbcon_do_set_font+0x1e0/0x27c)
> [    8.904747]  r8:00000008 r7:c17e5bc8 r6:c17e5a70 r5:ee39c010 r4:ee808c00
> [    8.904757] [<c0498a70>] (fbcon_do_set_font) from [<c0498ff0>]
> (fbcon_set_font+0x208/0x224)
> [    8.904765]  r10:c17e5bc8 r9:0000003e r8:ed0e3dd8 r7:20135b36
> r6:c17ebfb4 r5:00000000
> [    8.904769]  r4:c17e5bc8
> [    8.904782] [<c0498de8>] (fbcon_set_font) from [<c04e0824>]
> (con_font_op+0x438/0x4f0)
> [    8.904791]  r10:00000000 r9:00bdf9c8 r8:00000000 r7:ee808c00
> r6:00000001 r5:ee808c00
> [    8.904795]  r4:ed0e3e40
> [    8.904817] [<c04e03ec>] (con_font_op) from [<c04d3694>]
> (vt_ioctl+0x14a0/0x199c)
> [    8.904825]  r10:00000000 r9:ee808dc8 r8:00000000 r7:00000051
> r6:00000001 r5:ee808c00
> [    8.904829]  r4:bef4633c
> [    8.904851] [<c04d21f4>] (vt_ioctl) from [<c04c4c6c>] (tty_ioctl+0x190/0xbcc)
> [    8.904860]  r10:00000000 r9:ed0e2000 r8:edfe8c00 r7:bef4633c
> r6:edebe000 r5:edfe8c00
> [    8.904865]  r4:00004b72
> [    8.904880] [<c04c4adc>] (tty_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [    8.904888]  r9:ed0e2000 r8:00000003 r7:c023f474 r6:edebe000
> r5:eeb242f8 r4:bef4633c
> [    8.904896] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [    8.904905]  r10:00000000 r9:ed0e2000 r8:bef4633c r7:00004b72
> r6:edebe000 r5:00000003
> [    8.904909]  r4:edebe000
> [    8.904925] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    8.904933]  r9:ed0e2000 r8:c0108da4 r7:00000036 r6:00000010
> r5:00000008 r4:00027128
> [    8.904939] ---[ end trace 3e19c988c4369e20 ]---
> [    8.961980] ------------[ cut here ]------------
> [    8.962005] WARNING: CPU: 2 PID: 488 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    8.962010] This function requires support for accurate vblank timestamps.
> [    8.962014] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [    8.962099] CPU: 2 PID: 488 Comm: setfont Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [    8.962104] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    8.962107] Backtrace:
> [    8.962126] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    8.962134]  r7:c106eed0 r6:00000000 r5:60080093 r4:c106eed0
> [    8.962153] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    8.962168] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    8.962177]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    8.962182]  r4:ed41f9f0 r3:00000000
> [    8.962192] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    8.962200]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    8.962210] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    8.962215]  r3:00000000 r2:c0d50064
> [    8.962220]  r4:edc2f000
> [    8.962229] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    8.962236]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed787e80
> [    8.962268] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    8.962274]  r5:ed4f9200 r4:edc2b018
> [    8.962298] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    8.962304]  r5:ed4f9200 r4:00000018
> [    8.962321] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    8.962330]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed4f9200 r5:bf0ab088
> [    8.962334]  r4:ed4f9200
> [    8.962353] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    8.962362]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    8.962367]  r4:ed4f9200 r3:bf0a8174
> [    8.962376] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    8.962382]  r5:00000000 r4:ed4f9200
> [    8.962397] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    8.962404]  r7:ed4f9200 r6:edc2f000 r5:ed4f9200 r4:00000000
> [    8.962419] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    8.962426]  r7:ed4f9200 r6:00000001 r5:0000003f r4:000000a0
> [    8.962436] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [    8.962444]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [    8.962448]  r4:edf56e00
> [    8.962466] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [    8.962474]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [    8.962479]  r4:edfe3400 r3:00000000
> [    8.962493] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [    8.962501]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [    8.962506]  r4:edf57800 r3:c049a648
> [    8.962516] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [    8.962521]  r5:edfe3400 r4:ee808dc8
> [    8.962535] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [    8.962543]  r10:00000000 r9:edfe3400 r8:00000008 r7:00000001
> r6:c17e5a70 r5:00000000
> [    8.962547]  r4:ee808c00
> [    8.962557] [<c04db4cc>] (redraw_screen) from [<c0498c50>]
> (fbcon_do_set_font+0x1e0/0x27c)
> [    8.962565]  r8:00000008 r7:c17e5bc8 r6:c17e5a70 r5:ee39c010 r4:ee808c00
> [    8.962574] [<c0498a70>] (fbcon_do_set_font) from [<c0498ff0>]
> (fbcon_set_font+0x208/0x224)
> [    8.962583]  r10:c17e5bc8 r9:0000003e r8:ed41fdd8 r7:20135b36
> r6:c17ebfb4 r5:00000000
> [    8.962587]  r4:c17e5bc8
> [    8.962600] [<c0498de8>] (fbcon_set_font) from [<c04e0824>]
> (con_font_op+0x438/0x4f0)
> [    8.962608]  r10:00000000 r9:00b409c8 r8:00000000 r7:ee808c00
> r6:00000001 r5:ee808c00
> [    8.962612]  r4:ed41fe40
> [    8.962632] [<c04e03ec>] (con_font_op) from [<c04d3694>]
> (vt_ioctl+0x14a0/0x199c)
> [    8.962641]  r10:00000000 r9:ee808dc8 r8:00000000 r7:00000051
> r6:00000001 r5:ee808c00
> [    8.962645]  r4:beb4f34c
> [    8.962668] [<c04d21f4>] (vt_ioctl) from [<c04c4c6c>] (tty_ioctl+0x190/0xbcc)
> [    8.962677]  r10:00000000 r9:ed41e000 r8:edfe8c00 r7:beb4f34c
> r6:ededa000 r5:edfe8c00
> [    8.962681]  r4:00004b72
> [    8.962697] [<c04c4adc>] (tty_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [    8.962705]  r9:ed41e000 r8:00000003 r7:c023f474 r6:ededa000
> r5:eeb242f8 r4:beb4f34c
> [    8.962714] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [    8.962723]  r10:00000000 r9:ed41e000 r8:beb4f34c r7:00004b72
> r6:ededa000 r5:00000003
> [    8.962727]  r4:ededa000
> [    8.962743] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [    8.962755]  r9:ed41e000 r8:c0108da4 r7:00000036 r6:00000010
> r5:00000008 r4:00027128
> [    8.962765] ---[ end trace 3e19c988c4369e21 ]---
> [    8.966733] dw_hdmi_connector_get_modes:1917: dwhdmi-imx
> 120000.hdmi: failed to get edid
> [    8.967669] ------------[ cut here ]------------
> [    8.967706] WARNING: CPU: 1 PID: 15 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [    8.967712] This function requires support for accurate vblank timestamps.
> [    8.967716] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [    8.967804] CPU: 1 PID: 15 Comm: kworker/1:0 Tainted: G        W
>    4.14.0-rc7-gd65d313-dirty #1
> [    8.967809] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    8.967831] Workqueue: events output_poll_execute
> [    8.967838] Backtrace:
> [    8.967860] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [    8.967868]  r7:c106eed0 r6:00000000 r5:600d0193 r4:c106eed0
> [    8.967891] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [    8.967909] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [    8.967919]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [    8.967924]  r4:ee8a7c00 r3:00000000
> [    8.967934] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [    8.967943]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [    8.967954] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [    8.967960]  r3:00000000 r2:c0d50064
> [    8.967964]  r4:edc2f000
> [    8.967975] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [    8.967982]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed1cd900
> [    8.968020] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [    8.968027]  r5:ed1cd080 r4:edc2b018
> [    8.968051] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [    8.968057]  r5:ed1cd080 r4:00000018
> [    8.968076] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [    8.968085]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed1cd080 r5:bf0ab088
> [    8.968089]  r4:ed1cd080
> [    8.968107] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [    8.968116]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [    8.968121]  r4:ed1cd080 r3:bf0a8174
> [    8.968131] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [    8.968136]  r5:00000000 r4:ed1cd080
> [    8.968151] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [    8.968159]  r7:ed1cd080 r6:edc2f000 r5:ed1cd080 r4:00000000
> [    8.968172] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [    8.968179]  r7:ed1cd080 r6:00000001 r5:0000003f r4:000000a0
> [    8.968192] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c0501724>] (restore_fbdev_mode+0x30/0x168)
> [    8.968200]  r10:00000001 r9:00000000 r8:edc2f254 r7:edf56e00
> r6:edf56ed0 r5:edf56ed0
> [    8.968204]  r4:edf56e00
> [    8.968219] [<c05016f4>] (restore_fbdev_mode) from [<c0504740>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8+0x28/0x7c)
> [    8.968227]  r10:00000001 r9:00000000 r8:edc2f254 r7:00000001
> r6:edf56ed0 r5:edf56ed0
> [    8.968231]  r4:edf56e00
> [    8.968246] [<c0504718>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8) from [<c0504834>]
> (drm_fb_helper_set_par+0x5c/0x8c)
> [    8.968252]  r7:00000001 r6:edf56ed0 r5:00000000 r4:00000000
> [    8.968263] [<c05047d8>] (drm_fb_helper_set_par) from [<c05046d0>]
> (drm_fb_helper_hotplug_event.part.7+0xa4/0xbc)
> [    8.968268]  r5:00000000 r4:edf56e00
> [    8.968280] [<c050462c>] (drm_fb_helper_hotplug_event.part.7) from
> [<c0504714>] (drm_fb_helper_hotplug_event+0x2c/0x30)
> [    8.968286]  r7:00000001 r6:00000000 r5:edc2f000 r4:edc2f000
> [    8.968297] [<c05046e8>] (drm_fb_helper_hotplug_event) from
> [<c0504e34>] (drm_fbdev_cma_hotplug_event+0x18/0x1c)
> [    8.968321] [<c0504e1c>] (drm_fbdev_cma_hotplug_event) from
> [<bf0a82d0>] (imx_drm_output_poll_changed+0x18/0x1c [imxdrm])
> [    8.968348] [<bf0a82b8>] (imx_drm_output_poll_changed [imxdrm])
> from [<c04f3fbc>] (drm_kms_helper_hotplug_event+0x2c/0x30)
> [    8.968360] [<c04f3f90>] (drm_kms_helper_hotplug_event) from
> [<c04f41a0>] (output_poll_execute+0x190/0x1a4)
> [    8.968366]  r5:edc2f000 r4:edc2f418
> [    8.968381] [<c04f4010>] (output_poll_execute) from [<c013f1c4>]
> (process_one_work+0x258/0x4f0)
> [    8.968389]  r10:00000001 r9:00000000 r8:eefaed00 r7:ee8a7ef8
> r6:eefabcc0 r5:ee83bb00
> [    8.968393]  r4:edc2f418
> [    8.968403] [<c013ef6c>] (process_one_work) from [<c01400e8>]
> (worker_thread+0x58/0x59c)
> [    8.968412]  r10:ee8a6000 r9:eefabcf4 r8:c1004900 r7:00000008
> r6:ee83bb18 r5:eefabcc0
> [    8.968416]  r4:ee83bb00
> [    8.968427] [<c0140090>] (worker_thread) from [<c01462c0>]
> (kthread+0x140/0x16c)
> [    8.968435]  r10:ee85bd94 r9:ee83bc38 r8:ee83bb00 r7:ee8a6000
> r6:ee840180 r5:00000000
> [    8.968439]  r4:ee83bc00
> [    8.968453] [<c0146180>] (kthread) from [<c0108c88>]
> (ret_from_fork+0x14/0x2c)
> [    8.968461]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:c0146180
> [    8.968465]  r4:ee840180
> [    8.968471] ---[ end trace 3e19c988c4369e22 ]---
> [   10.604619] Atheros 8035 ethernet 2188000.ethernet-1:01: attached
> PHY driver [Atheros 8035 ethernet]
> (mii_bus:phy_addr=2188000.ethernet-1:01, irq=POLL)
> [   10.605926] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   14.077150] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full -
> flow control rx/tx
> [   14.078035] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   17.600543] ------------[ cut here ]------------
> [   17.600578] WARNING: CPU: 2 PID: 782 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   17.600582] This function requires support for accurate vblank timestamps.
> [   17.600586] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   17.600672] CPU: 2 PID: 782 Comm: Xorg.wrap Tainted: G        W
>   4.14.0-rc7-gd65d313-dirty #1
> [   17.600676] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   17.600680] Backtrace:
> [   17.600697] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   17.600705]  r7:c106eed0 r6:00000000 r5:600f0093 r4:c106eed0
> [   17.600723] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   17.600737] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   17.600746]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   17.600751]  r4:ed059c80 r3:00000000
> [   17.600760] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   17.600769]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   17.600781] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   17.600786]  r3:00000000 r2:c0d50064
> [   17.600790]  r4:edc2f000
> [   17.600800] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   17.600807]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed042b00
> [   17.600836] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   17.600844]  r5:ed409300 r4:edc2b018
> [   17.600867] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   17.600874]  r5:ed409300 r4:00000018
> [   17.600892] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   17.600901]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed409300 r5:bf0ab088
> [   17.600905]  r4:ed409300
> [   17.600923] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   17.600932]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   17.600937]  r4:ed409300 r3:bf0a8174
> [   17.600947] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   17.600952]  r5:00000000 r4:ed409300
> [   17.600968] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   17.600975]  r7:ed409300 r6:edc2f000 r5:ed409300 r4:00000000
> [   17.600987] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [   17.600993]  r7:ed409300 r6:00000001 r5:0000003f r4:000000a0
> [   17.601004] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c0501724>] (restore_fbdev_mode+0x30/0x168)
> [   17.601012]  r10:edf5ecec r9:edc2f214 r8:00000000 r7:edf56e00
> r6:edf5ed00 r5:edf56ed0
> [   17.601016]  r4:edf56e00
> [   17.601029] [<c05016f4>] (restore_fbdev_mode) from [<c0504740>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8+0x28/0x7c)
> [   17.601037]  r10:edf5ecec r9:edc2f214 r8:00000000 r7:edc2f0f0
> r6:edf5ed00 r5:edf56ed0
> [   17.601041]  r4:edf56e00
> [   17.601053] [<c0504718>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8) from [<c05047cc>]
> (drm_fb_helper_restore_fbdev_mode_unlocked+0x38/0x44)
> [   17.601060]  r7:edc2f0f0 r6:edf5ed00 r5:edc2f000 r4:edc2f000
> [   17.601071] [<c0504794>]
> (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0504e18>]
> (drm_fbdev_cma_restore_mode+0x18/0x1c)
> [   17.601091] [<c0504e00>] (drm_fbdev_cma_restore_mode) from
> [<bf0a82ec>] (imx_drm_driver_lastclose+0x18/0x1c [imxdrm])
> [   17.601108] [<bf0a82d4>] (imx_drm_driver_lastclose [imxdrm]) from
> [<c0508ec0>] (drm_lastclose+0x40/0xd4)
> [   17.601117] [<c0508e80>] (drm_lastclose) from [<c05091fc>]
> (drm_release+0x2a8/0x364)
> [   17.601123]  r5:edc2f000 r4:edf5ec00
> [   17.601137] [<c0508f54>] (drm_release) from [<c022bf20>] (__fput+0x94/0x1e0)
> [   17.601146]  r10:00000008 r9:ed759f28 r8:00000000 r7:edb5fc38
> r6:ee8d9410 r5:ed759f28
> [   17.601150]  r4:edee97c0
> [   17.601158] [<c022be8c>] (__fput) from [<c022c0cc>] (____fput+0x10/0x14)
> [   17.601167]  r10:00000000 r9:edee97c0 r8:c1087070 r7:edfc5dc4
> r6:edfc5940 r5:edfc5d94
> [   17.601171]  r4:00000000
> [   17.601186] [<c022c0bc>] (____fput) from [<c0144754>]
> (task_work_run+0x9c/0xc0)
> [   17.601202] [<c01446b8>] (task_work_run) from [<c010cc70>]
> (do_work_pending+0x94/0xbc)
> [   17.601210]  r9:ed058000 r8:c0108da4 r7:ed059fb0 r6:c0108da4
> r5:ed058000 r4:00000004
> [   17.601220] [<c010cbdc>] (do_work_pending) from [<c0108c14>]
> (slow_work_pending+0xc/0x20)
> [   17.601227]  r7:00000006 r6:00000003 r5:be9c9cb4 r4:00000001
> [   17.601231] ---[ end trace 3e19c988c4369e23 ]---
> [   17.609550] ------------[ cut here ]------------
> [   17.609591] WARNING: CPU: 3 PID: 783 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   17.609599] This function requires support for accurate vblank timestamps.
> [   17.609603] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   17.609687] CPU: 3 PID: 783 Comm: (agetty) Tainted: G        W
>  4.14.0-rc7-gd65d313-dirty #1
> [   17.609692] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   17.609696] Backtrace:
> [   17.609715] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   17.609726]  r7:c106eed0 r6:00000000 r5:600b0093 r4:c106eed0
> [   17.609744] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   17.609760] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   17.609769]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   17.609774]  r4:ed5e99b8 r3:00000000
> [   17.609784] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   17.609793]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   17.609804] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   17.609811]  r3:00000000 r2:c0d50064
> [   17.609815]  r4:edc2f000
> [   17.609825] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   17.609832]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed043980
> [   17.609872] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   17.609878]  r5:edc3f780 r4:edc2b018
> [   17.609908] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   17.609914]  r5:edc3f780 r4:00000018
> [   17.609933] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   17.609942]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:edc3f780 r5:bf0ab088
> [   17.609947]  r4:edc3f780
> [   17.609971] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   17.609980]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   17.609985]  r4:edc3f780 r3:bf0a8174
> [   17.609996] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   17.610002]  r5:00000000 r4:edc3f780
> [   17.610020] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   17.610029]  r7:edc3f780 r6:edc2f000 r5:edc3f780 r4:00000000
> [   17.610043] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [   17.610050]  r7:edc3f780 r6:00000001 r5:0000003f r4:000000a0
> [   17.610061] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [   17.610070]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [   17.610074]  r4:edf56e00
> [   17.610104] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [   17.610116]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [   17.610121]  r4:edfe3400 r3:00000000
> [   17.610137] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [   17.610146]  r10:00000000 r9:edf57800 r8:c17e5bc8 r7:c17e5a70
> r6:ee808c00 r5:edfe3400
> [   17.610152]  r4:edf57800 r3:c049a648
> [   17.610163] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [   17.610170]  r5:edfe3400 r4:ee808dc8
> [   17.610188] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [   17.610200]  r10:0000000a r9:ee808c00 r8:00000000 r7:00000001
> r6:ee808e34 r5:00000000
> [   17.610205]  r4:ee808c00
> [   17.610219] [<c04db4cc>] (redraw_screen) from [<c04db848>]
> (csi_J+0x134/0x160)
> [   17.610227]  r8:00000000 r7:c0bb934c r6:ee808e34 r5:ed4d4c00 r4:ee808c00
> [   17.610240] [<c04db714>] (csi_J) from [<c04df7cc>]
> (do_con_trol+0x14b8/0x1688)
> [   17.610247]  r7:c0bb934c r6:ed4d4c00 r5:ed4d4c00 r4:ee808c00
> [   17.610259] [<c04de314>] (do_con_trol) from [<c04dfba8>]
> (do_con_write.part.9+0x20c/0x95c)
> [   17.610268]  r10:0000000a r9:ee808c00 r8:00000000 r7:c0bb934c
> r6:ed4d4c00 r5:ffffffff
> [   17.610272]  r4:0000004a
> [   17.610282] [<c04df99c>] (do_con_write.part.9) from [<c04e03dc>]
> (con_write+0x80/0x90)
> [   17.610291]  r10:00000000 r9:f27e529c r8:edef2b40 r7:c0bb934c
> r6:ed4d4c00 r5:0000000a
> [   17.610295]  r4:ffffe000
> [   17.610320] [<c04e035c>] (con_write) from [<c04c7dc8>]
> (n_tty_write+0x1c8/0x45c)
> [   17.610327]  r7:c0bb934c r6:ed4d4000 r5:0000000a r4:ed4d4c00
> [   17.610339] [<c04c7c00>] (n_tty_write) from [<c04c3e80>]
> (tty_write+0x1f8/0x314)
> [   17.610347]  r10:00000400 r9:ed5e8000 r8:00000000 r7:0000000a
> r6:004dc55c r5:0000000a
> [   17.610351]  r4:ed4d4c00
> [   17.610374] [<c04c3c88>] (tty_write) from [<c022ade8>]
> (__vfs_write+0x34/0x134)
> [   17.610382]  r10:00000000 r9:0000000a r8:ed5e9f78 r7:ed5e9f78
> r6:004dc55c r5:c04c3c88
> [   17.610386]  r4:edef2b40
> [   17.610396] [<c022adb4>] (__vfs_write) from [<c022b06c>]
> (vfs_write+0xac/0x170)
> [   17.610404]  r10:00000000 r9:0000000a r8:00000000 r7:ed5e9f78
> r6:004dc55c r5:edef2b40
> [   17.610408]  r4:0000000a
> [   17.610418] [<c022afc0>] (vfs_write) from [<c022b248>] (SyS_write+0x44/0x98)
> [   17.610429]  r9:0000000a r8:004dc55c r7:00000000 r6:00000000
> r5:edef2b40 r4:edef2b40
> [   17.610448] [<c022b204>] (SyS_write) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [   17.610460]  r9:ed5e8000 r8:c0108da4 r7:00000004 r6:00000003
> r5:004dc55c r4:0000000a
> [   17.610466] ---[ end trace 3e19c988c4369e24 ]---
> [   17.768287] ------------[ cut here ]------------
> [   17.768355] WARNING: CPU: 2 PID: 782 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   17.768365] This function requires support for accurate vblank timestamps.
> [   17.768373] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   17.768564] CPU: 2 PID: 782 Comm: Xorg Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [   17.768573] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   17.768581] Backtrace:
> [   17.768608] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   17.768621]  r7:c106eed0 r6:00000000 r5:60070093 r4:c106eed0
> [   17.768646] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   17.768668] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   17.768683]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   17.768693]  r4:ed059c80 r3:00000006
> [   17.768709] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   17.768724]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   17.768742] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   17.768752]  r3:00000000 r2:c0d50064
> [   17.768761]  r4:edc2f000
> [   17.768776] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   17.768788]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed045800
> [   17.768827] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   17.768838]  r5:ed045200 r4:edc2b018
> [   17.768869] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   17.768880]  r5:ed045200 r4:00000018
> [   17.768905] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   17.768921]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed045200 r5:bf0ab088
> [   17.768930]  r4:ed045200
> [   17.768957] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   17.768972]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   17.768982]  r4:ed045200 r3:bf0a8174
> [   17.768998] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   17.769008]  r5:00000000 r4:ed045200
> [   17.769030] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   17.769042]  r7:ed045200 r6:edc2f000 r5:ed045200 r4:00000000
> [   17.769061] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [   17.769074]  r7:ed045200 r6:00000001 r5:0000003f r4:000000a0
> [   17.769091] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c0501724>] (restore_fbdev_mode+0x30/0x168)
> [   17.769105]  r10:ed43baec r9:edc2f214 r8:00000000 r7:edf56e00
> r6:ed43bb00 r5:edf56ed0
> [   17.769113]  r4:edf56e00
> [   17.769133] [<c05016f4>] (restore_fbdev_mode) from [<c0504740>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8+0x28/0x7c)
> [   17.769147]  r10:ed43baec r9:edc2f214 r8:00000000 r7:edc2f0f0
> r6:ed43bb00 r5:edf56ed0
> [   17.769156]  r4:edf56e00
> [   17.769174] [<c0504718>]
> (drm_fb_helper_restore_fbdev_mode_unlocked.part.8) from [<c05047cc>]
> (drm_fb_helper_restore_fbdev_mode_unlocked+0x38/0x44)
> [   17.769186]  r7:edc2f0f0 r6:ed43bb00 r5:edc2f000 r4:edc2f000
> [   17.769204] [<c0504794>]
> (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0504e18>]
> (drm_fbdev_cma_restore_mode+0x18/0x1c)
> [   17.769234] [<c0504e00>] (drm_fbdev_cma_restore_mode) from
> [<bf0a82ec>] (imx_drm_driver_lastclose+0x18/0x1c [imxdrm])
> [   17.769261] [<bf0a82d4>] (imx_drm_driver_lastclose [imxdrm]) from
> [<c0508ec0>] (drm_lastclose+0x40/0xd4)
> [   17.769275] [<c0508e80>] (drm_lastclose) from [<c05091fc>]
> (drm_release+0x2a8/0x364)
> [   17.769286]  r5:edc2f000 r4:ed43ba00
> [   17.769308] [<c0508f54>] (drm_release) from [<c022bf20>] (__fput+0x94/0x1e0)
> [   17.769322]  r10:00000008 r9:ed759f28 r8:00000000 r7:edb5fc38
> r6:ee8d9410 r5:ed759f28
> [   17.769331]  r4:edee8280
> [   17.769345] [<c022be8c>] (__fput) from [<c022c0cc>] (____fput+0x10/0x14)
> [   17.769359]  r10:00000000 r9:edee8280 r8:c1087070 r7:edfc5dc4
> r6:edfc5940 r5:edfc5d94
> [   17.769368]  r4:00000000
> [   17.769388] [<c022c0bc>] (____fput) from [<c0144754>]
> (task_work_run+0x9c/0xc0)
> [   17.769413] [<c01446b8>] (task_work_run) from [<c010cc70>]
> (do_work_pending+0x94/0xbc)
> [   17.769427]  r9:ed058000 r8:c0108da4 r7:ed059fb0 r6:c0108da4
> r5:ed058000 r4:00000004
> [   17.769444] [<c010cbdc>] (do_work_pending) from [<c0108c14>]
> (slow_work_pending+0xc/0x20)
> [   17.769457]  r7:00000006 r6:021d01e0 r5:00000000 r4:0000000a
> [   17.769466] ---[ end trace 3e19c988c4369e25 ]---
> [   17.848753] ------------[ cut here ]------------
> [   17.848786] WARNING: CPU: 0 PID: 29 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   17.848790] This function requires support for accurate vblank timestamps.
> [   17.848795] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   17.848879] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: G        W
>    4.14.0-rc7-gd65d313-dirty #1
> [   17.848884] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   17.848896] Workqueue: events console_callback
> [   17.848904] Backtrace:
> [   17.848919] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   17.848928]  r7:c106eed0 r6:00000000 r5:60080093 r4:c106eed0
> [   17.848944] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   17.848959] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   17.848968]  r10:edf56e00 r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   17.848973]  r4:ee993b48 r3:00000000
> [   17.848983] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   17.848991]  r9:edc2f3e0 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   17.849002] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   17.849007]  r3:00000000 r2:c0d50064
> [   17.849011]  r4:edc2f000
> [   17.849021] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   17.849028]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed1cca80
> [   17.849070] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   17.849086]  r5:ed1cc580 r4:edc2b018
> [   17.849131] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   17.849147]  r5:ed1cc580 r4:00000018
> [   17.849174] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   17.849193]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:ed1cc580 r5:bf0ab088
> [   17.849207]  r4:ed1cc580
> [   17.849249] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   17.849271]  r10:edf56e00 r9:edc2f3e0 r8:edfafdf8 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   17.849283]  r4:ed1cc580 r3:bf0a8174
> [   17.849296] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   17.849301]  r5:00000000 r4:ed1cc580
> [   17.849319] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   17.849326]  r7:ed1cc580 r6:edc2f000 r5:ed1cc580 r4:00000000
> [   17.849339] [<c051c0e4>] (drm_atomic_commit) from [<c0501698>]
> (restore_fbdev_mode_atomic+0x19c/0x1f8)
> [   17.849346]  r7:ed1cc580 r6:00000001 r5:0000003f r4:000000a0
> [   17.849369] [<c05014fc>] (restore_fbdev_mode_atomic) from
> [<c05019a4>] (drm_fb_helper_pan_display+0xb0/0x1bc)
> [   17.849389]  r10:00000000 r9:c04feb78 r8:edfe3400 r7:edf5781c
> r6:00000000 r5:edf56ed0
> [   17.849404]  r4:edf56e00
> [   17.849443] [<c05018f4>] (drm_fb_helper_pan_display) from
> [<c048bc58>] (fb_pan_display+0xd4/0x140)
> [   17.849456]  r10:00000000 r9:edf57800 r8:00000438 r7:00000000
> r6:00000000 r5:edf5781c
> [   17.849461]  r4:edfe3400 r3:00000000
> [   17.849488] [<c048bb84>] (fb_pan_display) from [<c049a664>]
> (bit_update_start+0x1c/0x38)
> [   17.849500]  r10:00000000 r9:edf57800 r8:c17e5e80 r7:c17e5a70
> r6:ed686000 r5:edfe3400
> [   17.849506]  r4:edf57800 r3:c049a648
> [   17.849517] [<c049a648>] (bit_update_start) from [<c049934c>]
> (fbcon_switch+0x340/0x558)
> [   17.849522]  r5:edfe3400 r4:ed6861c8
> [   17.849534] [<c049900c>] (fbcon_switch) from [<c04db61c>]
> (redraw_screen+0x150/0x248)
> [   17.849543]  r10:00000001 r9:00000000 r8:ee808c00 r7:00000001
> r6:c17ebe94 r5:00000001
> [   17.849547]  r4:ed686000
> [   17.849563] [<c04db4cc>] (redraw_screen) from [<c04d2158>]
> (complete_change_console+0x44/0xe0)
> [   17.849571]  r8:eef9ed00 r7:00000000 r6:eef9bcc0 r5:00000000 r4:ed686000
> [   17.849599] [<c04d2114>] (complete_change_console) from
> [<c04d3c44>] (change_console+0x74/0xa0)
> [   17.849617]  r7:ee993ef8 r6:eef9bcc0 r5:ee808c00 r4:ed686000
> [   17.849645] [<c04d3bd0>] (change_console) from [<c04de00c>]
> (console_callback+0xf0/0x150)
> [   17.849661]  r5:c102e7ac r4:c17ebe94
> [   17.849689] [<c04ddf1c>] (console_callback) from [<c013f1c4>]
> (process_one_work+0x258/0x4f0)
> [   17.849697]  r5:ee842680 r4:c102e7f8
> [   17.849707] [<c013ef6c>] (process_one_work) from [<c01400e8>]
> (worker_thread+0x58/0x59c)
> [   17.849730]  r10:ee992000 r9:eef9bcf4 r8:c1004900 r7:00000008
> r6:ee842698 r5:eef9bcc0
> [   17.849743]  r4:ee842680
> [   17.849769] [<c0140090>] (worker_thread) from [<c01462c0>]
> (kthread+0x140/0x16c)
> [   17.849791]  r10:ee87de74 r9:ee855238 r8:ee842680 r7:ee992000
> r6:ee963ec0 r5:00000000
> [   17.849805]  r4:ee855200
> [   17.849828] [<c0146180>] (kthread) from [<c0108c88>]
> (ret_from_fork+0x14/0x2c)
> [   17.849852]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:c0146180
> [   17.849864]  r4:ee963ec0
> [   17.849877] ---[ end trace 3e19c988c4369e26 ]---
> [   17.878902] dw_hdmi_connector_get_modes:1917: dwhdmi-imx
> 120000.hdmi: failed to get edid
> [   17.879975] dw_hdmi_connector_get_modes:1917: dwhdmi-imx
> 120000.hdmi: failed to get edid
> [   17.919734] dw_hdmi_phy_power_off:1096: dwhdmi-imx 120000.hdmi: PHY
> powered down in 0 iterations
> [   17.928202] dw_hdmi_setup:1679: dwhdmi-imx 120000.hdmi: Non-CEA
> mode used in HDMI
> [   17.928222] hdmi_av_composer:1495: dwhdmi-imx 120000.hdmi: final
> pixclk = 65000000
> [   17.928266] dw_hdmi_phy_power_off:1096: dwhdmi-imx 120000.hdmi: PHY
> powered down in 0 iterations
> [   17.939476] dw_hdmi_phy_power_on:1133: dwhdmi-imx 120000.hdmi: PHY
> PLL locked 1 iterations
> [   17.939504] dw_hdmi_phy_power_off:1096: dwhdmi-imx 120000.hdmi: PHY
> powered down in 0 iterations
> [   17.950712] dw_hdmi_phy_power_on:1133: dwhdmi-imx 120000.hdmi: PHY
> PLL locked 1 iterations
> [   17.950743] dw_hdmi_setup:1744: dwhdmi-imx 120000.hdmi:
> dw_hdmi_setup DVI mode
> [   17.951224] ------------[ cut here ]------------
> [   17.951269] WARNING: CPU: 0 PID: 782 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   17.951277] This function requires support for accurate vblank timestamps.
> [   17.951285] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   17.951438] CPU: 0 PID: 782 Comm: Xorg Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [   17.951445] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   17.951451] Backtrace:
> [   17.951474] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   17.951485]  r7:c106eed0 r6:00000000 r5:600e0093 r4:c106eed0
> [   17.951505] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   17.951523] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   17.951535]  r10:000000ab r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   17.951543]  r4:ed059c08 r3:00000006
> [   17.951556] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   17.951567]  r9:00000000 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   17.951580] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   17.951588]  r3:00000000 r2:c0d50064
> [   17.951595]  r4:edc2f000
> [   17.951608] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   17.951618]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ee34b380
> [   17.951649] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   17.951658]  r5:ee34b480 r4:edc2b018
> [   17.951685] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   17.951693]  r5:ee34b480 r4:00000018
> [   17.951713] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   17.951726]  r10:000000ab r9:00000000 r8:edc2b018 r7:edc2f000
> r6:ee34b480 r5:bf0ab088
> [   17.951733]  r4:ee34b480
> [   17.951754] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   17.951766]  r10:000000ab r9:00000000 r8:edc2b018 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   17.951773]  r4:ee34b480 r3:bf0a8174
> [   17.951786] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   17.951794]  r5:00000000 r4:ee34b480
> [   17.951810] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   17.951820]  r7:00000000 r6:edc2f000 r5:ee34b480 r4:00000000
> [   17.951836] [<c051c0e4>] (drm_atomic_commit) from [<c051d2fc>]
> (drm_atomic_connector_commit_dpms+0xf0/0x100)
> [   17.951846]  r7:00000000 r6:edc2c010 r5:ee34b480 r4:00000001
> [   17.951859] [<c051d20c>] (drm_atomic_connector_commit_dpms) from
> [<c0522a64>] (drm_mode_obj_set_property_ioctl+0x1b4/0x2ac)
> [   17.951871]  r9:ee34b480 r8:00000000 r7:00000000 r6:ed059d78
> r5:edc2c024 r4:edd76980
> [   17.951884] [<c05228b0>] (drm_mode_obj_set_property_ioctl) from
> [<c0521378>] (drm_mode_connector_property_set_ioctl+0x40/0x48)
> [   17.951896]  r10:000000ab r9:c01064ab r8:ed059e60 r7:c0521338
> r6:edc2f000 r5:00000000
> [   17.951903]  r4:00000000
> [   17.951919] [<c0521338>] (drm_mode_connector_property_set_ioctl)
> from [<c050a7e0>] (drm_ioctl_kernel+0x70/0xb0)
> [   17.951927]  r5:ed43b200 r4:0000001a
> [   17.951939] [<c050a770>] (drm_ioctl_kernel) from [<c050ac78>]
> (drm_ioctl+0x2a4/0x3ac)
> [   17.951950]  r9:c01064ab r8:ed43b200 r7:ed059e60 r6:c0b45b9c
> r5:00000010 r4:00000010
> [   17.951964] [<c050a9d4>] (drm_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [   17.951975]  r10:00000000 r9:ed058000 r8:0000000b r7:c023f474
> r6:edee9b80 r5:ed759f28
> [   17.951982]  r4:bea337d0
> [   17.951996] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [   17.952007]  r10:00000000 r9:ed058000 r8:bea337d0 r7:c01064ab
> r6:edee9b80 r5:0000000b
> [   17.952014]  r4:edee9b80
> [   17.952029] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [   17.952041]  r9:ed058000 r8:c0108da4 r7:00000036 r6:c01064ab
> r5:bea337d0 r4:00000000
> [   17.952048] ---[ end trace 3e19c988c4369e27 ]---
> [   19.108300] ------------[ cut here ]------------
> [   19.108329] WARNING: CPU: 2 PID: 782 at
> drivers/gpu/drm/drm_vblank.c:303
> drm_crtc_accurate_vblank_count+0x80/0x84
> [   19.108337] This function requires support for accurate vblank timestamps.
> [   19.108344] Modules linked in: dw_hdmi_cec dw_hdmi_ahb_audio
> snd_soc_imx_sgtl5000 snd_soc_imx_spdif snd_soc_fsl_asoc_card
> snd_ac97_codec coda videobuf2_dma_contig imx_vdoa v4l2_mem2mem
> videobuf2_vmalloc videobuf2_memops dw_hdmi_imx imxdrm dw_hdmi cec
> etnaviv imx_ipu_v3 binfmt_misc parport_pc ppdev lp parport
> [   19.108497] CPU: 2 PID: 782 Comm: Xorg Tainted: G        W
> 4.14.0-rc7-gd65d313-dirty #1
> [   19.108506] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   19.108513] Backtrace:
> [   19.108533] [<c010d558>] (dump_backtrace) from [<c010d838>]
> (show_stack+0x18/0x1c)
> [   19.108544]  r7:c106eed0 r6:00000000 r5:60000093 r4:c106eed0
> [   19.108562] [<c010d820>] (show_stack) from [<c09ff10c>]
> (dump_stack+0xac/0xd8)
> [   19.108579] [<c09ff060>] (dump_stack) from [<c0122d78>] (__warn+0xec/0x104)
> [   19.108592]  r10:000000ab r9:c0527bd8 r8:0000012f r7:00000009
> r6:c0d4fc08 r5:00000000
> [   19.108600]  r4:ed059c08 r3:00000006
> [   19.108612] [<c0122c8c>] (__warn) from [<c0122dd0>]
> (warn_slowpath_fmt+0x40/0x48)
> [   19.108624]  r9:00000000 r8:00000001 r7:edc2f000 r6:00000000
> r5:edc2f000 r4:c0d50064
> [   19.108638] [<c0122d94>] (warn_slowpath_fmt) from [<c0527bd8>]
> (drm_crtc_accurate_vblank_count+0x80/0x84)
> [   19.108646]  r3:00000000 r2:c0d50064
> [   19.108653]  r4:edc2f000
> [   19.108665] [<c0527b58>] (drm_crtc_accurate_vblank_count) from
> [<c052800c>] (drm_crtc_arm_vblank_event+0x30/0x64)
> [   19.108675]  r7:edc2f000 r6:00000001 r5:edc2f000 r4:ed042180
> [   19.108709] [<c0527fdc>] (drm_crtc_arm_vblank_event) from
> [<bf0a89bc>] (ipu_crtc_atomic_begin+0x50/0x80 [imxdrm])
> [   19.108718]  r5:ed042c80 r4:edc2b018
> [   19.108742] [<bf0a896c>] (ipu_crtc_atomic_begin [imxdrm]) from
> [<c04fa720>] (drm_atomic_helper_commit_planes+0x8c/0x2a8)
> [   19.108751]  r5:ed042c80 r4:00000018
> [   19.108771] [<c04fa694>] (drm_atomic_helper_commit_planes) from
> [<bf0a81a4>] (imx_drm_atomic_commit_tail+0x30/0x144 [imxdrm])
> [   19.108783]  r10:000000ab r9:00000000 r8:edc2b018 r7:edc2f000
> r6:ed042c80 r5:bf0ab088
> [   19.108791]  r4:ed042c80
> [   19.108814] [<bf0a8174>] (imx_drm_atomic_commit_tail [imxdrm]) from
> [<c04feb1c>] (commit_tail+0x48/0x8c)
> [   19.108826]  r10:000000ab r9:00000000 r8:edc2b018 r7:edc2f000
> r6:00000000 r5:bf0ab088
> [   19.108834]  r4:ed042c80 r3:bf0a8174
> [   19.108846] [<c04fead4>] (commit_tail) from [<c04fecb8>]
> (drm_atomic_helper_commit+0x140/0x148)
> [   19.108854]  r5:00000000 r4:ed042c80
> [   19.108871] [<c04feb78>] (drm_atomic_helper_commit) from
> [<c051c138>] (drm_atomic_commit+0x54/0x60)
> [   19.108881]  r7:00000000 r6:edc2f000 r5:ed042c80 r4:00000000
> [   19.108895] [<c051c0e4>] (drm_atomic_commit) from [<c051d2fc>]
> (drm_atomic_connector_commit_dpms+0xf0/0x100)
> [   19.108904]  r7:00000000 r6:edc2c010 r5:ed042c80 r4:00000001
> [   19.108917] [<c051d20c>] (drm_atomic_connector_commit_dpms) from
> [<c0522a64>] (drm_mode_obj_set_property_ioctl+0x1b4/0x2ac)
> [   19.108928]  r9:ed042c80 r8:00000000 r7:00000000 r6:ed059d78
> r5:edc2c024 r4:edd76980
> [   19.108942] [<c05228b0>] (drm_mode_obj_set_property_ioctl) from
> [<c0521378>] (drm_mode_connector_property_set_ioctl+0x40/0x48)
> [   19.108954]  r10:000000ab r9:c01064ab r8:ed059e60 r7:c0521338
> r6:edc2f000 r5:00000000
> [   19.108961]  r4:00000000
> [   19.108976] [<c0521338>] (drm_mode_connector_property_set_ioctl)
> from [<c050a7e0>] (drm_ioctl_kernel+0x70/0xb0)
> [   19.108985]  r5:ed43b200 r4:0000001a
> [   19.108996] [<c050a770>] (drm_ioctl_kernel) from [<c050ac78>]
> (drm_ioctl+0x2a4/0x3ac)
> [   19.109007]  r9:c01064ab r8:ed43b200 r7:ed059e60 r6:c0b45b9c
> r5:00000010 r4:00000010
> [   19.109022] [<c050a9d4>] (drm_ioctl) from [<c023eab8>]
> (do_vfs_ioctl+0xac/0xa2c)
> [   19.109034]  r10:00000000 r9:ed058000 r8:0000000b r7:c023f474
> r6:edee9b80 r5:ed759f28
> [   19.109041]  r4:bea33bb0
> [   19.109052] [<c023ea0c>] (do_vfs_ioctl) from [<c023f474>]
> (SyS_ioctl+0x3c/0x64)
> [   19.109063]  r10:00000000 r9:ed058000 r8:bea33bb0 r7:c01064ab
> r6:edee9b80 r5:0000000b
> [   19.109070]  r4:edee9b80
> [   19.109085] [<c023f438>] (SyS_ioctl) from [<c0108be0>]
> (ret_fast_syscall+0x0/0x28)
> [   19.109097]  r9:ed058000 r8:c0108da4 r7:00000036 r6:c01064ab
> r5:bea33bb0 r4:00000000
> [   19.109104] ---[ end trace 3e19c988c4369e28 ]---
>
> On Thu, Nov 9, 2017 at 12:12 PM, Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
>> On Thu, 09 Nov 2017, Lu?s Mendes <luis.p.mendes@gmail.com> wrote:
>>> I've just applied the referred individual patch to kernel-4.14-rc5 and
>>> the EDID isn't loaded. dw-hdmi gets no firmware at all.
>>
>> Sorry, I didn't mean you could just cherry-pick that one commit and make
>> it work. There were a number of preparatory patches before that, and I
>> think some cleanups on top.
>>
>> Please try drm-next to make sure you have it all.
>>
>> We didn't intend for the commits to be backported, instead we very much
>> wanted them to get a gradually increasing amount of exposure first to
>> make sure we don't break stuff.
>>
>> And as I said elsewhere in the thread, Russell's patch may be relevant
>> for current Linus' master and stable. We just need to reconciliate how
>> the two things should work together in drm-next and v4.15 and on.
>>
>> BR,
>> Jani.
>>
>> --
>> Jani Nikula, Intel Open Source Technology Center

-- 
Jani Nikula, Intel Open Source Technology Center
