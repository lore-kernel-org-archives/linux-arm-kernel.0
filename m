From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:19 +0100
Subject: [PATCH 5/8] pcmcia: sa1111: update socket driver to use
 devm_clk_get() API
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2Z-0007MZ-Pr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the pxa2xx socket driver to use the devm_clk_get() API so that
the cleanup paths are simplified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1111_generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 80b8e9d05275..fb902af8a5b7 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -145,7 +145,7 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 			return -ENOMEM;
 
 		s->soc.nr = ops->first + i;
-		s->soc.clk = clk_get(&dev->dev, NULL);
+		s->soc.clk = devm_clk_get(&dev->dev, NULL);
 		if (IS_ERR(s->soc.clk)) {
 			ret = PTR_ERR(s->soc.clk);
 			kfree(s);
@@ -226,7 +226,6 @@ static int pcmcia_remove(struct sa1111_dev *dev)
 	for (; s; s = next) {
 		next = s->next;
 		soc_pcmcia_remove_one(&s->soc);
-		clk_put(s->soc.clk);
 		kfree(s);
 	}
 
-- 
2.1.0
