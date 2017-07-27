From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 27 Jul 2017 11:51:06 +0200
Subject: [PATCH v6 4/7] drm/rockchip: vop: group vop registers
In-Reply-To: <1501049966-6070-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049966-6070-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <44153824.CqyclESHdT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Mittwoch, 26. Juli 2017, 14:19:25 CEST schrieb Mark Yao:
> Grouping the vop registers facilitates make register
> definition clearer, and also is useful for different vop
> reuse the same group register.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  99 ++++++++++++------------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  60 ++++++++-------
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 112
> +++++++++++++++------------- 3 files changed, 144 insertions(+), 127
> deletions(-)

This breaks display support on both rk3036 and rk3288 and I end up
with a null pointer dereference in

[   10.640297] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   10.654430] pgd = c0204000
[   10.657452] [00000000] *pgd=00000000
[   10.661473] Internal error: Oops: 5 [#1] SMP ARM
[   10.666635] Modules linked in: snd_pcm media snd_timer phy_rockchip_dp snd soundcore rockchipdrm dw_hdmi analogix_dp rtc_rk808 pwm_rockchip clk_rk808 spi_rockchip
[   10.682897] CPU: 2 PID: 143 Comm: kworker/2:2 Not tainted 4.13.0-rc2-01791-g2b86603d0515 #355
[   10.692430] Hardware name: Rockchip (Device Tree)
[   10.697692] Workqueue: events deferred_probe_work_func
[   10.702152] Linux video capture interface: v2.00
[   10.708590] task: ee38c800 task.stack: ed2e6000
[   10.713656] PC is at vop_reg_set.constprop.4+0x4/0xa8 [rockchipdrm]
[   10.720668] LR is at vop_bind+0x568/0x8a0 [rockchipdrm]
[   10.726507] pc : [<bf04db28>]    lr : [<bf04e134>]    psr: 40010013
[   10.733514] sp : ed2e7d68  ip : 00000004  fp : bf054988
[   10.739350] r10: bf054988  r9 : 00000000  r8 : 00000001
[   10.745189] r7 : ed66f500  r6 : ee29da10  r5 : 00000000  r4 : ed22e010
[   10.752487] r3 : ffffffff  r2 : 00000000  r1 : 00000000  r0 : ed22e010
[   10.759785] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   10.767763] Control: 10c5387d  Table: 2d4e806a  DAC: 00000051
[   10.774188] Process kworker/2:2 (pid: 143, stack limit = 0xed2e6220)
[...]
[   11.058818] [<bf04db28>] (vop_reg_set.constprop.4 [rockchipdrm]) from [<bf04e134>] (vop_bind+0x568/0x8a0 [rockchipdrm])
[   11.058828] [<bf04e134>] (vop_bind [rockchipdrm]) from [<c0870400>] (component_bind_all+0x11c/0x23c)
[   11.058836] [<c0870400>] (component_bind_all) from [<bf04c1cc>] (rockchip_drm_bind+0x90/0x1d4 [rockchipdrm])
[   11.058843] [<bf04c1cc>] (rockchip_drm_bind [rockchipdrm]) from [<c0870854>] (try_to_bring_up_master+0x148/0x184)
[   11.058847] [<c0870854>] (try_to_bring_up_master) from [<c0870928>] (component_add+0x98/0x144)
[   11.058853] [<c0870928>] (component_add) from [<bf050d90>] (rockchip_dp_probe+0x7c/0x8c [rockchipdrm])
[   11.058860] [<bf050d90>] (rockchip_dp_probe [rockchipdrm]) from [<c0877660>] (platform_drv_probe+0x50/0xb0)
[   11.058865] [<c0877660>] (platform_drv_probe) from [<c0875b48>] (driver_probe_device+0x230/0x2e4)
[   11.058869] [<c0875b48>] (driver_probe_device) from [<c0874208>] (bus_for_each_drv+0x60/0x94)
[   11.058873] [<c0874208>] (bus_for_each_drv) from [<c0875838>] (__device_attach+0xb0/0x114)
[   11.058876] [<c0875838>] (__device_attach) from [<c0874ec8>] (bus_probe_device+0x84/0x8c)
[   11.058879] [<c0874ec8>] (bus_probe_device) from [<c087534c>] (deferred_probe_work_func+0x68/0x94)
[   11.058884] [<c087534c>] (deferred_probe_work_func) from [<c035a884>] (process_one_work+0x200/0x504)
[   11.058889] [<c035a884>] (process_one_work) from [<c035b610>] (worker_thread+0x38/0x594)
[   11.058894] [<c035b610>] (worker_thread) from [<c036045c>] (kthread+0x128/0x158)
[   11.058900] [<c036045c>] (kthread) from [<c0307d18>] (ret_from_fork+0x14/0x3c)
[   11.058904] Code: eaffffe0 e3a03004 eaffffef e92d4070 (e5914000)
[   11.058930] ---[ end trace 9caa88bbcb1af5e4 ]---

I'll try to investigate a bit more, but maybe you'll be able to
find the issue faster than me in the meantime.


Heiko
