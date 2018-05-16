From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 12:14:44 +0200
Subject: [PATCH v3 00/26] device link, bridge supplier <-> drm device
Message-ID: <20180516101510.13215-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

It was noted by Russell King [1] that bridges (not using components)
might disappear unexpectedly if the owner of the bridge was unbound.
Jyri Sarha had previously noted the same thing with panels [2]. Jyri
came up with using device links to resolve the panel issue, which
was also my (independent) reaction to the note from Russell.

This series builds up to the addition of that link in the last
patch, but in my opinion the other 25 patches do have merit on their
own.

The last patch needs testing, while the others look trivial. Jyri, are
you able to test? That said, I might have missed some subtlety.

Oh, and the reason I'm pushing this is of course so that the issue
noted by Russell in [1] is addressed which in turn means that the
tda998x bridge driver can be patched according to that series without
objection (hopefully) and then used from the atmel-hlcdc driver (and
other drivers that are not componentized).

Changes since v2    https://lkml.org/lkml/2018/5/4/443

- Russell King spells his name this way. Sorry!
- Add review tag from Andrzej Hajda (patches 1, 25 and 26).
- Add ack tag from Daniel Vetter (patches 1, 24, 25 and 26).
- Mention the interaction with the rockchip_lvds driver in the
  commit message for patch 1.
- Change the comment for the new @link member in patch 26, so that a
  symmetric relationchip between cunsumer/supplier isn't implied.

Changes since v1    https://lkml.org/lkml/2018/4/26/1018

- rename .owner to .odev to not get mixed up with the module owner.
- added patches for new recent drivers thc63lvd1024 and cdns-dsi
- fix for problem in the rockchip_lvds driver reported by 0day
- added a WARN in drm_bridge_add if there is no .odev owner device

Cheers,
Peter

[1] https://lkml.org/lkml/2018/4/23/769
[2] https://www.spinics.net/lists/dri-devel/msg174275.html

Peter Rosin (26):
  drm/bridge: allow optionally specifying an owner .odev device
  drm/bridge: adv7511: provide an owner .odev device
  drm/bridge/analogix: core: specify the owner .odev of the bridge
  drm/bridge: analogix-anx78xx: provide an owner .odev device
  drm/bridge: cdns-dsi: provide an owner .odev device
  drm/bridge: vga-dac: provide an owner .odev device
  drm/bridge: lvds-encoder: provide an owner .odev device
  drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev
    device
  drm/bridge: nxp-ptn3460: provide an owner .odev device
  drm/bridge: panel: provide an owner .odev device
  drm/bridge: ps8622: provide an owner .odev device
  drm/bridge: sii902x: provide an owner .odev device
  drm/bridge: sii9234: provide an owner .odev device
  drm/bridge: sii8620: provide an owner .odev device
  drm/bridge: synopsys: provide an owner .odev device for the bridges
  drm/bridge: tc358767: provide an owner .odev device
  drm/bridge: thc63lvd1024: provide an owner .odev device
  drm/bridge: ti-tfp410: provide an owner .odev device
  drm/exynos: mic: provide an owner .odev device for the bridge
  drm/mediatek: hdmi: provide an owner .odev device for the bridge
  drm/msm: specify the owner .odev of the bridges
  drm/rcar-du: lvds: provide an owner .odev device for the bridge
  drm/sti: provide an owner .odev device for the bridges
  drm/bridge: remove the .of_node member
  drm/bridge: require the owner .odev to be filled in on
    drm_bridge_add/attach
  drm/bridge: establish a link between the bridge supplier and consumer

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
 drivers/gpu/drm/bridge/cdns-dsi.c                  |  2 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
 drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
 drivers/gpu/drm/bridge/panel.c                     |  4 +---
 drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
 drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
 drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/drm_bridge.c                       | 26 +++++++++++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
 drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  1 +
 drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
 include/drm/drm_bridge.h                           |  8 +++----
 30 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.11.0
