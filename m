From: rizhao@nvidia.com (Richard Zhao)
Date: Wed, 24 Jul 2013 12:09:59 +0800
Subject: [PATCH 6/9] serial: tegra: move to generic dma DT binding
In-Reply-To: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Message-ID: <1374639002-16753-7-git-send-email-rizhao@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- driver: remove use of nvidia,dma-request-selector
	  use dma_request_slave_channel to request channel
- update binding doc

Signed-off-by: Richard Zhao <rizhao@nvidia.com>
---
 .../devicetree/bindings/serial/nvidia,tegra20-hsuart.txt |  8 +++++---
 drivers/tty/serial/serial-tegra.c                        | 16 +---------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index 392a449..1ed2f48 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -4,8 +4,9 @@ Required properties:
 - compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this UART controller.
+- dmas : The Tegra DMA controller's phandle and request selector for
+  this UART controller.
+- dma-names : Should be "rx-tx";
 
 Optional properties:
 - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
@@ -18,7 +19,8 @@ serial at 70006000 {
 	reg = <0x70006000 0x40>;
 	reg-shift = <2>;
 	interrupts = <0 36 0x04>;
-	nvidia,dma-request-selector = <&apbdma 8>;
+	dmas = <&apbdma 8>;
+	dma-names = "rx-tx";
 	nvidia,enable-modem-interrupt;
 	status = "disabled";
 };
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ee7c812..c8a7828 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -120,7 +120,6 @@ struct tegra_uart_port {
 	bool					rx_timeout;
 	int					rx_in_progress;
 	int					symb_bit;
-	int					dma_req_sel;
 
 	struct dma_chan				*rx_dma_chan;
 	struct dma_chan				*tx_dma_chan;
@@ -902,11 +901,8 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 	dma_addr_t dma_phys;
 	int ret;
 	struct dma_slave_config dma_sconfig;
-	dma_cap_mask_t mask;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_chan = dma_request_channel(mask, NULL, NULL);
+	dma_chan = dma_request_slave_channel(tup->uport.dev, "rx-tx");
 	if (!dma_chan) {
 		dev_err(tup->uport.dev,
 			"Dma channel is not available, will try later\n");
@@ -930,7 +926,6 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		dma_buf = tup->uport.state->xmit.buf;
 	}
 
-	dma_sconfig.slave_id = tup->dma_req_sel;
 	if (dma_to_memory) {
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -1214,17 +1209,8 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 	struct tegra_uart_port *tup)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 of_dma[2];
 	int port;
 
-	if (of_property_read_u32_array(np, "nvidia,dma-request-selector",
-				of_dma, 2) >= 0) {
-		tup->dma_req_sel = of_dma[1];
-	} else {
-		dev_err(&pdev->dev, "missing dma requestor in device tree\n");
-		return -EINVAL;
-	}
-
 	port = of_alias_get_id(np, "serial");
 	if (port < 0) {
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", port);
-- 
1.8.1.5
