From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 4 Jan 2010 10:14:51 +0800
Subject: [ARM] pxa: use chip->ack() instead of accessing GEDR directly
Message-ID: <f17812d71001031814p52e99b6bhbcafd35c71439c47@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] pxa: use chip->ack() instead of accessing GEDR directly

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 7873fa3..161fc2d 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -59,7 +59,7 @@ void __init cmx2xx_pci_adjust_zones(int node,
unsigned long *zone_size,
 static void cmx2xx_it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	/* clear our parent irq */
-	GEDR(cmx2xx_it8152_irq_gpio) = GPIO_bit(cmx2xx_it8152_irq_gpio);
+	desc->chip->ack(irq);

 	it8152_irq_demux(irq, desc);
 }
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 1373c22..c87abc3 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -121,7 +121,7 @@ static void lpd270_irq_handler(unsigned int irq,
struct irq_desc *desc)

 	pending = __raw_readw(LPD270_INT_STATUS) & lpd270_irq_enabled;
 	do {
-		GEDR(0) = GPIO_bit(0);  /* clear useless edge notification */
+		desc->chip->ack(irq);	/* clear useless edge notification */
 		if (likely(pending)) {
 			irq = LPD270_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 98ee7e5..d9982b1 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -158,7 +158,7 @@ static void lubbock_irq_handler(unsigned int irq,
struct irq_desc *desc)
 {
 	unsigned long pending = LUB_IRQ_SET_CLR & lubbock_irq_enabled;
 	do {
-		GEDR(0) = GPIO_bit(0);	/* clear our parent irq */
+		desc->chip->ack(irq);	/* clear our parent irq */
 		if (likely(pending)) {
 			irq = LUBBOCK_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 851ee0f..a8674aa 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -162,7 +162,7 @@ static void mainstone_irq_handler(unsigned int
irq, struct irq_desc *desc)
 {
 	unsigned long pending = MST_INTSETCLR & mainstone_irq_enabled;
 	do {
-		GEDR(0) = GPIO_bit(0);  /* clear useless edge notification */
+		desc->chip->ack(irq);	/* clear useless edge notification */
 		if (likely(pending)) {
 			irq = MAINSTONE_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c
b/arch/arm/mach-pxa/pcm990-baseboard.c
index d5255ae..e74bdfc 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -259,8 +259,7 @@ static void pcm990_irq_handler(unsigned int irq,
struct irq_desc *desc)
 	unsigned long pending = (~PCM990_INTSETCLR) & pcm990_irq_enabled;

 	do {
-		GEDR(PCM990_CTRL_INT_IRQ_GPIO) =
-					GPIO_bit(PCM990_CTRL_INT_IRQ_GPIO);
+		desc->chip->ack(irq);	/* clear our parent IRQ */
 		if (likely(pending)) {
 			irq = PCM027_IRQ(0) + __ffs(pending);
 			generic_handle_irq(irq);
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 5352b4e..886b13a 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -281,7 +281,7 @@ static void viper_irq_handler(unsigned int irq,
struct irq_desc *desc)
 	do {
 		/* we're in a chained irq handler,
 		 * so ack the interrupt by hand */
-		GEDR(VIPER_CPLD_GPIO) = GPIO_bit(VIPER_CPLD_GPIO);
+		desc->chip->ack(irq);

 		if (likely(pending)) {
 			irq = viper_bit_to_irq(__ffs(pending));
