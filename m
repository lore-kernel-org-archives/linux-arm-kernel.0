From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 31 Oct 2016 15:19:25 +0100
Subject: [PATCH v5 0/2] drm: tilcdc: improved support for rev1
Message-ID: <1477923567-1610-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains two patches needed to support revision 1 of the
LCD controller on da850 SoCs.

The first one implements palette loading - this is a resend of v4 of
the stand-alone patch.

The second resets the input FIFO in the DMA controller if a sync lost
error occurs and disables the interrupt completely if we're being
flooded with these errors.

v1 -> v2:
- only allocate dma memory for revision 1

v2 -> v3:
- use devres managed API for dma memory allocation

v3 -> v4:
- reinit the palette completion in tilcdc_crtc_disable()

v4 -> v5:
- add a second patch clearing the sync lost bit in case of a sync lost
  error due to insufficient bandwidth

Bartosz Golaszewski (2):
  drm: tilcdc: implement palette loading for rev1
  drm: tilcdc: clear the sync lost bit in crtc isr

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 138 +++++++++++++++++++++++++++++++----
 drivers/gpu/drm/tilcdc/tilcdc_regs.h |   1 +
 2 files changed, 124 insertions(+), 15 deletions(-)

-- 
2.9.3
