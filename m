From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 23 Oct 2018 21:20:20 +0530
Subject: [PATCH v2 00/15] drm/sun4i: Allwinner A64 MIPI-DSI support 
Message-ID: <20181023155035.9101-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add MIPI-DSI support on Allwinner A64. The same A31 controller
is reused and tweaked for A64 since the register space for both SoC's look same.

A64 PLL_MIPI look difficult to set the proper dclk nkm dividers with
existing clock driver. But Setting the dclk on panel set to 55MHz
(BSP says 30MHz) and min PLL_MIPI rate used as 30MHz. This logic make proper
rounded rate by sun4i_dclk_round_rate which eventually working.

24 / 4 * 55000 = 330000 (24 bit format with 4 lane and 55MHz clock)

[    2.360344] sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_mixer_ops)
[    2.367899] sun4i_dclk_recalc_rate: val = 1, rate = 594000000
[    2.373827] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    2.381666] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops sun4i_tcon_ops)
[    2.389691] sun4i-drm display-engine: bound 1ca0000.dsi (ops sun6i_dsi_ops)
[    2.396653] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.403266] [drm] No driver support for vblank timestamp query.
[    2.411632] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.411693] ideal = 220000000, rounded = 0
[    2.411698] ideal = 275000000, rounded = 0
[    2.411716] ideal = 330000000, rounded = 330000000
[    2.411720] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.411725] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.411729] ideal = 220000000, rounded = 0
[    2.411732] ideal = 275000000, rounded = 0
[    2.411750] ideal = 330000000, rounded = 330000000
[    2.411753] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.411790] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.411794] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.411817] NKM: rate = 330000000
[    2.411819] NKM: parent_rate = 297000000
[    2.411821] NKM: _nkm.n = 5
[    2.411823] NKM: _nkm.k = 2
[    2.411825] NKM: _nkm.m = 9
[    2.412175] sun4i_dclk_set_rate div 6
[    2.412182] sun4i_dclk_recalc_rate: val = 6, rate = 55000000

But the same logic seems "not working" on 2-lane panel where dclk on panel
set to 27.5MHz(BSP says 29MHz)

24/2 * 27500 = 330000 (24 bit format with 2 lane and 27.5 MHz clock)

