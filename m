From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:56 +0100
Subject: [PATCH 6/8] ARM: pxa: Use gpio arrays in vpac270_pcmcia driver
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-6-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array(), this makes the code
cleaner and less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_vpac270.c |  107 +++++++++++----------------------------
 1 files changed, 29 insertions(+), 78 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index 55627ec..c13f411 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -22,6 +22,19 @@
 
 #include "soc_common.h"
 
+static struct gpio vpac270_pcmcia_gpios[] = {
+	{ GPIO84_VPAC270_PCMCIA_CD,	GPIOF_IN,	"PCMCIA Card Detect" },
+	{ GPIO35_VPAC270_PCMCIA_RDY,	GPIOF_IN,	"PCMCIA Ready" },
+	{ GPIO107_VPAC270_PCMCIA_PPEN,	GPIOF_INIT_LOW,	"PCMCIA PPEN" },
+	{ GPIO11_VPAC270_PCMCIA_RESET,	GPIOF_INIT_LOW,	"PCMCIA Reset" },
+};
+
+static struct gpio vpac270_cf_gpios[] = {
+	{ GPIO17_VPAC270_CF_CD,		GPIOF_IN,	"CF Card Detect" },
+	{ GPIO12_VPAC270_CF_RDY,	GPIOF_IN,	"CF Ready" },
+	{ GPIO16_VPAC270_CF_RESET,	GPIOF_INIT_LOW,	"CF Reset" },
+};
+
 static struct pcmcia_irqs cd_irqs[] = {
 	{
 		.sock = 0,
@@ -40,96 +53,34 @@ static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	int ret;
 
 	if (skt->nr == 0) {
-		ret = gpio_request(GPIO84_VPAC270_PCMCIA_CD, "PCMCIA CD");
-		if (ret)
-			goto err1;
-		ret = gpio_direction_input(GPIO84_VPAC270_PCMCIA_CD);
-		if (ret)
-			goto err2;
-
-		ret = gpio_request(GPIO35_VPAC270_PCMCIA_RDY, "PCMCIA RDY");
-		if (ret)
-			goto err2;
-		ret = gpio_direction_input(GPIO35_VPAC270_PCMCIA_RDY);
-		if (ret)
-			goto err3;
-
-		ret = gpio_request(GPIO107_VPAC270_PCMCIA_PPEN, "PCMCIA PPEN");
-		if (ret)
-			goto err3;
-		ret = gpio_direction_output(GPIO107_VPAC270_PCMCIA_PPEN, 0);
-		if (ret)
-			goto err4;
-
-		ret = gpio_request(GPIO11_VPAC270_PCMCIA_RESET, "PCMCIA RESET");
-		if (ret)
-			goto err4;
-		ret = gpio_direction_output(GPIO11_VPAC270_PCMCIA_RESET, 0);
-		if (ret)
-			goto err5;
+		ret = gpio_request_array(vpac270_pcmcia_gpios,
+				ARRAY_SIZE(vpac270_pcmcia_gpios));
 
 		skt->socket.pci_irq = gpio_to_irq(GPIO35_VPAC270_PCMCIA_RDY);
 
-		return soc_pcmcia_request_irqs(skt, &cd_irqs[0], 1);
-
-err5:
-		gpio_free(GPIO11_VPAC270_PCMCIA_RESET);
-err4:
-		gpio_free(GPIO107_VPAC270_PCMCIA_PPEN);
-err3:
-		gpio_free(GPIO35_VPAC270_PCMCIA_RDY);
-err2:
-		gpio_free(GPIO84_VPAC270_PCMCIA_CD);
-err1:
-		return ret;
-
+		if (!ret)
+			ret = soc_pcmcia_request_irqs(skt, &cd_irqs[0], 1);
 	} else {
-		ret = gpio_request(GPIO17_VPAC270_CF_CD, "CF CD");
-		if (ret)
-			goto err6;
-		ret = gpio_direction_input(GPIO17_VPAC270_CF_CD);
-		if (ret)
-			goto err7;
-
-		ret = gpio_request(GPIO12_VPAC270_CF_RDY, "CF RDY");
-		if (ret)
-			goto err7;
-		ret = gpio_direction_input(GPIO12_VPAC270_CF_RDY);
-		if (ret)
-			goto err8;
-
-		ret = gpio_request(GPIO16_VPAC270_CF_RESET, "CF RESET");
-		if (ret)
-			goto err8;
-		ret = gpio_direction_output(GPIO16_VPAC270_CF_RESET, 0);
-		if (ret)
-			goto err9;
+		ret = gpio_request_array(vpac270_cf_gpios,
+				ARRAY_SIZE(vpac270_cf_gpios));
 
 		skt->socket.pci_irq = gpio_to_irq(GPIO12_VPAC270_CF_RDY);
 
-		return soc_pcmcia_request_irqs(skt, &cd_irqs[1], 1);
-
-err9:
-		gpio_free(GPIO16_VPAC270_CF_RESET);
-err8:
-		gpio_free(GPIO12_VPAC270_CF_RDY);
-err7:
-		gpio_free(GPIO17_VPAC270_CF_CD);
-err6:
-		return ret;
-
+		if (!ret)
+			ret = soc_pcmcia_request_irqs(skt, &cd_irqs[1], 1);
 	}
+
+	return ret;
 }
 
 static void vpac270_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	gpio_free(GPIO11_VPAC270_PCMCIA_RESET);
-	gpio_free(GPIO107_VPAC270_PCMCIA_PPEN);
-	gpio_free(GPIO35_VPAC270_PCMCIA_RDY);
-	gpio_free(GPIO84_VPAC270_PCMCIA_CD);
-	gpio_free(GPIO16_VPAC270_CF_RESET);
-	gpio_free(GPIO12_VPAC270_CF_RDY);
-	gpio_free(GPIO17_VPAC270_CF_CD);
+	if (skt->nr == 0)
+		gpio_request_array(vpac270_pcmcia_gpios,
+					ARRAY_SIZE(vpac270_pcmcia_gpios));
+	else
+		gpio_request_array(vpac270_cf_gpios,
+					ARRAY_SIZE(vpac270_cf_gpios));
 }
 
 static void vpac270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-- 
1.7.2.3
