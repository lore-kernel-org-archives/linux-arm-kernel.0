From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 22 Mar 2015 00:30:02 +0000
Subject: [PATCH 6/7] ARM: mxs: register cpufreq-dt in pm init
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1426984203-9133-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the registration of cpufreq-dt into pm init to get
cpufreq support for MXS platform.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-mxs/pm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index 0170e99..23c52e0 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include "pm.h"
 
 static int mxs_suspend_enter(suspend_state_t state)
@@ -35,7 +36,12 @@ static struct platform_suspend_ops mxs_suspend_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
+static struct platform_device mxs_cpufreq_pdev = {
+	.name = "cpufreq-dt",
+};
+
 void __init mxs_pm_init(void)
 {
 	suspend_set_ops(&mxs_suspend_ops);
+	platform_device_register(&mxs_cpufreq_pdev);
 }
-- 
1.7.9.5
