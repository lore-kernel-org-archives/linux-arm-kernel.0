From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:49 +0100
Subject: [PATCH 10/10] IXP4xx: Introduce IXP4XX_GPIO_IRQ(n) macro and convert
	IXP4xx platform files.
Message-ID: <1258492549-16873-10-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/avila-pci.c         |   50 ++++++++++----------------
 arch/arm/mach-ixp4xx/coyote-pci.c        |   24 +++++-------
 arch/arm/mach-ixp4xx/dsmg600-pci.c       |   57 ++++++++++++------------------
 arch/arm/mach-ixp4xx/fsg-pci.c           |   35 ++++++++----------
 arch/arm/mach-ixp4xx/goramo_mlr.c        |   45 +++++++++++------------
 arch/arm/mach-ixp4xx/gtwx5715-pci.c      |   52 +++++++++++----------------
 arch/arm/mach-ixp4xx/include/mach/irqs.h |    4 ++-
 arch/arm/mach-ixp4xx/ixdp425-pci.c       |   46 +++++++++--------------
 arch/arm/mach-ixp4xx/nas100d-pci.c       |   50 ++++++++++----------------
 arch/arm/mach-ixp4xx/nslu2-pci.c         |   40 ++++++++------------
 10 files changed, 169 insertions(+), 234 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 14df8cf..845e1b5 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -27,49 +27,40 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
