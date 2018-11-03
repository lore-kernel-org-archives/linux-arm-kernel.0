From: aeden@csail.mit.edu (Anthony Eden)
Date: Sat, 3 Nov 2018 16:08:51 -0400
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <20180809140753.GH21639@ulmo>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
 <20180712154128.22705-6-thierry.reding@gmail.com>
 <20180714212210.at4b2gcpopsznyxx@localhost>
 <20180803104318.GA28546@ulmo>
 <CAHMsQjU=nmpTnPK6Ryhui67YVANHExd=yRB4hp+upd7O-Tjn+Q@mail.gmail.com>
 <20180809102104.GB21639@ulmo> <51a19ec3-8b34-56f5-d9c7-69397d3d11ff@kapsi.fi>
 <20180809140753.GH21639@ulmo>
Message-ID: <CAHMsQjXXM0Vfx1MQ4C++--55vdAMYx-9CG00QM7893K17Ca5jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the late reply. Thank you for the helpful information and guidance.

But before I investigate the thermal hypothesis further, I thought I'd
send out a kernel panic that I captured today during one of these
hangs. At the time I was upgrading packages via pacman (ArchLinux).
Does this shed any light on the issue?

Best,
-Anthony

On Thu, Aug 9, 2018 at 10:07 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Aug 09, 2018 at 01:34:37PM +0300, Mikko Perttunen wrote:
> > On 09.08.2018 13:21, Thierry Reding wrote:
> > > On Fri, Aug 03, 2018 at 07:26:04AM -0400, Anthony Eden wrote:
> > > > Mesa support aside- if I start a computationally intensive job on the
> > > > Jetson TX2 like building the Linux kernel on all cores, it will lock
> > > > up. My only work around has been to disable the Denver CPU's. I don't
> > > > think the tegra186 has upstream support to control the fan on the
> > > > Jetson TX2, could this be a thermal problem?
> > >
> > > Yes, I suppose this could be a thermal problem. Or it could be something
> > > else entirely. We do support CPU frequency scaling on Tegra X2, so what
> > > you could do is keep the Denver CPUs enabled, but set the powersave CPU
> > > frequency governor. That way it should use all the CPUs but at a lower
> > > clock rate, which should also be able to avoid any thermal issues. This
> > > could help determine whether or not the problem is thermal or something
> > > else.
> > >
> > > Also adding Mikko on Cc who wrote the Tegra186 driver, maybe he's aware
> > > of any issues.
> >
> > I haven't seen any issues myself, though I haven't stressed the CPU too
> > heavily. We also have a thermal driver for Tegra186, so we could set up
> > thermal throttling with a device tree change.
>
> Do you have an example of how that would work? The DT bindings are a
> little sparse on the specifics. It seems like something similar to what
> we did on Tegra124 could be done on Tegra186.
>
> Anthony: do you think you could come up with something suitable based on
> what arch/arm/boot/dts/tegra124{.dtsi,-jetson-tk1.dts} and the device
> tree bindings for Tegra186 contain in
>
>         Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
>
> as well as
>
>         include/dt-bindings/thermal/tegra186-bpmp-thermal.h
>
> ? That's provided that reducing the CPU frequency does indeed prevent
> the lock up that you were seeing.
>
> Thierry
-------------- next part --------------
/usr/lib/systemd/systemd: error wh[    7.411931] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
[    7.411931]
[    7.423817] CPU: 0 PID: 1 Comm: systemd Tainted: G S                4.19.0-22-ARCH #1
[    7.431661] Hardware name: NVIDIA Tegra186 P2771-0000 Development Board (DT)
[    7.438721] Call trace:
[    7.441176]  dump_backtrace+0x0/0x180
[    7.444845]  show_stack+0x24/0x30
[    7.448168]  dump_stack+0x9c/0xbc
[    7.451490]  panic+0x124/0x274
[    7.454551]  do_exit+0xa80/0xab0
[    7.457784]  do_group_exit+0x3c/0xd0
[    7.461365]  __arm64_sys_exit_group+0x24/0x28
[    7.465729]  el0_svc_common+0x94/0xe8
[    7.469397]  el0_svc_handler+0x38/0x80
[    7.473152]  el0_svc+0x8/0xc
[    7.476039] SMP: stopping secondary CPUs
[    7.479974] Kernel Offset: disabled
[    7.483469] CPU features: 0x0,20002000
[    7.487222] Memory Limit: none
[    7.490285] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
[    7.490285]  ]---
ile loading shared libraries: /u[    7.500730] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:1163 set_task_cpu+0x1b8/0x1c8
[    7.511448] Modules linked in: nvme nvme_core broadcom max77620_wdt bcm_phy_lib max77620_thermal ina3221 tegra_drm drm_kms_helper drm drm_panel_orientation_quirks syscopyarea gpio_keys sysfillrect sysimgblt tegra_bpmp_thermal dwmac_dwc_qos_eth i2c_tegra_bpmp fb_sys_fops stmmac_platform stmmac i2c_tegra host1x
[    7.538902] CPU: 0 PID: 1 Comm: systemd Tainted: G S                4.19.0-22-ARCH #1
[    7.546748] Hardware name: NVIDIA Tegra186 P2771-0000 Development Board (DT)
[    7.553809] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    7.558609] pc : set_task_cpu+0x1b8/0x1c8
[    7.562627] lr : try_to_wake_up+0x190/0x478
[    7.566815] sp : ffff000008003d10
[    7.570134] x29: ffff000008003d10 x28: ffff0000096160c0
[    7.575456] x27: ffff0000095fc000 x26: 0000000000000100
[    7.580779] x25: 0000000000000005 x24: ffff00000961a490
[    7.586102] x23: ffff0000096089c0 x22: 0000000000000000
[    7.593268] x21: 0000000000000004 x20: 0000000000000005
[    7.600426] x19: ffff8001ed1f5e80 x18: 0000000000000000
[    7.607584] x17: 0000000000000000 x16: 0000000000000000
[    7.614740] x15: 0000000000000000 x14: 0000000000000000
[    7.621866] x13: ffff000008ca2658 x12: 00000000ffffffff
[    7.629006] x11: 000000000000009c x10: 0000000000000001
[    7.636135] x9 : 0000000000000000 x8 : ffff8001f67412a8
[    7.643241] x7 : 0040000000000000 x6 : 0000000000000036
[    7.650358] x5 : 00008001ed140000 x4 : ffff00000961a490
[    7.657457] x3 : 00008001ed1b8000 x2 : 0000000000000005
[    7.664563] x1 : ffff000009619700 x0 : 0000000000000000
[    7.671641] Call trace:
[    7.675753]  set_task_cpu+0x1b8/0x1c8
[    7.681081]  try_to_wake_up+0x190/0x478
[    7.686593]  wake_up_process+0x28/0x38
[    7.691993]  process_timeout+0x20/0x30
[    7.697355]  call_timer_fn+0x34/0x170
[    7.702636]  expire_timers+0xc0/0x148
[    7.707908]  run_timer_softirq+0xbc/0x1d8
[    7.713515]  __do_softirq+0x120/0x300
[    7.718781]  irq_exit+0xc0/0xd0
[    7.723505]  __handle_domain_irq+0x70/0xc0
[    7.729138]  gic_handle_irq+0x58/0xa8
[    7.734332]  el1_irq+0xb0/0x140
[    7.739006]  panic+0x224/0x274
[    7.743561]  do_exit+0xa80/0xab0
[    7.748299]  do_group_exit+0x3c/0xd0
[    7.753361]  __arm64_sys_exit_group+0x24/0x28
[    7.759217]  el0_svc_common+0x94/0xe8
[    7.764357]  el0_svc_handler+0x38/0x80
[    7.769562]  el0_svc+0x8/0xc
[    7.773915] ---[ end trace 22e2a84658d004da ]---
sr/lib/libcryptsetup.so.12: file too short
