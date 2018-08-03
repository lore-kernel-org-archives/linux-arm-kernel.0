From: peda@axentia.se (Peter Rosin)
Date: Fri,  3 Aug 2018 12:11:21 +0200
Subject: [PATCH v6 0/3] drm/atmel-hlcdc: bus-width override support
Message-ID: <20180803101124.4622-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

The background for these patches is that our PCB interface between
the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
this has to be described somewhere, or the atmel-hlcdc driver have no
chance of selecting the correct output mode. Since we have similar
problems with a tda19988 HDMI encoder I added patches to override
the atmel-hlcdc output format via DT properties compatible with the
media video-interface binding and things start to play together.

There is still an open question regardning the binding in patch 2/3,
where Laurent wondered about plans Sakari might have for explicit
bus types for parallel buses. See https://lkml.org/lkml/2018/8/3/278

Cheers,
Peter

Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
- add reg properties (and #*-cells) to the example in patch 2/3
- prohibit bus-width 0 in the device-tree in patch 3/3
- added reviewed-by from Jacopo to patch 2/3 and 3/3

Peter Rosin (3):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 70 +++++++++++++++++++---
 5 files changed, 151 insertions(+), 28 deletions(-)

-- 
2.11.0
