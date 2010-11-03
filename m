From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed,  3 Nov 2010 11:09:48 +0100
Subject: [PATCH] ARM amba: optional PrimeCell core voltage switch
Message-ID: <1288778988-11041-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some contemporary sub-micron SoCs, peripherals on the chip have
power domain switches, i.e. the voltage to the core may be turned
off to conserve power. In the Ux500 we have this for out PrimeCell
derivates.

This patch makes it possible to specify an (optional) regulator to
handle the voltage domain switch on AMBA PrimeCells, modeled very
similar to how block clocks are handled.

Additional amba_vcore_[enable|disable] calls are supplied to make
it possible introduce optional powering off of the core voltage.
Using this will require code to spool/unspool any core HW state.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/amba/bus.c       |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/amba/bus.h |    8 ++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 2737b97..e7df019 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -147,6 +147,39 @@ static void amba_put_disable_pclk(struct amba_device *pcdev)
 	clk_put(pclk);
 }
 
+static int amba_get_enable_vcore(struct amba_device *pcdev)
+{
+	struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
+	int ret;
+
+	pcdev->vcore = vcore;
+
+	if (IS_ERR(vcore)) {
+		/* It is OK not to supply a vcore regulator */
+		if (PTR_ERR(vcore) == -ENODEV)
+			return 0;
+		return PTR_ERR(vcore);
+	}
+
+	ret = regulator_enable(vcore);
+	if (ret) {
+		regulator_put(vcore);
+		pcdev->vcore = ERR_PTR(-ENODEV);
+	}
+
+	return ret;
+}
+
+static void amba_put_disable_vcore(struct amba_device *pcdev)
+{
+	struct regulator *vcore = pcdev->vcore;
+
+	if (!IS_ERR(vcore)) {
+		regulator_disable(vcore);
+		regulator_put(vcore);
+	}
+}
+
 /*
  * These are the device model conversion veneers; they convert the
  * device model structures to our more specific structures.
@@ -159,6 +192,10 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = amba_get_enable_vcore(pcdev);
+		if (ret)
+			break;
+
 		ret = amba_get_enable_pclk(pcdev);
 		if (ret)
 			break;
@@ -168,6 +205,7 @@ static int amba_probe(struct device *dev)
 			break;
 
 		amba_put_disable_pclk(pcdev);
+		amba_put_disable_vcore(pcdev);
 	} while (0);
 
 	return ret;
@@ -180,6 +218,7 @@ static int amba_remove(struct device *dev)
 	int ret = drv->remove(pcdev);
 
 	amba_put_disable_pclk(pcdev);
+	amba_put_disable_vcore(pcdev);
 
 	return ret;
 }
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index c6454cc..9e7f259 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/resource.h>
+#include <linux/regulator/consumer.h>
 
 #define AMBA_NR_IRQS	2
 #define AMBA_CID	0xb105f00d
@@ -28,6 +29,7 @@ struct amba_device {
 	struct device		dev;
 	struct resource		res;
 	struct clk		*pclk;
+	struct regulator	*vcore;
 	u64			dma_mask;
 	unsigned int		periphid;
 	unsigned int		irq[AMBA_NR_IRQS];
@@ -71,6 +73,12 @@ void amba_release_regions(struct amba_device *);
 #define amba_pclk_disable(d)	\
 	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
 
+#define amba_vcore_enable(d)	\
+	(IS_ERR((d)->vcore) ? 0 : regulator_enable((d)->vcore))
+
+#define amba_vcore_disable(d)	\
+	do { if (!IS_ERR((d)->vcore)) regulator_disable((d)->vcore); } while (0)
+
 /* Some drivers don't use the struct amba_device */
 #define AMBA_CONFIG_BITS(a) (((a) >> 24) & 0xff)
 #define AMBA_REV_BITS(a) (((a) >> 20) & 0x0f)
-- 
1.7.2.3
