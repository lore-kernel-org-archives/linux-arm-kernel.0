From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Apr 2014 21:52:02 +0200
Subject: [PATCH 2/4] dma: ste_dma40: Don't require CONFIG_PM_RUNTIME
In-Reply-To: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1398282724-2607-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While probing, don't rely on CONFIG_PM_RUNTIME to be configured.
Instead, let's power up the device and make it fully operational.
Update the runtime PM status to reflect the active state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/ste_dma40.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 6e97cf6..45e809f 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -556,7 +556,6 @@ struct d40_gen_dmac {
  * later
  * @reg_val_backup_chan: Backup data for standard channel parameter registers.
  * @gcc_pwr_off_mask: Mask to maintain the channels that can be turned off.
- * @initialized: true if the dma has been initialized
  * @gen_dmac: the struct for generic registers values to represent u8500/8540
  * DMA controller
  */
@@ -594,7 +593,6 @@ struct d40_base {
 	u32				  reg_val_backup_v4[BACKUP_REGS_SZ_MAX];
 	u32				 *reg_val_backup_chan;
 	u16				  gcc_pwr_off_mask;
-	bool				  initialized;
 	struct d40_gen_dmac		  gen_dmac;
 };
 
@@ -3030,8 +3028,7 @@ static int dma40_runtime_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct d40_base *base = platform_get_drvdata(pdev);
 
-	if (base->initialized)
-		d40_save_restore_registers(base, false);
+	d40_save_restore_registers(base, false);
 
 	writel_relaxed(D40_DREG_GCC_ENABLE_ALL,
 		       base->virtbase + D40_DREG_GCC);
@@ -3645,12 +3642,6 @@ static int __init d40_probe(struct platform_device *pdev)
 		goto failure;
 	}
 
-	pm_runtime_irq_safe(base->dev);
-	pm_runtime_set_autosuspend_delay(base->dev, DMA40_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(base->dev);
-	pm_runtime_enable(base->dev);
-	pm_runtime_resume(base->dev);
-
 	if (base->plat_data->use_esram_lcla) {
 
 		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
@@ -3671,7 +3662,15 @@ static int __init d40_probe(struct platform_device *pdev)
 		}
 	}
 
-	base->initialized = true;
+	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
+
+	pm_runtime_irq_safe(base->dev);
+	pm_runtime_set_autosuspend_delay(base->dev, DMA40_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(base->dev);
+	pm_runtime_mark_last_busy(base->dev);
+	pm_runtime_set_active(base->dev);
+	pm_runtime_enable(base->dev);
+
 	ret = d40_dmaengine_init(base, num_reserved_chans);
 	if (ret)
 		goto failure;
-- 
1.7.9.5
