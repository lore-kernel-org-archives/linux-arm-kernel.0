From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Sep 2016 17:38:03 +0100
Subject: [PATCH 7/8] ARM: sa1111: fix missing clk_disable()
In-Reply-To: <20160906163711.GB1041@n2100.armlinux.org.uk>
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
Message-ID: <E1bhJNr-0008DL-Vx@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA1111 forgets to call clk_disable() in the probe error cleanup path.
Add the necessary call.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 7838659b870a..2e076c492005 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -754,7 +754,7 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	if (sachip->irq != NO_IRQ) {
 		ret = sa1111_setup_irq(sachip, pd->irq_base);
 		if (ret)
-			goto err_unmap;
+			goto err_clk;
 	}
 
 #ifdef CONFIG_ARCH_SA1100
@@ -799,6 +799,8 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
 	return 0;
 
+ err_clk:
+	clk_disable(sachip->clk);
  err_unmap:
 	iounmap(sachip->base);
  err_clk_unprep:
-- 
2.1.0
