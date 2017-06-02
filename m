From: alcooperx@gmail.com (Al Cooper)
Date: Fri,  2 Jun 2017 14:01:50 -0400
Subject: [PATCH 1/3] soc: brcmstb: Add Product ID and Family ID helper
 functions
In-Reply-To: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
References: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
Message-ID: <1496426512-10590-2-git-send-email-alcooperx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c    | 12 ++++++++++++
 include/linux/soc/brcmstb/brcmstb.h | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index b6195fd..184dbf5 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -40,6 +40,18 @@ bool soc_is_brcmstb(void)
 	return of_match_node(brcmstb_machine_match, root) != NULL;
 }
 
+u32 brcmstb_get_family_id(void)
+{
+	return family_id;
+}
+EXPORT_SYMBOL(brcmstb_get_family_id);
+
+u32 brcmstb_get_product_id(void)
+{
+	return product_id;
+}
+EXPORT_SYMBOL(brcmstb_get_product_id);
+
 static const struct of_device_id sun_top_ctrl_match[] = {
 	{ .compatible = "brcm,bcm7125-sun-top-ctrl", },
 	{ .compatible = "brcm,bcm7346-sun-top-ctrl", },
diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
index 337ce41..23e4dc9 100644
--- a/include/linux/soc/brcmstb/brcmstb.h
+++ b/include/linux/soc/brcmstb/brcmstb.h
@@ -1,10 +1,20 @@
 #ifndef __BRCMSTB_SOC_H
 #define __BRCMSTB_SOC_H
 
+#define BRCM_ID(reg)	((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
+#define BRCM_REV(reg)	((u32)reg & 0xff)
+
 /*
  * Bus Interface Unit control register setup, must happen early during boot,
  * before SMP is brought up, called by machine entry point.
  */
 void brcmstb_biuctrl_init(void);
 
+/*
+ * Helper functions for getting family or product id from the
+ * SoC driver.
+ */
+u32 brcmstb_get_family_id(void);
+u32 brcmstb_get_product_id(void);
+
 #endif /* __BRCMSTB_SOC_H */
-- 
1.9.0.138.g2de3478
