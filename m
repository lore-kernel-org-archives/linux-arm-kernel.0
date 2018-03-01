From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  1 Mar 2018 22:34:32 +0100
Subject: [PATCH v3 06/16] drm/sun4i: Release exclusive clock lock when
 disabling TCON
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Message-ID: <20180301213442.16677-7-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently exclusive TCON clock lock is never released, which, for
example, prevents changing resolution on HDMI.

In order to fix that, release clock when disabling TCON. TCON is always
disabled first before new mode is set.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 1d714c06ec9d..7f6c4125c89f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -102,10 +102,12 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 		return;
 	}
 
-	if (enabled)
+	if (enabled) {
 		clk_prepare_enable(clk);
-	else
+	} else {
+		clk_rate_exclusive_put(clk);
 		clk_disable_unprepare(clk);
+	}
 }
 
 static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
-- 
2.16.2
