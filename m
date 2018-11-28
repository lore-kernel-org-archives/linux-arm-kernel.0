From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:12:03 +0000
Subject: [PATCH 6/8] ARM: pxa/lubbock: switch PCMCIA to MAX1600 library
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxlD-0001vC-E0@rmk-PC.armlinux.org.uk>
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
 3 files changed, 37 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index fe2ef9b78602..8e24455facd8 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -136,10 +136,26 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
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
 static void lubbock_init_pcmcia(void)
 {
 	struct clk *clk;
 
+	gpiod_add_lookup_table(&sa1111_pcmcia_gpio_table);
+
 	/* Add an alias for the SA1111 PCMCIA clock */
 	clk = clk_get_sys("pxa2xx-pcmcia", NULL);
 	if (!IS_ERR(clk)) {
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 9ac3d4a68075..d687a7640f6a 100644
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
index e741f499c875..e3fc14cfb42b 100644
--- a/drivers/pcmcia/sa1111_lubbock.c
+++ b/drivers/pcmcia/sa1111_lubbock.c
@@ -24,20 +24,31 @@
 #include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/mach-types.h>
-#include <mach/lubbock.h>
 
 #include "sa1111_generic.h"
+#include "max1600.h"
+
+static int lubbock_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	struct max1600 *m;
+	int ret;
+
+	ret = max1600_init(skt->socket.dev.parent, &m,
+			   skt->nr ? MAX1600_CHAN_B : MAX1600_CHAN_A,
+			   MAX1600_CODE_HIGH);
+	if (ret == 0)
+		skt->driver_data = m;
+
+	return ret;
+}
 
 static int
 lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				const socket_state_t *state)
 {
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set, misc_mask, misc_set;
+	struct max1600 *m = skt->driver_data;
 	int ret = 0;
 
-	pa_dwr_mask = pa_dwr_set = misc_mask = misc_set = 0;
-
 	/* Lubbock uses the Maxim MAX1602, with the following connections:
 	 *
 	 * Socket 0 (PCMCIA):
@@ -71,74 +82,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
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
@@ -147,11 +91,8 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
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
@@ -175,8 +116,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 			/*
 			 * Switch to 5V,  Configure socket with 5V voltage
 			 */
-			lubbock_set_misc_wr(misc_mask, 0);
-			sa1111_set_io(s->dev, pa_dwr_mask, 0);
+			max1600_configure(m, 0, 0);
 
 			/*
 			 * It takes about 100ms to turn off Vcc.
@@ -201,6 +141,7 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
 static struct pcmcia_low_level lubbock_pcmcia_ops = {
 	.owner			= THIS_MODULE,
+	.hw_init		= lubbock_pcmcia_hw_init,
 	.configure_socket	= lubbock_pcmcia_configure_socket,
 	.first			= 0,
 	.nr			= 2,
@@ -210,17 +151,6 @@ static struct pcmcia_low_level lubbock_pcmcia_ops = {
 
 int pcmcia_lubbock_init(struct sa1111_dev *sadev)
 {
-	/*
-	 * Set GPIO_A<3:0> to be outputs for the MAX1600,
-	 * and switch to standby mode.
-	 */
-	sa1111_set_io_dir(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-	sa1111_set_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-	sa1111_set_sleep_io(sadev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-
-	/* Set CF Socket 1 power to standby mode. */
-	lubbock_set_misc_wr((1 << 15) | (1 << 14), 0);
-
 	pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
 	pxa2xx_configure_sockets(&sadev->dev, &lubbock_pcmcia_ops);
 	return sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
-- 
2.7.4
