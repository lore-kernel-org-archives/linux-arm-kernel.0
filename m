From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 3 Jul 2012 13:09:52 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
Message-ID: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I've found the following problems in linux-3.5-rc5
(6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:

At boot:

------------[ cut here ]------------
WARNING: at drivers/clk/clk.c:508 __clk_enable+0x28/0x94()
Modules linked in:
[<c0018c7c>] (unwind_backtrace+0x0/0xf0) from [<c0020fc8>]
(warn_slowpath_common+0x4c/0x64)
[<c0020fc8>] (warn_slowpath_common+0x4c/0x64) from [<c0020ff8>]
(warn_slowpath_null+0x18/0x1c)
[<c0020ff8>] (warn_slowpath_null+0x18/0x1c) from [<c020a14c>]
(__clk_enable+0x28/0x94)
[<c020a14c>] (__clk_enable+0x28/0x94) from [<c020a1dc>] (clk_enable+0x24/0x58)
[<c020a1dc>] (clk_enable+0x24/0x58) from [<c0227f44>] (imx_ssi_probe+0x9c/0x374)
[<c0227f44>] (imx_ssi_probe+0x9c/0x374) from [<c018d018>]
(platform_drv_probe+0x14/0x18)
[<c018d018>] (platform_drv_probe+0x14/0x18) from [<c018bf44>]
(driver_probe_device+0xb0/0x1c4)
[<c018bf44>] (driver_probe_device+0xb0/0x1c4) from [<c018c0b8>]
(__driver_attach+0x60/0x84)
[<c018c0b8>] (__driver_attach+0x60/0x84) from [<c018a930>]
(bus_for_each_dev+0x48/0x84)
[<c018a930>] (bus_for_each_dev+0x48/0x84) from [<c018b044>]
(bus_add_driver+0x9c/0x214)
[<c018b044>] (bus_add_driver+0x9c/0x214) from [<c018c5c8>]
(driver_register+0xa0/0x12c)
[<c018c5c8>] (driver_register+0xa0/0x12c) from [<c00087d8>]
(do_one_initcall+0x94/0x16c)
[<c00087d8>] (do_one_initcall+0x94/0x16c) from [<c03a1280>]
(kernel_init+0xd4/0x19c)
[<c03a1280>] (kernel_init+0xd4/0x19c) from [<c0014940>]
(kernel_thread_exit+0x0/0x8)
---[ end trace 1b7118a416fcba5f ]---


When closing audio file:

visstrim login: Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Tainted: G        W     (3.4.0-rc4-00070-gea01d31 #20)
PC is at snd_dmaengine_pcm_get_data+0x8/0x10
LR is at snd_imx_close+0xc/0x28
pc : [<c021d860>]    lr : [<c02288cc>]    psr: a0000013
sp : c3365ef8  ip : 00000000  fp : b6e67538
r10: c316ec00  r9 : c316aca0  r8 : c31706c0
r7 : c316fda0  r6 : c316abf0  r5 : c31706c0  r4 : c316abfc
r3 : 00000000  r2 : 00000001  r1 : c33400c0  r0 : c31706c0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: a3374000  DAC: 00000015
Process linphonec (pid: 443, stack limit = 0xc3364270)
Stack: (0xc3365ef8 to 0xc3366000)
5ee0:                                                       c316abfc c316fec0
5f00: c316abf0 c02269d0 c31706c0 c33400c0 c316e8e0 c327ba00 c31706c0 c30171d0
5f20: c33400c8 c021673c c316e800 c33400c0 c316e8e0 c02167b4 c33400c0 c24a6998
5f40: c24a87b8 00000000 00000008 c0089a3c 00000000 00000000 c3365f90 c33400c0
5f60: 00000000 c3023140 00000014 c0013b48 c3364000 00000000 b6e67538 c0086a4c
5f80: c3023140 c33400c0 00000001 c0086b1c 011b81c8 00000000 011b81c8 00000006
5fa0: c0013b48 c00139a0 011b81c8 00000000 00000014 011b81c8 b6db4000 b6d54bdc
5fc0: 011b81c8 00000000 011b81c8 00000006 b6e67548 00000670 011a9b08 b6e67538
5fe0: 011b8178 bebb5a58 b6d54bf0 b5e2813c 60000010 00000014 00000000 00000000
[<c021d860>] (snd_dmaengine_pcm_get_data+0x8/0x10) from [<c02288cc>]
(snd_imx_close+0xc/0x28)
[<c02288cc>] (snd_imx_close+0xc/0x28) from [<c02269d0>]
(soc_pcm_close+0x134/0x1c8)
[<c02269d0>] (soc_pcm_close+0x134/0x1c8) from [<c021673c>]
(snd_pcm_release_substream+0x54/0xa4)
[<c021673c>] (snd_pcm_release_substream+0x54/0xa4) from [<c02167b4>]
(snd_pcm_release+0x28/0x6c)
[<c02167b4>] (snd_pcm_release+0x28/0x6c) from [<c0089a3c>] (fput+0x108/0x23c)
[<c0089a3c>] (fput+0x108/0x23c) from [<c0086a4c>] (filp_close+0x6c/0x78)
[<c0086a4c>] (filp_close+0x6c/0x78) from [<c0086b1c>] (sys_close+0xc4/0x120)
[<c0086b1c>] (sys_close+0xc4/0x120) from [<c00139a0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5831008 e12fff1e e59030a0 e59330bc (e5930008)


Moreover, the following 'clk_get()' fails in mx2_camera.c driver:

	pcdev->clk_emma = clk_get(NULL, "emma");
	if (IS_ERR(pcdev->clk_emma)) {
		err = PTR_ERR(pcdev->clk_emma);
		goto exit_free_irq;
	}


I know you guys have been doing some hard deep job with the clocks in
the i.MX. I've tried a bisect but it's highly thedious since there are
a lot of commits that do not compile:

git bisect start
# bad: [6e1c39c6b00d9141a82c231ba7c5e5b1716974b2] ALSA: hda - Fix
power-map regression for HP dv6 & co
git bisect bad 6e1c39c6b00d9141a82c231ba7c5e5b1716974b2
# good: [a23dc694828e3de96bf18e20459ba885ba91cb29] ASoC: imx: merge
sound/soc/imx into sound/soc/fsl
git bisect good a23dc694828e3de96bf18e20459ba885ba91cb29
# good: [94b5aff4c6f72fee6b0f49d49e4fa8b204e8ded9] Merge tag
'tty-3.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 94b5aff4c6f72fee6b0f49d49e4fa8b204e8ded9
# good: [f2fde3a65e88330017b816faf2ef75f141d21375] Merge branch
'drm-core-next' of git://people.freedesktop.org/~airlied/linux
git bisect good f2fde3a65e88330017b816faf2ef75f141d21375
# bad: [858ee3784e8105467f1f3017f4ece51cb51d4830] ipc/mqueue: switch
back to using non-max values on create
git bisect bad 858ee3784e8105467f1f3017f4ece51cb51d4830
# bad: [27953437059c64d14086196eb96f43c78caa9db3] Merge tag 'clock' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 27953437059c64d14086196eb96f43c78caa9db3
# good: [ece78b7df734726e790dcab207f463401ff80440] Merge branch
'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good ece78b7df734726e790dcab207f463401ff80440
# good: [0877aa3908aaeeae8fc2850691668c4315d3db56] Merge tag
'defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 0877aa3908aaeeae8fc2850691668c4315d3db56
# good: [0877aa3908aaeeae8fc2850691668c4315d3db56] Merge tag
'defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 0877aa3908aaeeae8fc2850691668c4315d3db56
# bad: [fcd8d84a585f3578a9ebdd27e757495a27415322] Merge branches
'spear/clock' and 'imx/clock' into next/clock
git bisect bad fcd8d84a585f3578a9ebdd27e757495a27415322
# good: [66a2886d867343eff6bf2646bea2c923d0cbf620] Merge branch
'spear/dt' into spear/clock
git bisect good 66a2886d867343eff6bf2646bea2c923d0cbf620
# skip: [b75c015143a4a6021731ff3e36718896381be94f] ARM i.MX: Add
common clock support for 2bit gate
git bisect skip b75c015143a4a6021731ff3e36718896381be94f
# skip: [a10bd67f1905b394f5a9bd610dfc8b9b9befac0e] ARM: imx: add
common clock support for pfd
git bisect skip a10bd67f1905b394f5a9bd610dfc8b9b9befac0e
# skip: [a3f6b9dbf2a964b85f0523e577807d6f63d6b29d] ARM: imx: add
common clock support for pllv3
git bisect skip a3f6b9dbf2a964b85f0523e577807d6f63d6b29d
# skip: [4f5a9fd341e8ffd825ecf56155df6fe6c3d732b1] Merge branch
'imx/pinctrl' into imx/clock
git bisect skip 4f5a9fd341e8ffd825ecf56155df6fe6c3d732b1
# skip: [6bbaec5676e4f475b0d78743cbd4c70a8804ce14] ARM i.MX25:
implement clocks using common clock framework
git bisect skip 6bbaec5676e4f475b0d78743cbd4c70a8804ce14
# skip: [4e7b6c9a6b4700cf121a0d5924f193db83cbd008] watchdog imx2:
prepare clk before enabling it
git bisect skip 4e7b6c9a6b4700cf121a0d5924f193db83cbd008
# skip: [32af7a830fe1625fa93900606f82c541f3b3de94] ARM: imx: add
common clock support for clk busy
git bisect skip 32af7a830fe1625fa93900606f82c541f3b3de94
# skip: [fdf7748b9f8d392a086560616bf112f0ba0c1f71] media mx3 camera:
prepare clk before enabling it
git bisect skip fdf7748b9f8d392a086560616bf112f0ba0c1f71
# skip: [a547b816a879b235ae0f90ae32d74effbb20d6d1] ARM i.MX: Add
common clock support for pllv2
git bisect skip a547b816a879b235ae0f90ae32d74effbb20d6d1
# skip: [c818f97bc3266f0fbf619f2348d951272f8ac335] ARM i.MX: remove
now unused clock files
git bisect skip c818f97bc3266f0fbf619f2348d951272f8ac335
# skip: [2af9e6db14db9a7a0a6510227352fb2e69f9d032] ARM i.MX: Add
common clock support for pllv1
git bisect skip 2af9e6db14db9a7a0a6510227352fb2e69f9d032
# skip: [2acd1b6f889c04f8f303a5a11993f60fda6a7885] ARM: i.MX6:
implement clocks using common clock framework
git bisect skip 2acd1b6f889c04f8f303a5a11993f60fda6a7885
# good: [7560e3f3581ed415828d3f431b8622fa38c2d133] dmaengine i.MX
SDMA: do not depend on grouped clocks
git bisect good 7560e3f3581ed415828d3f431b8622fa38c2d133
# skip: [4ec8c7f52654cdbb13770d04dc76f9a4615cd4e1] rtc: imx dryice:
Add missing clk_prepare
git bisect skip 4ec8c7f52654cdbb13770d04dc76f9a4615cd4e1
# good: [23b5e15a2994fb0c1444f92b76f09a482f32843c] clk: mxs: add mxs
specific clocks
git bisect good 23b5e15a2994fb0c1444f92b76f09a482f32843c
# skip: [5b48a6145466f1e2b58b31b1673ec413dabdab2a] ARM i.MX35:
implement clocks using common clock framework
git bisect skip 5b48a6145466f1e2b58b31b1673ec413dabdab2a
...
...
...

Do you have any hints of what could have been broken? I'll keep on
searching meanwhile.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
