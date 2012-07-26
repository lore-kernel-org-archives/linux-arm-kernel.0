From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:34:04 +0100
Subject: [PATCH 22/24] ARM: enable earlyprintk=xen
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-22-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ian Campbell <ian.campbell@citrix.com>

Currently ARM setup_early_printk does not support alternative early
consoles and it always registers early_console only.

This patch adds support for xenboot_console.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/kernel/early_printk.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 85aa2b2..eecfa21 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <xen/hvc-console.h>
 
 extern void printch(int);
 
@@ -50,7 +52,14 @@ asmlinkage void early_printk(const char *fmt, ...)
 
 static int __init setup_early_printk(char *buf)
 {
-	register_console(&early_console);
+	if (!buf || !strncmp(buf, "serial", 6))
+		register_console(&early_console);
+
+#ifdef CONFIG_HVC_XEN
+	if (!strncmp(buf, "xen", 3))
+		register_console(&xenboot_console);
+#endif
+
 	return 0;
 }
 
-- 
1.7.2.5
