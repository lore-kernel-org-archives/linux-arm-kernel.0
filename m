From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 2 Jan 2012 14:17:40 +0100
Subject: [PATCH] mfd/db8500-prcmu: remove support for early silicon revisions
Message-ID: <1325510260-4368-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The DB8500 ED (Early Drop) and V1 are only available inside of
ST-Ericsson or partners, we have actively replaced and scrapped
these prototypes. All Nova products on the open market (such as
the Snowball board) are based on V2 and later ASIC variants.
So let us focus on supporting the silicon that will be used and
delete this to get a clear overview.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM-SoC guys, can either of you please merge this patch to
wherever the other ux500 patches are pending? There is some
cross-dependence on the MFD core and I intended to include this
patch in the original pull request, but I screwed up, breaking
linux-next. Thanks.
---
 drivers/mfd/db8500-prcmu.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index a25ab9c..af8e0ef 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2102,14 +2102,11 @@ static struct irq_chip prcmu_irq_chip = {
 void __init db8500_prcmu_early_init(void)
 {
 	unsigned int i;
-
-	if (cpu_is_u8500v1()) {
-		tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE_V1);
-	} else if (cpu_is_u8500v2()) {
+	if (cpu_is_u8500v2()) {
 		void *tcpm_base = ioremap_nocache(U8500_PRCMU_TCPM_BASE, SZ_4K);
 
 		if (tcpm_base != NULL) {
-			int version;
+			u32 version;
 			version = readl(tcpm_base + PRCMU_FW_VERSION_OFFSET);
 			prcmu_version.project_number = version & 0xFF;
 			prcmu_version.api_version = (version >> 8) & 0xFF;
-- 
1.7.8
