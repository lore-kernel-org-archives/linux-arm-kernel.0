From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 27 Feb 2015 15:59:26 +0200
Subject: [PATCH] ARM: OMAP4+: PRM: fix omap4 version of
 prm_save_and_clear_irqen
Message-ID: <1425045566-19580-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was incorrectly reading the irq status registers during the save
and clear, instead of the irq enable. This worked because there is only
one user for the prcm interrupts currently, namely the io-chain. Whenever
the function was called, an io-chain interrupt was both pending and
enabled.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a08a617..d6d6bc3 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -252,10 +252,10 @@ static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
 {
 	saved_mask[0] =
 		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
-					OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
+					OMAP4_PRM_IRQENABLE_MPU_OFFSET);
 	saved_mask[1] =
 		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
-					OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
+					OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 
 	omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-- 
1.7.9.5
