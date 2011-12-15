From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Dec 2011 14:36:24 -0700
Subject: [PATCH 9/9] ARM: OMAP4: PRM: use PRCM interrupt handler
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Message-ID: <20111215213623.26632.23587.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Use the new PRCM interrupt handler code on OMAP4 systems.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul at pwsan.com: split this from a previous patch to this patch; call
 omap4xxx_prcm_init() during init; write trivial commit log]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm44xx.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index c4be5d9..040c39c 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -27,6 +27,24 @@
 #include "prcm44xx.h"
 #include "prminst44xx.h"
 
+static const struct omap_prcm_irq omap4_prcm_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",   0,      0),
+	OMAP_PRCM_IRQ("io",     9,      1),
+};
+
+static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
+	.ack			= OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
+	.mask			= OMAP4_PRM_IRQENABLE_MPU_OFFSET,
+	.nr_regs		= 2,
+	.irqs			= omap4_prcm_irqs,
+	.nr_irqs		= ARRAY_SIZE(omap4_prcm_irqs),
+	.irq			= OMAP44XX_IRQ_PRCM,
+	.read_pending_irqs	= &omap44xx_prm_read_pending_irqs,
+	.ocp_barrier		= &omap44xx_prm_ocp_barrier,
+	.save_and_clear_irqen	= &omap44xx_prm_save_and_clear_irqen,
+	.restore_irqen		= &omap44xx_prm_restore_irqen,
+};
+
 /* PRM low-level functions */
 
 /* Read a register in a CM/PRM instance in the PRM module */
@@ -211,3 +229,11 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
 	omap4_prm_write_inst_reg(saved_mask[1], OMAP4430_PRM_DEVICE_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 }
+
+static int __init omap4xxx_prcm_init(void)
+{
+	if (cpu_is_omap44xx())
+		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
+	return 0;
+}
+subsys_initcall(omap4xxx_prcm_init);
