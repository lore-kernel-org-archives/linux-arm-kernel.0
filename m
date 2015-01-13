From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:23:13 +0100
Subject: [PATCH] dmaengine: k3: fix duplicate function definition
In-Reply-To: <20150113120751.GQ4160@sirena.org.uk>
References: <E1YAwSG-0000zm-Cs@debutante> <20150113120751.GQ4160@sirena.org.uk>
Message-ID: <1869934.MKKaD1UAQn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit db08425ebd51f ("dmaengine: k3: Split device_control") introduced
two new helper functions, which unfortunately have the same names
as the existing suspend/resume functions, resulting in a build error
when CONFIG_PM_SLEEP is enabled:

drivers/dma/k3dma.c:823:12: error: conflicting types for 'k3_dma_resume'
 static int k3_dma_resume(struct device *dev)
            ^
drivers/dma/k3dma.c:625:12: note: previous definition of 'k3_dma_resume' was here
 static int k3_dma_resume(struct dma_chan *chan)
            ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: db08425ebd51f ("dmaengine: k3: Split device_control")

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 49be7f687c4c..8cc61ae42f42 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -804,7 +804,7 @@ static int k3_dma_remove(struct platform_device *op)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int k3_dma_suspend(struct device *dev)
+static int k3_dma_suspend_dev(struct device *dev)
 {
 	struct k3_dma_dev *d = dev_get_drvdata(dev);
 	u32 stat = 0;
@@ -820,7 +820,7 @@ static int k3_dma_suspend(struct device *dev)
 	return 0;
 }
 
-static int k3_dma_resume(struct device *dev)
+static int k3_dma_resume_dev(struct device *dev)
 {
 	struct k3_dma_dev *d = dev_get_drvdata(dev);
 	int ret = 0;
@@ -835,7 +835,7 @@ static int k3_dma_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(k3_dma_pmops, k3_dma_suspend, k3_dma_resume);
+static SIMPLE_DEV_PM_OPS(k3_dma_pmops, k3_dma_suspend_dev, k3_dma_resume_dev);
 
 static struct platform_driver k3_pdma_driver = {
 	.driver		= {
