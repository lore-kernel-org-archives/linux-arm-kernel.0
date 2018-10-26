From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 26 Oct 2018 15:51:18 +0800
Subject: [PATCH v2 2/4] irqchip/mbigen: rename register marcros
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1540540280-26612-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A MBIGEN can also be used for generating SPIs, so let's
rename register macros to make them more resonable.

The first 64-pins of MBIGEN is used by SPIs, so rename
RESERVED_IRQ_PER_MBIGEN_CHIP to SPI_NUM_PER_MBIGEN_CHIP
and change the comment for this marcro.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 567b29c..f05998f 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -30,14 +30,14 @@
 /* Interrupt numbers per mbigen node supported */
 #define IRQS_PER_MBIGEN_NODE		128
 
-/* 64 irqs (Pin0-pin63) are reserved for each mbigen chip */
-#define RESERVED_IRQ_PER_MBIGEN_CHIP	64
+/* 64 irqs (Pin0-pin63) are used for SPIs on each mbigen chip */
+#define SPI_NUM_PER_MBIGEN_CHIP	64
 
 /* The maximum IRQ pin number of mbigen chip(start from 0) */
 #define MAXIMUM_IRQ_PIN_NUM		1407
 
 /**
- * In mbigen vector register
+ * In mbigen lpi vector register
  * bit[21:12]:	event id value
  * bit[11:0]:	device id
  */
@@ -48,7 +48,7 @@
 #define MBIGEN_NODE_OFFSET		0x1000
 
 /* offset of vector register in mbigen node */
-#define REG_MBIGEN_VEC_OFFSET		0x200
+#define REG_MBIGEN_LPI_VEC_OFFSET	0x200
 
 /**
  * offset of clear register in mbigen node
@@ -62,7 +62,7 @@
  * This register is used to configure interrupt
  * trigger type
  */
-#define REG_MBIGEN_TYPE_OFFSET		0x0
+#define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
 
 /**
  * struct mbigen_device - holds the information of mbigen device.
@@ -79,12 +79,12 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
 
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
+	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
 	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+			+ REG_MBIGEN_LPI_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -92,7 +92,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 {
 	unsigned int nid, irq_ofst, ofst;
 
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
+	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
 
@@ -100,7 +100,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	ofst = irq_ofst / 32 * 4;
 
 	*addr = ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+		+ REG_MBIGEN_LPI_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
@@ -183,7 +183,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
-			(fwspec->param[0] < RESERVED_IRQ_PER_MBIGEN_CHIP))
+			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
 			return -EINVAL;
 		else
 			*hwirq = fwspec->param[0];
-- 
1.8.3
