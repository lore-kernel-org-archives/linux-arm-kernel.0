From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:25 +0530
Subject: [PATCH v4 07/11] da850: pruss SUART platform specific additions.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-8-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the McASP clock alias.
The alias is used by the pruss suart driver
for enabling the McASP PSC.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index f51c9ad..8f41ae4 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -567,9 +567,27 @@ static struct platform_device da8xx_pruss_mfddev = {
 	.resource	= da8xx_pruss_resources,
 };
 
+#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
+static int da8xx_mcasp_clk_add_alias(void)
+{
+	return clk_add_alias(NULL, "da8xx_pruss_uart.0",
+			NULL, &da850_mcasp_device.dev);
+}
+#else
+static int da8xx_mcasp_clk_add_alias(void)
+{
+	return 0;
+}
+#endif
 int __init da8xx_register_pruss_mfd(struct mfd_cell *cell)
 {
+	int ret;
+
 	da8xx_pruss_mfddev.dev.platform_data = cell;
+
+	ret = da8xx_mcasp_clk_add_alias();
+	if (ret < 0)
+		return ret;
 	return platform_device_register(&da8xx_pruss_mfddev);
 }
 
-- 
1.7.2.3
