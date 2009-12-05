From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Sat, 5 Dec 2009 12:31:28 +0100
Subject: [PATCH V2 1/2] arm nomadik: add hardware RNG driver
Message-ID: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

The hardware random number generator by ST is used in both the Nomadik
8815 SoC and the U8500. It returns 16 bits every 400ns with automatic
delay if a read is issued too early. It depends on PLAT_NOMADIK.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---

This V2 uses the new interface, so it depends on this patch from
cryptodev-2.6.git:
   commit 9996508b3353063f2d6c48c1a28a84543d72d70b
   Author: Ian Molton <ian.molton@collabora.co.uk>
   Date:   Tue Dec 1 14:47:32 2009 +0800

With dd I can fetch 3 MB/s of random data where /dev/urandom gives
0.4 M/s and /dev/zero gives 60 MB/s.

 drivers/char/hw_random/Kconfig       |   12 ++++
 drivers/char/hw_random/Makefile      |    1 +
 drivers/char/hw_random/nomadik-rng.c |  103 ++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/nomadik-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 8706026..6ea1014 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -186,3 +186,15 @@ config HW_RANDOM_MXC_RNGA
 	  module will be called mxc-rnga.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_NOMADIK
+	tristate "ST-Ericsson Nomadik Random Number Generator support"
+	depends on HW_RANDOM && PLAT_NOMADIK
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on ST-Ericsson SoCs (8815 and 8500).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nomadik-rng.
+
+	  If unsure, say Y.
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 5eeb130..4273308 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_HW_RANDOM_VIRTIO) += virtio-rng.o
 obj-$(CONFIG_HW_RANDOM_TX4939) += tx4939-rng.o
 obj-$(CONFIG_HW_RANDOM_MXC_RNGA) += mxc-rnga.o
 obj-$(CONFIG_HW_RANDOM_OCTEON) += octeon-rng.o
+obj-$(CONFIG_HW_RANDOM_NOMADIK) += nomadik-rng.o
diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
new file mode 100644
index 0000000..a8b4c40
--- /dev/null
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -0,0 +1,103 @@
+/*
+ * Nomadik RNG support
+ *  Copyright 2009 Alessandro Rubini
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/amba/bus.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+
+static int nmk_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	void __iomem *base = (void __iomem *)rng->priv;
+
+	/*
+	 * The register is 32 bits and gives 16 random bits (low half).
+	 * A subsequent read will delay the core for 400ns, so we just read
+	 * once and accept the very unlikely very small delay, even if wait==0.
+	 */
+	*(u16 *)data = __raw_readl(base + 8) & 0xffff;
+	return 2;
+}
+
+/* we have at most one RNG per machine, granted */
+static struct hwrng nmk_rng = {
+	.name		= "nomadik",
+	.read		= nmk_rng_read,
+};
+
+static int nmk_rng_probe(struct amba_device *dev, struct amba_id *id)
+{
+	void __iomem *base;
+	int ret;
+
+	ret = amba_request_regions(dev, dev->dev.init_name);
+	if (ret)
+		return ret;
+	ret = -ENOMEM;
+	base = ioremap(dev->res.start, resource_size(&dev->res));
+	if (!base)
+		goto out_release;
+	nmk_rng.priv = (unsigned long)base;
+	ret = hwrng_register(&nmk_rng);
+	if (ret)
+		goto out_unmap;
+	return 0;
+
+out_unmap:
+	iounmap(base);
+out_release:
+	amba_release_regions(dev);
+	return ret;
+}
+
+static int nmk_rng_remove(struct amba_device *dev)
+{
+	void __iomem *base = (void __iomem *)nmk_rng.priv;
+	hwrng_unregister(&nmk_rng);
+	iounmap(base);
+	amba_release_regions(dev);
+	return 0;
+}
+
+static struct amba_id nmk_rng_ids[] = {
+	{
+		.id	= 0x000805e1,
+		.mask	= 0x000fffff, /* top bits are rev and cfg: accept all */
+	},
+	{0, 0},
+};
+
+static struct amba_driver nmk_rng_driver = {
+	.drv = {
+		.owner = THIS_MODULE,
+		.name = "rng",
+		},
+	.probe = nmk_rng_probe,
+	.remove = nmk_rng_remove,
+	.id_table = nmk_rng_ids,
+};
+
+static int __init nmk_rng_init(void)
+{
+	return amba_driver_register(&nmk_rng_driver);
+}
+
+static void __devexit nmk_rng_exit(void)
+{
+	amba_driver_unregister(&nmk_rng_driver);
+}
+
+module_init(nmk_rng_init);
+module_exit(nmk_rng_exit);
+
+MODULE_LICENSE("GPL");
-- 
1.6.0.2
