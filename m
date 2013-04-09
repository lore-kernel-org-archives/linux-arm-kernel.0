From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  9 Apr 2013 19:39:38 +0100
Subject: [PATCH 3/8] dmaengine: ste_dma40: Actually write the runtime
 configuration to registers
In-Reply-To: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Someone has spent a fair amount of effort writing a runtime configuration
changing algorithm for DMA clients. However, the config appears to never
actually make it to hardware. In order for the configuration to take hold
we need to issue a d40_config_write(), as this is the routine which writes
it into the hardware's registers.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 3b83dee..2a0a9d4 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2831,6 +2831,9 @@ static int d40_set_runtime_config(struct dma_chan *chan,
 	/* These settings will take precedence later */
 	d40c->runtime_addr = config_addr;
 	d40c->runtime_direction = config->direction;
+
+	d40_config_write(d40c);
+
 	dev_dbg(d40c->base->dev,
 		"configured channel %s for %s, data width %d/%d, "
 		"maxburst %d/%d elements, LE, no flow control\n",
-- 
1.7.10.4
