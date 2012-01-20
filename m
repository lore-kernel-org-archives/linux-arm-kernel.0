From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:18:10 +0000
Subject: [PATCH 03/19] PCMCIA: pxa: convert PXA socket drivers to use new
 irq/gpio management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBXu-0005hW-15@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all the PXA platform socket drivers to use the new irq/gpio
management provided by soc_common.  This relieves these drivers from
having to do anything with these GPIOs other than provide the numbers
to soc_common.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/include/mach/balloon3.h |    1 -
 drivers/pcmcia/pxa2xx_balloon3.c          |   21 ++-------
 drivers/pcmcia/pxa2xx_cm_x255.c           |   38 +++++-----------
 drivers/pcmcia/pxa2xx_cm_x270.c           |   22 ++-------
 drivers/pcmcia/pxa2xx_colibri.c           |   20 +-------
 drivers/pcmcia/pxa2xx_e740.c              |   70 +++++------------------------
 drivers/pcmcia/pxa2xx_mainstone.c         |   30 ++++++-------
 drivers/pcmcia/pxa2xx_palmld.c            |    7 +--
 drivers/pcmcia/pxa2xx_palmtc.c            |    7 +--
 drivers/pcmcia/pxa2xx_palmtx.c            |    7 +--
 drivers/pcmcia/pxa2xx_sharpsl.c           |   30 +-----------
 drivers/pcmcia/pxa2xx_stargate2.c         |   33 ++-----------
 drivers/pcmcia/pxa2xx_trizeps4.c          |   61 +++----------------------
 drivers/pcmcia/pxa2xx_viper.c             |   38 +++-------------
 drivers/pcmcia/pxa2xx_vpac270.c           |   53 +++------------------
 15 files changed, 82 insertions(+), 356 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index f02fa1e..954641e 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -174,7 +174,6 @@ enum balloon3_features {
 
 #define BALLOON3_AUX_NIRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_AUX_NIRQ)
 #define BALLOON3_CODEC_IRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_CODEC_IRQ)
-#define BALLOON3_S0_CD_IRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_S0_CD)
 
 #define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 16)
 
diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
index 22a75e6..12e38b4 100644
--- a/drivers/pcmcia/pxa2xx_balloon3.c
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -29,15 +29,6 @@
 
 #include "soc_common.h"
 
-/*
- * These are a list of interrupt sources that provokes a polled
- * check of status
- */
-static struct pcmcia_irqs irqs[] = {
-	{ 0, BALLOON3_S0_CD_IRQ, "PCMCIA0 CD" },
-	{ 0, BALLOON3_BP_NSTSCHG_IRQ, "PCMCIA0 STSCHG" },
-};
-
 static int balloon3_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	uint16_t ver;
@@ -49,12 +40,12 @@ static int balloon3_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 			ver);
 
 	skt->socket.pci_irq = BALLOON3_BP_CF_NRDY_IRQ;
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
+	skt->stat[SOC_STAT_CD].gpio = BALLOON3_GPIO_S0_CD;
+	skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
+	skt->stat[SOC_STAT_BVD1].irq = BALLOON3_BP_NSTSCHG_IRQ;
+	skt->stat[SOC_STAT_BVD1].name = "PCMCIA0 STSCHG";
 
-static void balloon3_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 }
 
 static unsigned long balloon3_pcmcia_status[2] = {
@@ -85,7 +76,6 @@ static void balloon3_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 			disable_irq(BALLOON3_BP_NSTSCHG_IRQ);
 	}
 
-	state->detect	= !gpio_get_value(BALLOON3_GPIO_S0_CD);
 	state->ready	= !!(status & BALLOON3_CF_nIRQ);
 	state->bvd1	= !!(status & BALLOON3_CF_nSTSCHG_BVD1);
 	state->bvd2	= 0;	/* not available */
@@ -106,7 +96,6 @@ static int balloon3_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 static struct pcmcia_low_level balloon3_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= balloon3_pcmcia_hw_init,
-	.hw_shutdown		= balloon3_pcmcia_hw_shutdown,
 	.socket_state		= balloon3_pcmcia_socket_state,
 	.configure_socket	= balloon3_pcmcia_configure_socket,
 	.first			= 0,
diff --git a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
index 31ab6ddf..f90e7b1 100644
--- a/drivers/pcmcia/pxa2xx_cm_x255.c
+++ b/drivers/pcmcia/pxa2xx_cm_x255.c
@@ -25,17 +25,6 @@
 #define GPIO_PCMCIA_S1_RDYINT	(8)
 #define GPIO_PCMCIA_RESET	(9)
 
