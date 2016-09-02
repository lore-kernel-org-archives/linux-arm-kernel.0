From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 02 Sep 2016 13:04:17 +0100
Subject: [PATCH] pcmcia: sa1111: fix propagation of lowlevel board init return
 code
Message-ID: <E1bfnCj-0006HT-12@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing Lubbock, it was noticed that the sa1111 pcmcia driver bound
but was not functional due to no sockets being registered.  This is
because the return code from the lowlevel board initialisation was not
being propagated out of the probe function.  Fix this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Robert,

I'd prefer this solution.  Please check that it resolves your issue,
thanks.

 drivers/pcmcia/sa1111_badge4.c     | 22 ++++++++--------------
 drivers/pcmcia/sa1111_generic.c    | 22 +++++++++++++++++-----
 drivers/pcmcia/sa1111_jornada720.c | 16 +++++-----------
 drivers/pcmcia/sa1111_lubbock.c    | 14 ++++----------
 drivers/pcmcia/sa1111_neponset.c   | 12 +++---------
 5 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/pcmcia/sa1111_badge4.c b/drivers/pcmcia/sa1111_badge4.c
index 12f0dd091477..2f490930430d 100644
--- a/drivers/pcmcia/sa1111_badge4.c
+++ b/drivers/pcmcia/sa1111_badge4.c
@@ -134,20 +134,14 @@ static struct pcmcia_low_level badge4_pcmcia_ops = {
 
 int pcmcia_badge4_init(struct sa1111_dev *dev)
 {
-	int ret = -ENODEV;
-
-	if (machine_is_badge4()) {
-		printk(KERN_INFO
-		       "%s: badge4_pcmvcc=%d, badge4_pcmvpp=%d, badge4_cfvcc=%d\n",
-		       __func__,
-		       badge4_pcmvcc, badge4_pcmvpp, badge4_cfvcc);
-
-		sa11xx_drv_pcmcia_ops(&badge4_pcmcia_ops);
-		ret = sa1111_pcmcia_add(dev, &badge4_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
+	printk(KERN_INFO
+	       "%s: badge4_pcmvcc=%d, badge4_pcmvpp=%d, badge4_cfvcc=%d\n",
+	       __func__,
+	       badge4_pcmvcc, badge4_pcmvpp, badge4_cfvcc);
+
+	sa11xx_drv_pcmcia_ops(&badge4_pcmcia_ops);
+	return sa1111_pcmcia_add(dev, &badge4_pcmcia_ops,
+				 sa11xx_drv_pcmcia_add_one);
 }
 
 static int __init pcmv_setup(char *s)
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index a1531feb8460..3d95dffcff7a 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -18,6 +18,7 @@
 
 #include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
+#include <asm/mach-types.h>
 #include <asm/irq.h>
 
 #include "sa1111_generic.h"
@@ -203,19 +204,30 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 	sa1111_writel(PCSSR_S0_SLEEP | PCSSR_S1_SLEEP, base + PCSSR);
 	sa1111_writel(PCCR_S0_FLT | PCCR_S1_FLT, base + PCCR);
 
+	ret = -ENODEV;
 #ifdef CONFIG_SA1100_BADGE4
-	pcmcia_badge4_init(dev);
+	if (machine_is_badge4())
+		ret = pcmcia_badge4_init(dev);
 #endif
 #ifdef CONFIG_SA1100_JORNADA720
-	pcmcia_jornada720_init(dev);
+	if (machine_is_jornada720())
+		ret = pcmcia_jornada720_init(dev);
 #endif
 #ifdef CONFIG_ARCH_LUBBOCK
-	pcmcia_lubbock_init(dev);
+	if (machine_is_lubbock())
+		ret = pcmcia_lubbock_init(dev);
 #endif
 #ifdef CONFIG_ASSABET_NEPONSET
-	pcmcia_neponset_init(dev);
+	if (machine_is_assabet())
+		ret = pcmcia_neponset_init(dev);
 #endif
-	return 0;
+
+	if (ret) {
+		release_mem_region(dev->res.start, 512);
+		sa1111_disable_device(dev);
+	}
+
+	return ret;
 }
 
 static int pcmcia_remove(struct sa1111_dev *dev)
diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
index bfcb9fd43352..9ce146e018c0 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -127,16 +127,10 @@ static struct pcmcia_low_level jornada720_pcmcia_ops = {
 
 int pcmcia_jornada720_init(struct sa1111_dev *sadev)
 {
-	int ret = -ENODEV;
+	/* Fixme: why messing around with SA11x0's GPIO1? */
+	GRER |= 0x00000002;
 
-	if (machine_is_jornada720()) {
-		/* Fixme: why messing around with SA11x0's GPIO1? */
-		GRER |= 0x00000002;
-
-		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
-		ret = sa1111_pcmcia_add(sadev, &jornada720_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
+	sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
+	return sa1111_pcmcia_add(sadev, &jornada720_pcmcia_ops,
+				 sa11xx_drv_pcmcia_add_one);
 }
diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
index 9d5ffc71ae51..ccde1a8bba12 100644
--- a/drivers/pcmcia/sa1111_lubbock.c
+++ b/drivers/pcmcia/sa1111_lubbock.c
@@ -153,16 +153,10 @@ static struct pcmcia_low_level lubbock_pcmcia_ops = {
 
 int pcmcia_lubbock_init(struct sa1111_dev *sadev)
 {
-	int ret = -ENODEV;
-
-	if (machine_is_lubbock()) {
-		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
-		pxa2xx_configure_sockets(&sadev->dev);
-		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
-				pxa2xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
+	pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
+	pxa2xx_configure_sockets(&sadev->dev);
+	return sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
+				 pxa2xx_drv_pcmcia_add_one);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/pcmcia/sa1111_neponset.c b/drivers/pcmcia/sa1111_neponset.c
index 30a1602dd984..795a85b158fb 100644
--- a/drivers/pcmcia/sa1111_neponset.c
+++ b/drivers/pcmcia/sa1111_neponset.c
@@ -76,13 +76,7 @@ static struct pcmcia_low_level neponset_pcmcia_ops = {
 
 int pcmcia_neponset_init(struct sa1111_dev *sadev)
 {
-	int ret = -ENODEV;
-
-	if (machine_is_assabet()) {
-		sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
-		ret = sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
-				sa11xx_drv_pcmcia_add_one);
-	}
-
-	return ret;
+	sa11xx_drv_pcmcia_ops(&neponset_pcmcia_ops);
+	return sa1111_pcmcia_add(sadev, &neponset_pcmcia_ops,
+				 sa11xx_drv_pcmcia_add_one);
 }
-- 
2.1.0
