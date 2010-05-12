From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:49 -0700
Subject: [PATCH 20/25] msm: dma: add 7x30 security domain abstraction
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-21-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM SOC's DMA controller contains several security domains.
On the MSM7x00, only security domain 3 is accessible to our CPU.
The 7x30, however, uses security domain 2.  Fix up the register
definition macros to select this appropriately, based on
configured target.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/dma.h |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/dma.h b/arch/arm/mach-msm/include/mach/dma.h
index 78b0ffd..00f9bbf 100644
--- a/arch/arm/mach-msm/include/mach/dma.h
+++ b/arch/arm/mach-msm/include/mach/dma.h
@@ -43,40 +43,42 @@ int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr);
 #define DMOV_SD2(off, ch) (MSM_DMOV_BASE + 0x0800 + (off) + ((ch) << 2))
 #define DMOV_SD3(off, ch) (MSM_DMOV_BASE + 0x0C00 + (off) + ((ch) << 2))
 
-/* only security domain 3 is available to the ARM11
- * SD0 -> mARM trusted, SD1 -> mARM nontrusted, SD2 -> aDSP, SD3 -> aARM
- */
+#if defined(CONFIG_ARCH_MSM7X30)
+#define DMOV_SD_AARM DMOV_SD2
+#else
+#define DMOV_SD_AARM DMOV_SD3
+#endif
 
-#define DMOV_CMD_PTR(ch)      DMOV_SD3(0x000, ch)
+#define DMOV_CMD_PTR(ch)      DMOV_SD_AARM(0x000, ch)
 #define DMOV_CMD_LIST         (0 << 29) /* does not work */
 #define DMOV_CMD_PTR_LIST     (1 << 29) /* works */
 #define DMOV_CMD_INPUT_CFG    (2 << 29) /* untested */
 #define DMOV_CMD_OUTPUT_CFG   (3 << 29) /* untested */
 #define DMOV_CMD_ADDR(addr)   ((addr) >> 3)
 
-#define DMOV_RSLT(ch)         DMOV_SD3(0x040, ch)
+#define DMOV_RSLT(ch)         DMOV_SD_AARM(0x040, ch)
 #define DMOV_RSLT_VALID       (1 << 31) /* 0 == host has empties result fifo */
 #define DMOV_RSLT_ERROR       (1 << 3)
 #define DMOV_RSLT_FLUSH       (1 << 2)
 #define DMOV_RSLT_DONE        (1 << 1)  /* top pointer done */
 #define DMOV_RSLT_USER        (1 << 0)  /* command with FR force result */
 
-#define DMOV_FLUSH0(ch)       DMOV_SD3(0x080, ch)
-#define DMOV_FLUSH1(ch)       DMOV_SD3(0x0C0, ch)
-#define DMOV_FLUSH2(ch)       DMOV_SD3(0x100, ch)
-#define DMOV_FLUSH3(ch)       DMOV_SD3(0x140, ch)
-#define DMOV_FLUSH4(ch)       DMOV_SD3(0x180, ch)
-#define DMOV_FLUSH5(ch)       DMOV_SD3(0x1C0, ch)
+#define DMOV_FLUSH0(ch)       DMOV_SD_AARM(0x080, ch)
+#define DMOV_FLUSH1(ch)       DMOV_SD_AARM(0x0C0, ch)
+#define DMOV_FLUSH2(ch)       DMOV_SD_AARM(0x100, ch)
+#define DMOV_FLUSH3(ch)       DMOV_SD_AARM(0x140, ch)
+#define DMOV_FLUSH4(ch)       DMOV_SD_AARM(0x180, ch)
+#define DMOV_FLUSH5(ch)       DMOV_SD_AARM(0x1C0, ch)
 
-#define DMOV_STATUS(ch)       DMOV_SD3(0x200, ch)
+#define DMOV_STATUS(ch)       DMOV_SD_AARM(0x200, ch)
 #define DMOV_STATUS_RSLT_COUNT(n)    (((n) >> 29))
 #define DMOV_STATUS_CMD_COUNT(n)     (((n) >> 27) & 3)
 #define DMOV_STATUS_RSLT_VALID       (1 << 1)
 #define DMOV_STATUS_CMD_PTR_RDY      (1 << 0)
 
-#define DMOV_ISR              DMOV_SD3(0x380, 0)
-
-#define DMOV_CONFIG(ch)       DMOV_SD3(0x300, ch)
+#define DMOV_ISR              DMOV_SD_AARM(0x380, 0)
+  
+#define DMOV_CONFIG(ch)       DMOV_SD_AARM(0x300, ch)
 #define DMOV_CONFIG_FORCE_TOP_PTR_RSLT (1 << 2)
 #define DMOV_CONFIG_FORCE_FLUSH_RSLT   (1 << 1)
 #define DMOV_CONFIG_IRQ_EN             (1 << 0)
-- 
1.6.2.3
