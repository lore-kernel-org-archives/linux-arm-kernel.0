From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Aug 2011 09:34:35 +0100
Subject: [PATCH] dmaengine: amba-pl08x: make filter check that the channel
	is owned by pl08x
Message-ID: <20110831083435.GD26905@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before converting the dma channel to our private data structure, first
check that the channel is indeed one which our driver registered.  We
do this by ensuring that the underlying device is bound to our driver.

This avoids potential oopses if we try to reference 'plchan->name'
against a foreign drivers dma channel.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--- 
 drivers/dma/amba-pl08x.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index be21e3f..91d4148 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -92,6 +92,8 @@
 
 #define DRIVER_NAME	"pl08xdmac"
 
+static struct amba_driver pl08x_amba_driver;
+
 /**
  * struct vendor_data - vendor-specific config parameters for PL08x derivatives
  * @channels: the number of channels available in this variant
@@ -1489,9 +1491,15 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 {
-	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_dma_chan *plchan;
 	char *name = chan_id;
 
+	/* Reject channels for devices not bound to this driver */
+	if (chan->device->dev->driver != &pl08x_amba_driver.drv)
+		return false;
+
+	plchan = to_pl08x_chan(chan);
+
 	/* Check that the channel is not taken! */
 	if (!strcmp(plchan->name, name))
 		return true;
