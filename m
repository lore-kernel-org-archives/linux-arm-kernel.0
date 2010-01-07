From: PeterHuewe@gmx.de (Peter Huewe)
Date: Thu, 7 Jan 2010 02:50:13 +0100
Subject: [PATCH] arch/arm: Fix build failure for defconfigs without
	CONFIG_ISA_DMA_API set
Message-ID: <201001070250.14063.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>
Date: Thu, 7 Jan 2010 02:34:44 +0100

A lot of ARM-defconfigs (those without CONFIG_ISA_DMA_API set) fail to
build [1][2][3] due to the changes of the patch
    [PATCH] PCI: Clean up build for CONFIG_PCI_QUIRKS unset
    by Rafael J. Wysocki (Sat, 2 Jan 2010 22:57:24 +0100) [4]
as the referenced variable 'isa_dma_bridge_buggy' in asm/dma.h is
enclosed by the CONFIG_ISA_DMA_API conditional all configs without this
setting fail to build.

I'm not sure wether moving the condition is the right way to solve the
issue, but atleast it fixes the issue :)

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/1983354/
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/1983333/
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/1983337/
[4] http://lkml.org/lkml/2010/1/2/102

Patch against Linus' tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/include/asm/dma.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 7edf353..ca51143 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -138,12 +138,12 @@ extern int  get_dma_residue(unsigned int chan);
 #define NO_DMA	255
 #endif
 
+#endif /* CONFIG_ISA_DMA_API */
+
 #ifdef CONFIG_PCI
 extern int isa_dma_bridge_buggy;
 #else
 #define isa_dma_bridge_buggy    (0)
 #endif
 
-#endif /* CONFIG_ISA_DMA_API */
-
 #endif /* __ASM_ARM_DMA_H */
-- 
1.6.4.4