-#define PCMCIA_S0_CD_VALID	gpio_to_irq(GPIO_PCMCIA_S0_CD_VALID)
-#define PCMCIA_S1_CD_VALID	gpio_to_irq(GPIO_PCMCIA_S1_CD_VALID)
-#define PCMCIA_S0_RDYINT	gpio_to_irq(GPIO_PCMCIA_S0_RDYINT)
-#define PCMCIA_S1_RDYINT	gpio_to_irq(GPIO_PCMCIA_S1_RDYINT)
-
-
-static struct pcmcia_irqs irqs[] = {
-	{ .sock = 0, .str = "PCMCIA0 CD" },
-	{ .sock = 1, .str = "PCMCIA1 CD" },
-};
-
 static int cmx255_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
@@ -43,19 +32,23 @@ static int cmx255_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		return ret;
 	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
-	skt->socket.pci_irq = skt->nr == 0 ? PCMCIA_S0_RDYINT : PCMCIA_S1_RDYINT;
-	irqs[0].irq = PCMCIA_S0_CD_VALID;
-	irqs[1].irq = PCMCIA_S1_CD_VALID;
-	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-	if (!ret)
-		gpio_free(GPIO_PCMCIA_RESET);
+	if (skt->nr == 0) {
+		skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S0_CD_VALID;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S0_RDYINT;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA0 RDY";
+	} else {
+		skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S1_CD_VALID;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA1 CD";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S1_RDYINT;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA1 RDY";
+	}
 
-	return ret;
+	return 0;
 }
 
 static void cmx255_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	gpio_free(GPIO_PCMCIA_RESET);
 }
 
@@ -63,13 +56,6 @@ static void cmx255_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
 static void cmx255_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				       struct pcmcia_state *state)
 {
-	int cd = skt->nr ? GPIO_PCMCIA_S1_CD_VALID : GPIO_PCMCIA_S0_CD_VALID;
-	int rdy = skt->nr ? GPIO_PCMCIA_S1_RDYINT : GPIO_PCMCIA_S0_RDYINT;
-
-	state->detect = !gpio_get_value(cd);
-	state->ready  = !!gpio_get_value(rdy);
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->vs_3v  = 0;
 	state->vs_Xv  = 0;
 	state->wrprot = 0;  /* not available */
diff --git a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
index 3dc7621..efb5f13 100644
--- a/drivers/pcmcia/pxa2xx_cm_x270.c
+++ b/drivers/pcmcia/pxa2xx_cm_x270.c
@@ -22,14 +22,6 @@
 #define GPIO_PCMCIA_S0_RDYINT	(82)
 #define GPIO_PCMCIA_RESET	(53)
 
-#define PCMCIA_S0_CD_VALID	gpio_to_irq(GPIO_PCMCIA_S0_CD_VALID)
-#define PCMCIA_S0_RDYINT	gpio_to_irq(GPIO_PCMCIA_S0_RDYINT)
-
-
-static struct pcmcia_irqs irqs[] = {
-	{ .sock = 0, .str = "PCMCIA0 CD" },
-};
-
 static int cmx270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
@@ -37,18 +29,16 @@ static int cmx270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		return ret;
 	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
-	skt->socket.pci_irq = PCMCIA_S0_RDYINT;
-	irqs[0].irq = PCMCIA_S0_CD_VALID;
-	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-	if (!ret)
-		gpio_free(GPIO_PCMCIA_RESET);
+	skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S0_CD_VALID;
+	skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
+	skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S0_RDYINT;
+	skt->stat[SOC_STAT_RDY].name = "PCMCIA0 RDY";
 
 	return ret;
 }
 
 static void cmx270_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	gpio_free(GPIO_PCMCIA_RESET);
 }
 
