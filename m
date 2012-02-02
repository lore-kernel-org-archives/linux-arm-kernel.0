From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:04 +0800
Subject: [PATCH v2 5/9] ARM: mxc: convert audmux-v2 to a platform driver
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Plaform driver is more flexible and easy to add DT support.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/audmux-v2.c |  102 ++++++++++++++++++++++++++++++----------
 1 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 8cced35..d53c029 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -24,6 +24,9 @@
 #include <mach/audmux.h>
 #include <mach/hardware.h>
 
+#define DRIVER_NAME "audmux-v2"
+
+struct resource *audmux_res;
 static struct clk *audmux_clk;
 static void __iomem *audmux_base;
 
@@ -140,7 +143,7 @@ static const struct file_operations audmux_debugfs_fops = {
 	.llseek = default_llseek,
 };
 
-static void audmux_debugfs_init(void)
+static void __init audmux_debugfs_init(void)
 {
 	int i;
 	char buf[20];
@@ -159,10 +162,18 @@ static void audmux_debugfs_init(void)
 				   i);
 	}
 }
+
+static void __exit audmux_debugfs_remove(void)
+{
+	debugfs_remove_recursive(audmux_debugfs_root);
+}
 #else
 static inline void audmux_debugfs_init(void)
 {
 }
+static void audmux_debugfs_remove(void)
+{
+}
 #endif
 
 int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
@@ -184,36 +195,75 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
 
-static int mxc_audmux_v2_init(void)
+static int __init mxc_audmux_v2_probe(struct platform_device *pdev)
 {
-	int ret;
-	if (cpu_is_mx51()) {
-		audmux_base = MX51_IO_ADDRESS(MX51_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx31()) {
-		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx35()) {
-		audmux_clk = clk_get(NULL, "audmux");
-		if (IS_ERR(audmux_clk)) {
-			ret = PTR_ERR(audmux_clk);
-			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
-					ret);
-			return ret;
-		}
-		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx25()) {
-		audmux_clk = clk_get(NULL, "audmux");
-		if (IS_ERR(audmux_clk)) {
-			ret = PTR_ERR(audmux_clk);
-			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
-					ret);
-			return ret;
-		}
-		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
+	struct resource *res;
+	resource_size_t res_size;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "can't get device resources\n");
+		return -ENOENT;
+	}
+
+	res_size = resource_size(res);
+
+	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		return -EBUSY;
+	}
+
+	audmux_base = ioremap(res->start, res_size);
+
+	if (!audmux_base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		release_mem_region(res->start, resource_size(res));
+		return -EIO;
+	}
+
+	audmux_clk = clk_get(&pdev->dev, "audmux");
+	if (IS_ERR(audmux_clk)) {
+		dev_warn(&pdev->dev, "cannot get clock: %ld\n",
+				PTR_ERR(audmux_clk));
+		audmux_clk = NULL;
 	}
 
 	audmux_debugfs_init();
+	audmux_res = res;
 
 	return 0;
 }
 
-postcore_initcall(mxc_audmux_v2_init);
+static int __exit mxc_audmux_v2_remove(struct platform_device *pdev)
+{
+	audmux_debugfs_remove();
+	clk_put(audmux_clk);
+	iounmap(audmux_base);
+	release_mem_region(audmux_res->start, resource_size(audmux_res));
+
+	return 0;
+}
+
+static struct platform_driver mxc_audmux_v2_driver = {
+	.remove		= __exit_p(mxc_audmux_v2_remove),
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+static int __init mxc_audmux_v2_init(void)
+{
+	return platform_driver_probe(&mxc_audmux_v2_driver,
+					mxc_audmux_v2_probe);
+}
+subsys_initcall(mxc_audmux_v2_init);
+
+static void __exit mxc_audmux_v2_exit(void)
+{
+	platform_driver_unregister(&mxc_audmux_v2_driver);
+}
+module_exit(mxc_audmux_v2_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.5.4
