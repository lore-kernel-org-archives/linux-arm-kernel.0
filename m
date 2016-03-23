From: justinpopo6@gmail.com (Justin Chen)
Date: Wed, 23 Mar 2016 11:56:50 -0700
Subject: [PATCH v3] bsp: add SoC driver to brcmstb
Message-ID: <1458759410-8991-1-git-send-email-justinpopo6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Chen <justin.chen@broadcom.com>

Value of soc_dev_attributes:
family = chip family id
soc_id = product id
revision = product revision

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig    |    1 +
 drivers/soc/brcmstb/common.c |   58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef1214..b95ea11 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -179,6 +179,7 @@ config ARCH_BRCMSTB
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SOC_BRCMSTB
+	select SOC_BUS
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
 	  chipset.
diff --git a/drivers/soc/brcmstb/common.c b/drivers/soc/brcmstb/common.c
index c262c02..daf86ac 100644
--- a/drivers/soc/brcmstb/common.c
+++ b/drivers/soc/brcmstb/common.c
@@ -12,10 +12,18 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/soc/brcmstb/brcmstb.h>
+#include <linux/sys_soc.h>
 
 #include <soc/brcmstb/common.h>
 
+static u32 family_id;
+static u32 product_id;
+
 static const struct of_device_id brcmstb_machine_match[] = {
 	{ .compatible = "brcm,brcmstb", },
 	{ }
@@ -31,3 +39,53 @@ bool soc_is_brcmstb(void)
 
 	return of_match_node(brcmstb_machine_match, root) != NULL;
 }
+
+static const struct of_device_id sun_top_ctrl_match[] = {
+	{ .compatible = "brcm,brcmstb-sun-top-ctrl", },
+	{ }
+};
+
+static int __init brcmstb_soc_device_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *sun_top_ctrl;
+	void __iomem *sun_top_ctrl_base;
+
+	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
+	if (!sun_top_ctrl)
+		return -ENODEV;
+
+	sun_top_ctrl_base = of_iomap(sun_top_ctrl, 0);
+	if (!sun_top_ctrl_base)
+		return -ENODEV;
+
+	family_id = readl(sun_top_ctrl_base);
+	product_id = readl(sun_top_ctrl_base + 0x4);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "%x",
+					 family_id >> 28 ?
+					 family_id >> 16 : family_id >> 8);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%x",
+					 product_id >> 28 ?
+					 product_id >> 16 : product_id >> 8);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c%d",
+					 ((product_id & 0xf0) >> 4) + 'A',
+					   product_id & 0xf);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+arch_initcall(brcmstb_soc_device_init);
-- 
1.7.1