@@ -56,10 +46,6 @@ static void cmx270_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
 static void cmx270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				       struct pcmcia_state *state)
 {
-	state->detect = (gpio_get_value(GPIO_PCMCIA_S0_CD_VALID) == 0) ? 1 : 0;
-	state->ready  = (gpio_get_value(GPIO_PCMCIA_S0_RDYINT) == 0) ? 0 : 1;
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->vs_3v  = 0;
 	state->vs_Xv  = 0;
 	state->wrprot = 0;  /* not available */
diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
index c6dec57..3565169 100644
--- a/drivers/pcmcia/pxa2xx_colibri.c
+++ b/drivers/pcmcia/pxa2xx_colibri.c
@@ -53,13 +53,6 @@ static struct gpio colibri_pcmcia_gpios[] = {
 	{ 0,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
 };
 
-static struct pcmcia_irqs colibri_irqs[] = {
-	{
-		.sock = 0,
-		.str  = "PCMCIA CD"
-	},
-};
-
 static int colibri_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
@@ -69,19 +62,10 @@ static int colibri_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	if (ret)
 		goto err1;
 
-	colibri_irqs[0].irq = gpio_to_irq(colibri_pcmcia_gpios[DETECT].gpio);
 	skt->socket.pci_irq = gpio_to_irq(colibri_pcmcia_gpios[READY].gpio);
+	skt->stat[SOC_STAT_CD].irq = gpio_to_irq(colibri_pcmcia_gpios[DETECT].gpio);
+	skt->stat[SOC_STAT_CD].name = "PCMCIA CD";
 
-	ret = soc_pcmcia_request_irqs(skt, colibri_irqs,
-					ARRAY_SIZE(colibri_irqs));
-	if (ret)
-		goto err2;
-
-	return ret;
-
-err2:
-	gpio_free_array(colibri_pcmcia_gpios,
-			ARRAY_SIZE(colibri_pcmcia_gpios));
 err1:
 	return ret;
 }
diff --git a/drivers/pcmcia/pxa2xx_e740.c b/drivers/pcmcia/pxa2xx_e740.c
index 17cd2ce..24e00a5 100644
--- a/drivers/pcmcia/pxa2xx_e740.c
+++ b/drivers/pcmcia/pxa2xx_e740.c
@@ -23,52 +23,27 @@
 
 #include "soc_common.h"
 
-static struct pcmcia_irqs cd_irqs[] = {
-	{
-		.sock = 0,
-		.str  = "CF card detect"
-	},
-	{
-		.sock = 1,
-		.str  = "Wifi switch"
-	},
-};
-
 static int e740_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	if (skt->nr == 0)
-		skt->socket.pci_irq = gpio_to_irq(GPIO_E740_PCMCIA_RDY0);
-	else
-		skt->socket.pci_irq = gpio_to_irq(GPIO_E740_PCMCIA_RDY1);
-
-	cd_irqs[0].irq = gpio_to_irq(GPIO_E740_PCMCIA_CD0);
-	cd_irqs[1].irq = gpio_to_irq(GPIO_E740_PCMCIA_CD1);
-
-	return soc_pcmcia_request_irqs(skt, &cd_irqs[skt->nr], 1);
-}
+	if (skt->nr == 0) {
+		skt->stat[SOC_STAT_CD].gpio = GPIO_E740_PCMCIA_CD0;
+		skt->stat[SOC_STAT_CD].name = "CF card detect";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO_E740_PCMCIA_RDY0;
+		skt->stat[SOC_STAT_RDY].name = "CF ready";
+	} else {
+		skt->stat[SOC_STAT_CD].gpio = GPIO_E740_PCMCIA_CD1;
+		skt->stat[SOC_STAT_CD].name = "Wifi switch";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO_E740_PCMCIA_RDY1;
+		skt->stat[SOC_STAT_RDY].name = "Wifi ready";
+	}
 
-/*
- * Release all resources.
- */
-static void e740_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, &cd_irqs[skt->nr], 1);
+	return 0;
 }
 
 static void e740_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
-	if (skt->nr == 0) {
-		state->detect = gpio_get_value(GPIO_E740_PCMCIA_CD0) ? 0 : 1;
-		state->ready  = gpio_get_value(GPIO_E740_PCMCIA_RDY0) ? 1 : 0;
-	} else {
-		state->detect = gpio_get_value(GPIO_E740_PCMCIA_CD1) ? 0 : 1;
-		state->ready  = gpio_get_value(GPIO_E740_PCMCIA_RDY1) ? 1 : 0;
-	}
-
 	state->vs_3v  = 1;
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_Xv  = 0;
 }
