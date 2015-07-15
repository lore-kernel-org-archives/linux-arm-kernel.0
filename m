From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:24 +0100
Subject: [PATCH 6/8] pcmcia: sa1111: simplify clk handing in
 sa1111_pcmcia_add()
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2e-0007Mf-Sp@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get(dev, NULL) will always refer to the same clock, so it's
pointless calling this multiple times for the same device.  As we no
longer have to worry about the cleanup (via use of devm_clk_get()) we
can simplify sa1111_pcmcia_add() too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1111_generic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index fb902af8a5b7..a1531feb8460 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -135,8 +135,13 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 	int (*add)(struct soc_pcmcia_socket *))
 {
 	struct sa1111_pcmcia_socket *s;
+	struct clk *clk;
 	int i, ret = 0;
 
+	clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	ops->socket_state = sa1111_pcmcia_socket_state;
 
 	for (i = 0; i < ops->nr; i++) {
@@ -145,12 +150,8 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 			return -ENOMEM;
 
 		s->soc.nr = ops->first + i;
-		s->soc.clk = devm_clk_get(&dev->dev, NULL);
-		if (IS_ERR(s->soc.clk)) {
-			ret = PTR_ERR(s->soc.clk);
-			kfree(s);
-			return ret;
-		}
+		s->soc.clk = clk;
+
 		soc_pcmcia_init_one(&s->soc, ops, &dev->dev);
 		s->dev = dev;
 		if (s->soc.nr) {
-- 
2.1.0
