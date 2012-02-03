From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:00:17 +0000
Subject: [PATCH 17/20] ARM: sa1111: only setup DMA for DMA capable devices
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPIv-00044m-M3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's pointless registering the PS/2 interfaces with the dmabounce code
when there's no DMA support for these in hardware, so only setup the
DMA masks for two subdevices which support DMA - the OHCI and SAC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 7b4351b..d78499f 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -121,6 +121,7 @@ static struct sa1111 *g_sa1111;
 struct sa1111_dev_info {
 	unsigned long	offset;
 	unsigned long	skpcr_mask;
+	bool		dma;
 	unsigned int	devid;
 	unsigned int	irq[6];
 };
@@ -129,6 +130,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	{
 		.offset		= SA1111_USB,
 		.skpcr_mask	= SKPCR_UCLKEN,
+		.dma		= true,
 		.devid		= SA1111_DEVID_USB,
 		.irq = {
 			IRQ_USBPWR,
@@ -142,6 +144,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	{
 		.offset		= 0x0600,
 		.skpcr_mask	= SKPCR_I2SCLKEN | SKPCR_L3CLKEN,
+		.dma		= true,
 		.devid		= SA1111_DEVID_SAC,
 		.irq = {
 			AUDXMTDMADONEA,
@@ -641,10 +644,10 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 		dev->irq[i] = sachip->irq_base + info->irq[i];
 
 	/*
-	 * If the parent device has a DMA mask associated with it,
-	 * propagate it down to the children.
+	 * If the parent device has a DMA mask associated with it, and
+	 * this child supports DMA, propagate it down to the children.
 	 */
-	if (sachip->dev->dma_mask) {
+	if (info->dma && sachip->dev->dma_mask) {
 		dev->dma_mask = *sachip->dev->dma_mask;
 		dev->dev.dma_mask = &dev->dma_mask;
 		dev->dev.coherent_dma_mask = sachip->dev->coherent_dma_mask;
-- 
1.7.4.4
