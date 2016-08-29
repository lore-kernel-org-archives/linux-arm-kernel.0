From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:34 +0100
Subject: [PATCH 29/33] pcmcia: sa1111/neponset: convert to use MAX1600 power
 driver
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJly-0000oX-6W@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the MAX1600 power switch driver for Neponset.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/Kconfig           |  1 +
 drivers/pcmcia/sa1111_neponset.c | 79 ++++++++++------------------------------
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 8ac7f9f270c8..1441c1945088 100644
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
index 1d78739c4c07..30a1602dd984 100644
--- a/drivers/pcmcia/sa1111_neponset.c
+++ b/drivers/pcmcia/sa1111_neponset.c
@@ -9,12 +9,10 @@
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
@@ -39,70 +37,38 @@
  * "Standard Intel code" mode. Refer to the Maxim data sheet for
  * the corresponding truth table.
  */
-
-static int
-neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
+static int neponset_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	struct sa1111_pcmcia_socket *s = to_skt(skt);
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
+	ret = max1600_init(skt->socket.dev.parent, &m,
+			   skt->nr ? MAX1600_CHAN_B : MAX1600_CHAN_A,
+			   MAX1600_CODE_LOW);
+	if (ret == 0)
+		s->driver_data = m;
 
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
-
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
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	struct max1600 *m = s->driver_data;
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
@@ -113,13 +79,6 @@ int pcmcia_neponset_init(struct sa1111_dev *sadev)
 	int ret = -ENODEV;
 
 	if (machine_is_assabet()) {
-		/*
-		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-		 * and switch to standby mode.
-		 */
-		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
 		sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
 		ret = sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
 				sa11xx_drv_pcmcia_add_one);
-- 
2.1.0
