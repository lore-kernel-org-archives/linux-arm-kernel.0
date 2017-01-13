From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 11:03:25 +0000
Subject: [PATCH RFC 3/5] pinctrl: mvebu: provide generic simple mmio-based
 implementation
In-Reply-To: <20170113110240.GA29164@n2100.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
Message-ID: <E1cRzdl-0002Ye-Gm@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a generic simple mmio-based probe function and methods, which
pinctrl drivers can use to initialise the mvebu pinctrl subsystem.
Most mvebu pinctrl drivers can use this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 57 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-mvebu.h |  6 ++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index c2e35da9bbd7..9c6736d0595d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -58,6 +58,30 @@ struct mvebu_pinctrl {
 	u8 variant;
 };
 
+int mvebu_mmio_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+			     unsigned int pid, unsigned long *config)
+{
+	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
+	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
+
+	*config = (readl(data->base + off) >> shift) & MVEBU_MPP_MASK;
+
+	return 0;
+}
+
+int mvebu_mmio_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+			     unsigned int pid, unsigned long config)
+{
+	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
+	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
+	unsigned long reg;
+
+	reg = readl(data->base + off) & ~(MVEBU_MPP_MASK << shift);
+	writel(reg | (config << shift), data->base + off);
+
+	return 0;
+}
+
 static struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_pid(
 	struct mvebu_pinctrl *pctl, unsigned pid)
 {
@@ -731,3 +755,36 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 
 	return 0;
 }
+
+/*
+ * mvebu_pinctrl_simple_mmio_probe - probe a simple mmio pinctrl
+ * @pdev: platform device (with platform data already attached)
+ *
+ * Initialise a simple (single base address) mmio pinctrl driver,
+ * assigning the MMIO base address to all mvebu mpp ctrl instances.
+ */
+int mvebu_pinctrl_simple_mmio_probe(struct platform_device *pdev)
+{
+	struct mvebu_pinctrl_soc_info *soc = dev_get_platdata(&pdev->dev);
+	struct mvebu_mpp_ctrl_data *mpp_data;
+	struct resource *res;
+	void __iomem *base;
+	int i;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mpp_data = devm_kcalloc(&pdev->dev, soc->ncontrols, sizeof(*mpp_data),
+				GFP_KERNEL);
+	if (!mpp_data)
+		return -ENOMEM;
+
+	for (i = 0; i < soc->ncontrols; i++)
+		mpp_data[i].base = base;
+
+	soc->control_data = mpp_data;
+
+	return mvebu_pinctrl_probe(pdev);
+}
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index 37bfa3bb56f0..c055581cf887 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -214,6 +214,12 @@ static inline int default_mpp_ctrl_set(void __iomem *base, unsigned int pid,
 	return 0;
 }
 
+int mvebu_mmio_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			       unsigned long *config);
+int mvebu_mmio_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			       unsigned long config);
+
 int mvebu_pinctrl_probe(struct platform_device *pdev);
+int mvebu_pinctrl_simple_mmio_probe(struct platform_device *pdev);
 
 #endif
-- 
2.7.4
