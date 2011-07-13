From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 13 Jul 2011 15:54:58 +0100
Subject: [PATCH 3/3] pxa2xx pcmcia - stargate 2 use gpio array.
In-Reply-To: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
References: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <1310568898-9201-4-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kill off the buff gpio as not used anywhere.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/pcmcia/pxa2xx_stargate2.c |   34 +++++++++++-----------------------
 1 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_stargate2.c b/drivers/pcmcia/pxa2xx_stargate2.c
index d08802f..9396222 100644
--- a/drivers/pcmcia/pxa2xx_stargate2.c
+++ b/drivers/pcmcia/pxa2xx_stargate2.c
@@ -28,7 +28,6 @@
 
 #include "soc_common.h"
 
-#define SG2_S0_BUFF_CTL		120
 #define SG2_S0_POWER_CTL	108
 #define SG2_S0_GPIO_RESET	82
 #define SG2_S0_GPIO_DETECT	53
@@ -38,6 +37,11 @@ static struct pcmcia_irqs irqs[] = {
 	{ 0, IRQ_GPIO(SG2_S0_GPIO_DETECT), "PCMCIA0 CD" },
 };
 
+static struct gpio sg2_pcmcia_gpios[] = {
+	{ SG2_S0_GPIO_RESET, GPIOF_OUT_INIT_HIGH, "PCMCIA Reset" },
+	{ SG2_S0_POWER_CTL, GPIOF_OUT_INIT_HIGH, "PCMCIA Power Ctrl" },
+};
+
 static int sg2_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	skt->socket.pci_irq = IRQ_GPIO(SG2_S0_GPIO_READY);
@@ -122,37 +126,23 @@ static int __init sg2_pcmcia_init(void)
 	if (!sg2_pcmcia_device)
 		return -ENOMEM;
 
-	ret = gpio_request(SG2_S0_BUFF_CTL, "SG2 CF buff ctl");
+	ret = gpio_request_array(sg2_pcmcia_gpios, ARRAY_SIZE(sg2_pcmcia_gpios));
 	if (ret)
 		goto error_put_platform_device;
-	ret = gpio_request(SG2_S0_POWER_CTL, "SG2 CF power ctl");
-	if (ret)
-		goto error_free_gpio_buff_ctl;
-	ret = gpio_request(SG2_S0_GPIO_RESET, "SG2 CF reset");
-	if (ret)
-		goto error_free_gpio_power_ctl;
-	/* Set gpio directions */
-	gpio_direction_output(SG2_S0_BUFF_CTL, 0);
-	gpio_direction_output(SG2_S0_POWER_CTL, 1);
-	gpio_direction_output(SG2_S0_GPIO_RESET, 1);
 
 	ret = platform_device_add_data(sg2_pcmcia_device,
 				       &sg2_pcmcia_ops,
 				       sizeof(sg2_pcmcia_ops));
 	if (ret)
-		goto error_free_gpio_reset;
+		goto error_free_gpios;
 
 	ret = platform_device_add(sg2_pcmcia_device);
 	if (ret)
-		goto error_free_gpio_reset;
+		goto error_free_gpios;
 
 	return 0;
-error_free_gpio_reset:
-	gpio_free(SG2_S0_GPIO_RESET);
-error_free_gpio_power_ctl:
-	gpio_free(SG2_S0_POWER_CTL);
-error_free_gpio_buff_ctl:
-	gpio_free(SG2_S0_BUFF_CTL);
+error_free_gpios:
+	gpio_free_array(sg2_pcmcia_gpios, ARRAY_SIZE(sg2_pcmcia_gpios));
 error_put_platform_device:
 	platform_device_put(sg2_pcmcia_device);
 
@@ -162,9 +152,7 @@ error_put_platform_device:
 static void __exit sg2_pcmcia_exit(void)
 {
 	platform_device_unregister(sg2_pcmcia_device);
-	gpio_free(SG2_S0_BUFF_CTL);
-	gpio_free(SG2_S0_POWER_CTL);
-	gpio_free(SG2_S0_GPIO_RESET);
+	gpio_free_array(sg2_pcmcia_gpios, ARRAY_SIZE(sg2_pcmcia_gpios));
 }
 
 fs_initcall(sg2_pcmcia_init);
-- 
1.7.3.4
