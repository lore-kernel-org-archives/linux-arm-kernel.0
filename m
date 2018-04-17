From: peda@axentia.se (Peter Rosin)
Date: Tue, 17 Apr 2018 15:10:46 +0200
Subject: [PATCH v2 0/6] Add tda998x (HDMI) support to atmel-hlcdc
Message-ID: <20180417131052.16336-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around, and found some missing
pieces in the tilcdc driver. I "stole" some things and made it work
for my use case.

In addition to the above, our PCB interface between the SAMA5D3 and the
HDMI encoder is only using 16 bits, and this has to be described
somewhere, or the atmel-hlcdc driver have no chance of selecting the
correct output mode. Since I had similar problems with ds90c185 lvds
encoder I added patches to override the atmel-hlcdc output format via
DT properties compatible with the media video-interface binding and
things start to play together.

Since this series superseeds the bridge series [1], I have included the
leftover bindings patch for the ti,ds90c185 here. I also noticed that
the driver date for atmel-hlcdc is bonkers, and added a patch for that.

However, I don't know if the tilcdc driver is interfacing with the
tda998x driver in a sane and modern way, and I don't know if I have
missed any subtle point when I "stole" the code and componentized the
atmel-hlcdc driver. I also have not tested how this behaves if I run
with the components as modules (not targeting that). Further, I'm
not sure if I interpret the media video-interface binding correctly.

Anyway, this series solves some real issues for my HW.

Cheers,
Peter

Changes since v1   https://lkml.org/lkml/2018/4/9/294
- added reviewed-by from Rob to patch 1/6
- patch 2/6 changed so that the bus format override is in the endpoint
  DT node, and follows the binding of media video-interfaces.
- patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
  media video-interface binding (partially).
- patch 4/6 now makes use of the above helper (and also fixes problems
  with the 3/5 patch from v1 when no override was specified).
- do not mention unrelated connector display_info details in the cover
  letter and commit messages.

[1]
"Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
"Bridge" series v1   https://lkml.org/lkml/2018/3/17/221

Peter Rosin (6):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm: of: introduce drm_of_media_bus_fmt
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/atmel-hlcdc: add support for connecting to tda998x HDMI encoder
  drm/atmel-hlcdc: fix broken release date

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |   8 ++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  85 ++++++++++----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  85 ++++++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  15 +++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 130 +++++++++++++++++++++
 drivers/gpu/drm/drm_of.c                           |  38 ++++++
 include/drm/drm_of.h                               |   7 ++
 8 files changed, 347 insertions(+), 29 deletions(-)

-- 
2.11.0