@@ -109,32 +84,11 @@ static int e740_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-/*
- * Enable card status IRQs on (re-)initialisation.  This can
- * be called at initialisation, power management event, or
- * pcmcia event.
- */
-static void e740_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, cd_irqs, ARRAY_SIZE(cd_irqs));
-}
-
-/*
- * Disable card status IRQs on suspend.
- */
-static void e740_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_disable_irqs(skt, cd_irqs, ARRAY_SIZE(cd_irqs));
-}
-
 static struct pcmcia_low_level e740_pcmcia_ops = {
 	.owner            = THIS_MODULE,
 	.hw_init          = e740_pcmcia_hw_init,
-	.hw_shutdown      = e740_pcmcia_hw_shutdown,
 	.socket_state     = e740_pcmcia_socket_state,
 	.configure_socket = e740_pcmcia_configure_socket,
-	.socket_init      = e740_pcmcia_socket_init,
-	.socket_suspend   = e740_pcmcia_socket_suspend,
 	.nr               = 2,
 };
 
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
index aded706c..b0ea4d3 100644
--- a/drivers/pcmcia/pxa2xx_mainstone.c
+++ b/drivers/pcmcia/pxa2xx_mainstone.c
@@ -30,27 +30,26 @@
 #include "soc_common.h"
 
 
-static struct pcmcia_irqs irqs[] = {
-	{ 0, MAINSTONE_S0_CD_IRQ, "PCMCIA0 CD" },
-	{ 1, MAINSTONE_S1_CD_IRQ, "PCMCIA1 CD" },
-	{ 0, MAINSTONE_S0_STSCHG_IRQ, "PCMCIA0 STSCHG" },
-	{ 1, MAINSTONE_S1_STSCHG_IRQ, "PCMCIA1 STSCHG" },
-};
-
 static int mst_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	/*
 	 * Setup default state of GPIO outputs
 	 * before we enable them as outputs.
 	 */
-
-	skt->socket.pci_irq = (skt->nr == 0) ? MAINSTONE_S0_IRQ : MAINSTONE_S1_IRQ;
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void mst_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	if (skt->nr == 0) {
+		skt->socket.pci_irq = MAINSTONE_S0_IRQ;
+		skt->stat[SOC_STAT_CD].irq = MAINSTONE_S0_CD_IRQ;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
+		skt->stat[SOC_STAT_BVD1].irq = MAINSTONE_S0_STSCHG_IRQ;
+		skt->stat[SOC_STAT_BVD1].name = "PCMCIA0 STSCHG";
+	} else {
+		skt->socket.pci_irq = MAINSTONE_S1_IRQ;
+		skt->stat[SOC_STAT_CD].irq = MAINSTONE_S1_CD_IRQ;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA1 CD";
+		skt->stat[SOC_STAT_BVD1].irq = MAINSTONE_S1_STSCHG_IRQ;
+		skt->stat[SOC_STAT_BVD1].name = "PCMCIA1 STSCHG";
+	}
+	return 0;
 }
 
 static unsigned long mst_pcmcia_status[2];
