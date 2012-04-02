From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 Apr 2012 03:21:25 +0200
Subject: [PATCH 1/4] amba: add functions to add devices dynamically
Message-ID: <1333329685-31631-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two functions to add APB and AHB devices to the amba (PrimeCell)
bus dynamically. This is modeled after the static definition
macros recently introduced into <linux/amba/bus.h> and can
help us in factoring out a bunch of code across the kernel.
Since a lot of call sites seem to be using a returned struct
amba device* pointer, let's use that.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/amba/bus.c       |   49 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/bus.h |    8 +++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 01c2cf4..5382624 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -583,6 +583,55 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 }
 EXPORT_SYMBOL_GPL(amba_device_add);
 
+static struct amba_device *
+amba_aphb_device_add(struct device *parent, const char *name,
+		     resource_size_t base, size_t size, int irq1, int irq2,
+		     void *pdata, unsigned int periphid, u64 dma_mask)
+{
+	struct amba_device *dev;
+	int ret;
+
+	dev = amba_device_alloc(name, base, size);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->dma_mask = dma_mask;
+	dev->dev.coherent_dma_mask = dma_mask;
+	dev->irq[0] = irq1;
+	dev->irq[1] = irq2;
+	dev->periphid = periphid;
+	dev->dev.platform_data = pdata;
+	dev->dev.parent = parent;
+
+	ret = amba_device_add(dev, &iomem_resource);
+	if (ret) {
+		amba_device_put(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+struct amba_device *
+amba_apb_device_add(struct device *parent, const char *name,
+		    resource_size_t base, size_t size, int irq1, int irq2,
+		    void *pdata, unsigned int periphid)
+{
+	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
+				    periphid, 0);
+}
+EXPORT_SYMBOL_GPL(amba_apb_device_add);
+
+struct amba_device *
+amba_ahb_device_add(struct device *parent, const char *name,
+		    resource_size_t base, size_t size, int irq1, int irq2,
+		    void *pdata, unsigned int periphid)
+{
+	return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
+				    periphid, ~0ULL);
+}
+EXPORT_SYMBOL_GPL(amba_ahb_device_add);
+
 static void amba_device_initialize(struct amba_device *dev, const char *name)
 {
 	device_initialize(&dev->dev);
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 7847e19..db64b0c 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -64,6 +64,14 @@ struct amba_device *amba_device_alloc(const char *, resource_size_t, size_t);
 void amba_device_put(struct amba_device *);
 int amba_device_add(struct amba_device *, struct resource *);
 int amba_device_register(struct amba_device *, struct resource *);
+struct amba_device *amba_apb_device_add(struct device *parent, const char *name,
+					resource_size_t base, size_t size,
+					int irq1, int irq2, void *pdata,
+					unsigned int periphid);
+struct amba_device *amba_ahb_device_add(struct device *parent, const char *name,
+					resource_size_t base, size_t size,
+					int irq1, int irq2, void *pdata,
+					unsigned int periphid);
 void amba_device_unregister(struct amba_device *);
 struct amba_device *amba_find_device(const char *, struct device *, unsigned int, unsigned int);
 int amba_request_regions(struct amba_device *, const char *);
-- 
1.7.7.6
