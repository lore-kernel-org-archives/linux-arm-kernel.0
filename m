From: peda@axentia.se (Peter Rosin)
Date: Fri, 10 Aug 2018 15:03:55 +0200
Subject: [PATCH v8 0/4] drm/atmel-hlcdc: bus-width override support
Message-ID: <20180810130359.9882-1-peda@axentia.se>
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

Cheers,
Peter

Changes since v7  https://lkml.org/lkml/2018/8/4/288
- The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
  which simplifies fixing this in patch 4/4 (and adds flexibility)
  and adjust patch 4/4 to the changes done in the new 3/4.
- return -ENOMEM on allocation failure in patch 4/4

Changes since v6  https://lkml.org/lkml/2018/8/3/333
- zap bus-type from the binding in patch 2/3

Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
- add reg properties (and #*-cells) to the example in patch 2/3
- prohibit bus-width 0 in the device-tree in patch 3/3
- added reviewed-by from Jacopo to patch 2/3 and 3/3

Peter Rosin (4):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: iterate over all output endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 28 +++++++
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 98 ++++++++++++++++++----
 5 files changed, 170 insertions(+), 35 deletions(-)

-- 
2.11.0
