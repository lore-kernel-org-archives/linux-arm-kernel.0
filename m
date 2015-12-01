From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Dec 2015 17:24:18 +0100
Subject: [PATCH v3 2/6] pinctrl: meson: Update pinctrl data with GPIO IRQ info
In-Reply-To: <1448987062-31225-1-git-send-email-carlo@caione.org>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
Message-ID: <1448987062-31225-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch extends the pinctrl SoC specific data adding two new
information: IRQ register and last pin number in the SoC.
These two numbers are used in the GPIO IRQ controller.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/pinctrl/meson/pinctrl-meson.h   |  6 +++++-
 drivers/pinctrl/meson/pinctrl-meson8.c  | 36 +++++++++++++++++++--------------
 drivers/pinctrl/meson/pinctrl-meson8b.c | 36 +++++++++++++++++++--------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 0fe7d53..374f4b6 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -83,6 +83,7 @@ enum meson_reg_type {
  * @first:	first pin of the bank
  * @last:	last pin of the bank
  * @regs:	array of register descriptors
+ * @irq:	input mux location for IRQs
  *
  * A bank represents a set of pins controlled by a contiguous set of
  * bits in the domain registers. The structure specifies which bits in
@@ -94,6 +95,7 @@ struct meson_bank {
 	unsigned int first;
 	unsigned int last;
 	struct meson_reg_desc regs[NUM_REG];
+	unsigned int irq;
 };
 
 /**
@@ -145,6 +147,7 @@ struct meson_pinctrl_data {
 	unsigned int num_groups;
 	unsigned int num_funcs;
 	unsigned int num_domains;
+	unsigned int last_pin;
 };
 
 struct meson_pinctrl {
@@ -192,11 +195,12 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib)		\
+#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib, i)	\
 	{								\
 		.name	= n,						\
 		.first	= f,						\
 		.last	= l,						\
+		.irq	= i,						\
 		.regs	= {						\
 			[REG_PULLEN]	= { per, peb },			\
 			[REG_PULL]	= { pr, pb },			\
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 7b1cc91..d941568 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -14,7 +14,12 @@
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	120
+#define EE_BASE		0
+#define EE_NPINS	120
+#define AO_BASE		120
+#define AO_NPINS	16
+
+#define AO_OFF		AO_BASE
 
 static const struct pinctrl_pin_desc meson8_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
@@ -907,19 +912,19 @@ static struct meson_pmx_func meson8_functions[] = {
 };
 
 static struct meson_bank meson8_banks[] = {
-	/*   name    first             last                 pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
-	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first             last                 pullen  pull    dir     out     in     irq */
+	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0, 112),
+	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0,  95),
+	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0,  65),
+	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19,  29),
+	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17,  14),
+	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22,  58),
+	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0,  39),
 };
 
 static struct meson_bank meson8_ao_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      pullen  pull    dir     out     in     irq */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0,  0),
 };
 
 static struct meson_domain_data meson8_domain_data[] = {
@@ -927,15 +932,15 @@ static struct meson_domain_data meson8_domain_data[] = {
 		.name		= "banks",
 		.banks		= meson8_banks,
 		.num_banks	= ARRAY_SIZE(meson8_banks),
-		.pin_base	= 0,
-		.num_pins	= 120,
+		.pin_base	= EE_BASE,
+		.num_pins	= EE_NPINS,
 	},
 	{
 		.name		= "ao-bank",
 		.banks		= meson8_ao_banks,
 		.num_banks	= ARRAY_SIZE(meson8_ao_banks),
-		.pin_base	= 120,
-		.num_pins	= 16,
+		.pin_base	= AO_BASE,
+		.num_pins	= AO_NPINS,
 	},
 };
 
@@ -948,4 +953,5 @@ struct meson_pinctrl_data meson8_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson8_groups),
 	.num_funcs	= ARRAY_SIZE(meson8_functions),
 	.num_domains	= ARRAY_SIZE(meson8_domain_data),
+	.last_pin	= EE_NPINS + AO_NPINS,
 };
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 9677807..c921ae3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -15,7 +15,12 @@
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	130
+#define EE_BASE		0
+#define EE_NPINS	130
+#define AO_BASE		130
+#define AO_NPINS	16
+
+#define AO_OFF		AO_BASE
 
 static const struct pinctrl_pin_desc meson8b_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
@@ -855,19 +860,19 @@ static struct meson_pmx_func meson8b_functions[] = {
 };
 
 static struct meson_bank meson8b_banks[] = {
-	/*   name    first                      last                   pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
-	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
+	/*   name    first                      last                   pullen  pull    dir     out     in     irq */
+	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0,  97),
+	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0,  80),
+	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0,  59),
+	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19,  14),
+	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22,  43),
+	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0,  24),
+	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12, 119),
 };
 
 static struct meson_bank meson8b_ao_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      pullen  pull    dir     out     in    irq */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0,  0),
 };
 
 static struct meson_domain_data meson8b_domain_data[] = {
@@ -875,15 +880,15 @@ static struct meson_domain_data meson8b_domain_data[] = {
 		.name		= "banks",
 		.banks		= meson8b_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_banks),
-		.pin_base	= 0,
-		.num_pins	= 130,
+		.pin_base	= EE_BASE,
+		.num_pins	= EE_NPINS,
 	},
 	{
 		.name		= "ao-bank",
 		.banks		= meson8b_ao_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_ao_banks),
-		.pin_base	= 130,
-		.num_pins	= 16,
+		.pin_base	= AO_BASE,
+		.num_pins	= AO_NPINS,
 	},
 };
 
@@ -896,4 +901,5 @@ struct meson_pinctrl_data meson8b_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson8b_groups),
 	.num_funcs	= ARRAY_SIZE(meson8b_functions),
 	.num_domains	= ARRAY_SIZE(meson8b_domain_data),
+	.last_pin	= EE_NPINS + AO_NPINS,
 };
-- 
2.5.0
