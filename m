From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:54 +0100
Subject: [PATCH 4/8] ARM: pxa: Use gpio arrays in palmtc_pcmcia driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-4-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code
cleaner and less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_palmtc.c |   73 ++++++---------------------------------
 1 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index 459a232..e655af9 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -21,79 +21,30 @@
 #include <mach/palmtc.h>
 #include "soc_common.h"
 
+static struct gpio palmtc_pcmcia_gpios[] = {
+	{ GPIO_NR_PALMTC_PCMCIA_POWER1,	GPIOF_INIT_LOW,	"PCMCIA Power 1" },
+	{ GPIO_NR_PALMTC_PCMCIA_POWER2,	GPIOF_INIT_LOW,	"PCMCIA Power 2" },
+	{ GPIO_NR_PALMTC_PCMCIA_POWER3,	GPIOF_INIT_LOW,	"PCMCIA Power 3" },
+	{ GPIO_NR_PALMTC_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
+	{ GPIO_NR_PALMTC_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
+	{ GPIO_NR_PALMTC_PCMCIA_PWRREADY, GPIOF_IN,	"PCMCIA Power Ready" },
+};
+
 static int palmtc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER1, "PCMCIA PWR1");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER1, 0);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER2, "PCMCIA PWR2");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER2, 0);
-	if (ret)
-		goto err3;
-
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_POWER3, "PCMCIA PWR3");
-	if (ret)
-		goto err3;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_POWER3, 0);
-	if (ret)
-		goto err4;
-
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_RESET, "PCMCIA RST");
-	if (ret)
-		goto err4;
-	ret = gpio_direction_output(GPIO_NR_PALMTC_PCMCIA_RESET, 1);
-	if (ret)
-		goto err5;
-
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_READY, "PCMCIA RDY");
-	if (ret)
-		goto err5;
-	ret = gpio_direction_input(GPIO_NR_PALMTC_PCMCIA_READY);
-	if (ret)
-		goto err6;
-
-	ret = gpio_request(GPIO_NR_PALMTC_PCMCIA_PWRREADY, "PCMCIA PWRRDY");
-	if (ret)
-		goto err6;
-	ret = gpio_direction_input(GPIO_NR_PALMTC_PCMCIA_PWRREADY);
-	if (ret)
-		goto err7;
+	ret = gpio_request_array(palmtc_pcmcia_gpios,
+				ARRAY_SIZE(palmtc_pcmcia_gpios));
 
 	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
-	return 0;
 
-err7:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_PWRREADY);
-err6:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_READY);
-err5:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_RESET);
-err4:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER3);
-err3:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER2);
-err2:
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER1);
-err1:
 	return ret;
 }
 
 static void palmtc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_PWRREADY);
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_READY);
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_RESET);
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER3);
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER2);
-	gpio_free(GPIO_NR_PALMTC_PCMCIA_POWER1);
+	gpio_free_array(palmtc_pcmcia_gpios, ARRAY_SIZE(palmtc_pcmcia_gpios));
 }
 
 static void palmtc_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-- 
1.7.2.3
