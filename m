From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:46:17 +0000
Subject: [PATCH 48/48] ARM: PL08x: prevent dma_set_runtime_config()
	reconfiguring memcpy channels
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZtAP-0003TD-SG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent dma_set_runtime_config() being used to alter the configuration
supplied by the platform for memcpy channel configuration.  No one
should be trying to change this configuration.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c7f7b82..bebc678 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1129,6 +1129,9 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	u32 cctl = 0;
 	int i;
 
+	if (!plchan->slave)
+		return -EINVAL;
+
 	/* Transfer direction */
 	plchan->runtime_direction = config->direction;
 	if (config->direction == DMA_TO_DEVICE) {
-- 
1.6.2.5
