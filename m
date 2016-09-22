From: sam.van.den.berge@telenet.be (Sam Van Den Berge)
Date: Thu, 22 Sep 2016 20:51:15 +0200
Subject: [PATCH v3] dmaengine: s3c24xx: Add dma_slave_map for s3c2440 devices
Message-ID: <1474570275-7238-1-git-send-email-sam.van.den.berge@telenet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the s3c24xx dma driver to be able to pass a
dma_slave_map array via the platform data. This is needed to
be able to use the new, simpler dmaengine API [1].
I used the virtual DMA channels as a parameter for the dma_filter
function. By doing that, I could reuse the existing filter function in
drivers/dma/s3c24xx-dma.c.

I have tested this on my mini2440 board with the audio driver.
According to my observations, dma_request_slave_channel in the
function dmaengine_pcm_new in the file
sound/soc/soc-generic-dmaengine-pcm.c now returns a valid DMA channel
whereas before no DMA channel was returned at that point.

Entries for DMACH_XD0, DMACH_XD1 and DMACH_TIMER are missing because I
don't realy know which driver to use for these.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393635.html

Signed-off-by: Sam Van Den Berge <sam.van.den.berge@telenet.be>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
This patch depends on the audio fixes from Sylwester Nawrocki
(http://www.spinics.net/lists/arm-kernel/msg521918.html)

Changes since v2:
- s/3c2440-sdi/s3c2440-sdi/
- Removed reference to the audio fixes of Sylwester from the commit message
  because I don't think it belongs in the commit message itself.

Changes since v1:
- rename arm into dmaengine in title
- one channel for s3c2440-sdi named "rx-tx"

 arch/arm/mach-s3c24xx/common.c            | 35 +++++++++++++++++++++++++++++++
 drivers/dma/s3c24xx-dma.c                 |  3 +++
 include/linux/platform_data/dma-s3c24xx.h |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index fe7485d..f6c3f15 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_data/dma-s3c24xx.h>
+#include <linux/dmaengine.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
@@ -445,10 +446,44 @@ static struct s3c24xx_dma_channel s3c2440_dma_channels[DMACH_MAX] = {
 	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 3), },
 };
 
+static const struct dma_slave_map s3c2440_dma_slave_map[] = {
+	/* TODO: DMACH_XD0 */
+	/* TODO: DMACH_XD1 */
+	{ "s3c2440-sdi", "rx-tx", (void *)DMACH_SDI },
+	{ "s3c2410-spi.0", "rx", (void *)DMACH_SPI0 },
+	{ "s3c2410-spi.0", "tx", (void *)DMACH_SPI0 },
+	{ "s3c2410-spi.1", "rx", (void *)DMACH_SPI1 },
+	{ "s3c2410-spi.1", "tx", (void *)DMACH_SPI1 },
+	{ "s3c2440-uart.0", "rx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.0", "tx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.1", "rx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.1", "tx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.2", "rx", (void *)DMACH_UART2 },
+	{ "s3c2440-uart.2", "tx", (void *)DMACH_UART2 },
+	{ "s3c2440-uart.3", "rx", (void *)DMACH_UART3 },
+	{ "s3c2440-uart.3", "tx", (void *)DMACH_UART3 },
+	/* TODO: DMACH_TIMER */
+	{ "s3c24xx-iis", "rx", (void *)DMACH_I2S_IN },
+	{ "s3c24xx-iis", "tx", (void *)DMACH_I2S_OUT },
+	{ "samsung-ac97", "rx", (void *)DMACH_PCM_IN },
+	{ "samsung-ac97", "tx", (void *)DMACH_PCM_OUT },
+	{ "samsung-ac97", "rx", (void *)DMACH_MIC_IN },
+	{ "s3c-hsudc", "rx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "rx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "rx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "rx3", (void *)DMACH_USB_EP4 },
+	{ "s3c-hsudc", "tx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "tx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "tx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "tx3", (void *)DMACH_USB_EP4 }
+};
+
 static struct s3c24xx_dma_platdata s3c2440_dma_platdata = {
 	.num_phy_channels = 4,
 	.channels = s3c2440_dma_channels,
 	.num_channels = DMACH_MAX,
+	.slave_map = s3c2440_dma_slave_map,
+	.slavecnt = ARRAY_SIZE(s3c2440_dma_slave_map),
 };
 
 struct platform_device s3c2440_device_dma = {
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index ce67075..d5c85e7 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1301,6 +1301,9 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 	s3cdma->slave.device_prep_dma_cyclic = s3c24xx_dma_prep_dma_cyclic;
 	s3cdma->slave.device_config = s3c24xx_dma_set_runtime_config;
 	s3cdma->slave.device_terminate_all = s3c24xx_dma_terminate_all;
+	s3cdma->slave.filter.map = pdata->slave_map;
+	s3cdma->slave.filter.mapcnt = pdata->slavecnt;
+	s3cdma->slave.filter.fn = s3c24xx_dma_filter;
 
 	/* Register as many memcpy channels as there are physical channels */
 	ret = s3c24xx_dma_init_virtual_channels(s3cdma, &s3cdma->memcpy,
diff --git a/include/linux/platform_data/dma-s3c24xx.h b/include/linux/platform_data/dma-s3c24xx.h
index 89ba1b0..4f9aba4 100644
--- a/include/linux/platform_data/dma-s3c24xx.h
+++ b/include/linux/platform_data/dma-s3c24xx.h
@@ -30,16 +30,22 @@ struct s3c24xx_dma_channel {
 	u16 chansel;
 };
 
+struct dma_slave_map;
+
 /**
  * struct s3c24xx_dma_platdata - platform specific settings
  * @num_phy_channels: number of physical channels
  * @channels: array of virtual channel descriptions
  * @num_channels: number of virtual channels
+ * @slave_map: dma slave map matching table
+ * @slavecnt: number of elements in slave_map
  */
 struct s3c24xx_dma_platdata {
 	int num_phy_channels;
 	struct s3c24xx_dma_channel *channels;
 	int num_channels;
+	const struct dma_slave_map *slave_map;
+	int slavecnt;
 };
 
 struct dma_chan;
-- 
1.9.1
