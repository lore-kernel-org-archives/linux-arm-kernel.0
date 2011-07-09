From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 09:12:23 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <20110708203045.GT4812@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230455.GZ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062043180.14596@xanadu.home>
	<20110708121441.GD4812@n2100.arm.linux.org.uk>
	<20110708203045.GT4812@n2100.arm.linux.org.uk>
Message-ID: <20110709081223.GA30368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 09:30:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 08, 2011 at 01:14:41PM +0100, Russell King - ARM Linux wrote:
> > It looks like ISA_DMA_THRESHOLD has become unused by most of the kernel,
> > so yes, renaming it to "dma_zone_limit" would be more descriptive.  We
> > should probably make dma_supported() be out-of-line anyway (which then
> > means that dma_zone_limit doesn't have to be exported to drivers) - and
> > I think the DMA bounce stuff needs cleaning up in dma_set_mask().
> 
> ... and I now have a patch which does this, pending testing.  Once
> I've tested it I'll send it out.

8<-----
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: dmabounce: simplify dma_set_mask()

Simplify the dmabounce specific code in dma_set_mask().  We can just
omit setting the dma mask if dmabounce is enabled (we will have already
set dma mask via callbacks when the device is created in that case.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 4ad2533..94662f4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -133,18 +133,12 @@ static inline int dma_supported(struct device *dev, u64 mask)
 
 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
-#ifdef CONFIG_DMABOUNCE
-	if (dev->archdata.dmabounce) {
-		if (dma_mask >= ISA_DMA_THRESHOLD)
-			return 0;
-		else
-			return -EIO;
-	}
-#endif
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 
+#ifndef CONFIG_DMABOUNCE
 	*dev->dma_mask = dma_mask;
+#endif
 
 	return 0;
 }
-- 
1.7.4.4
