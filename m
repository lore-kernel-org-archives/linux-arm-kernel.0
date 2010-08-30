From: robert.richter@amd.com (Robert Richter)
Date: Mon, 30 Aug 2010 10:56:18 +0200
Subject: [PATCH] oprofile, x86: fix init_sysfs error handling
Message-ID: <mailman.214.1283250914.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On failure init_sysfs() might not properly free resources. The error
code of the function is not checked. And, when reinitializing the exit
function might be called twice. This patch fixes all this.

Cc: stable at kernel.org
Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 arch/x86/oprofile/nmi_int.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index f6b48f6..73a41d3 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -568,8 +568,13 @@ static int __init init_sysfs(void)
 	int error;
 
 	error = sysdev_class_register(&oprofile_sysclass);
-	if (!error)
-		error = sysdev_register(&device_oprofile);
+	if (error)
+		return error;
+
+	error = sysdev_register(&device_oprofile);
+	if (error)
+		sysdev_class_unregister(&oprofile_sysclass);
+
 	return error;
 }
 
@@ -695,6 +700,8 @@ int __init op_nmi_init(struct oprofile_operations *ops)
 	char *cpu_type = NULL;
 	int ret = 0;
 
+	using_nmi = 0;
+
 	if (!cpu_has_apic)
 		return -ENODEV;
 
@@ -774,7 +781,10 @@ int __init op_nmi_init(struct oprofile_operations *ops)
 
 	mux_init(ops);
 
-	init_sysfs();
+	ret = init_sysfs();
+	if (ret)
+		return ret;
+
 	using_nmi = 1;
 	printk(KERN_INFO "oprofile: using NMI interrupt.\n");
 	return 0;
-- 
1.7.1.1



-- 
Advanced Micro Devices, Inc.
Operating System Research Center
