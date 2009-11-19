From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:16 +0100
Subject: [PATCH 02/12] mxc: iomux v3: remove resource handling
In-Reply-To: <1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current model does not allow to put a pad into different modes
once a pins is allocated. Remove the resource handling.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-v3.h |   17 +-------------
 arch/arm/plat-mxc/iomux-v3.c              |   36 +---------------------------
 2 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index a0fa402..1deda01 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -88,9 +88,7 @@ struct pad_desc {
 #define PAD_CTL_SRE_FAST		(1 << 0)
 
 /*
- * setups a single pad:
- * 	- reserves the pad so that it is not claimed by another driver
- * 	- setups the iomux according to the configuration
+ * setups a single pad in the iomuxer
  */
 int mxc_iomux_v3_setup_pad(struct pad_desc *pad);
 
@@ -101,19 +99,6 @@ int mxc_iomux_v3_setup_pad(struct pad_desc *pad);
 int mxc_iomux_v3_setup_multiple_pads(struct pad_desc *pad_list, unsigned count);
 
 /*
- * releases a single pad:
- * 	- make it available for a future use by another driver
- * 	- DOES NOT reconfigure the IOMUX in its reset state
- */
-void mxc_iomux_v3_release_pad(struct pad_desc *pad);
-
-/*
- * releases multiple pads
- * convenvient way to call the above function with tables
- */
-void mxc_iomux_v3_release_multiple_pads(struct pad_desc *pad_list, int count);
-
-/*
  * Initialise the iomux controller
  */
 void mxc_iomux_v3_init(void __iomem *iomux_v3_base);
diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/plat-mxc/iomux-v3.c
index 851ca99..b318c6a 100644
--- a/arch/arm/plat-mxc/iomux-v3.c
+++ b/arch/arm/plat-mxc/iomux-v3.c
@@ -31,19 +31,11 @@
 
 static void __iomem *base;
 
-static unsigned long iomux_v3_pad_alloc_map[0x200 / BITS_PER_LONG];
-
 /*
- * setups a single pin:
- * 	- reserves the pin so that it is not claimed by another driver
- * 	- setups the iomux according to the configuration
+ * setups a single pad in the iomuxer
  */
 int mxc_iomux_v3_setup_pad(struct pad_desc *pad)
 {
-	unsigned int pad_ofs = pad->pad_ctrl_ofs;
-
-	if (test_and_set_bit(pad_ofs >> 2, iomux_v3_pad_alloc_map))
-		return -EBUSY;
 	if (pad->mux_ctrl_ofs)
 		__raw_writel(pad->mux_mode, base + pad->mux_ctrl_ofs);
 
@@ -66,37 +58,13 @@ int mxc_iomux_v3_setup_multiple_pads(struct pad_desc *pad_list, unsigned count)
 	for (i = 0; i < count; i++) {
 		ret = mxc_iomux_v3_setup_pad(p);
 		if (ret)
-			goto setup_error;
+			return ret;
 		p++;
 	}
 	return 0;
-
-setup_error:
-	mxc_iomux_v3_release_multiple_pads(pad_list, i);
-	return ret;
 }
 EXPORT_SYMBOL(mxc_iomux_v3_setup_multiple_pads);
 
-void mxc_iomux_v3_release_pad(struct pad_desc *pad)
-{
-	unsigned int pad_ofs = pad->pad_ctrl_ofs;
-
-	clear_bit(pad_ofs >> 2, iomux_v3_pad_alloc_map);
-}
-EXPORT_SYMBOL(mxc_iomux_v3_release_pad);
-
-void mxc_iomux_v3_release_multiple_pads(struct pad_desc *pad_list, int count)
-{
-	struct pad_desc *p = pad_list;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		mxc_iomux_v3_release_pad(p);
-		p++;
-	}
-}
-EXPORT_SYMBOL(mxc_iomux_v3_release_multiple_pads);
-
 void mxc_iomux_v3_init(void __iomem *iomux_v3_base)
 {
 	base = iomux_v3_base;
-- 
1.6.5.2
