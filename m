From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 16 Sep 2012 22:28:35 -0300
Subject: [PATCH v3] ARM: imx: armadillo5x0: Fix illegal register access
Message-ID: <1347845315-16565-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit eb92044eb (ARM i.MX3: Make ccm base address a variable )
it is necessary to pass the CCM register base as a variable.

Fix the CCM register access in mach-armadillo5x0 by passing mx3_ccm_base and 
avoid illegal accesses.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Indicate the correct commit that caused the issue
Changes since v1:
- Also fixes the write part.

 arch/arm/mach-imx/mach-armadillo5x0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 2c6ab32..9f39f7e 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -526,7 +526,8 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mxc_nand(&armadillo5x0_nand_board_info);
 
 	/* set NAND page size to 2k if not configured via boot mode pins */
-	__raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
+	__raw_writel(__raw_readl(mx3_ccm_base + MXC_CCM_RCSR) | 
+					(1 << 30), mx3_ccm_base + MXC_CCM_RCSR);
 
 	/* RTC */
 	/* Get RTC IRQ and register the chip */
-- 
1.7.9.5
