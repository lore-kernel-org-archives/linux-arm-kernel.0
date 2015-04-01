From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:34 +0200
Subject: [PATCH RFC v2 00/12] drm/rockchip: add support for lvds controller
 and external encoders
Message-ID: <1427882986-19110-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes since v1:
- add separate components subdirectory
- implement the already existing bindings for adv7123 and vga-connector
  instead of defining a new one
- use component graph for subsequent lvds-panel or connected external
  encoders instead of defining special properties.


This series still adds support for the soc-level lvds encoder that also
controls the generic rgb output pins. Also generic components for "dumb"
vga encoders and connectors are added to a new subdirectory which implement
the already existing bindings for adv7123 and vga-connector.

While the major comment from Laurent Pinchart gets addressed with these
separate components, it still needs to address others like the lvds setting
in dt and how to handle the atomic mode setting conversion correctly.

But I'd still like to solicit opinions if the general concept looks sane
especially wrt. introducing the new components element and of_graph structure.

Tested on a firefly board using the vga connector.


Thanks
Heiko


Heiko Stuebner (10):
  drm/encoder: add functionality to register encoders to a global list
  drm/connector: add functionality to register connectors to a global
    list
  drm: add components subdirectory and infrastructure
  drm/components: add generic vga encoder driver
  drm/components: add generic vga connector driver
  drm/rockchip: lvds: register a bridge when no panel is set
  drm/rockchip: enable rgb output of vops for all other connectors
  ARM: dts: rockchip: add rk3288 lcdc0 pinmux settings
  ARM: dts: rockchip: add rk3288 lvds node
  ARM: dts: rockchip: add vga encoder and enable lvds on rk3288-firefly

Mark Yao (2):
  dt-bindings: Add documentation for rockchip lvds
  drm/rockchip: Add support for Rockchip Soc LVDS

 .../devicetree/bindings/video/rockchip-lvds.txt    |  74 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  68 ++
 arch/arm/boot/dts/rk3288.dtsi                      |  51 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/components/Kconfig                 |  15 +
 drivers/gpu/drm/components/Makefile                |   4 +
 drivers/gpu/drm/components/vga-connector.c         | 254 ++++++
 drivers/gpu/drm/components/vga-encoder.c           | 315 ++++++++
 drivers/gpu/drm/drm_crtc.c                         |  82 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  10 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           | 851 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h           | 107 +++
 include/drm/drm_crtc.h                             |  15 +
 16 files changed, 1852 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/rockchip-lvds.txt
 create mode 100644 drivers/gpu/drm/components/Kconfig
 create mode 100644 drivers/gpu/drm/components/Makefile
 create mode 100644 drivers/gpu/drm/components/vga-connector.c
 create mode 100644 drivers/gpu/drm/components/vga-encoder.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h

-- 
2.1.4
