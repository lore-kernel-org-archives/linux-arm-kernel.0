From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 15 Sep 2012 17:33:48 -0300
Subject: [PATCH v2] ARM: imx: armadillo5x0: Fix illegal register access
Message-ID: <1347741228-19995-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 0c8bad6a(Armadillo 500 add NAND flash device support (resend).)
introduced an incorrect access to MXC_CCM_RCSR.

MXC_CCM_RCSR is an offset and in order to properly access this register, 
the mx3_ccm_base needs to be passed, otherwise an illegal access is done.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also fix the write part.

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
