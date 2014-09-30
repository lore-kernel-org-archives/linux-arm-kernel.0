From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 14:04:17 +0200
Subject: [PATCH] nand: omap2: fix building with CONFIG_MTD_NAND_OMAP_BCH=m
Message-ID: <1811108.CcWEs0vKNL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the OMAP nand driver is built-in but the BCH driver is a module,
we get a link-time error:

drivers/built-in.o: In function `omap_elm_correct_data':
:(.text+0x174e88): undefined reference to `elm_decode_bch_error_page'
drivers/built-in.o: In function `omap_nand_probe':
:(.text+0x175b48): undefined reference to `elm_config'

There are two possible ways to deal with this, either prevent that
configuration in Kconfig or make sure we don't reference the ELM
driver in this case.

This patch picks the second approach, which makes it possible to
use the ELM driver in other modules while still having the OMAP
NAND driver built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 93af53b8633c ("nand: omap2: Remove horrible ifdefs to fix module probe")

diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index b8686c00f15f..cbca66ce7c10 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -42,7 +42,7 @@ struct elm_errorvec {
 	int error_loc[16];
 };
 
-#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
+#if defined(CONFIG_MTD_NAND_OMAP_BCH) || (defined(CONFIG_MTD_NAND_OMAP_BCH_MODULE) && defined(MODULE))
 void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
 		struct elm_errorvec *err_vec);
 int elm_config(struct device *dev, enum bch_ecc bch_type,
