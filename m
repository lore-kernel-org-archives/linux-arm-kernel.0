From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  6 Feb 2018 13:18:51 +0100
Subject: [PATCH 0/3] Bandwidth limitation on PL111, take 2
Message-ID: <20180206121854.4407-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had to add a hook into the simple KMS helper to be able
to gate off too high bandwidths on the PL111.

Let me know what you think.

This solution is inspired by the OMAPDRM commit a7631c4b9846
"drm/omap: Filter displays mode based on bandwidth limit"
by Peter Ujfalusi.

I'm not super-happy that we don't know or negotiate the
desired pixel format when the CRTC asks the driver whether
the mode is valid, I need to think more about this for the
future.

For now patch 2/2 just hammers that down to 16 or 32 BPP
depending on variant, so we get running code. But the
BPP is not used to negotiate formats wrt bandwidth, we
just fix that variable and work on the resolution
limitation.

Maybe the 16BPP systems are in such a minority that this
hard-coding is reasonable.

Linus Walleij (3):
  drm: simple_kms_helper: Add mode_valid() callback support
  drm/pl111: Make the default BPP a per-variant variable
  drm/pl111: Use max memory bandwidth for resolution

 drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++++++++++
 drivers/gpu/drm/pl111/pl111_display.c   | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm.h       |  3 +++
 drivers/gpu/drm/pl111/pl111_drv.c       | 10 +++++++++-
 drivers/gpu/drm/pl111/pl111_versatile.c |  2 ++
 include/drm/drm_simple_kms_helper.h     | 15 +++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.14.3
