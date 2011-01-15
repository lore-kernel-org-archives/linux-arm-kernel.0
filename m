From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:52 +0100
Subject: [PATCH 2/8] ARM: pxa: Use gpio arrays in colibri_pcmcia driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code cleaner and
less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_colibri.c |  133 ++++++++++++++------------------------
 1 files changed, 49 insertions(+), 84 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
index c3f7219..f6a0940 100644
--- a/drivers/pcmcia/pxa2xx_colibri.c
+++ b/drivers/pcmcia/pxa2xx_colibri.c
@@ -34,14 +34,24 @@
 #define	COLIBRI320_DETECT_GPIO	81
 #define	COLIBRI320_READY_GPIO	29
 
-static struct {
-	int	reset_gpio;
-	int	ppen_gpio;
-	int	bvd1_gpio;
-	int	bvd2_gpio;
-	int	detect_gpio;
-	int	ready_gpio;
-} colibri_pcmcia_gpio;
+enum {
+	DETECT = 0,
+	READY = 1,
+	BVD1 = 2,
+	BVD2 = 3,
+	PPEN = 4,
+	RESET = 5,
+};
+
+/* Contents of this array are configured on-the-fly in init function */
+static struct gpio colibri_pcmcia_gpios[] = {
+	{ 0,	GPIOF_IN,	"PCMCIA Detect" },
+	{ 0,	GPIOF_IN,	"PCMCIA Ready" },
+	{ 0,	GPIOF_IN,	"PCMCIA BVD1" },
+	{ 0,	GPIOF_IN,	"PCMCIA BVD2" },
+	{ 0,	GPIOF_INIT_LOW,	"PCMCIA PPEN" },
+	{ 0,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
+};
 
 static struct pcmcia_irqs colibri_irqs[] = {
 	{
@@ -54,88 +64,42 @@ static int colibri_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(colibri_pcmcia_gpio.detect_gpio, "DETECT");
+	ret = gpio_request_array(colibri_pcmcia_gpios,
+				ARRAY_SIZE(colibri_pcmcia_gpios));
 	if (ret)
 		goto err1;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.detect_gpio);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(colibri_pcmcia_gpio.ready_gpio, "READY");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.ready_gpio);
-	if (ret)
-		goto err3;
 
-	ret = gpio_request(colibri_pcmcia_gpio.bvd1_gpio, "BVD1");
-	if (ret)
-		goto err3;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.bvd1_gpio);
-	if (ret)
-		goto err4;
+	colibri_irqs[0].irq = gpio_to_irq(colibri_pcmcia_gpios[DETECT].gpio);
+	skt->socket.pci_irq = gpio_to_irq(colibri_pcmcia_gpios[READY].gpio);
 
-	ret = gpio_request(colibri_pcmcia_gpio.bvd2_gpio, "BVD2");
-	if (ret)
-		goto err4;
-	ret = gpio_direction_input(colibri_pcmcia_gpio.bvd2_gpio);
-	if (ret)
-		goto err5;
-
-	ret = gpio_request(colibri_pcmcia_gpio.ppen_gpio, "PPEN");
-	if (ret)
-		goto err5;
-	ret = gpio_direction_output(colibri_pcmcia_gpio.ppen_gpio, 0);
-	if (ret)
-		goto err6;
-
-	ret = gpio_request(colibri_pcmcia_gpio.reset_gpio, "RESET");
-	if (ret)
-		goto err6;
-	ret = gpio_direction_output(colibri_pcmcia_gpio.reset_gpio, 1);
+	ret = soc_pcmcia_request_irqs(skt, colibri_irqs,
+					ARRAY_SIZE(colibri_irqs));
 	if (ret)
-		goto err7;
-
-	colibri_irqs[0].irq = gpio_to_irq(colibri_pcmcia_gpio.detect_gpio);
-	skt->socket.pci_irq = gpio_to_irq(colibri_pcmcia_gpio.ready_gpio);
+		goto err2;
 
-	return soc_pcmcia_request_irqs(skt, colibri_irqs,
-					ARRAY_SIZE(colibri_irqs));
+	return ret;
 
-err7:
-	gpio_free(colibri_pcmcia_gpio.detect_gpio);
-err6:
-	gpio_free(colibri_pcmcia_gpio.ready_gpio);
-err5:
-	gpio_free(colibri_pcmcia_gpio.bvd1_gpio);
-err4:
-	gpio_free(colibri_pcmcia_gpio.bvd2_gpio);
-err3:
-	gpio_free(colibri_pcmcia_gpio.reset_gpio);
 err2:
-	gpio_free(colibri_pcmcia_gpio.ppen_gpio);
+	gpio_free_array(colibri_pcmcia_gpios,
+			ARRAY_SIZE(colibri_pcmcia_gpios));
 err1:
 	return ret;
 }
 
 static void colibri_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(colibri_pcmcia_gpio.detect_gpio);
