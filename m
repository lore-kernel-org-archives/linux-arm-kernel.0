From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 18:14:01 +0200
Subject: Unconditional registering EMDA platform devices
In-Reply-To: <20141024142904.GC3142@lunn.ch>
References: <20141024142904.GC3142@lunn.ch>
Message-ID: <2124815.5oBngWtcFV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 16:29:04 Andrew Lunn wrote:
> Hi Matt
> 
> I've had a report of a Debian kernel running on a Marvell XP system
> giving warnings:
> 
> [    0.114771] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
> [    0.114794] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
> 
> These seem to be coming from drivers/dma/emda.c
> 
> That driver has a subsys_initcall(edma_init);
> 
> and the edma_init function is unconditionally registering a driver and
> a platform device. For a multiarch kernel, this is not a good idea.
> 
> Please could you make this conditionally. Maybe look into the DT and
> see if the DMA is needed on the platform?
 
I just looked at that code an I'm completely confused about how that
even works today. I do see that the driver is used on ATAGS based
davinci machines, which means we can't just look into the DT.

The main problem seems to stem from arch/arm/common/edma.c being
half the driver that provides interfaces to both drivers/dma/edma.c
and to sound/soc/davinci/davinci-pcm.c, while drivers/dma/edma.c
is not really a driver by itself. My preferred solution to this would
be to move arch/arm/common/edma.c into drivers/dma/edma.c and still
have it export its private API, but I assume that the dmaengine
maintainers have already NAKed that approach.

Would the approach below work?

	Arnd

8<-------
Subject: dma: edma: move device registration to platform code

The horrible split between the low-level part of the edma support
and the dmaengine front-end driver causes problems on multiplatform
kernels. This is an attempt to improve the situation slightly
by only registering the dmaengine devices that are actually
present.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index d86771abbf57..f6cffee3c6ee 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1623,6 +1623,11 @@ static int edma_probe(struct platform_device *pdev)
 	struct device_node	*node = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 	int			ret;
+	struct platform_device_info edma_dev_info = {
+		.name = "edma-dma-engine",
+		.dma_mask = DMA_BIT_MASK(32),
+		.parent = &pdev->dev,
+	};
 
 	if (node) {
 		/* Check if this is a second instance registered */
@@ -1793,6 +1798,9 @@ static int edma_probe(struct platform_device *pdev)
 			edma_write_array(j, EDMA_QRAE, i, 0x0);
 		}
 		arch_num_cc++;
+
+		edma_dev_info.id = j;
+		platform_device_register_full(&edma_dev_info);
 	}
 
 	return 0;
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 123f578d6dd3..4cfaaa5a49be 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1107,52 +1107,14 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(edma_filter_fn);
 
-static struct platform_device *pdev0, *pdev1;
-
-static const struct platform_device_info edma_dev_info0 = {
-	.name = "edma-dma-engine",
-	.id = 0,
-	.dma_mask = DMA_BIT_MASK(32),
-};
-
-static const struct platform_device_info edma_dev_info1 = {
-	.name = "edma-dma-engine",
-	.id = 1,
-	.dma_mask = DMA_BIT_MASK(32),
-};
-
 static int edma_init(void)
 {
-	int ret = platform_driver_register(&edma_driver);
-
-	if (ret == 0) {
-		pdev0 = platform_device_register_full(&edma_dev_info0);
-		if (IS_ERR(pdev0)) {
-			platform_driver_unregister(&edma_driver);
-			ret = PTR_ERR(pdev0);
-			goto out;
-		}
-	}
-
-	if (!of_have_populated_dt() && EDMA_CTLRS == 2) {
-		pdev1 = platform_device_register_full(&edma_dev_info1);
-		if (IS_ERR(pdev1)) {
-			platform_driver_unregister(&edma_driver);
-			platform_device_unregister(pdev0);
-			ret = PTR_ERR(pdev1);
-		}
-	}
-
-out:
-	return ret;
+	return platform_driver_register(&edma_driver);
 }
 subsys_initcall(edma_init);
 
 static void __exit edma_exit(void)
 {
-	platform_device_unregister(pdev0);
-	if (pdev1)
-		platform_device_unregister(pdev1);
 	platform_driver_unregister(&edma_driver);
 }
 module_exit(edma_exit);