@@ -131,7 +130,6 @@ static int mst_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 static struct pcmcia_low_level mst_pcmcia_ops __initdata = {
 	.owner			= THIS_MODULE,
 	.hw_init		= mst_pcmcia_hw_init,
-	.hw_shutdown		= mst_pcmcia_hw_shutdown,
 	.socket_state		= mst_pcmcia_socket_state,
 	.configure_socket	= mst_pcmcia_configure_socket,
 	.nr			= 2,
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 6a8e011..4bf6814 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -23,7 +23,6 @@
 static struct gpio palmld_pcmcia_gpios[] = {
 	{ GPIO_NR_PALMLD_PCMCIA_POWER,	GPIOF_INIT_LOW,	"PCMCIA Power" },
 	{ GPIO_NR_PALMLD_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
-	{ GPIO_NR_PALMLD_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
 };
 
 static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
@@ -33,7 +32,8 @@ static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	ret = gpio_request_array(palmld_pcmcia_gpios,
 				ARRAY_SIZE(palmld_pcmcia_gpios));
 
-	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMLD_PCMCIA_READY);
+	skt->stat[SOC_STAT_RDY].gpio = GPIO_NR_PALMLD_PCMCIA_READY;
+	skt->stat[SOC_STAT_RDY].name = "PCMCIA Ready";
 
 	return ret;
 }
@@ -47,9 +47,6 @@ static void palmld_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->ready  = !!gpio_get_value(GPIO_NR_PALMLD_PCMCIA_READY);
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index 9e38de7..b32d05f 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -26,7 +26,6 @@ static struct gpio palmtc_pcmcia_gpios[] = {
 	{ GPIO_NR_PALMTC_PCMCIA_POWER2,	GPIOF_INIT_LOW,	"PCMCIA Power 2" },
 	{ GPIO_NR_PALMTC_PCMCIA_POWER3,	GPIOF_INIT_LOW,	"PCMCIA Power 3" },
 	{ GPIO_NR_PALMTC_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
-	{ GPIO_NR_PALMTC_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
 	{ GPIO_NR_PALMTC_PCMCIA_PWRREADY, GPIOF_IN,	"PCMCIA Power Ready" },
 };
 
@@ -37,7 +36,8 @@ static int palmtc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	ret = gpio_request_array(palmtc_pcmcia_gpios,
 				ARRAY_SIZE(palmtc_pcmcia_gpios));
 
-	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTC_PCMCIA_READY);
+	skt->stat[SOC_STAT_RDY].gpio = GPIO_NR_PALMTC_PCMCIA_READY;
+	skt->stat[SOC_STAT_RDY].name = "PCMCIA Ready";
 
 	return ret;
 }
@@ -51,9 +51,6 @@ static void palmtc_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->ready  = !!gpio_get_value(GPIO_NR_PALMTC_PCMCIA_READY);
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index 80645a6..ee024ff 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -23,7 +23,6 @@ static struct gpio palmtx_pcmcia_gpios[] = {
 	{ GPIO_NR_PALMTX_PCMCIA_POWER1,	GPIOF_INIT_LOW,	"PCMCIA Power 1" },
 	{ GPIO_NR_PALMTX_PCMCIA_POWER2,	GPIOF_INIT_LOW,	"PCMCIA Power 2" },
 	{ GPIO_NR_PALMTX_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
-	{ GPIO_NR_PALMTX_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
 };
 
 static int palmtx_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
@@ -33,7 +32,8 @@ static int palmtx_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	ret = gpio_request_array(palmtx_pcmcia_gpios,
 				ARRAY_SIZE(palmtx_pcmcia_gpios));
 
-	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
+	skt->stat[SOC_STAT_RDY].gpio = GPIO_NR_PALMTX_PCMCIA_READY;
+	skt->stat[SOC_STAT_RDY].name = "PCMCIA Ready";
 
 	return ret;
 }
@@ -47,9 +47,6 @@ static void palmtx_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->ready  = !!gpio_get_value(GPIO_NR_PALMTX_PCMCIA_READY);
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index 69ae2fd..b066273 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -46,21 +46,9 @@ static void sharpsl_pcmcia_init_reset(struct soc_pcmcia_socket *skt)
 
 static int sharpsl_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	int ret;
-
-	/* Register interrupts */
 	if (SCOOP_DEV[skt->nr].cd_irq >= 0) {
-		struct pcmcia_irqs cd_irq;
-
-		cd_irq.sock = skt->nr;
-		cd_irq.irq  = SCOOP_DEV[skt->nr].cd_irq;
-		cd_irq.str  = SCOOP_DEV[skt->nr].cd_irq_str;
-		ret = soc_pcmcia_request_irqs(skt, &cd_irq, 1);
-
-		if (ret) {
-			printk(KERN_ERR "Request for Compact Flash IRQ failed\n");
-			return ret;
-		}
+		skt->stat[SOC_STAT_CD].irq = SCOOP_DEV[skt->nr].cd_irq;
+		skt->stat[SOC_STAT_CD].name = SCOOP_DEV[skt->nr].cd_irq_str;
 	}
 
 	skt->socket.pci_irq = SCOOP_DEV[skt->nr].irq;
@@ -68,19 +56,6 @@ static int sharpsl_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	return 0;
 }
 
-static void sharpsl_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	if (SCOOP_DEV[skt->nr].cd_irq >= 0) {
-		struct pcmcia_irqs cd_irq;
-
-		cd_irq.sock = skt->nr;
-		cd_irq.irq  = SCOOP_DEV[skt->nr].cd_irq;
-		cd_irq.str  = SCOOP_DEV[skt->nr].cd_irq_str;
-		soc_pcmcia_free_irqs(skt, &cd_irq, 1);
-	}
-}
-
-
 static void sharpsl_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				    struct pcmcia_state *state)
 {
@@ -222,7 +197,6 @@ static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 static struct pcmcia_low_level sharpsl_pcmcia_ops __initdata = {
 	.owner                  = THIS_MODULE,
 	.hw_init                = sharpsl_pcmcia_hw_init,
-	.hw_shutdown            = sharpsl_pcmcia_hw_shutdown,
 	.socket_state           = sharpsl_pcmcia_socket_state,
 	.configure_socket       = sharpsl_pcmcia_configure_socket,
 	.socket_init            = sharpsl_pcmcia_socket_init,
diff --git a/drivers/pcmcia/pxa2xx_stargate2.c b/drivers/pcmcia/pxa2xx_stargate2.c
index 6c2366b..e7c7eb5 100644
--- a/drivers/pcmcia/pxa2xx_stargate2.c
+++ b/drivers/pcmcia/pxa2xx_stargate2.c
@@ -33,10 +33,6 @@
 #define SG2_S0_GPIO_DETECT	53
 #define SG2_S0_GPIO_READY	81
 
-static struct pcmcia_irqs irqs[] = {
-	{.sock = 0, .str = "PCMCIA0 CD" },
-};
-
 static struct gpio sg2_pcmcia_gpios[] = {
 	{ SG2_S0_GPIO_RESET, GPIOF_OUT_INIT_HIGH, "PCMCIA Reset" },
 	{ SG2_S0_POWER_CTL, GPIOF_OUT_INIT_HIGH, "PCMCIA Power Ctrl" },
@@ -44,22 +40,16 @@ static struct gpio sg2_pcmcia_gpios[] = {
 
 static int sg2_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->socket.pci_irq = gpio_to_irq(SG2_S0_GPIO_READY);
-	irqs[0].irq = gpio_to_irq(SG2_S0_GPIO_DETECT);
-
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void sg2_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	skt->stat[SOC_STAT_CD].gpio = SG2_S0_GPIO_DETECT;
+	skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
+	skt->stat[SOC_STAT_RDY].gpio = SG2_S0_GPIO_READY;
+	skt->stat[SOC_STAT_RDY].name = "PCMCIA0 RDY";
+	return 0;
 }
 
 static void sg2_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				    struct pcmcia_state *state)
 {
-	state->detect = !gpio_get_value(SG2_S0_GPIO_DETECT);
-	state->ready  = !!gpio_get_value(SG2_S0_GPIO_READY);
 	state->bvd1   = 0; /* not available - battery detect on card */
 	state->bvd2   = 0; /* not available */
 	state->vs_3v  = 1; /* not available - voltage detect for card */
@@ -94,24 +84,11 @@ static int sg2_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void sg2_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void sg2_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 static struct pcmcia_low_level sg2_pcmcia_ops __initdata = {
 	.owner			= THIS_MODULE,
 	.hw_init		= sg2_pcmcia_hw_init,
-	.hw_shutdown		= sg2_pcmcia_hw_shutdown,
 	.socket_state		= sg2_pcmcia_socket_state,
 	.configure_socket	= sg2_pcmcia_configure_socket,
-	.socket_init		= sg2_pcmcia_socket_init,
-	.socket_suspend		= sg2_pcmcia_socket_suspend,
 	.nr			= 1,
 };
 
diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index 7c33f89..aeda98e 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -29,32 +29,18 @@
 
 extern void board_pcmcia_power(int power);
 
-static struct pcmcia_irqs irqs[] = {
-	{ .sock = 0, .str = "cs0_cd" }
-	/* on other baseboards we can have more inputs */
-};
-
 static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	int ret, i;
 	/* we dont have voltage/card/ready detection
 	 * so we dont need interrupts for it
 	 */
 	switch (skt->nr) {
 	case 0:
-		if (gpio_request(GPIO_PRDY, "cf_irq") < 0) {
-			pr_err("%s: sock %d unable to request gpio %d\n", __func__,
-				skt->nr, GPIO_PRDY);
-			return -EBUSY;
-		}
-		if (gpio_direction_input(GPIO_PRDY) < 0) {
-			pr_err("%s: sock %d unable to set input gpio %d\n", __func__,
-				skt->nr, GPIO_PRDY);
-			gpio_free(GPIO_PRDY);
-			return -EINVAL;
-		}
-		skt->socket.pci_irq = gpio_to_irq(GPIO_PRDY);
-		irqs[0].irq = gpio_to_irq(GPIO_PCD);
+		skt->socket.pci_irq = IRQ_GPIO(GPIO_PRDY);
+		skt->stat[SOC_STAT_CD].gpio = GPIO_PCD;
+		skt->stat[SOC_STAT_CD].name = "cs0_cd";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO_PRDY;
+		skt->stat[SOC_STAT_RDY].name = "cs0_rdy";
 		break;
 	default:
 		break;
@@ -62,39 +48,7 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	/* release the reset of this card */
 	pr_debug("%s: sock %d irq %d\n", __func__, skt->nr, skt->socket.pci_irq);
 
-	/* supplementory irqs for the socket */
-	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
-		if (irqs[i].sock != skt->nr)
-			continue;
-		if (gpio_request(irq_to_gpio(irqs[i].irq), irqs[i].str) < 0) {
-			pr_err("%s: sock %d unable to request gpio %d\n",
-				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
-			ret = -EBUSY;
-			goto error;
-		}
-		if (gpio_direction_input(irq_to_gpio(irqs[i].irq)) < 0) {
-			pr_err("%s: sock %d unable to set input gpio %d\n",
-				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
-			ret = -EINVAL;
-			goto error;
-		}
-	}
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-
-error:
-	for (; i >= 0; i--) {
-		gpio_free(irq_to_gpio(irqs[i].irq));
-	}
-	return (ret);
-}
-
-static void trizeps_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	int i;
-	/* free allocated gpio's */
-	gpio_free(GPIO_PRDY);
-	for (i = 0; i < ARRAY_SIZE(irqs); i++)
-		gpio_free(irq_to_gpio(irqs[i].irq));
+	return 0;
 }
 
 static unsigned long trizeps_pcmcia_status[2];
@@ -118,8 +72,6 @@ static void trizeps_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	switch (skt->nr) {
 	case 0:
 		/* just fill in fix states */
-		state->detect = gpio_get_value(GPIO_PCD) ? 0 : 1;
-		state->ready  = gpio_get_value(GPIO_PRDY) ? 1 : 0;
 		state->bvd1   = (status & ConXS_CFSR_BVD1) ? 1 : 0;
 		state->bvd2   = (status & ConXS_CFSR_BVD2) ? 1 : 0;
 		state->vs_3v  = (status & ConXS_CFSR_VS1) ? 0 : 1;
@@ -204,7 +156,6 @@ static void trizeps_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 static struct pcmcia_low_level trizeps_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= trizeps_pcmcia_hw_init,
-	.hw_shutdown		= trizeps_pcmcia_hw_shutdown,
 	.socket_state		= trizeps_pcmcia_socket_state,
 	.configure_socket	= trizeps_pcmcia_configure_socket,
 	.socket_init		= trizeps_pcmcia_socket_init,
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index 1064b1c..6100ef8 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -32,13 +32,6 @@
 
 static struct platform_device *arcom_pcmcia_dev;
 
-static struct pcmcia_irqs irqs[] = {
-	{
-		.sock	= 0,
-		.str	= "PCMCIA_CD",
-	},
-};
-
 static inline struct arcom_pcmcia_pdata *viper_get_pdata(void)
 {
 	return arcom_pcmcia_dev->dev.platform_data;
@@ -49,38 +42,28 @@ static int viper_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
 	unsigned long flags;
 
-	skt->socket.pci_irq = gpio_to_irq(pdata->rdy_gpio);
-	irqs[0].irq = gpio_to_irq(pdata->cd_gpio);
-
-	if (gpio_request(pdata->cd_gpio, "CF detect"))
-		goto err_request_cd;
-
-	if (gpio_request(pdata->rdy_gpio, "CF ready"))
-		goto err_request_rdy;
+	skt->stat[SOC_STAT_CD].gpio = pdata->cd_gpio;
+	skt->stat[SOC_STAT_CD].name = "PCMCIA_CD";
+	skt->stat[SOC_STAT_RDY].gpio = pdata->rdy_gpio;
+	skt->stat[SOC_STAT_RDY].name = "CF ready";
 
 	if (gpio_request(pdata->pwr_gpio, "CF power"))
 		goto err_request_pwr;
 
 	local_irq_save(flags);
 
-	if (gpio_direction_output(pdata->pwr_gpio, 0) ||
-	    gpio_direction_input(pdata->cd_gpio) ||
-	    gpio_direction_input(pdata->rdy_gpio)) {
+	if (gpio_direction_output(pdata->pwr_gpio, 0)) {
 		local_irq_restore(flags);
 		goto err_dir;
 	}
 
 	local_irq_restore(flags);
 
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 
 err_dir:
 	gpio_free(pdata->pwr_gpio);
 err_request_pwr:
-	gpio_free(pdata->rdy_gpio);
-err_request_rdy:
-	gpio_free(pdata->cd_gpio);
-err_request_cd:
 	dev_err(&arcom_pcmcia_dev->dev, "Failed to setup PCMCIA GPIOs\n");
 	return -1;
 }
@@ -92,21 +75,12 @@ static void viper_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
 	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
 
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	gpio_free(pdata->pwr_gpio);
-	gpio_free(pdata->rdy_gpio);
-	gpio_free(pdata->cd_gpio);
 }
 
 static void viper_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				      struct pcmcia_state *state)
 {
-	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
-
-	state->detect = !gpio_get_value(pdata->cd_gpio);
-	state->ready  = !!gpio_get_value(pdata->rdy_gpio);
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_3v  = 1; /* Can only apply 3.3V */
 	state->vs_Xv  = 0;
diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index 61b17d2..cf07d88 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -23,29 +23,14 @@
 #include "soc_common.h"
 
 static struct gpio vpac270_pcmcia_gpios[] = {
-	{ GPIO84_VPAC270_PCMCIA_CD,	GPIOF_IN,	"PCMCIA Card Detect" },
-	{ GPIO35_VPAC270_PCMCIA_RDY,	GPIOF_IN,	"PCMCIA Ready" },
 	{ GPIO107_VPAC270_PCMCIA_PPEN,	GPIOF_INIT_LOW,	"PCMCIA PPEN" },
 	{ GPIO11_VPAC270_PCMCIA_RESET,	GPIOF_INIT_LOW,	"PCMCIA Reset" },
 };
 
 static struct gpio vpac270_cf_gpios[] = {
-	{ GPIO17_VPAC270_CF_CD,		GPIOF_IN,	"CF Card Detect" },
-	{ GPIO12_VPAC270_CF_RDY,	GPIOF_IN,	"CF Ready" },
 	{ GPIO16_VPAC270_CF_RESET,	GPIOF_INIT_LOW,	"CF Reset" },
 };
 
-static struct pcmcia_irqs cd_irqs[] = {
-	{
-		.sock = 0,
-		.str  = "PCMCIA CD"
-	},
-	{
-		.sock = 1,
-		.str  = "CF CD"
-	},
-};
-
 static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
@@ -54,20 +39,18 @@ static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		ret = gpio_request_array(vpac270_pcmcia_gpios,
 				ARRAY_SIZE(vpac270_pcmcia_gpios));
 
-		skt->socket.pci_irq = gpio_to_irq(GPIO35_VPAC270_PCMCIA_RDY);
-		cd_irqs[0].irq = gpio_to_irq(GPIO84_VPAC270_PCMCIA_CD);
-
-		if (!ret)
-			ret = soc_pcmcia_request_irqs(skt, &cd_irqs[0], 1);
+		skt->stat[SOC_STAT_CD].gpio = GPIO84_VPAC270_PCMCIA_CD;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA CD";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO35_VPAC270_PCMCIA_RDY;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA Ready";
 	} else {
 		ret = gpio_request_array(vpac270_cf_gpios,
 				ARRAY_SIZE(vpac270_cf_gpios));
 
-		skt->socket.pci_irq = gpio_to_irq(GPIO12_VPAC270_CF_RDY);
-		cd_irqs[1].irq = gpio_to_irq(GPIO17_VPAC270_CF_CD);
-
-		if (!ret)
-			ret = soc_pcmcia_request_irqs(skt, &cd_irqs[1], 1);
+		skt->stat[SOC_STAT_CD].gpio = GPIO17_VPAC270_CF_CD;
+		skt->stat[SOC_STAT_CD].name = "CF CD";
+		skt->stat[SOC_STAT_RDY].gpio = GPIO12_VPAC270_CF_RDY;
+		skt->stat[SOC_STAT_RDY].name = "CF Ready";
 	}
 
 	return ret;
@@ -86,15 +69,6 @@ static void vpac270_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 static void vpac270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
-	if (skt->nr == 0) {
-		state->detect = !gpio_get_value(GPIO84_VPAC270_PCMCIA_CD);
-		state->ready  = !!gpio_get_value(GPIO35_VPAC270_PCMCIA_RDY);
-	} else {
-		state->detect = !gpio_get_value(GPIO17_VPAC270_CF_CD);
-		state->ready  = !!gpio_get_value(GPIO12_VPAC270_CF_RDY);
-	}
-	state->bvd1   = 1;
-	state->bvd2   = 1;
 	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
@@ -117,14 +91,6 @@ vpac270_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void vpac270_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void vpac270_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level vpac270_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
@@ -136,9 +102,6 @@ static struct pcmcia_low_level vpac270_pcmcia_ops = {
 
 	.socket_state		= vpac270_pcmcia_socket_state,
 	.configure_socket	= vpac270_pcmcia_configure_socket,
-
-	.socket_init		= vpac270_pcmcia_socket_init,
-	.socket_suspend		= vpac270_pcmcia_socket_suspend,
 };
 
 static struct platform_device *vpac270_pcmcia_device;
-- 
1.7.4.4
