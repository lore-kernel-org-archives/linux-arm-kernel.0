From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon,  3 May 2010 14:41:10 -0700
Subject: [PATCH 2/3] OMAP3: PRCM interrupt: only check and clear enabled PRCM
	IRQs
In-Reply-To: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
References: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1272922871-18847-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While handling PRCM IRQs, mask out interrupts that are not enabled in
PRM_IRQENABLE_MPU.  If these are not masked out, non-enabled
interrupts are caught, a WARN() is printed due to no 'handler' and the
events are cleared.  In addition to being noisy, this can also
interfere with independent polling of this register by SR/VP code.

This was noticed using SmartReflex transitions which cause the VPx_*
interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
but not enabled in PRM_IRQENABLE_MPU.

Acked-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fee2efb..c38016b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,13 +266,16 @@ static int _prcm_int_handle_wakeup(void)
  */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
-	u32 irqstatus_mpu;
+	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
 
-	do {
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	irqstatus_mpu &= irqenable_mpu;
 
+	do {
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
 			c = _prcm_int_handle_wakeup();
 
@@ -291,7 +294,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
+		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		irqstatus_mpu &= irqenable_mpu;
+
+	} while (irqstatus_mpu);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.2
