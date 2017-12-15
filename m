From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Dec 2017 13:10:43 +0100
Subject: [PATCH 0/4 v5] Support bridge timings
Message-ID: <20171215121047.3650-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is in response to Laurent's mail:
https://www.spinics.net/lists/dri-devel/msg155618.html

So in summary:
- The connector is apparently not the right abstraction to carry
  the detailed timings specification between DRI drivers and bridge
  drivers.

- Instead put detailed timing data into the bridge itself as an
  optional information pointer.

- Add fields to specify triggering edge on the clock, setup
  and hold time for the bridge.

- Augment the dumb VGA driver with this data, supporting a few
  ADV and TI variants.

- Augment the PL111 driver to use this data to figure out if it
  needs to clock out display data on the negative edge rather
  than the positive edge because the current clocking out on the
  positive edge obviously partly misses the setup->hold window,
  as can be observed in annoying green flicker.

Linus Walleij (4):
  drm/bridge: Add bindings for TI THS8134
  drm/bridge: Provide a way to embed timing info in bridges
  drm/bridge: Add timing support to dumb VGA DAC
  drm/pl111: Support handling bridge timings

 .../bridge/{ti,ths8135.txt => ti,ths813x.txt}      | 13 +++--
 drivers/gpu/drm/bridge/dumb-vga-dac.c              | 61 ++++++++++++++++++++--
 drivers/gpu/drm/pl111/Kconfig                      |  1 +
 drivers/gpu/drm/pl111/pl111_display.c              | 35 +++++++++++--
 drivers/gpu/drm/pl111/pl111_drv.c                  | 20 +++----
 include/drm/drm_bridge.h                           | 20 +++++++
 6 files changed, 130 insertions(+), 20 deletions(-)
 rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt => ti,ths813x.txt} (69%)

-- 
2.14.3
