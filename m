From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 11 Feb 2011 20:21:31 +0530
Subject: [PATCH v2 12/13] da850: pruss SUART platform specific additions.
In-Reply-To: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1297435892-28278-13-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the McASP clock alias.
The alias is used by the pruss suart driver
for enabling the McASP PSC.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index e15de72..f1cf605 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -560,7 +560,18 @@ struct platform_device da8xx_pruss_dev = {
 
 int __init da8xx_register_pruss(struct da8xx_pruss_devices *pruss_device)
 {
+#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
+	int ret;
+#endif
+
 	da8xx_pruss_dev.dev.platform_data = pruss_device;
+
+#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
+	ret = clk_add_alias(NULL, "da8xx_pruss_uart.1",
+	NULL, &da850_mcasp_device.dev);
+	if (ret < 0)
+		return ret;
+#endif
 	return platform_device_register(&da8xx_pruss_dev);
 }
 
-- 
1.7.2.3
