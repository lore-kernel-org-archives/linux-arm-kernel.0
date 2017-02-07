From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue,  7 Feb 2017 17:41:21 +0100
Subject: [PATCH 08/10] ARM: davinci: fix the DT boot on da850-evm
In-Reply-To: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1486485683-11427-9-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we enable vpif capture on the da850-evm we hit a BUG_ON() because
the i2c adapter can't be found. The board file boot uses i2c adapter 1
but in the DT mode it's actually adapter 0. Drop the problematic lines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 94948c1..09f62ac 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -116,10 +116,6 @@ static void __init da850_vpif_legacy_init(void)
 	if (of_machine_is_compatible("ti,da850-lcdk"))
 		da850_vpif_capture_config.subdev_count = 1;
 
-	/* EVM (UI card) uses i2c adapter 1 (not default: zero) */
-	if (of_machine_is_compatible("ti,da850-evm"))
-		da850_vpif_capture_config.i2c_adapter_id = 1;
-
 	ret = da850_register_vpif_capture(&da850_vpif_capture_config);
 	if (ret)
 		pr_warn("%s: VPIF capture setup failed: %d\n",
-- 
2.9.3
