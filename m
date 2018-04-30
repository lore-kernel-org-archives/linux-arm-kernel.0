From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:42 +0200
Subject: [PATCH 01/12] mtd: nand: davinci: store the core chipselect number in
 platform data
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Message-ID: <20180430082453.8091-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We have the 'ti,davinci-chipselect' property in the device tree, but
when using platform data the driver silently uses the id field of
struct platform_device as the chipselect. This is confusing and we
almost broke the nand support again recently after converting the
platform to common clock framework (which changed the device id in the
clock lookup - the problem is gone now that we no longer acquire the
clock in the nand driver.

This patch adds a new filed - core_chipsel - to the platform_data.
Subsequent patches will convert the platforms to using this new field.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/mtd-davinci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/mtd-davinci.h b/include/linux/platform_data/mtd-davinci.h
index f1a2cf655bdb..879a59f97dac 100644
--- a/include/linux/platform_data/mtd-davinci.h
+++ b/include/linux/platform_data/mtd-davinci.h
@@ -56,6 +56,8 @@ struct davinci_nand_pdata {		/* platform_data */
 	uint32_t		mask_ale;
 	uint32_t		mask_cle;
 
+	uint32_t		core_chipsel;
+
 	/* for packages using two chipselects */
 	uint32_t		mask_chipsel;
 
-- 
2.17.0
