From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:01 +0100
Subject: [PATCH 11/33] pcmcia: soc_common: request legacy detect GPIO with
 active low
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkT-0000mm-Pz@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request the legacy card detect signal with the active low property and
remove our own negation of the detection value.  This allows us to use
the firmware-defined polarities rather than hard-coding it into the
driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 5d167512e96e..edfb6045fcda 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -168,7 +168,13 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
 	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
 		if (gpio_is_valid(skt->stat[i].gpio)) {
-			ret = gpio_request_one(skt->stat[i].gpio, GPIOF_IN,
+			unsigned long flags = GPIOF_IN;
+
+			/* CD is active low by default */
+			if (i == SOC_STAT_CD)
+				flags |= GPIOF_ACTIVE_LOW;
+
+			ret = gpio_request_one(skt->stat[i].gpio, flags,
 					       skt->stat[i].name);
 			if (ret) {
 				__soc_pcmcia_hw_shutdown(skt, i);
@@ -235,11 +241,8 @@ static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 	state.bvd1 = 1;
 	state.bvd2 = 1;
 
-	/* CD is active low by default */
 	if (skt->stat[SOC_STAT_CD].desc)
-		state.detect = !gpiod_get_raw_value(skt->stat[SOC_STAT_CD].desc);
-
-	/* RDY and BVD are active high by default */
+		state.detect = !!gpiod_get_value(skt->stat[SOC_STAT_CD].desc);
 	if (skt->stat[SOC_STAT_RDY].desc)
 		state.ready = !!gpiod_get_value(skt->stat[SOC_STAT_RDY].desc);
 	if (skt->stat[SOC_STAT_BVD1].desc)
-- 
2.1.0
