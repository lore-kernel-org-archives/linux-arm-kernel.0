From: lauraa@codeaurora.org (Laura Abbott)
Date: Sun, 29 Jun 2014 12:06:23 -0700
Subject: [PATCH 1/2] of: Split early_init_dt_scan into two parts
Message-ID: <1404068784-27604-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, early_init_dt_scan validates the header, sets the
boot params, and scans for chosen/memory all in one function.
Split this up into two separate functions (validation/setting
boot params in one, scanning in another) to allow for
additional setup between boot params and scanning the memory.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/of/fdt.c       | 18 +++++++++++++++++-
 include/linux/of_fdt.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c4cddf0..55bfca9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -922,7 +922,7 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 }
 #endif
 
-bool __init early_init_dt_scan(void *params)
+bool __init early_init_dt_verify(void *params)
 {
 	if (!params)
 		return false;
@@ -936,6 +936,12 @@ bool __init early_init_dt_scan(void *params)
 		return false;
 	}
 
+	return true;
+}
+
+
+void __init early_init_dt_scan_all(void)
+{
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 
@@ -944,7 +950,17 @@ bool __init early_init_dt_scan(void *params)
 
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+}
+
+bool __init early_init_dt_scan(void *params)
+{
+	bool status;
+
+	status = early_init_dt_verify(params);
+	if (!status)
+		return false;
 
+	early_init_dt_scan_all();
 	return true;
 }
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0511789..d600993 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -73,6 +73,8 @@ extern int early_init_dt_scan_root(unsigned long node, const char *uname,
 				   int depth, void *data);
 
 extern bool early_init_dt_scan(void *params);
+extern bool early_init_dt_verify(void *params);
+extern void early_init_dt_scan_all(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
