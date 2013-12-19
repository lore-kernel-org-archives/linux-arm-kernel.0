From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:23 +0100
Subject: [PATCH 12/38] arm: s5pv210: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-13-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-s5pv210/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 26027a2..81f43ae 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -267,8 +267,14 @@ core_initcall(s5pv210_core_init);
 
 int __init s5pv210_init(void)
 {
+	int rc = 0;
+
 	printk(KERN_INFO "S5PV210: Initializing architecture\n");
-	return device_register(&s5pv210_dev);
+	rc = device_register(&s5pv210_dev);
+	if (rc)
+		put_device(&s5pv210_dev);
+
+	return rc;
 }
 
 /* uart registration process */
-- 
1.8.3.1
