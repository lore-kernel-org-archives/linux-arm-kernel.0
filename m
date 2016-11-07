From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Sun,  6 Nov 2016 17:13:23 -0700
Subject: [PATCH 1/4] fpga mgr: Introduce FPGA capabilities
In-Reply-To: <20161107001326.7395-1-moritz.fischer@ettus.com>
References: <20161107001326.7395-1-moritz.fischer@ettus.com>
Message-ID: <20161107001326.7395-2-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FPGA capabilities as a way to express the capabilities
of a given FPGA manager.

Removes code duplication by comparing the low-level driver's
capabilities at the framework level rather than having each driver
check for supported operations in the write_init() callback.

This allows for extending with additional capabilities, similar
to the the dmaengine framework's implementation.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Alan Tull <atull@opensource.altera.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---

Changes from RFC:
* in the RFC the caps weren't actually stored into the struct fpga_mgr

Note:

If people disagree on the typedef being a 'false positive' I can fix
that in a future rev of the patchset.

Thanks,

    Moritz

---
 drivers/fpga/fpga-mgr.c       | 15 ++++++++++++++
 drivers/fpga/socfpga.c        | 10 +++++-----
 drivers/fpga/zynq-fpga.c      |  7 ++++++-
 include/linux/fpga/fpga-mgr.h | 46 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 953dc91..ed57c17 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -49,6 +49,18 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
 	struct device *dev = &mgr->dev;
 	int ret;
 
+	if (flags & FPGA_MGR_PARTIAL_RECONFIG &&
+	    !fpga_mgr_has_cap(FPGA_MGR_CAP_PARTIAL_RECONF, mgr->caps)) {
+		dev_err(dev, "Partial reconfiguration not supported\n");
+		return -ENOTSUPP;
+	}
+
+	if (flags & FPGA_MGR_FULL_RECONFIG &&
+	    !fpga_mgr_has_cap(FPGA_MGR_CAP_FULL_RECONF, mgr->caps)) {
+		dev_err(dev, "Full reconfiguration not supported\n");
+		return -ENOTSUPP;
+	}
+
 	/*
 	 * Call the low level driver's write_init function.  This will do the
 	 * device-specific things to get the FPGA into the state where it is
@@ -245,12 +257,14 @@ EXPORT_SYMBOL_GPL(fpga_mgr_put);
  * @dev:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
+ * @caps:	fpga manager capabilities
  * @priv:	fpga manager private data
  *
  * Return: 0 on success, negative error code otherwise.
  */
 int fpga_mgr_register(struct device *dev, const char *name,
 		      const struct fpga_manager_ops *mops,
+		      fpga_mgr_cap_mask_t caps,
 		      void *priv)
 {
 	struct fpga_manager *mgr;
@@ -282,6 +296,7 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	mgr->name = name;
 	mgr->mops = mops;
 	mgr->priv = priv;
+	mgr->caps = caps;
 
 	/*
 	 * Initialize framework state by requesting low level driver read state
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 27d2ff2..fd9760c 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -413,10 +413,6 @@ static int socfpga_fpga_ops_configure_init(struct fpga_manager *mgr, u32 flags,
 	struct socfpga_fpga_priv *priv = mgr->priv;
 	int ret;
 
-	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
-		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
-		return -EINVAL;
-	}
 	/* Steps 1 - 5: Reset the FPGA */
 	ret = socfpga_fpga_reset(mgr);
 	if (ret)
@@ -555,6 +551,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct socfpga_fpga_priv *priv;
 	struct resource *res;
+	fpga_mgr_cap_mask_t caps;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -580,8 +577,11 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	fpga_mgr_cap_zero(&caps);
+	fpga_mgr_cap_set(FPGA_MGR_CAP_FULL_RECONF, caps);
+
 	return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
-				 &socfpga_fpga_ops, priv);
+				 &socfpga_fpga_ops, caps, priv);
 }
 
 static int socfpga_fpga_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index c2fb412..1d37ff0 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -410,6 +410,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynq_fpga_priv *priv;
 	struct resource *res;
+	fpga_mgr_cap_mask_t caps;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -461,9 +462,13 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
 
 	clk_disable(priv->clk);
+	fpga_mgr_cap_zero(&caps);
+	fpga_mgr_cap_set(FPGA_MGR_CAP_FULL_RECONF, caps);
+	fpga_mgr_cap_set(FPGA_MGR_CAP_PARTIAL_RECONF, caps);
+
 
 	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
-				&zynq_fpga_ops, priv);
+				&zynq_fpga_ops, caps, priv);
 	if (err) {
 		dev_err(dev, "unable to register FPGA manager");
 		clk_unprepare(priv->clk);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0940bf4..e73429c 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,6 +67,47 @@ enum fpga_mgr_states {
  * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
+#define FPGA_MGR_FULL_RECONFIG		BIT(1)
+
+enum fpga_mgr_capability {
+	FPGA_MGR_CAP_PARTIAL_RECONF,
+	FPGA_MGR_CAP_FULL_RECONF,
+
+/* last capability type for creation of the capabilities mask */
+	FPGA_MGR_CAP_END,
+};
+
+typedef struct { DECLARE_BITMAP(bits, FPGA_MGR_CAP_END); } fpga_mgr_cap_mask_t;
+
+#define fpga_mgr_has_cap(cap, mask) __fpga_mgr_has_cap((cap), &(mask))
+static inline int __fpga_mgr_has_cap(enum fpga_mgr_capability cap,
+				     fpga_mgr_cap_mask_t *mask)
+{
+	return test_bit(cap, mask->bits);
+}
+
+#define fpga_mgr_cap_zero(mask) __fpga_mgr_cap_zero(mask)
+static inline void __fpga_mgr_cap_zero(fpga_mgr_cap_mask_t *mask)
+{
+	bitmap_zero(mask->bits, FPGA_MGR_CAP_END);
+}
+
+#define fpga_mgr_cap_clear(cap, mask) __fpga_mgr_cap_clear((cap), &(mask))
+static inline void __fpga_mgr_cap_clear(enum fpga_mgr_capability cap,
+				       fpga_mgr_cap_mask_t *mask)
+
+{
+	clear_bit(cap, mask->bits);
+}
+
+#define fpga_mgr_cap_set(cap, mask) __fpga_mgr_cap_set((cap), &(mask))
+static inline void __fpga_mgr_cap_set(enum fpga_mgr_capability cap,
+				      fpga_mgr_cap_mask_t *mask)
+
+{
+	set_bit(cap, mask->bits);
+}
+
 
 /**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
@@ -105,6 +146,7 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+	fpga_mgr_cap_mask_t caps;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
@@ -120,7 +162,9 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
 void fpga_mgr_put(struct fpga_manager *mgr);
 
 int fpga_mgr_register(struct device *dev, const char *name,
-		      const struct fpga_manager_ops *mops, void *priv);
+		      const struct fpga_manager_ops *mops,
+		      fpga_mgr_cap_mask_t caps,
+		      void *priv);
 
 void fpga_mgr_unregister(struct device *dev);
 
-- 
2.10.0
