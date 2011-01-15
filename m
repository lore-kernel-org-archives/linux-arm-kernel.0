From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:55 +0100
Subject: [PATCH 5/8] ARM: pxa: Use gpio arrays in palmtx_pcmcia driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code
cleaner and less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_palmtx.c |   55 ++++++++--------------------------------
 1 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index b07b247..06f7f14 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -13,67 +13,34 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
-
-#include <mach/gpio.h>
 #include <mach/palmtx.h>
-
 #include "soc_common.h"
 
+static struct gpio palmtx_pcmcia_gpios[] = {
+	{ GPIO_NR_PALMTX_PCMCIA_POWER1,	GPIOF_INIT_LOW,	"PCMCIA Power 1" },
+	{ GPIO_NR_PALMTX_PCMCIA_POWER2,	GPIOF_INIT_LOW,	"PCMCIA Power 2" },
+	{ GPIO_NR_PALMTX_PCMCIA_RESET,	GPIOF_INIT_HIGH,"PCMCIA Reset" },
+	{ GPIO_NR_PALMTX_PCMCIA_READY,	GPIOF_IN,	"PCMCIA Ready" },
+};
+
 static int palmtx_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER1, "PCMCIA PWR1");
-	if (ret)
-		goto err1;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER1, 0);
-	if (ret)
-		goto err2;
-
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_POWER2, "PCMCIA PWR2");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_POWER2, 0);
-	if (ret)
-		goto err3;
-
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_RESET, "PCMCIA RST");
-	if (ret)
-		goto err3;
-	ret = gpio_direction_output(GPIO_NR_PALMTX_PCMCIA_RESET, 1);
-	if (ret)
-		goto err4;
-
-	ret = gpio_request(GPIO_NR_PALMTX_PCMCIA_READY, "PCMCIA RDY");
-	if (ret)
-		goto err4;
-	ret = gpio_direction_input(GPIO_NR_PALMTX_PCMCIA_READY);
-	if (ret)
-		goto err5;
+	ret = gpio_request_array(palmtx_pcmcia_gpios,
+				ARRAY_SIZE(palmtx_pcmcia_gpios));
 
 	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
-	return 0;
 
-err5:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_READY);
-err4:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_RESET);
-err3:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER2);
-err2:
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER1);
-err1:
 	return ret;
 }
 
 static void palmtx_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_READY);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_RESET);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER2);
-	gpio_free(GPIO_NR_PALMTX_PCMCIA_POWER1);
+	gpio_free_array(palmtx_pcmcia_gpios, ARRAY_SIZE(palmtx_pcmcia_gpios));
 }
 
 static void palmtx_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-- 
1.7.2.3
