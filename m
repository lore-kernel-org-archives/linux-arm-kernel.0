From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed,  8 Nov 2017 22:09:32 +0100
Subject: [PATCH 4/4] omapdss: fix problem enabling VDDS_DSI on OMAP3530
 (OpenPandora)
In-Reply-To: <cover.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
Message-ID: <b94c5e773994ee55df9225fc84825bacb3fcb256.1510175371.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI feature to dpi code")

introduced a new match table which turned out to be wrong, at least
for the 600 MHz OpenPandora using the OMAP3530.

The effect was strange: only the Blue channel of the RGB panel was
driven while Red and Green stayed black. So a coloured picture turned
into blue/black.

The GTA04 with DM3730 didn't show the effect.

It turned out that VDDS_DSI was not properly initialized on OMAP3530,
because the .family string is just "OMAP3" for these processors and
not "OMAP3xxx".

Therefore we match the .machine attribute.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/omapdrm/dss/dpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c b/drivers/gpu/drm/omapdrm/dss/dpi.c
index 4ed5fde11313..aae3626910bb 100644
--- a/drivers/gpu/drm/omapdrm/dss/dpi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
@@ -566,8 +566,7 @@ static int dpi_verify_pll(struct dss_pll *pll)
 }
 
 static const struct soc_device_attribute dpi_soc_devices[] = {
-	{ .family = "OMAP3[456]*" },
-	{ .family = "[AD]M37*" },
+	{ .machine = "OMAP3[456]*" },
 	{ /* sentinel */ }
 };
 
-- 
2.12.2
