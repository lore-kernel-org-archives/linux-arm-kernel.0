From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 21 Mar 2016 11:01:41 -0500
Subject: [PATCHv3 4/9] EDAC, altera: Abstract ECC Enable Mask in check_deps()
In-Reply-To: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1458576106-24505-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, the
ECC Enable mask is used in place of hard coded masks
in the check dependency functions.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v3: This change added.
---
 drivers/edac/altera_edac.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e20a045..0dbfa47 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -859,7 +859,9 @@ static void ocram_free_mem(void *p, size_t size, void *other)
 static int altr_ocram_check_deps(struct altr_edac_device_dev *device)
 {
 	void __iomem  *base = device->base;
-	if (readl(base) & ALTR_OCR_ECC_EN)
+	const struct edac_device_prv_data *prv = device->data;
+
+	if (readl(base) & prv->ecc_enable_mask)
 		return 0;
 
 	edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -926,7 +928,10 @@ static void l2_free_mem(void *p, size_t size, void *other)
 static int altr_l2_check_deps(struct altr_edac_device_dev *device)
 {
 	void __iomem *base = device->base;
-	if (readl(base) & ALTR_L2_ECC_EN)
+	const struct edac_device_prv_data *prv = device->data;
+
+	if ((readl(base) & prv->ecc_enable_mask) ==
+	     prv->ecc_enable_mask)
 		return 0;
 
 	edac_printk(KERN_ERR, EDAC_DEVICE,
-- 
1.7.9.5
