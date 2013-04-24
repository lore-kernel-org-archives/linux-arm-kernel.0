From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 09:49:12 +0100
Subject: [PATCH 08/32 v2] dmaengine: ste_dma40: Remove home-brew MAX() macro
In-Reply-To: <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20130424084912.GH17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of the DMA40's local MAX() macro evaluates
its arguments more times than is necessary and it not type checked.
This patch strips replaces it with a new, more efficient constant.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Reported-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cc93416..a1984d2 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -53,8 +53,6 @@
 #define D40_ALLOC_PHY		BIT(30)
 #define D40_ALLOC_LOG_FREE	0
 
-#define MAX(a, b) (((a) < (b)) ? (b) : (a))
-
 #define D40_IS_SRC(dir)  (dir == STEDMA40_PERIPH_TO_MEM)
 #define D40_IS_DST(dir) ((dir == STEDMA40_MEM_TO_PERIPH) || \
 			 (dir == STEDMA40_MEM_TO_MEM))
@@ -206,6 +204,9 @@ static u32 d40_backup_regs_chan[] = {
 	D40_CHAN_REG_SDLNK,
 };
 
+#define BACKUP_REGS_SZ_MAX ((BACKUP_REGS_SZ_V4A > BACKUP_REGS_SZ_V4B) ? \
+			     BACKUP_REGS_SZ_V4A : BACKUP_REGS_SZ_V4B)
+
 /**
  * struct d40_interrupt_lookup - lookup table for interrupt handler
  *
@@ -569,7 +570,7 @@ struct d40_base {
 	resource_size_t			  lcpa_size;
 	struct kmem_cache		 *desc_slab;
 	u32				  reg_val_backup[BACKUP_REGS_SZ];
-	u32				  reg_val_backup_v4[MAX(BACKUP_REGS_SZ_V4A, BACKUP_REGS_SZ_V4B)];
+	u32				  reg_val_backup_v4[BACKUP_REGS_SZ_MAX];
 	u32				 *reg_val_backup_chan;
 	u16				  gcc_pwr_off_mask;
 	bool				  initialized;
