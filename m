From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:34 +0100
Subject: [PATCH v2 0/9] drm: atmel-hlcdc: various fixes/improvements
Message-ID: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a collection of fixes and improvements for the
atmel-hlcdc driver.

The main feature added here is the support for external RGB -> XXX
bridges (patch 6 and 7).

The first patch is a fix preventing a potential memory leak.
Patch 2 is adding support for asynchronous mode setting, which was
supported before the migration to atomic mode setting.

Patch 3 is just a minor fix to expose the real encoder and connector
types (we are currently exposing an LVDS encoder/connector, which is
wrong since the display controller output the pixel stream in raw
RGB).

Patch 4 is removing useless fields and functions which were left
when moving to atomic modesetting.

Patch 8 is just a cosmetic patch moving the mode checking code
from ->atomic_check() to ->mode_fixup().

Patch 9 is increasing HLCDC bandwidth by making use of the two AHB
interfaces.

Best Regards,

Boris

Changes since v1:
- Add Nicolas Reviewed/Teste/Acked-by tags
- Add a patch to increase HLCDC bandwidth by using both AHB interfaces

Boris Brezillon (9):
  drm: atmel-hlcdc: add a ->cleanup_fb() operation
  drm: atmel-hlcdc: support asynchronous atomic commit operations
  drm: atmel-hlcdc: fix connector and encoder types
  drm: atmel-hlcdc: remove leftovers from atomic mode setting migration
  drm: atmel-hlcdc: support extended timing ranges on sama5d4 and
    sama5d2
  drm: atmel-hlcdc: move output mode selection in CRTC implementation
  drm: atmel-hlcdc: rework the output code to support drm bridges
  drm: atmel-hlcdc: check display mode validity in crtc->mode_fixup()
  drm: atmel-hlcdc: route DMA accesses through AHB interfaces

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 154 +++++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 123 ++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  17 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 249 ++++++++++-------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  |  65 +++++-
 5 files changed, 447 insertions(+), 161 deletions(-)

-- 
2.5.0