[    1.877154] sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_mixer_ops)
[    1.884695] sun4i_dclk_recalc_rate: val = 1, rate = 594000000
[    1.890659] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    1.898515] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops sun4i_tcon_ops)
[    1.906563] sun4i-drm display-engine: bound 1ca0000.dsi (ops sun6i_dsi_ops)
[    1.913542] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.920173] [drm] No driver support for vblank timestamp query.
[    1.929330] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 27500000
[    1.929388] ideal = 110000000, rounded = 0
[    1.929392] ideal = 137500000, rounded = 0
[    1.929396] ideal = 165000000, rounded = 0
[    1.929400] ideal = 192500000, rounded = 0
[    1.929403] ideal = 220000000, rounded = 0
[    1.929407] ideal = 247500000, rounded = 0
[    1.929410] ideal = 275000000, rounded = 0
[    1.929429] ideal = 302500000, rounded = 297000000
[    1.929446] ideal = 330000000, rounded = 330000000
[    1.929449] sun4i_dclk_round_rate: div = 12 rate = 27500000
[    1.929454] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 27500000
[    1.929458] ideal = 110000000, rounded = 0
[    1.929462] ideal = 137500000, rounded = 0
[    1.929465] ideal = 165000000, rounded = 0
[    1.929469] ideal = 192500000, rounded = 0
[    1.929472] ideal = 220000000, rounded = 0
[    1.929476] ideal = 247500000, rounded = 0
[    1.929479] ideal = 275000000, rounded = 0
[    1.929496] ideal = 302500000, rounded = 297000000
[    1.929536] ideal = 330000000, rounded = 330000000
[    1.929539] sun4i_dclk_round_rate: div = 12 rate = 27500000
[    1.929576] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.929580] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    1.929613] NKM: rate = 330000000
[    1.929616] NKM: parent_rate = 297000000
[    1.929619] NKM: _nkm.n = 5
[    1.929620] NKM: _nkm.k = 2
[    1.929622] NKM: _nkm.m = 9
[    1.929966] sun4i_dclk_set_rate div 12
[    1.929974] sun4i_dclk_recalc_rate: val = 12, rate = 27500000
[    1.957513] random: fast init done
[    1.967893] mmc0: new high speed SDIO card at address 0001
[    1.971835] mmc1: new DDR MMC card at address 0001
[    1.973250] mmcblk1: mmc1:0001 8GND3R 7.28 GiB
[    1.974391] mmcblk1boot0: mmc1:0001 8GND3R partition 1 4.00 MiB
[    1.975528] mmcblk1boot1: mmc1:0001 8GND3R partition 2 4.00 MiB
[    1.982660]  mmcblk1: p1 p2 p3 p4 p5 p6
[    3.221053] ------------[ cut here ]------------
[    3.221059] [CRTC:36:crtc-0] vblank wait timed out
[    3.221136] WARNING: CPU: 2 PID: 42 at drivers/gpu/drm/drm_atomic_helper.c:1387 drm_atomic_helper_
wait_for_vblanks.part.9+0x294/0x2a0
[    3.221139] Modules linked in:
[    3.221151] CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 4.19.0-rc8-next-20181016-00024-g11217d38f
d10-dirty #5
[    3.221154] Hardware name: Amarula A64-Relic (DT)
[    3.221166] Workqueue: events deferred_probe_work_func
[    3.221173] pstate: 60000005 (nZCv daif -PAN -UAO)
[    3.221179] pc : drm_atomic_helper_wait_for_vblanks.part.9+0x294/0x2a0
[    3.221185] lr : drm_atomic_helper_wait_for_vblanks.part.9+0x294/0x2a0
[    3.221187] sp : ffff0000095fb3e0
[    3.221190] x29: ffff0000095fb3e0 x28: 0000000000000001
[    3.221196] x27: 0000000000000000 x26: 0000000000000000
[    3.221202] x25: ffff80003c057000 x24: ffff80003bdbb000
[    3.221207] x23: 0000000000000001 x22: 0000000000000030
[    3.221213] x21: 0000000000000001 x20: ffff80003bdbc018
[    3.221218] x19: 0000000000000000 x18: ffffffffffffffff
[    3.221224] x17: 0000000000000000 x16: 0000000000000000
[    3.221229] x15: ffff0000091d96c8 x14: 00000000fffffff0
[    3.221235] x13: ffff000009340ba0 x12: ffff0000091f1348
[    3.221240] x11: ffff0000091f1000 x10: ffff000009340000
[    3.221246] x9 : 0000000000000000 x8 : 0000000000000000
[    3.221251] x7 : 0000000000000000 x6 : 000000000dc21395
[    3.221256] x5 : 0000000000000000 x4 : 0000000000000000
[    3.221262] x3 : ffffffffffffffff x2 : ffff0000091f1378
[    3.221267] x1 : de241ee6737e7400 x0 : 0000000000000000
[    3.221273] Call trace:
[    3.221279]  drm_atomic_helper_wait_for_vblanks.part.9+0x294/0x2a0
[    3.221285]  drm_atomic_helper_commit_tail_rpm+0x60/0x78
[    3.221289]  commit_tail+0x44/0x78
[    3.221294]  drm_atomic_helper_commit+0xcc/0x148
[    3.221301]  drm_atomic_commit+0x48/0x58
[    3.221309]  restore_fbdev_mode_atomic+0x17c/0x1e8
[    3.221316]  restore_fbdev_mode+0x50/0x190
[    3.221322]  drm_fb_helper_restore_fbdev_mode_unlocked+0x70/0xc8
[    3.221328]  drm_fb_helper_set_par+0x2c/0x60
[    3.221335]  fbcon_init+0x4d8/0x528
[    3.221341]  visual_init+0xb0/0x108
[    3.221346]  do_bind_con_driver+0x1d0/0x3b0
[    3.221351]  do_take_over_console+0x148/0x1d8
[    3.221355]  do_fbcon_takeover+0x6c/0xf0
[    3.221361]  fbcon_event_notify+0x9a4/0x9d0
[    3.221370]  notifier_call_chain+0x50/0x90
[    3.221376]  __blocking_notifier_call_chain+0x4c/0x90
[    3.221382]  blocking_notifier_call_chain+0x14/0x20
[    3.221390]  fb_notifier_call_chain+0x1c/0x28
[    3.221396]  register_framebuffer+0x1ec/0x320
[    3.221402]  __drm_fb_helper_initial_config_and_unlock+0x22c/0x3b0
[    3.221408]  drm_fb_helper_fbdev_setup+0xd4/0x1f8
[    3.221414]  drm_fbdev_cma_init+0x9c/0xe8
[    3.221420]  drm_fb_cma_fbdev_init+0xc/0x20
[    3.221426]  sun4i_framebuffer_init+0x48/0x58
[    3.221431]  sun4i_drv_bind+0x14c/0x1a0
[    3.221436]  try_to_bring_up_master+0x144/0x1a8
[    3.221440]  component_add+0x98/0x160
[    3.221447]  sun8i_mixer_probe+0x18/0x20
[    3.221453]  platform_drv_probe+0x50/0xa8
[    3.221458]  really_probe+0x1e4/0x2a8
[    3.221464]  driver_probe_device+0x58/0x100
[    3.221470]  __device_attach_driver+0x9c/0xf8
[    3.221475]  bus_for_each_drv+0x70/0xc8
[    3.221480]  __device_attach+0xdc/0x138
[    3.221486]  device_initial_probe+0x10/0x18
[    3.221492]  bus_probe_device+0x94/0xa0
[    3.221497]  deferred_probe_work_func+0x6c/0xa0
[    3.221505]  process_one_work+0x1c8/0x318
[    3.221511]  worker_thread+0x234/0x428
[    3.221516]  kthread+0xf8/0x128
[    3.221523]  ret_from_fork+0x10/0x18
[    3.221527] ---[ end trace af12203776f67ca9 ]---
[   13.277055] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:36:crtc-0] flip_done timed
 out
[   23.517053] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:38:DSI-1] flip_done t
imed out
[   33.757052] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-1] flip_done tim
ed out
[   33.813049] ------------[ cut here ]------------
[   33.813053] [CRTC:36:crtc-0] vblank wait timed out

Any suggestions,
Jagan.

Jagan Teki (15):
  clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: Add check for maximum rate to NKM PLLs
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  dt-bindings: panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB
    bridge
  drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
  arm64: dts: allwinner: a64: Add DSI pipeline
  arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel

 .../panel/bananapi,s070wv20-ct16-icn6211.txt  |  21 ++
 .../bindings/display/sunxi/sun6i-dsi.txt      |   3 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  42 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                |  14 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   2 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 336 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  68 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   5 +
 12 files changed, 532 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c

-- 
2.18.0.321.gffc6fa0e3
