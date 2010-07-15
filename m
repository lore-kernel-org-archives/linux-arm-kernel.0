From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 10:56:37 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <4C3ED678.7010308@st.com>
References: <20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
Message-ID: <20100715095637.GF26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 03:05:52PM +0530, Viresh KUMAR wrote:
> Just a little issue, in your patch you were enabling interface clock in
> amba_probe which is called after reading peripheral id registers in
> amba_device_register. We need interface clock enabled before reading these
> registers.

Yes, I've already updated my patch.  I've also renamed a the bus clock
functions so that we consistently call this clock 'pclk' after the
signal which it refers to.

I had noticed that Linus' patches were referring to 'ahb_pclk' - the
slave interface for primcells lives on APB not AHB.

 drivers/amba/bus.c       |   88 ++++++++++++++++++++++++++++++++++++----------
 include/linux/amba/bus.h |   11 ++++++
 2 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f60b2b6..d31590e 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -122,6 +122,31 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
+static int amba_get_enable_pclk(struct amba_device *pcdev)
+{
+	struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
+	int ret;
+
+	pcdev->pclk = pclk;
+
+	if (IS_ERR(pclk))
+		return PTR_ERR(pclk);
+
+	ret = clk_enable(pclk);
+	if (ret)
+		clk_put(pclk);
+
+	return ret;
+}
+
+static void amba_put_disable_pclk(struct amba_device *pcdev)
+{
+	struct clk *pclk = pcdev->pclk;
+
+	clk_disable(pclk);
+	clk_put(pclk);
+}
+
 /*
  * These are the device model conversion veneers; they convert the
  * device model structures to our more specific structures.
@@ -130,17 +155,33 @@ static int amba_probe(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	struct amba_id *id;
+	struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
+	int ret;
 
-	id = amba_lookup(pcdrv->id_table, pcdev);
+	do {
+		ret = amba_get_enable_pclk(pcdev);
+		if (ret)
+			break;
+
+		ret = pcdrv->probe(pcdev, id);
+		if (ret == 0)
+			break;
 
-	return pcdrv->probe(pcdev, id);
+		amba_put_disable_pclk(pcdev);
+	} while (0);
+
+	return ret;
 }
 
 static int amba_remove(struct device *dev)
 {
+	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
-	return drv->remove(to_amba_device(dev));
+	int ret = drv->remove(pcdev);
+
+	amba_put_disable_pclk(pcdev);
+
+	return ret;
 }
 
 static void amba_shutdown(struct device *dev)
@@ -203,7 +244,6 @@ static void amba_device_release(struct device *dev)
  */
 int amba_device_register(struct amba_device *dev, struct resource *parent)
 {
-	u32 pid, cid;
 	u32 size;
 	void __iomem *tmp;
 	int i, ret;
@@ -241,25 +281,35 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 		goto err_release;
 	}
 
-	/*
-	 * Read pid and cid based on size of resource
-	 * they are located at end of region
-	 */
-	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
-	for (cid = 0, i = 0; i < 4; i++)
-		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
+	ret = amba_get_enable_pclk(dev);
+	if (ret == 0) {
+		u32 pid, cid;
 
-	iounmap(tmp);
+		/*
+		 * Read pid and cid based on size of resource
+		 * they are located@end of region
+		 */
+		for (pid = 0, i = 0; i < 4; i++)
+			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
+				(i * 8);
+		for (cid = 0, i = 0; i < 4; i++)
+			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
+				(i * 8);
 
-	if (cid == 0xb105f00d)
-		dev->periphid = pid;
+		amba_put_disable_pclk(dev);
 
-	if (!dev->periphid) {
-		ret = -ENODEV;
-		goto err_release;
+		if (cid == 0xb105f00d)
+			dev->periphid = pid;
+
+		if (!dev->periphid)
+			ret = -ENODEV;
 	}
 
+	iounmap(tmp);
+
+	if (ret)
+		goto err_release;
+
 	ret = device_add(&dev->dev);
 	if (ret)
 		goto err_release;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 8b10386..b0c1740 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -14,14 +14,19 @@
 #ifndef ASMARM_AMBA_H
 #define ASMARM_AMBA_H
 
+#include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/resource.h>
 
 #define AMBA_NR_IRQS	2
 
+struct clk;
+
 struct amba_device {
 	struct device		dev;
 	struct resource		res;
+	struct clk		*pclk;
 	u64			dma_mask;
 	unsigned int		periphid;
 	unsigned int		irq[AMBA_NR_IRQS];
@@ -59,6 +64,12 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
+#define amba_pclk_enable(d)	\
+	(IS_ERR((d)->pclk) ? 0 : clk_enable((d)->pclk))
+
+#define amba_pclk_disable(d)	\
+	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
+
 #define amba_config(d)	(((d)->periphid >> 24) & 0xff)
 #define amba_rev(d)	(((d)->periphid >> 20) & 0x0f)
 #define amba_manf(d)	(((d)->periphid >> 12) & 0xff)
