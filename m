From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:03:11 +0100
Subject: [PATCH 3/3] pcmcia: soc_common: fix SS_STSCHG polarity
In-Reply-To: <20160829100232.GC1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
Message-ID: <E1beJPL-0005Ej-4I@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SS_STSCHG should be set for an IO card when the BVD1 signal is asserted
low, not high.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index eed5e9c05353..d5ca760c4eb2 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -235,7 +235,7 @@ static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 	stat |= skt->cs_state.Vcc ? SS_POWERON : 0;
 
 	if (skt->cs_state.flags & SS_IOCARD)
-		stat |= state.bvd1 ? SS_STSCHG : 0;
+		stat |= state.bvd1 ? 0 : SS_STSCHG;
 	else {
 		if (state.bvd1 == 0)
 			stat |= SS_BATDEAD;
-- 
2.1.0
