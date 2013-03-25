From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 25 Mar 2013 22:31:34 +0100
Subject: [PATCH v5 5/7] irqchip: s3c24xx: globally keep track of the created
 intc instances
In-Reply-To: <201303252226.21402.heiko@sntech.de>
References: <201303252226.21402.heiko@sntech.de>
Message-ID: <201303252231.34833.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For dt-enabled machines we want to use a big irq_domain over all controllers
and therefore need to access not only the main controllers but the
sub-controller as well.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |   99 +++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 7cba4f0..9914abd 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -69,6 +69,14 @@ struct s3c_irq_intc {
 	struct s3c_irq_data	*irqs;
 };
 
+/*
+ * Array holding pointers to the global controller structs
+ * [0] ... main_intc
+ * [1] ... sub_intc
+ * [2] ... main_intc2 on s3c2416
+ */
+static struct s3c_irq_intc *s3c_intc[3];
+
 static void s3c_irq_mask(struct irq_data *data)
 {
 	struct s3c_irq_intc *intc = data->domain->host_data;
@@ -307,9 +315,6 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static struct s3c_irq_intc *main_intc;
-static struct s3c_irq_intc *main_intc2;
-
 static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 				      struct pt_regs *regs)
 {
@@ -345,12 +350,12 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
 {
 	do {
-		if (likely(main_intc))
-			if (s3c24xx_handle_intc(main_intc, regs))
+		if (likely(s3c_intc[0]))
+			if (s3c24xx_handle_intc(s3c_intc[0], regs))
 				continue;
 
-		if (main_intc2)
-			if (s3c24xx_handle_intc(main_intc2, regs))
+		if (s3c_intc[2])
+			if (s3c24xx_handle_intc(s3c_intc[2], regs))
 				continue;
 
 		break;
@@ -577,11 +582,6 @@ static struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 		goto err;
 	}
 
-	if (address == 0x4a000000)
-		main_intc = intc;
-	else if (address == 0x4a000040)
-		main_intc2 = intc;
-
 	set_handle_irq(s3c24xx_handle_irq);
 
 	return intc;
@@ -670,20 +670,20 @@ static struct s3c_irq_data init_s3c2410subint[32] = {
 
 void __init s3c2410_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2410base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2410base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_s3c2410subint[0], main_intc, 0x4a000018);
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2410subint[0],
+					s3c_intc[0], 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], s3c_intc[0], 0x560000a4);
 }
 #endif
 
@@ -770,22 +770,22 @@ static struct s3c_irq_data init_s3c2412subint[32] = {
 
 void s3c2412_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 	pr_info("S3C2412: IRQ Support\n");
 
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2412base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2412base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_s3c2412eint[0], main_intc, 0x560000a4);
-	s3c24xx_init_intc(NULL, &init_s3c2412subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_s3c2412eint[0], s3c_intc[0], 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2412subint[0],
+					s3c_intc[0], 0x4a000018);
 }
 #endif
 
@@ -869,24 +869,25 @@ static struct s3c_irq_data init_s3c2416_second[32] = {
 
 void __init s3c2416_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 	pr_info("S3C2416: IRQ Support\n");
 
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2416base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2416base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
-	s3c24xx_init_intc(NULL, &init_s3c2416subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], s3c_intc[0], 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2416subint[0],
+					s3c_intc[0], 0x4a000018);
 
-	s3c24xx_init_intc(NULL, &init_s3c2416_second[0], NULL, 0x4a000040);
+	s3c_intc[2] = s3c24xx_init_intc(NULL, &init_s3c2416_second[0],
+					NULL, 0x4a000040);
 }
 
 #endif
@@ -947,22 +948,22 @@ static struct s3c_irq_data init_s3c2440subint[32] = {
 
 void __init s3c2440_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 	pr_info("S3C2440: IRQ Support\n");
 
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2440base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2440base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
-	s3c24xx_init_intc(NULL, &init_s3c2440subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], s3c_intc[0], 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2440subint[0],
+					s3c_intc[0], 0x4a000018);
 }
 #endif
 
@@ -1020,22 +1021,22 @@ static struct s3c_irq_data init_s3c2442subint[32] = {
 
 void __init s3c2442_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 	pr_info("S3C2442: IRQ Support\n");
 
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2442base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2442base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
-	s3c24xx_init_intc(NULL, &init_s3c2442subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], s3c_intc[0], 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2442subint[0],
+					s3c_intc[0], 0x4a000018);
 }
 #endif
 
@@ -1110,21 +1111,21 @@ static struct s3c_irq_data init_s3c2443subint[32] = {
 
 void __init s3c2443_init_irq(void)
 {
-	struct s3c_irq_intc *main_intc;
-
 	pr_info("S3C2443: IRQ Support\n");
 
 #ifdef CONFIG_FIQ
 	init_FIQ(FIQ_START);
 #endif
 
-	main_intc = s3c24xx_init_intc(NULL, &init_s3c2443base[0], NULL, 0x4a000000);
-	if (IS_ERR(main_intc)) {
+	s3c_intc[0] = s3c24xx_init_intc(NULL, &init_s3c2443base[0], NULL,
+					0x4a000000);
+	if (IS_ERR(s3c_intc[0])) {
 		pr_err("irq: could not create main interrupt controller\n");
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
-	s3c24xx_init_intc(NULL, &init_s3c2443subint[0], main_intc, 0x4a000018);
+	s3c24xx_init_intc(NULL, &init_eint[0], s3c_intc[0], 0x560000a4);
+	s3c_intc[1] = s3c24xx_init_intc(NULL, &init_s3c2443subint[0],
+					s3c_intc[0], 0x4a000018);
 }
 #endif
-- 
1.7.10.4
