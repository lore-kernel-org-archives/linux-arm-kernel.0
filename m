From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Fri, 07 Nov 2014 14:14:47 +0000
Subject: [PATCH 4/5] serial: pl011: Don't enable RX DMA if residue processing
 not supported
Message-ID: <545CD3D7.5010300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If the DMA engine doesn't support residue processing then the RX DMA
handling won't work terribly well if polling is enabled.  So, disable
RX DMA if residue handling isn't available.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7c5e263..79b9c93 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -322,7 +322,22 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 			.src_maxburst = uap->fifosize >> 2,
 			.device_fc = false,
 		};
+		struct dma_slave_caps caps;
 
+		/*
+		 * Some DMA controllers provide information on their capabilities.
+		 * If the controller does, check for suitable residue processing
+		 * otherwise assime all is well.
+		 */
+		if (0 == dma_get_slave_caps(chan, &caps)) {
+			if (caps.residue_granularity ==
+					DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
+				dma_release_channel(chan);
+				dev_info(uap->port.dev,
+					"RX DMA disabled - no residue processing\n");
+				return;
+			}
+		}
 		dmaengine_slave_config(chan, &rx_conf);
 		uap->dmarx.chan = chan;
 
-- 
1.7.1
