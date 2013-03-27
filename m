From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 27 Mar 2013 22:03:19 +0100
Subject: [PATCH 2/3] ARM: ux500: Stop passing ios_handler() as an MMCI power
 controlling call-back
In-Reply-To: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
References: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1364418200-15628-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

This fixes a regression introduced during the v3.9 merge window.

Now MMCI on/off functionality is using the regulator framework
from the MMCI driver, if we provide the ios_handler call-back we
essentially duplicate functionality, which causes a large mess
and lots of booting issues.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 051b62c..7f2cb6c 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -81,7 +81,6 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 #endif
 
 struct mmci_platform_data mop500_sdi0_data = {
-	.ios_handler	= mop500_sdi0_ios_handler,
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 50000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
-- 
1.7.11.3