-	gpio_free(colibri_pcmcia_gpio.ready_gpio);
-	gpio_free(colibri_pcmcia_gpio.bvd1_gpio);
-	gpio_free(colibri_pcmcia_gpio.bvd2_gpio);
-	gpio_free(colibri_pcmcia_gpio.reset_gpio);
-	gpio_free(colibri_pcmcia_gpio.ppen_gpio);
+	gpio_free_array(colibri_pcmcia_gpios,
+			ARRAY_SIZE(colibri_pcmcia_gpios));
 }
 
 static void colibri_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 
-	state->detect = !!gpio_get_value(colibri_pcmcia_gpio.detect_gpio);
-	state->ready  = !!gpio_get_value(colibri_pcmcia_gpio.ready_gpio);
-	state->bvd1   = !!gpio_get_value(colibri_pcmcia_gpio.bvd1_gpio);
-	state->bvd2   = !!gpio_get_value(colibri_pcmcia_gpio.bvd2_gpio);
+	state->detect = !!gpio_get_value(colibri_pcmcia_gpios[DETECT].gpio);
+	state->ready  = !!gpio_get_value(colibri_pcmcia_gpios[READY].gpio);
+	state->bvd1   = !!gpio_get_value(colibri_pcmcia_gpios[BVD1].gpio);
+	state->bvd2   = !!gpio_get_value(colibri_pcmcia_gpios[BVD2].gpio);
 	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
@@ -145,9 +109,10 @@ static int
 colibri_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				const socket_state_t *state)
 {
-	gpio_set_value(colibri_pcmcia_gpio.ppen_gpio,
+	gpio_set_value(colibri_pcmcia_gpios[PPEN].gpio,
 			!(state->Vcc == 33 && state->Vpp < 50));
-	gpio_set_value(colibri_pcmcia_gpio.reset_gpio, state->flags & SS_RESET);
+	gpio_set_value(colibri_pcmcia_gpios[RESET].gpio,
+			state->flags & SS_RESET);
 	return 0;
 }
 
@@ -187,20 +152,20 @@ static int __init colibri_pcmcia_init(void)
 
 	/* Colibri PXA270 */
 	if (machine_is_colibri()) {
-		colibri_pcmcia_gpio.reset_gpio	= COLIBRI270_RESET_GPIO;
-		colibri_pcmcia_gpio.ppen_gpio	= COLIBRI270_PPEN_GPIO;
-		colibri_pcmcia_gpio.bvd1_gpio	= COLIBRI270_BVD1_GPIO;
-		colibri_pcmcia_gpio.bvd2_gpio	= COLIBRI270_BVD2_GPIO;
-		colibri_pcmcia_gpio.detect_gpio	= COLIBRI270_DETECT_GPIO;
-		colibri_pcmcia_gpio.ready_gpio	= COLIBRI270_READY_GPIO;
+		colibri_pcmcia_gpios[RESET].gpio	= COLIBRI270_RESET_GPIO;
+		colibri_pcmcia_gpios[PPEN].gpio		= COLIBRI270_PPEN_GPIO;
+		colibri_pcmcia_gpios[BVD1].gpio		= COLIBRI270_BVD1_GPIO;
+		colibri_pcmcia_gpios[BVD2].gpio		= COLIBRI270_BVD2_GPIO;
+		colibri_pcmcia_gpios[DETECT].gpio	= COLIBRI270_DETECT_GPIO;
+		colibri_pcmcia_gpios[READY].gpio	= COLIBRI270_READY_GPIO;
 	/* Colibri PXA320 */
 	} else if (machine_is_colibri320()) {
-		colibri_pcmcia_gpio.reset_gpio	= COLIBRI320_RESET_GPIO;
-		colibri_pcmcia_gpio.ppen_gpio	= COLIBRI320_PPEN_GPIO;
-		colibri_pcmcia_gpio.bvd1_gpio	= COLIBRI320_BVD1_GPIO;
-		colibri_pcmcia_gpio.bvd2_gpio	= COLIBRI320_BVD2_GPIO;
-		colibri_pcmcia_gpio.detect_gpio	= COLIBRI320_DETECT_GPIO;
-		colibri_pcmcia_gpio.ready_gpio	= COLIBRI320_READY_GPIO;
+		colibri_pcmcia_gpios[RESET].gpio	= COLIBRI320_RESET_GPIO;
+		colibri_pcmcia_gpios[PPEN].gpio		= COLIBRI320_PPEN_GPIO;
+		colibri_pcmcia_gpios[BVD1].gpio		= COLIBRI320_BVD1_GPIO;
+		colibri_pcmcia_gpios[BVD2].gpio		= COLIBRI320_BVD2_GPIO;
+		colibri_pcmcia_gpios[DETECT].gpio	= COLIBRI320_DETECT_GPIO;
+		colibri_pcmcia_gpios[READY].gpio	= COLIBRI320_READY_GPIO;
 	}
 
 	ret = platform_device_add_data(colibri_pcmcia_device,
-- 
1.7.2.3
