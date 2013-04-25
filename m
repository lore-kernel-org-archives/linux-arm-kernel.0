From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:51 +0200
Subject: [PATCH 08/21] drm/nouveau: use mdelay instead of large udelay
 constants
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM cannot handle udelay for more than 2 miliseconds, so we
should use mdelay instead for those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel at lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c b/drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c
index d0817d9..ed7415e 100644
--- a/drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c
+++ b/drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c
@@ -51,7 +51,8 @@ nv50_dac_sense(struct nv50_disp_priv *priv, int or, u32 loadval)
 	const u32 doff = (or * 0x800);
 	int load = -EINVAL;
 	nv_wr32(priv, 0x61a00c + doff, 0x00100000 | loadval);
-	udelay(9500);
+	mdelay(9);
+	udelay(500);
 	nv_wr32(priv, 0x61a00c + doff, 0x80000000);
 	load = (nv_rd32(priv, 0x61a00c + doff) & 0x38000000) >> 27;
 	nv_wr32(priv, 0x61a00c + doff, 0x00000000);
-- 
1.8.1.2
