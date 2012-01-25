From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:33:08 +0000
Subject: [PATCH 09/33] MFD: mcp-sa11x0: remove DMA initializers and variables
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3uO-0000YE-Br@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_device_t variables are only ever written to by mcp-sa11x0 and
never read.  As the old SA11x0 DMA support will be removed, remove
these so that it no longer depends on the old SA11x0 DMA definitions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-core.c        |    1 -
 drivers/mfd/mcp-sa11x0.c      |    5 -----
 drivers/mfd/ucb1x00-assabet.c |    3 ---
 drivers/mfd/ucb1x00-core.c    |    1 -
 drivers/mfd/ucb1x00-ts.c      |    1 -
 include/linux/mfd/mcp.h       |    6 ------
 6 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index cc76431..280a4f8 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/mfd/mcp.h>
 
-#include <mach/dma.h>
 #include <asm/system.h>
 
 
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 33cadc0..d2ebc64 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -20,7 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/mcp.h>
 
-#include <mach/dma.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/system.h>
@@ -158,10 +157,6 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	mcp->owner		= THIS_MODULE;
 	mcp->ops		= &mcp_sa11x0;
 	mcp->sclk_rate		= data->sclk_rate;
-	mcp->dma_audio_rd	= DMA_Ser4MCP0Rd;
-	mcp->dma_audio_wr	= DMA_Ser4MCP0Wr;
-	mcp->dma_telco_rd	= DMA_Ser4MCP1Rd;
-	mcp->dma_telco_wr	= DMA_Ser4MCP1Wr;
 	mcp->gpio_base		= data->gpio_base;
 
 	platform_set_drvdata(pdev, mcp);
diff --git a/drivers/mfd/ucb1x00-assabet.c b/drivers/mfd/ucb1x00-assabet.c
index cea9da6..b7be613 100644
--- a/drivers/mfd/ucb1x00-assabet.c
+++ b/drivers/mfd/ucb1x00-assabet.c
@@ -16,9 +16,6 @@
 #include <linux/device.h>
 #include <linux/mfd/ucb1x00.h>
 
-#include <mach/dma.h>
-
-
 #define UCB1X00_ATTR(name,input)\
 static ssize_t name##_show(struct device *dev, struct device_attribute *attr, \
 			   char *buf)	\
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index febc90c..f2fb420 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -29,7 +29,6 @@
 #include <linux/gpio.h>
 #include <linux/semaphore.h>
 
-#include <mach/dma.h>
 #include <mach/hardware.h>
 
 static DEFINE_MUTEX(ucb1x00_mutex);
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 63a3cbd..ec6ffb6 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -32,7 +32,6 @@
 #include <linux/kthread.h>
 #include <linux/mfd/ucb1x00.h>
 
-#include <mach/dma.h>
 #include <mach/collie.h>
 #include <asm/mach-types.h>
 
diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index 79a6b13..dfe7e51 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -10,8 +10,6 @@
 #ifndef MCP_H
 #define MCP_H
 
-#include <mach/dma.h>
-
 struct mcp_ops;
 
 struct mcp {
@@ -21,10 +19,6 @@ struct mcp {
 	int		use_count;
 	unsigned int	sclk_rate;
 	unsigned int	rw_timeout;
-	dma_device_t	dma_audio_rd;
-	dma_device_t	dma_audio_wr;
-	dma_device_t	dma_telco_rd;
-	dma_device_t	dma_telco_wr;
 	struct device	attached_device;
 	int		gpio_base;
 };
-- 
1.7.4.4
