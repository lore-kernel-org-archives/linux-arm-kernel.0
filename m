From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:12:27 +0200
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regmap does not support 64bit. The ival that is used to write the 64bit
data to, is unsigned int and can't hold 64bit. _regmap_write also just
supports unsigend int.

This patch removes the 64bit case as it may lead to compile warnings.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7111d04f2621..64a106af174f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1694,11 +1694,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			case 4:
 				ival = *(u32 *)(val + (i * val_bytes));
 				break;
-#ifdef CONFIG_64BIT
-			case 8:
-				ival = *(u64 *)(val + (i * val_bytes));
-				break;
-#endif
 			default:
 				ret = -EINVAL;
 				goto out;
-- 
2.4.6
