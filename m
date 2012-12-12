From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Wed, 12 Dec 2012 10:37:18 +0100
Subject: [PATCH 4/7] dmaengine: ste_dma40: limit burst size to 16
In-Reply-To: <1355305041-2338-1-git-send-email-fabio.baltieri@linaro.org>
References: <1355305041-2338-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1355305041-2338-5-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@stericsson.com>

The client is not aware of the maximum burst size in the dma driver.  If
the size exceeds 16 set max to 16.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 16c96f5..0b80ee9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2579,6 +2579,14 @@ static int d40_set_runtime_config(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
+	if (src_maxburst > 16) {
+		src_maxburst = 16;
+		dst_maxburst = src_maxburst * src_addr_width / dst_addr_width;
+	} else if (dst_maxburst > 16) {
+		dst_maxburst = 16;
+		src_maxburst = dst_maxburst * dst_addr_width / src_addr_width;
+	}
+
 	ret = dma40_config_to_halfchannel(d40c, &cfg->src_info,
 					  src_addr_width,
 					  src_maxburst);
-- 
1.7.12.1
