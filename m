From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sat, 26 Apr 2014 21:35:48 +0530
Subject: [PATCH v3 6/6] arm: exynos: Add /dev/bL_status user interface on
 Exynos5420
In-Reply-To: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398528348-21214-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a user interface to check the core and cluster status on
Exynos5420. This can be utilized while debugging mcpm issues.
cat /dev/bL_status will show the current power status of all
the 8 cores along with the cluster.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index f9977bf..83428b0 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -269,6 +269,53 @@ static void __init exynos_mcpm_usage_count_init(void)
 	cpu_use_count[cpu][cluster] = 1;
 }
 
+static size_t bL_check_status(char *info)
+{
+	size_t len = 0;
+	int i;
+
+	len += sprintf(&info[len], "\t0 1 2 3 L2\n");
+	len += sprintf(&info[len], "[A15]   ");
+	for (i = 0; i < 4; i++) {
+		len += sprintf(&info[len], "%d ",
+			(readl(EXYNOS_ARM_CORE_STATUS(i)) & 0x3) == 3 ? 1 : 0);
+	}
+	len += sprintf(&info[len], "%d\n",
+			(readl(EXYNOS_COMMON_STATUS(0)) & 0x3) == 3 ? 1 : 0);
+
+	len += sprintf(&info[len], "[A7]    ");
+	for (i = 4; i < 8; i++)
+		len += sprintf(&info[len], "%d ",
+			(readl(EXYNOS_ARM_CORE_STATUS(i)) & 0x3) == 3 ? 1 : 0);
+	len += sprintf(&info[len], "%d\n\n",
+			(readl(EXYNOS_COMMON_STATUS(1)) & 0x3) == 3 ? 1 : 0);
+
+	return len;
+}
+
+static ssize_t bL_status_read(struct file *file, char __user *buf,
+			size_t len, loff_t *pos)
+{
+	size_t count = 0;
+	char info[100];
+
+	count = bL_check_status(info);
+	if (count < 0)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, len, pos, info, count);
+}
+
+static const struct file_operations bL_status_fops = {
+	.read		= bL_status_read,
+};
+
+static struct miscdevice bL_status_device = {
+	MISC_DYNAMIC_MINOR,
+	"bL_status",
+	&bL_status_fops
+};
+
 /*
  * Enable cluster-level coherency, in preparation for turning on the MMU.
  */
@@ -319,3 +366,20 @@ static int __init exynos_mcpm_init(void)
 }
 
 early_initcall(exynos_mcpm_init);
+
+static int __init exynos_bl_status_init(void)
+{
+	int ret;
+
+	if (!soc_is_exynos5420())
+		return -ENODEV;
+
+	ret = misc_register(&bL_status_device);
+	if (ret) {
+		pr_info("bl_status not available\n");
+		return ret;
+	}
+	return 0;
+}
+
+late_initcall(exynos_bl_status_init);
-- 
1.8.3.2
