From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 11 Oct 2015 21:35:45 -0400
Subject: [PATCH 1/3] amba: create builtin_amba_driver to avoid registration
 boilerplate
In-Reply-To: <1444613747-17715-1-git-send-email-paul.gortmaker@windriver.com>
References: <1444613747-17715-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1444613747-17715-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
better support builtin boilerplate avoidance") we introduced the
builtin_driver macro.

Here we use that support and extend it to amba driver registration,
so where a driver is clearly non-modular and builtin-only, we can
register it in a similar fashion.  And existing code that is clearly
non-modular can be updated with the simple mapping of

     module_amba_driver(...)  ---> builtin_amba_driver(...)

We've essentially cloned the former to make the latter, and taken
out the remove/module_exit parts since those never get used in a
non-modular build of the code.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/amba/bus.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 50fc66868402..0e8cb21c20e5 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -165,4 +165,13 @@ struct amba_device name##_device = {				\
 #define module_amba_driver(__amba_drv) \
 	module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
 
+/*
+ * builtin_amba_driver() - Helper macro for drivers that don't do anything
+ * special in driver initcall.  This eliminates a lot of boilerplate.  Each
+ * driver may only use this macro once, and calling it replaces the instance
+ * device_initcall().
+ */
+#define builtin_amba_driver(__amba_drv) \
+	builtin_driver(__amba_drv, amba_driver_register)
+
 #endif
-- 
2.6.1
