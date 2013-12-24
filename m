From: b20788@freescale.com (Anson Huang)
Date: Tue, 24 Dec 2013 13:00:47 -0500
Subject: [PATCH] ARM: imx: improve the comment of CCM lpm SW workaround
Message-ID: <1387908047-1848-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the comment of SW workaround for CCM lpm issue using
hardware errata description to avoid confusion.

TKT194736:
Chip will enter low power mode before ARM A9 CPU executes
WFI when improper low power sequence is used.

SW workaround:
1) SW will trigger irq #32(IOMUX) to be always pending manually by setting IOMUX_GPR1_GINT bit,
2) SW should then Unmask it in GPC before setting CCM LPM
3) SW should Mask it right after CCM LPM is set (set bit0-1 of CCM_CLPCR)

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/pm-imx6q.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index aecd9f8..8da4732 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -156,10 +156,13 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	}
 
 	/*
-	 * Unmask the always pending IOMUXC interrupt #32 as wakeup source to
-	 * deassert dsm_request signal, so that we can ensure dsm_request
-	 * is not asserted when we're going to write CLPCR register to set LPM.
-	 * After setting up LPM bits, we need to mask this wakeup source.
+	 * TKT194736:
+	 * Chip will enter low power mode before ARM A9 CPU executes WFI when improper low power sequence is used.
+	 *
+	 * SW workaround:
+	 * 1) SW will trigger irq #32(IOMUXC) to be always pending manually by setting IOMUX_GPR1_GINT bit,
+	 * 2) SW should then Unmask it in GPC before setting CCM LPM
+	 * 3) SW should Mask it right after CCM LPM is set (set bit0-1 of CCM_CLPCR)
 	 */
 	iomuxc_irq_desc = irq_to_desc(32);
 	imx_gpc_irq_unmask(&iomuxc_irq_desc->irq_data);
@@ -219,6 +222,8 @@ void __init imx6q_pm_init(void)
 	WARN_ON(!ccm_base);
 
 	/*
+	 * This is for SW workaround step #1 of TKT194736, see comments
+	 * in imx6q_set_lpm for details of this errata.
 	 * Force IOMUXC irq pending, so that the interrupt to GPC can be
 	 * used to deassert dsm_request signal when the signal gets
 	 * asserted unexpectedly.
-- 
1.7.9.5