-#define AVILA_PCI_MAX_DEV	4
-#define LOFT_PCI_MAX_DEV	6
-#define AVILA_PCI_IRQ_LINES	4
+#define AVILA_MAX_DEV	4
+#define LOFT_MAX_DEV	6
+#define IRQ_LINES	4
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define AVILA_PCI_INTA_PIN	11
-#define AVILA_PCI_INTB_PIN	10
-#define AVILA_PCI_INTC_PIN	9
-#define AVILA_PCI_INTD_PIN	8
-
-#define IRQ_AVILA_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define IRQ_AVILA_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define IRQ_AVILA_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define IRQ_AVILA_PCI_INTD	IRQ_IXP4XX_GPIO8
+#define INTA		11
+#define INTB		10
+#define INTC		9
+#define INTD		8
 
 void __init avila_pci_preinit(void)
 {
-	set_irq_type(IRQ_AVILA_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_AVILA_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_AVILA_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_AVILA_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init avila_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[AVILA_PCI_IRQ_LINES] = {
-		IRQ_AVILA_PCI_INTA,
-		IRQ_AVILA_PCI_INTB,
-		IRQ_AVILA_PCI_INTC,
-		IRQ_AVILA_PCI_INTD
+	static int pci_irq_table[IRQ_LINES] = {
+		IXP4XX_GPIO_IRQ(INTA),
+		IXP4XX_GPIO_IRQ(INTB),
+		IXP4XX_GPIO_IRQ(INTC),
+		IXP4XX_GPIO_IRQ(INTD)
 	};
 
-	int irq = -1;
-
 	if (slot >= 1 &&
-	slot <= (machine_is_loft() ? LOFT_PCI_MAX_DEV : AVILA_PCI_MAX_DEV) &&
-		pin >= 1 && pin <= AVILA_PCI_IRQ_LINES) {
-		irq = pci_irq_table[(slot + pin - 2) % 4];
-	}
+	    slot <= (machine_is_loft() ? LOFT_MAX_DEV : AVILA_MAX_DEV) &&
+	    pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[(slot + pin - 2) % 4];
 
-	return irq;
+	return -1;
 }
 
 struct hw_pci avila_pci __initdata = {
@@ -89,4 +80,3 @@ int __init avila_pci_init(void)
 }
 
 subsys_initcall(avila_pci_init);
-
diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index 624f8fe..b978ea8 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -23,30 +23,26 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 
-#define COYOTE_PCI_SLOT0_DEVID	14
-#define COYOTE_PCI_SLOT1_DEVID	15
+#define SLOT0_DEVID	14
+#define SLOT1_DEVID	15
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define COYOTE_PCI_SLOT0_PIN	6
-#define COYOTE_PCI_SLOT1_PIN	11
-
-#define IRQ_COYOTE_PCI_SLOT0	IRQ_IXP4XX_GPIO6
-#define IRQ_COYOTE_PCI_SLOT1	IRQ_IXP4XX_GPIO11
+#define SLOT0_INTA	6
+#define SLOT1_INTA	11
 
 void __init coyote_pci_preinit(void)
 {
-	set_irq_type(IRQ_COYOTE_PCI_SLOT0, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_COYOTE_PCI_SLOT1, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT0_INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT1_INTA), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init coyote_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	if (slot == COYOTE_PCI_SLOT0_DEVID)
-		return IRQ_COYOTE_PCI_SLOT0;
-	else if (slot == COYOTE_PCI_SLOT1_DEVID)
-		return IRQ_COYOTE_PCI_SLOT1;
+	if (slot == SLOT0_DEVID)
+		return IXP4XX_GPIO_IRQ(SLOT0_INTA);
+	else if (slot == SLOT1_DEVID)
+		return IXP4XX_GPIO_IRQ(SLOT1_INTA);
 	else return -1;
 }
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index 29a9e41..fa70fed 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -22,53 +22,42 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#define DSMG600_PCI_MAX_DEV	4
-#define DSMG600_PCI_IRQ_LINES	3
+#define MAX_DEV		4
+#define IRQ_LINES	3
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define DSMG600_PCI_INTA_PIN	11
-#define DSMG600_PCI_INTB_PIN	10
-#define DSMG600_PCI_INTC_PIN	9
-#define DSMG600_PCI_INTD_PIN	8
-#define DSMG600_PCI_INTE_PIN	7
-#define DSMG600_PCI_INTF_PIN	6
-
-#define IRQ_DSMG600_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define IRQ_DSMG600_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define IRQ_DSMG600_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define IRQ_DSMG600_PCI_INTD	IRQ_IXP4XX_GPIO8
-#define IRQ_DSMG600_PCI_INTE	IRQ_IXP4XX_GPIO7
-#define IRQ_DSMG600_PCI_INTF	IRQ_IXP4XX_GPIO6
+#define INTA		11
+#define INTB		10
+#define INTC		9
+#define INTD		8
+#define INTE		7
+#define INTF		6
 
 void __init dsmg600_pci_preinit(void)
 {
-	set_irq_type(IRQ_DSMG600_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_DSMG600_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_DSMG600_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_DSMG600_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_DSMG600_PCI_INTE, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_DSMG600_PCI_INTF, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTE), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTF), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init dsmg600_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[DSMG600_PCI_MAX_DEV][DSMG600_PCI_IRQ_LINES] =
-	{
-		{ IRQ_DSMG600_PCI_INTE, -1, -1 },
-		{ IRQ_DSMG600_PCI_INTA, -1, -1 },
-		{ IRQ_DSMG600_PCI_INTB, IRQ_DSMG600_PCI_INTC, IRQ_DSMG600_PCI_INTD },
-		{ IRQ_DSMG600_PCI_INTF, -1, -1 },
+	static int pci_irq_table[MAX_DEV][IRQ_LINES] = {
+		{ IXP4XX_GPIO_IRQ(INTE), -1, -1 },
+		{ IXP4XX_GPIO_IRQ(INTA), -1, -1 },
+		{ IXP4XX_GPIO_IRQ(INTB), IXP4XX_GPIO_IRQ(INTC),
+		  IXP4XX_GPIO_IRQ(INTD) },
+		{ IXP4XX_GPIO_IRQ(INTF), -1, -1 },
 	};
 
-	int irq = -1;
-
-	if (slot >= 1 && slot <= DSMG600_PCI_MAX_DEV &&
-		pin >= 1 && pin <= DSMG600_PCI_IRQ_LINES)
-		irq = pci_irq_table[slot-1][pin-1];
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[slot - 1][pin - 1];
 
-	return irq;
+	return -1;
 }
 
 struct hw_pci __initdata dsmg600_pci = {
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index 2a1701b..5a810c9 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -22,40 +22,35 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#define FSG_PCI_MAX_DEV		3
-#define FSG_PCI_IRQ_LINES	3
+#define MAX_DEV		3
+#define IRQ_LINES	3
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define FSG_PCI_INTA_PIN	6
-#define FSG_PCI_INTB_PIN	7
-#define FSG_PCI_INTC_PIN	5
-#define IRQ_FSG_PCI_INTA	IRQ_IXP4XX_GPIO6
-#define IRQ_FSG_PCI_INTB	IRQ_IXP4XX_GPIO7
-#define IRQ_FSG_PCI_INTC	IRQ_IXP4XX_GPIO5
+#define INTA	6
+#define INTB	7
+#define INTC	5
 
 void __init fsg_pci_preinit(void)
 {
-	set_irq_type(IRQ_FSG_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_FSG_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_FSG_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init fsg_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[FSG_PCI_IRQ_LINES] = {
-		IRQ_FSG_PCI_INTC,
-		IRQ_FSG_PCI_INTB,
-		IRQ_FSG_PCI_INTA,
+	static int pci_irq_table[IRQ_LINES] = {
+		IXP4XX_GPIO_IRQ(INTC),
+		IXP4XX_GPIO_IRQ(INTB),
+		IXP4XX_GPIO_IRQ(INTA),
 	};
 
 	int irq = -1;
-	slot = slot - 11;
+	slot -= 11;
 
-	if (slot >= 1 && slot <= FSG_PCI_MAX_DEV &&
-	    pin >= 1 && pin <= FSG_PCI_IRQ_LINES)
-		irq = pci_irq_table[(slot - 1)];
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		irq = pci_irq_table[slot - 1];
 	printk(KERN_INFO "%s: Mapped slot %d pin %d to IRQ %d\n",
 	       __func__, slot, pin, irq);
 
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index a733b8f..1c28048 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -17,29 +17,28 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/pci.h>
 
-#define xgpio_irq(n)		(IRQ_IXP4XX_GPIO ## n)
-#define gpio_irq(n)		xgpio_irq(n)
-
 #define SLOT_ETHA		0x0B	/* IDSEL = AD21 */
 #define SLOT_ETHB		0x0C	/* IDSEL = AD20 */
 #define SLOT_MPCI		0x0D	/* IDSEL = AD19 */
 #define SLOT_NEC		0x0E	/* IDSEL = AD18 */
 
-#define IRQ_ETHA		IRQ_IXP4XX_GPIO4
-#define IRQ_ETHB		IRQ_IXP4XX_GPIO5
-#define IRQ_NEC			IRQ_IXP4XX_GPIO3
-#define IRQ_MPCI		IRQ_IXP4XX_GPIO12
-
 /* GPIO lines */
 #define GPIO_SCL		0
 #define GPIO_SDA		1
 #define GPIO_STR		2
+#define GPIO_IRQ_NEC		3
+#define GPIO_IRQ_ETHA		4
+#define GPIO_IRQ_ETHB		5
 #define GPIO_HSS0_DCD_N		6
 #define GPIO_HSS1_DCD_N		7
+#define GPIO_UART0_DCD		8
+#define GPIO_UART1_DCD		9
 #define GPIO_HSS0_CTS_N		10
 #define GPIO_HSS1_CTS_N		11
+#define GPIO_IRQ_MPCI		12
 #define GPIO_HSS1_RTS_N		13
 #define GPIO_HSS0_RTS_N		14
+/* GPIO15 is not connected */
 
 /* Control outputs from 74HC4094 */
 #define CONTROL_HSS0_CLK_INT	0
@@ -152,7 +151,7 @@ static int hss_set_clock(int port, unsigned int clock_type)
 
 static irqreturn_t hss_dcd_irq(int irq, void *pdev)
 {
-	int i, port = (irq == gpio_irq(GPIO_HSS1_DCD_N));
+	int i, port = (irq == IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N));
 	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
 	set_carrier_cb_tab[port](pdev, !i);
 	return IRQ_HANDLED;
@@ -165,9 +164,9 @@ static int hss_open(int port, void *pdev,
 	int i, irq;
 
 	if (!port)
-		irq = gpio_irq(GPIO_HSS0_DCD_N);
+		irq = IXP4XX_GPIO_IRQ(GPIO_HSS0_DCD_N);
 	else
-		irq = gpio_irq(GPIO_HSS1_DCD_N);
+		irq = IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N);
 
 	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
 	set_carrier_cb(pdev, !i);
@@ -188,8 +187,8 @@ static int hss_open(int port, void *pdev,
 
 static void hss_close(int port, void *pdev)
 {
-	free_irq(port ? gpio_irq(GPIO_HSS1_DCD_N) : gpio_irq(GPIO_HSS0_DCD_N),
-		 pdev);
+	free_irq(port ? IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N) :
+		 IXP4XX_GPIO_IRQ(GPIO_HSS0_DCD_N), pdev);
 	set_carrier_cb_tab[!!port] = NULL; /* catch bugs */
 
 	set_control(port ? CONTROL_HSS1_DTR_N : CONTROL_HSS0_DTR_N, 1);
@@ -421,8 +420,8 @@ static void __init gmlr_init(void)
 	gpio_line_config(GPIO_HSS1_RTS_N, IXP4XX_GPIO_OUT);
 	gpio_line_config(GPIO_HSS0_DCD_N, IXP4XX_GPIO_IN);
 	gpio_line_config(GPIO_HSS1_DCD_N, IXP4XX_GPIO_IN);
-	set_irq_type(gpio_irq(GPIO_HSS0_DCD_N), IRQ_TYPE_EDGE_BOTH);
-	set_irq_type(gpio_irq(GPIO_HSS1_DCD_N), IRQ_TYPE_EDGE_BOTH);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS0_DCD_N), IRQ_TYPE_EDGE_BOTH);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N), IRQ_TYPE_EDGE_BOTH);
 
 	set_control(CONTROL_HSS0_DTR_N, 1);
 	set_control(CONTROL_HSS1_DTR_N, 1);
@@ -442,10 +441,10 @@ static void __init gmlr_init(void)
 #ifdef CONFIG_PCI
 static void __init gmlr_pci_preinit(void)
 {
-	set_irq_type(IRQ_ETHA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_ETHB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NEC, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_MPCI, IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_IRQ_ETHA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_IRQ_ETHB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_IRQ_NEC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(GPIO_IRQ_MPCI), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
@@ -466,10 +465,10 @@ static void __init gmlr_pci_postinit(void)
 static int __init gmlr_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch(slot) {
-	case SLOT_ETHA:	return IRQ_ETHA;
-	case SLOT_ETHB:	return IRQ_ETHB;
-	case SLOT_NEC:	return IRQ_NEC;
-	default:	return IRQ_MPCI;
+	case SLOT_ETHA:	return IXP4XX_GPIO_IRQ(GPIO_IRQ_ETHA);
+	case SLOT_ETHB:	return IXP4XX_GPIO_IRQ(GPIO_IRQ_ETHB);
+	case SLOT_NEC:	return IXP4XX_GPIO_IRQ(GPIO_IRQ_NEC);
+	default:	return IXP4XX_GPIO_IRQ(GPIO_IRQ_MPCI);
 	}
 }
 
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 6801185..276c614 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -30,20 +30,16 @@
 #include <mach/hardware.h>
 #include <asm/mach/pci.h>
 
-#define GTWX5715_PCI_SLOT0_DEVID	0
-#define GTWX5715_PCI_SLOT0_INTA_GPIO	10
-#define GTWX5715_PCI_SLOT0_INTB_GPIO	11
-#define GTWX5715_PCI_SLOT0_INTA_IRQ	IRQ_IXP4XX_GPIO10
-#define GTWX5715_PCI_SLOT0_INTB_IRQ	IRQ_IXP4XX_GPIO11
+#define SLOT0_DEVID	0
+#define SLOT0_INTA	10
+#define SLOT0_INTB	11
 
-#define GTWX5715_PCI_SLOT1_DEVID	1
-#define GTWX5715_PCI_SLOT1_INTA_GPIO	11
-#define GTWX5715_PCI_SLOT1_INTB_GPIO	10
-#define GTWX5715_PCI_SLOT1_INTA_IRQ	IRQ_IXP4XX_GPIO11
-#define GTWX5715_PCI_SLOT1_INTB_IRQ	IRQ_IXP4XX_GPIO10
+#define SLOT1_DEVID	1
+#define SLOT1_INTA	11
+#define SLOT1_INTB	10
 
-#define GTWX5715_PCI_SLOT_COUNT		2
-#define GTWX5715_PCI_INT_PIN_COUNT	2
+#define SLOT_COUNT	2
+#define INT_PIN_COUNT	2
 
 /*
  * Slot 0 isn't actually populated with a card connector but
@@ -53,11 +49,10 @@
  */
 void __init gtwx5715_pci_preinit(void)
 {
-	set_irq_type(GTWX5715_PCI_SLOT0_INTA_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(GTWX5715_PCI_SLOT0_INTB_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(GTWX5715_PCI_SLOT1_INTA_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(GTWX5715_PCI_SLOT1_INTB_IRQ, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT0_INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT0_INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT1_INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(SLOT1_INTB), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
@@ -65,20 +60,19 @@ void __init gtwx5715_pci_preinit(void)
 static int __init gtwx5715_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int rc;
-	static int gtwx5715_irqmap
-			[GTWX5715_PCI_SLOT_COUNT]
-			[GTWX5715_PCI_INT_PIN_COUNT] = {
-	{GTWX5715_PCI_SLOT0_INTA_IRQ, GTWX5715_PCI_SLOT0_INTB_IRQ},
-	{GTWX5715_PCI_SLOT1_INTA_IRQ, GTWX5715_PCI_SLOT1_INTB_IRQ},
-};
+	static int gtwx5715_irqmap[SLOT_COUNT][INT_PIN_COUNT] = {
+		{IXP4XX_GPIO_IRQ(SLOT0_INTA), IXP4XX_GPIO_IRQ(SLOT0_INTB)},
+		{IXP4XX_GPIO_IRQ(SLOT1_INTA), IXP4XX_GPIO_IRQ(SLOT1_INTB)},
+	};
 
-	if (slot >= GTWX5715_PCI_SLOT_COUNT ||
-			pin >= GTWX5715_PCI_INT_PIN_COUNT) rc = -1;
+	if (slot >= SLOT_COUNT || pin >= INT_PIN_COUNT)
+		rc = -1;
 	else
-		rc = gtwx5715_irqmap[slot][pin-1];
+		rc = gtwx5715_irqmap[slot][pin - 1];
 
-	printk("%s: Mapped slot %d pin %d to IRQ %d\n", __func__, slot, pin, rc);
-	return(rc);
+	printk(KERN_INFO "%s: Mapped slot %d pin %d to IRQ %d\n",
+	       __func__, slot, pin, rc);
+	return rc;
 }
 
 struct hw_pci gtwx5715_pci __initdata = {
@@ -93,9 +87,7 @@ struct hw_pci gtwx5715_pci __initdata = {
 int __init gtwx5715_pci_init(void)
 {
 	if (machine_is_gtwx5715())
-	{
 		pci_common_init(&gtwx5715_pci);
-	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index dbc20bf..7e6d4cc 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -15,7 +15,6 @@
 #ifndef _ARCH_IXP4XX_IRQS_H_
 #define _ARCH_IXP4XX_IRQS_H_
 
-
 #define IRQ_IXP4XX_NPEA		0
 #define IRQ_IXP4XX_NPEB		1
 #define IRQ_IXP4XX_NPEC		2
@@ -59,6 +58,9 @@
 #define IRQ_IXP4XX_MCU_ECC	61
 #define IRQ_IXP4XX_EXP_PE	62
 
+#define _IXP4XX_GPIO_IRQ(n)	(IRQ_IXP4XX_GPIO ## n)
+#define IXP4XX_GPIO_IRQ(n)	_IXP4XX_GPIO_IRQ(n)
+
 /*
  * Only first 32 sources are valid if running on IXP42x systems
  */
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index dc8b588..1ba165a 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -24,47 +24,38 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
-#define IXDP425_PCI_MAX_DEV	4
-#define IXDP425_PCI_IRQ_LINES	4
+#define MAX_DEV		4
+#define IRQ_LINES	4
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define IXDP425_PCI_INTA_PIN	11
-#define IXDP425_PCI_INTB_PIN	10
-#define IXDP425_PCI_INTC_PIN	9
-#define IXDP425_PCI_INTD_PIN	8
+#define INTA		11
+#define INTB		10
+#define INTC		9
+#define INTD		8
 
-#define IRQ_IXDP425_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define IRQ_IXDP425_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define IRQ_IXDP425_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define IRQ_IXDP425_PCI_INTD	IRQ_IXP4XX_GPIO8
 
 void __init ixdp425_pci_preinit(void)
 {
-	set_irq_type(IRQ_IXDP425_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_IXDP425_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_IXDP425_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_IXDP425_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init ixdp425_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[IXDP425_PCI_IRQ_LINES] = {
-		IRQ_IXDP425_PCI_INTA,
-		IRQ_IXDP425_PCI_INTB,
-		IRQ_IXDP425_PCI_INTC,
-		IRQ_IXDP425_PCI_INTD
+	static int pci_irq_table[IRQ_LINES] = {
+		IXP4XX_GPIO_IRQ(INTA),
+		IXP4XX_GPIO_IRQ(INTB),
+		IXP4XX_GPIO_IRQ(INTC),
+		IXP4XX_GPIO_IRQ(INTD)
 	};
 
-	int irq = -1;
-
-	if (slot >= 1 && slot <= IXDP425_PCI_MAX_DEV && 
-		pin >= 1 && pin <= IXDP425_PCI_IRQ_LINES) {
-		irq = pci_irq_table[(slot + pin - 2) % 4];
-	}
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[(slot + pin - 2) % 4];
 
-	return irq;
+	return -1;
 }
 
 struct hw_pci ixdp425_pci __initdata = {
@@ -85,4 +76,3 @@ int __init ixdp425_pci_init(void)
 }
 
 subsys_initcall(ixdp425_pci_init);
-
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index ac04fc1..d0cea34 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -21,49 +21,39 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#define NAS100D_PCI_MAX_DEV	3
-#define NAS100D_PCI_IRQ_LINES	3
+#define MAX_DEV		3
+#define IRQ_LINES	3
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define NAS100D_PCI_INTA_PIN	11
-#define NAS100D_PCI_INTB_PIN	10
-#define NAS100D_PCI_INTC_PIN	9
-#define NAS100D_PCI_INTD_PIN	8
-#define NAS100D_PCI_INTE_PIN	7
-
-#define IRQ_NAS100D_PCI_INTA    IRQ_IXP4XX_GPIO11
-#define IRQ_NAS100D_PCI_INTB    IRQ_IXP4XX_GPIO10
-#define IRQ_NAS100D_PCI_INTC    IRQ_IXP4XX_GPIO9
-#define IRQ_NAS100D_PCI_INTD    IRQ_IXP4XX_GPIO8
-#define IRQ_NAS100D_PCI_INTE    IRQ_IXP4XX_GPIO7
+#define INTA		11
+#define INTB		10
+#define INTC		9
+#define INTD		8
+#define INTE		7
 
 void __init nas100d_pci_preinit(void)
 {
-	set_irq_type(IRQ_NAS100D_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NAS100D_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NAS100D_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NAS100D_PCI_INTD, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NAS100D_PCI_INTE, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTD), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTE), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init nas100d_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[NAS100D_PCI_MAX_DEV][NAS100D_PCI_IRQ_LINES] =
-	{
-		{ IRQ_NAS100D_PCI_INTA, -1, -1 },
-		{ IRQ_NAS100D_PCI_INTB, -1, -1 },
-		{ IRQ_NAS100D_PCI_INTC, IRQ_NAS100D_PCI_INTD, IRQ_NAS100D_PCI_INTE },
+	static int pci_irq_table[MAX_DEV][IRQ_LINES] = {
+		{ IXP4XX_GPIO_IRQ(INTA), -1, -1 },
+		{ IXP4XX_GPIO_IRQ(INTB), -1, -1 },
+		{ IXP4XX_GPIO_IRQ(INTC), IXP4XX_GPIO_IRQ(INTD),
+		  IXP4XX_GPIO_IRQ(INTE) },
 	};
 
-	int irq = -1;
-
-	if (slot >= 1 && slot <= NAS100D_PCI_MAX_DEV &&
-		pin >= 1 && pin <= NAS100D_PCI_IRQ_LINES)
-		irq = pci_irq_table[slot-1][pin-1];
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[slot - 1][pin - 1];
 
-	return irq;
+	return -1;
 }
 
 struct hw_pci __initdata nas100d_pci = {
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index 9665bb0..1eb5a90 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -21,43 +21,35 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#define NSLU2_PCI_MAX_DEV	3
-#define NSLU2_PCI_IRQ_LINES	3
+#define MAX_DEV		3
+#define IRQ_LINES	3
 
 /* PCI controller GPIO to IRQ pin mappings */
-#define NSLU2_PCI_INTA_PIN	11
-#define NSLU2_PCI_INTB_PIN	10
-#define NSLU2_PCI_INTC_PIN	9
-#define NSLU2_PCI_INTD_PIN	8
-#define IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
-#define IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
-#define IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9
+#define INTA		11
+#define INTB		10
+#define INTC		9
+#define INTD		8
 
 void __init nslu2_pci_preinit(void)
 {
-	set_irq_type(IRQ_NSLU2_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NSLU2_PCI_INTB, IRQ_TYPE_LEVEL_LOW);
-	set_irq_type(IRQ_NSLU2_PCI_INTC, IRQ_TYPE_LEVEL_LOW);
-
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTC), IRQ_TYPE_LEVEL_LOW);
 	ixp4xx_pci_preinit();
 }
 
 static int __init nslu2_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static int pci_irq_table[NSLU2_PCI_IRQ_LINES] = {
-		IRQ_NSLU2_PCI_INTA,
-		IRQ_NSLU2_PCI_INTB,
-		IRQ_NSLU2_PCI_INTC,
+	static int pci_irq_table[IRQ_LINES] = {
+		IXP4XX_GPIO_IRQ(INTA),
+		IXP4XX_GPIO_IRQ(INTB),
+		IXP4XX_GPIO_IRQ(INTC),
 	};
 
-	int irq = -1;
-
-	if (slot >= 1 && slot <= NSLU2_PCI_MAX_DEV &&
-		pin >= 1 && pin <= NSLU2_PCI_IRQ_LINES) {
-			irq = pci_irq_table[(slot + pin - 2) % NSLU2_PCI_IRQ_LINES];
-	}
+	if (slot >= 1 && slot <= MAX_DEV && pin >= 1 && pin <= IRQ_LINES)
+		return pci_irq_table[(slot + pin - 2) % IRQ_LINES];
 
-	return irq;
+	return -1;
 }
 
 struct hw_pci __initdata nslu2_pci = {
-- 
1.6.5.2
