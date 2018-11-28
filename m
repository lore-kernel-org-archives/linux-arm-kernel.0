From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:11:53 +0000
Subject: [PATCH 4/8] ARM: sa1100/neponset: switch PCMCIA to MAX1600 library
 and gpiod APIs
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxl3-0001ui-2y@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Neponset to use the gpiod API to specify which GPIOs are used
for PCMCIA, and use the MAX1600 power switch library for Neponset,
simplifying the neponset pcmcia driver as a result.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c  | 19 ++++++++++
 drivers/pcmcia/Kconfig           |  1 +
 drivers/pcmcia/sa1111_neponset.c | 79 +++++++++-------------------------------
 3 files changed, 38 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index b1823f445358..eb60a71cf125 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/gpio-reg.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -96,6 +97,19 @@ struct neponset_drvdata {
 	struct gpio_chip *gpio[4];
 };
 
+static struct gpiod_lookup_table neponset_pcmcia_table = {
+	.dev_id = "1800",
+	.table = {
+		GPIO_LOOKUP("sa1111", 1, "a0vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 0, "a1vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("neponset-ncr", 5, "a0vpp", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("neponset-ncr", 6, "a1vpp", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 2, "b0vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 3, "b1vcc", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct neponset_drvdata *nep;
 
 void neponset_ncr_frob(unsigned int mask, unsigned int val)
@@ -374,6 +388,8 @@ static int neponset_probe(struct platform_device *dev)
 			   d->base + AUD_CTL, AUD_NGPIO, false,
 			   neponset_aud_names);
 
+	gpiod_add_lookup_table(&neponset_pcmcia_table);
+
 	/*
 	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
 	 * something on the Neponset activates this IRQ on sleep (eth?)
@@ -424,6 +440,9 @@ static int neponset_remove(struct platform_device *dev)
 		platform_device_unregister(d->sa1111);
 	if (!IS_ERR(d->smc91x))
 		platform_device_unregister(d->smc91x);
+
+	gpiod_remove_lookup_table(&neponset_pcmcia_table);
+
 	irq_set_chained_handler(irq, NULL);
 	irq_free_descs(d->irq_base, NEP_IRQ_NR);
 	nep = NULL;
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 1a257a323923..8e8db3aa9fce 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -194,6 +194,7 @@ config PCMCIA_SA1111
 	select PCMCIA_SOC_COMMON
 	select PCMCIA_SA11XX_BASE if ARCH_SA1100
 	select PCMCIA_PXA2XX if ARCH_LUBBOCK && SA1111
+	select PCMCIA_MAX1600 if ASSABET_NEPONSET
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
diff --git a/drivers/pcmcia/sa1111_neponset.c b/drivers/pcmcia/sa1111_neponset.c
index 0ccf05a28a4b..de0ce13355b4 100644
--- a/drivers/pcmcia/sa1111_neponset.c
+++ b/drivers/pcmcia/sa1111_neponset.c
@@ -10,12 +10,10 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <mach/neponset.h>
-#include <asm/hardware/sa1111.h>
 
 #include "sa1111_generic.h"
+#include "max1600.h"
 
 /*
  * Neponset uses the Maxim MAX1600, with the following connections:
@@ -40,70 +38,36 @@
  * "Standard Intel code" mode. Refer to the Maxim data sheet for
  * the corresponding truth table.
  */
-
-static int
-neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+static int neponset_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int ncr_mask, ncr_set, pa_dwr_mask, pa_dwr_set;
+	struct max1600 *m;
 	int ret;
 
-	switch (skt->nr) {
-	case 0:
-		pa_dwr_mask = GPIO_A0 | GPIO_A1;
-		ncr_mask = NCR_A0VPP | NCR_A1VPP;
-
-		if (state->Vpp == 0)
-			ncr_set = 0;
-		else if (state->Vpp == 120)
-			ncr_set = NCR_A1VPP;
-		else if (state->Vpp == state->Vcc)
-			ncr_set = NCR_A0VPP;
-		else {
-			printk(KERN_ERR "%s(): unrecognized VPP %u\n",
-			       __func__, state->Vpp);
-			return -1;
-		}
-		break;
-
-	case 1:
-		pa_dwr_mask = GPIO_A2 | GPIO_A3;
-		ncr_mask = 0;
-		ncr_set = 0;
-
-		if (state->Vpp != state->Vcc && state->Vpp != 0) {
-			printk(KERN_ERR "%s(): CF slot cannot support VPP %u\n",
-			       __func__, state->Vpp);
-			return -1;
-		}
-		break;
+	ret = max1600_init(skt->socket.dev.parent, &m,
+			   skt->nr ? MAX1600_CHAN_B : MAX1600_CHAN_A,
+			   MAX1600_CODE_LOW);
+	if (ret == 0)
+		skt->driver_data = m;
 
-	default:
-		return -1;
-	}
+	return ret;
+}
 
-	/*
-	 * pa_dwr_set is the mask for selecting Vcc on both sockets.
-	 * pa_dwr_mask selects which bits (and therefore socket) we change.
-	 */
-	switch (state->Vcc) {
-	default:
-	case 0:  pa_dwr_set = 0;		break;
-	case 33: pa_dwr_set = GPIO_A1|GPIO_A2;	break;
-	case 50: pa_dwr_set = GPIO_A0|GPIO_A3;	break;
-	}
+static int
+neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+{
+	struct max1600 *m = skt->driver_data;
+	int ret;
 
 	ret = sa1111_pcmcia_configure_socket(skt, state);
-	if (ret == 0) {
-		neponset_ncr_frob(ncr_mask, ncr_set);
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-	}
+	if (ret == 0)
+		ret = max1600_configure(m, state->Vcc, state->Vpp);
 
 	return ret;
 }
 
 static struct pcmcia_low_level neponset_pcmcia_ops = {
 	.owner			= THIS_MODULE,
+	.hw_init		= neponset_pcmcia_hw_init,
 	.configure_socket	= neponset_pcmcia_configure_socket,
 	.first			= 0,
 	.nr			= 2,
@@ -111,13 +75,6 @@ static struct pcmcia_low_level neponset_pcmcia_ops = {
 
 int pcmcia_neponset_init(struct sa1111_dev *sadev)
 {
-	/*
-	 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-	 * and switch to standby mode.
-	 */
-	sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-	sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-	sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
 	sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
 	return sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
 				 sa11xx_drv_pcmcia_add_one);
-- 
2.7.4
