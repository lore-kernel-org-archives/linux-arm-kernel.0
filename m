From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:44 +0100
Subject: [PATCH 31/33] ARM: pxa/lubbock: convert PCMCIA to use MAX1600 driver
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJm8-0000ok-E7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Lubbock now provides GPIOs via gpiolib for controlling the socket
power, we can use the MAX1600 driver.  Switch Lubbock to use this
driver, which simplifies the code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/lubbock.c     |  16 ++++++
 drivers/pcmcia/Kconfig          |   1 +
 drivers/pcmcia/sa1111_lubbock.c | 110 ++++++++--------------------------------
 3 files changed, 38 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index e974d1eb0f88..8686c5d0dc3b 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -136,6 +136,20 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
 	// no D+ pullup; lubbock can't connect/disconnect in software
 };
 
+/* GPIOs for SA1111 PCMCIA */
+static struct gpiod_lookup_table sa1111_pcmcia_gpio_table = {
+	.dev_id = "1800",
+	.table = {
+		{ "sa1111", 0, "a0vpp", GPIO_ACTIVE_HIGH },
+		{ "sa1111", 1, "a1vpp", GPIO_ACTIVE_HIGH },
+		{ "sa1111", 2, "a0vcc", GPIO_ACTIVE_HIGH },
+		{ "sa1111", 3, "a1vcc", GPIO_ACTIVE_HIGH },
+		{ "lubbock", 14, "b0vcc", GPIO_ACTIVE_HIGH },
+		{ "lubbock", 15, "b1vcc", GPIO_ACTIVE_HIGH },
+		{ },
+	},
+};
+
 static struct resource sa1111_resources[] = {
 	[0] = {
 		.start	= 0x10000000,
@@ -475,6 +489,8 @@ static void __init lubbock_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&sa1111_pcmcia_gpio_table);
+
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 1441c1945088..1b4b641a1e04 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -195,6 +195,7 @@ config PCMCIA_SA1111
 	select PCMCIA_SA11XX_BASE if ARCH_SA1100
 	select PCMCIA_PXA2XX if ARCH_LUBBOCK && SA1111
 	select PCMCIA_MAX1600 if ASSABET_NEPONSET
+	select PCMCIA_MAX1600 if ARCH_LUBBOCK && SA1111
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
index c5caf5790451..9d5ffc71ae51 100644
--- a/drivers/pcmcia/sa1111_lubbock.c
+++ b/drivers/pcmcia/sa1111_lubbock.c
@@ -24,20 +24,33 @@
 #include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/mach-types.h>
-#include <mach/lubbock.h>
 
 #include "sa1111_generic.h"
+#include "max1600.h"
+
+static int lubbock_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	struct max1600 *m;
+	int ret;
+
+	ret = max1600_init(skt->socket.dev.parent, &m,
+			   skt->nr ? MAX1600_CHAN_B : MAX1600_CHAN_A,
+			   MAX1600_CODE_HIGH);
+	if (ret == 0)
+		s->driver_data = m;
+
+	return ret;
+}
 
 static int
 lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				const socket_state_t *state)
 {
 	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set, misc_mask, misc_set;
+	struct max1600 *m = s->driver_data;
 	int ret = 0;
 
-	pa_dwr_mask = pa_dwr_set = misc_mask = misc_set = 0;
-
 	/* Lubbock uses the Maxim MAX1602, with the following connections:
 	 *
 	 * Socket 0 (PCMCIA):
@@ -71,74 +84,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
  again:
 	switch (skt->nr) {
 	case 0:
-		pa_dwr_mask = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
-
-		switch (state->Vcc) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 33: /* VY */
-			pa_dwr_set |= GPIO_A3;
-			break;
-
-		case 50: /* VX */
-			pa_dwr_set |= GPIO_A2;
-			break;
-
-		default:
-			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-			       __func__, state->Vcc);
-			ret = -1;
-		}
-
-		switch (state->Vpp) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 120: /* 12IN */
-			pa_dwr_set |= GPIO_A1;
-			break;
-
-		default: /* VCC */
-			if (state->Vpp == state->Vcc)
-				pa_dwr_set |= GPIO_A0;
-			else {
-				printk(KERN_ERR "%s(): unrecognized Vpp %u\n",
-				       __func__, state->Vpp);
-				ret = -1;
-				break;
-			}
-		}
-		break;
-
 	case 1:
-		misc_mask = (1 << 15) | (1 << 14);
-
-		switch (state->Vcc) {
-		case 0: /* Hi-Z */
-			break;
-
-		case 33: /* VY */
-			misc_set |= 1 << 15;
-			break;
-
-		case 50: /* VX */
-			misc_set |= 1 << 14;
-			break;
-
-		default:
-			printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-			       __func__, state->Vcc);
-			ret = -1;
-			break;
-		}
-
-		if (state->Vpp != state->Vcc && state->Vpp != 0) {
-			printk(KERN_ERR "%s(): CF slot cannot support Vpp %u\n",
-			       __func__, state->Vpp);
-			ret = -1;
-			break;
-		}
 		break;
 
 	default:
@@ -147,11 +93,8 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
 	if (ret == 0)
 		ret = sa1111_pcmcia_configure_socket(skt, state);
-
-	if (ret == 0) {
-		lubbock_set_misc_wr(misc_mask, misc_set);
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-	}
+	if (ret == 0)
+		ret = max1600_configure(m, state->Vcc, state->Vpp);
 
 #if 1
 	if (ret == 0 && state->Vcc == 33) {
@@ -175,8 +118,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 			/*
 			 * Switch to 5V,  Configure socket with 5V voltage
 			 */
-			lubbock_set_misc_wr(misc_mask, 0);
-			sa1111_set_io(s->dev, pa_dwr_mask, 0);
+			max1600_configure(m, 0, 0);
 
 			/*
 			 * It takes about 100ms to turn off Vcc.
@@ -201,6 +143,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
 static struct pcmcia_low_level lubbock_pcmcia_ops = {
 	.owner			= THIS_MODULE,
+	.hw_init		= lubbock_pcmcia_hw_init,
 	.configure_socket	= lubbock_pcmcia_configure_socket,
 	.first			= 0,
 	.nr			= 2,
@@ -213,17 +156,6 @@ int pcmcia_lubbock_init(struct sa1111_dev *sadev)
 	int ret = -ENODEV;
 
 	if (machine_is_lubbock()) {
-		/*
-		 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-		 * and switch to standby mode.
-		 */
-		sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-		sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-		sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-
-		/* Set CF Socket 1 power to standby mode. */
-		lubbock_set_misc_wr((1 << 15) | (1 << 14), 0);
-
 		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
 		pxa2xx_configure_sockets(&sadev->dev);
 		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
-- 
2.1.0
