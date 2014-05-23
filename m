From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 23 May 2014 16:19:45 +0100
Subject: [PATCH] efi: arm64: memory node handling cleanup
Message-ID: <1400858385-32079-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused variable, and convert strncmp() to strcmp(), since the
former is not available in arm zImage.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 drivers/firmware/efi/fdt.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/fdt.c b/drivers/firmware/efi/fdt.c
index 5c6a8e8..ab12870 100644
--- a/drivers/firmware/efi/fdt.c
+++ b/drivers/firmware/efi/fdt.c
@@ -63,15 +63,14 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 	 */
 	prev = 0;
 	for (;;) {
-		const char *type, *name;
-		int len;
+		const char *type;
 
 		node = fdt_next_node(fdt, prev, NULL);
 		if (node < 0)
 			break;
 
-		type = fdt_getprop(fdt, node, "device_type", &len);
-		if (type && strncmp(type, "memory", len) == 0) {
+		type = fdt_getprop(fdt, node, "device_type", NULL);
+		if (type && strcmp(type, "memory") == 0) {
 			fdt_del_node(fdt, node);
 			continue;
 		}
-- 
1.7.10.4
