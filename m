From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 31 Oct 2017 00:01:08 +0100
Subject: [PATCH v6 00/10] rockchip: kevin: Enable edp display
In-Reply-To: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
Message-ID: <2449324.8EdsLz1NaV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy, Sean,

Am Donnerstag, 19. Oktober 2017, 11:48:02 CET schrieb Jeffy Chen:
> 
> Make edp display works on chromebook kevin(at least for boot animation).
> 
> Also solve some issues i meet during the bringup.
> 
> Changes in v6:
> Don't change order of rockchip_drm_psr_register().
> 
> Changes in v5:
> Call the destroy hook in the error handling path like in unbind().
> Call the destroy hook in the error handling path like in unbind().
> Update cleanup order in unbind().
> Add disable to unbind(), and inline clk_prepare_enable() with bind().
> 
> Jeffy Chen (10):
>   arm64: dts: rockchip: Enable edp disaplay on kevin
>   drm/rockchip: analogix_dp: Remove unnecessary init code
>   drm/bridge: analogix: Do not use device's drvdata
>   drm/bridge: analogix_dp: Fix connector and encoder cleanup
>   drm/rockchip: analogix_dp: Add a sanity check for
>     rockchip_drm_psr_register()
>   drm/rockchip: dw-mipi-dsi: Fix error handling path
>   drm/rockchip: inno_hdmi: Fix error handling path
>   drm/bridge/synopsys: dw-hdmi: Add missing bridge detach
>   drm/bridge/synopsys: dw-hdmi: Do not use device's drvdata
>   drm/rockchip: dw_hdmi: Fix error handling path

As I was just looking at the edp dts change in patch1 again, does this
series also contain a fix for the issue below [0] ?

I'm still seeing this on 4.14-rc6 with the most recent drm tree merged in.


Heiko

[0]

[   27.960120] BUG: scheduling while atomic: kworker/1:1/68/0x00000002
[   27.974429] Modules linked in: rockchipdrm dw_hdmi analogix_dp drm_kms_helper panel_simple crc32_ce drm crct10dif_ce rockchip_saradc pwm_bl pwm_cros_ec rockchip_thermal ip_tables x_tabl
es ipv6 smsc95xx smsc75xx ax88179_178a asix usbnet phy_rockchip_pcie pcie_rockchip
[   28.008769] CPU: 1 PID: 68 Comm: kworker/1:1 Tainted: G        W       4.14.0-rc7-03201-g12490811b353 #559
[   28.008774] Hardware name: Google Kevin (DT)
[   28.008825] Workqueue: events analogix_dp_psr_work [rockchipdrm]
[   28.008828] Call trace:
[   28.008838] [<ffff000008088d60>] dump_backtrace+0x0/0x378
[   28.008842] [<ffff0000080890ec>] show_stack+0x14/0x20
[   28.008847] [<ffff0000089b04d8>] dump_stack+0x9c/0xbc
[   28.008852] [<ffff0000080ec4b4>] __schedule_bug+0x4c/0x70
[   28.008856] [<ffff0000089c4828>] __schedule+0x558/0x5e8
[   28.008859] [<ffff0000089c48f0>] schedule+0x38/0xa0
[   28.008864] [<ffff0000089c8194>] schedule_hrtimeout_range_clock+0x84/0xe8
[   28.008867] [<ffff0000089c8208>] schedule_hrtimeout_range+0x10/0x18
[   28.008870] [<ffff0000089c7c74>] usleep_range+0x64/0x78
[   28.008882] [<ffff000000ef56e4>] analogix_dp_transfer+0x16c/0xa88 [analogix_dp]
[   28.008891] [<ffff000000ef2190>] analogix_dpaux_transfer+0x10/0x18 [analogix_dp]
[   28.008950] [<ffff000000ddbb1c>] drm_dp_dpcd_access+0x4c/0xf8 [drm_kms_helper]
[   28.008994] [<ffff000000ddbbe4>] drm_dp_dpcd_write+0x1c/0x28 [drm_kms_helper]
[   28.009002] [<ffff000000ef2130>] analogix_dp_disable_psr+0x60/0xb0 [analogix_dp]
[   28.009036] [<ffff000000f8398c>] analogix_dp_psr_work+0x4c/0xc0 [rockchipdrm]
[   28.009040] [<ffff0000080dff44>] process_one_work+0x1d4/0x348
[   28.009043] [<ffff0000080e0100>] worker_thread+0x48/0x470
[   28.009048] [<ffff0000080e63d4>] kthread+0x12c/0x130
[   28.009052] [<ffff000008084b88>] ret_from_fork+0x10/0x18
