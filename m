From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:32:53 +0100
Subject: [PATCH 00/11] drm/rockchip: add support for lvds controller and
 external encoders
Message-ID: <1422721984-27782-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the lvds encoder present on rk3288 soc and
allows external connectors to use the generic rgb pins.

On the older socs (rk3188, rk3066, etc) these pins where accessible by
anyone, while on the rk3288 the lvds controller controls access to them.

So while on the old socs an external encoder was explicitly connected
to one of the two lcd-controllers, on the rk3288 the lvds in between
can toggle which controller should be the source.

To facilitate this the lvds encoder can use two modes. When a panel is
attached it acts as encoder and without panel it just registers a bridge
that can be used later.

The bridge association to an encoder is done via a rockchip,rgb-bridge
property in the encoder node itself and handled in rockchip_drm_load
to not leak rockchip-specific handling into generic encoder drivers.


As example on how this can work, I've included a driver for simple
(dumb) vga encoders, like the adv7123 (and clones) as used on the
rk3288-firefly board. This same encoder is used on the Rayeager-px2
board but there connected directly to the rgb pins of the rk3066
which will hopefully also be supported in the future.

I've named this currently vga-simply (inspired by panel-simple), because
so far I have found the adv7123 (and two clones) but I guess there will
be more dumb vga encoders around that only differ in minimal things.


Similarly, most of the rk3288-based TV-boxes use a rk1000 i2c tv encoder
connected in a similar way - and again directly connected on the
rk3188-radxarock.


Caveats:
- the i2c subdirectory is probably not the right one for my vga encoder
  so if somebody could suggest where this should live, I'd be very happy
- I'm not sure if I'm abusing some drm-APIs in a wrong way :-)


Heiko Stuebner (9):
  drm/encoder: allow encoders to remember their of_node
  drm: add bindings for simple vga encoders
  drm: add driver for simple vga encoders
  drm/rockchip: lvds: register a bridge when no panel is set
  drm/rockchip: attach rgb bridge to encoders needing it
  drm/rockchip: enable rgb ouput of vops for vga and tv connectors
  ARM: dts: rockchip: add rk3288 lcdc0 pinmux settings
  ARM: dts: rockchip: add rk3288 lvds node
  ARM: dts: rockchip: add vga encoder and enable lvds on rk3288-firefly

Mark Yao (2):
  dt-bindings: Add documentation for rockchip lvds
  drm/rockchip: Add support for Rockchip Soc LVDS

 .../devicetree/bindings/drm/i2c/vga-simple.txt     |  18 +
 .../devicetree/bindings/video/rockchip-lvds.txt    |  63 ++
 .../devicetree/bindings/video/rockchip-vop.txt     |  16 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  45 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  45 ++
 drivers/gpu/drm/i2c/Kconfig                        |   6 +
 drivers/gpu/drm/i2c/Makefile                       |   2 +
 drivers/gpu/drm/i2c/vga-simple.c                   | 325 +++++++++
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  32 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c           | 756 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h           | 107 +++
 include/drm/drm_crtc.h                             |   4 +
 15 files changed, 1431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/i2c/vga-simple.txt
 create mode 100644 Documentation/devicetree/bindings/video/rockchip-lvds.txt
 create mode 100644 drivers/gpu/drm/i2c/vga-simple.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h

-- 
2.1.1
