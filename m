From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:03:00 +0100
Subject: [PATCH 1/3] pcmcia: sa11xx_base: fix reporting of timing information
In-Reply-To: <20160829100232.GC1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
Message-ID: <E1beJPA-0005EX-IZ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the reporting of the currently programmed timing information.  These
entries have been showing zero due to the clock rate being a factor of
1000 too big.  With this change, we go from:

I/O      : 165 (0)
attribute: 300 (0)
common   : 300 (0)

to:

I/O      : 165 (172)
attribute: 300 (316)
common   : 300 (316)

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa11xx_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 9f6ec87b9f9e..af37b7ec1c73 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -144,7 +144,7 @@ static int
 sa1100_pcmcia_show_timing(struct soc_pcmcia_socket *skt, char *buf)
 {
 	struct soc_pcmcia_timing timing;
-	unsigned int clock = clk_get_rate(skt->clk);
+	unsigned int clock = clk_get_rate(skt->clk) / 1000;
 	unsigned long mecr = MECR;
 	char *p = buf;
 
-- 
2.1.0
