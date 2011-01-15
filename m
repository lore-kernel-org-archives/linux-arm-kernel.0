From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:53 +0100
Subject: [PATCH 3/8] ARM: pxa: Use gpio arrays in palmld_pcmcia driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code
cleaner and less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_palmld.c |   40 +++++++++-------------------------------
 1 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 6fb6f7f..59f8405 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -20,49 +20,27 @@
 #include <mach/palmld.h>
 #include "soc_common.h"
 
+static struct gpio palmld_pcmcia_gpios[] = {
+	{ GPIO_NR_PALMLD_PCMCIA_POWER,	GPIOF_INIT_LOW,	"PCMCIA Power" },
+	{ GPIO_NR_PALMLD_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
+	{ GPIO_NR_PALMLD_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
+};
+
 static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_POWER, "PCMCIA PWR");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_POWER, 0);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_RESET, "PCMCIA RST");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMLD_PCMCIA_RESET, 1);
-	if (ret)
-		goto err3;
-
-	ret = gpio_request(GPIO_NR_PALMLD_PCMCIA_READY, "PCMCIA RDY");
-	if (ret)
-		goto err3;
-	ret = gpio_direction_input(GPIO_NR_PALMLD_PCMCIA_READY);
-	if (ret)
-		goto err4;
+	ret = gpio_request_array(palmld_pcmcia_gpios,
+				ARRAY_SIZE(palmld_pcmcia_gpios));
 
 	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
-	return 0;
 
-err4:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_READY);
-err3:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_RESET);
-err2:
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_POWER);
-err1:
 	return ret;
 }
 
 static void palmld_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_READY);
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_RESET);
-	gpio_free(GPIO_NR_PALMLD_PCMCIA_POWER);
+	gpio_free_array(palmld_pcmcia_gpios, ARRAY_SIZE(palmld_pcmcia_gpios));
 }
 
 static void palmld_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-- 
1.7.2.3
