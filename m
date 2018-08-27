From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:05 -0600
Subject: [PATCH 2/9] drm/msm/a6xx: Fix PDC register overlap
In-Reply-To: <20180827151112.25211-1-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
Message-ID: <20180827151112.25211-3-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current design greedily takes a big chunk of the PDC
register space instead of just the GPU specific sections
which conflicts with other drivers and generally makes
a mess of things.

Furthermore we only need to map the GPU PDC sections
just once during init so map the memory inside the function
that uses it.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 87 ++++++++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 --
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bbb8126ec5c5..d0dac4c2e3e7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -348,8 +348,23 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
 }
 
+static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
+{
+	return msm_writel(value, ptr + (offset << 2));
+}
+
+static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
+		const char *name);
+
 static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 {
+	struct platform_device *pdev = to_platform_device(gmu->dev);
+	void __iomem *pdcptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc");
+	void __iomem *seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
+
+	if (!pdcptr || !seqptr)
+		goto err;
+
 	/* Disable SDE clock gating */
 	gmu_write(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0, BIT(24));
 
@@ -374,44 +389,48 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_RSCC_SEQ_MEM_0_DRV0 + 4, 0x0020e8a8);
 
 	/* Load PDC sequencer uCode for power up and power down sequence */
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_MEM_0, 0xfebea1e1);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 1, 0xa5a4a3a2);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 2, 0x8382a6e0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 3, 0xbce3e284);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 4, 0x002081fc);
+	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0, 0xfebea1e1);
+	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 1, 0xa5a4a3a2);
+	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 2, 0x8382a6e0);
+	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 3, 0xbce3e284);
+	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 4, 0x002081fc);
 
 	/* Set TCS commands used by PDC sequence for low power modes */
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD_ENABLE_BANK, 7);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD_WAIT_FOR_CMPL_BANK, 0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CONTROL, 0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR, 0x30010);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA, 1);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 4, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 4, 0x30000);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 4, 0x0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 8, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, 0x30080);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 8, 0x0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD_ENABLE_BANK, 7);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD_WAIT_FOR_CMPL_BANK, 0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CONTROL, 0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR, 0x30010);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA, 2);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 4, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, 0x30000);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x3);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 8, 0x10108);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, 0x30080);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 8, 0x3);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD_ENABLE_BANK, 7);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD_WAIT_FOR_CMPL_BANK, 0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CONTROL, 0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR, 0x30010);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA, 1);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 4, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 4, 0x30000);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 4, 0x0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 8, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, 0x30080);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 8, 0x0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD_ENABLE_BANK, 7);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD_WAIT_FOR_CMPL_BANK, 0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CONTROL, 0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR, 0x30010);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA, 2);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 4, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, 0x30000);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x3);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 8, 0x10108);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, 0x30080);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 8, 0x3);
 
 	/* Setup GPU PDC */
-	pdc_write(gmu, REG_A6XX_PDC_GPU_SEQ_START_ADDR, 0);
-	pdc_write(gmu, REG_A6XX_PDC_GPU_ENABLE_PDC, 0x80000001);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_SEQ_START_ADDR, 0);
+	pdc_write(pdcptr, REG_A6XX_PDC_GPU_ENABLE_PDC, 0x80000001);
 
 	/* ensure no writes happen before the uCode is fully written */
 	wmb();
+
+err:
+	devm_iounmap(gmu->dev, pdcptr);
+	devm_iounmap(gmu->dev, seqptr);
 }
 
 /*
@@ -1170,11 +1189,7 @@ int a6xx_gmu_probe(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	/* Map the GMU registers */
 	gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
-
-	/* Map the GPU power domain controller registers */
-	gmu->pdc_mmio = a6xx_gmu_get_mmio(pdev, "gmu_pdc");
-
-	if (IS_ERR(gmu->mmio) || IS_ERR(gmu->pdc_mmio))
+	if (IS_ERR(gmu->mmio))
 		goto err;
 
 	/* Get the HFI and GMU interrupts */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index d9a386c18799..09d97e4ed293 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -47,7 +47,6 @@ struct a6xx_gmu {
 	struct device *dev;
 
 	void * __iomem mmio;
-	void * __iomem pdc_mmio;
 
 	int hfi_irq;
 	int gmu_irq;
@@ -89,11 +88,6 @@ static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
 	return msm_writel(value, gmu->mmio + (offset << 2));
 }
 
-static inline void pdc_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
-{
-	return msm_writel(value, gmu->pdc_mmio + (offset << 2));
-}
-
 static inline void gmu_rmw(struct a6xx_gmu *gmu, u32 reg, u32 mask, u32 or)
 {
 	u32 val = gmu_read(gmu, reg);
-- 
2.18.0
