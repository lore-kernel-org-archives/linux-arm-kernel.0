From: keescook@chromium.org (Kees Cook)
Date: Fri, 29 Jun 2018 11:51:07 -0700
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
Message-ID: <20180629185107.GA37488@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a pre-allocated scratch register space, set up with
all other other allocations.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: dmaengine at vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/ste_dma40.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 1bc149af990e..f4edfc56f34e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -555,6 +555,7 @@ struct d40_gen_dmac {
  * @reg_val_backup_v4: Backup of registers that only exits on dma40 v3 and
  * later
  * @reg_val_backup_chan: Backup data for standard channel parameter registers.
+ * @regs_interrupt: Scratch space for registers during interrupt.
  * @gcc_pwr_off_mask: Mask to maintain the channels that can be turned off.
  * @gen_dmac: the struct for generic registers values to represent u8500/8540
  * DMA controller
@@ -592,6 +593,7 @@ struct d40_base {
 	u32				  reg_val_backup[BACKUP_REGS_SZ];
 	u32				  reg_val_backup_v4[BACKUP_REGS_SZ_MAX];
 	u32				 *reg_val_backup_chan;
+	u32				 *regs_interrupt;
 	u16				  gcc_pwr_off_mask;
 	struct d40_gen_dmac		  gen_dmac;
 };
@@ -1637,7 +1639,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 	struct d40_chan *d40c;
 	unsigned long flags;
 	struct d40_base *base = data;
-	u32 regs[base->gen_dmac.il_size];
+	u32 *regs = base->regs_interrupt;
 	struct d40_interrupt_lookup *il = base->gen_dmac.il;
 	u32 il_size = base->gen_dmac.il_size;
 
@@ -3258,13 +3260,22 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	if (!base->lcla_pool.alloc_map)
 		goto free_backup_chan;
 
+	base->regs_interrupt = kmalloc_array(base->gen_dmac.il_size,
+					     sizeof(*base->regs_interrupt),
+					     GFP_KERNEL);
+	if (!base->regs_interrupt)
+		goto free_map;
+
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
 	if (base->desc_slab == NULL)
-		goto free_map;
+		goto free_regs;
+
 
 	return base;
+ free_regs:
+	kfree(base->regs_interrupt);
  free_map:
 	kfree(base->lcla_pool.alloc_map);
  free_backup_chan:
-- 
2.17.1


-- 
Kees Cook
Pixel Security
