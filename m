From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:51 +0200
Subject: [PATCH v2 52/53] dmaengine: sun6i: Declare slave capabilities for the
 generic code
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-53-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic slave caps code can make use of the device assigned
capabilities, instead of relying on a callback to be implemented.

Make use of this code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/sun6i-dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 6324c1e27cc9..1cb347e9f20d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -944,6 +944,16 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.device_resume		= sun6i_dma_resume;
 	sdc->slave.device_terminate_all		= sun6i_dma_terminate_all;
 	sdc->slave.chancnt			= NR_MAX_VCHANS;
+	sdc->slave.generic_slave_caps		= true;
+	sdc->slave.src_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
+						  BIT(DMA_MEM_TO_DEV);
+	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
 	sdc->slave.dev = &pdev->dev;
 
 	sdc->pchans = devm_kcalloc(&pdev->dev, NR_MAX_CHANNELS,
-- 
2.1.1
