From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:34 -0400
Subject: [PATCH 02/10] ARM: add dma_zone_size to the machine_desc structure
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/mach/arch.h |    4 ++++
 arch/arm/kernel/setup.c          |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 946f4d7..7b79a00 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -23,6 +23,10 @@ struct machine_desc {
 
 	unsigned int		nr_irqs;	/* number of IRQs */
 
+#ifdef CONFIG_ZONE_DMA
+	unsigned long dma_zone_size;		/* size of DMA-able area */
+#endif
+
 	unsigned int		video_start;	/* start of video RAM	*/
 	unsigned int		video_end;	/* end of video RAM	*/
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ed11fb0..e0db84d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -916,6 +916,12 @@ void __init setup_arch(char **cmdline_p)
 	cpu_init();
 	tcm_init();
 
+#ifdef CONFIG_ZONE_DMA
+	if (mdesc->dma_zone_size) {
+		extern unsigned long arm_dma_zone_size;
+		arm_dma_zone_size = mdesc->dma_zone_size;
+	}
+#endif
 #ifdef CONFIG_MULTI_IRQ_HANDLER
 	handle_arch_irq = mdesc->handle_irq;
 #endif
-- 
1.7.4
