From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 6 May 2014 22:16:16 -0700
Subject: [PATCH] ARM: zImage: Allow DTB to override broken ATAG_MEM
Message-ID: <1399439776-18535-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support overriding ATAG_MEM, by specifying non-zero content of the /memory/reg
property in the appended DTB. This is needed to work around bootloaders passing
broken tags.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index d1153c8..b534cd6 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -95,6 +95,22 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 	setprop_string(fdt, "/chosen", "bootargs", cmdline);
 }
 
+static int fdt_overrides_atag_mem(void *fdt)
+{
+	const char *memory;
+	int len = 0;
+
+	memory = getprop(fdt, "/memory", "reg", &len);
+	if (memory) {
+		while (len--) {
+			if (*memory != '\0')
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
@@ -180,7 +196,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		}
 	}
 
-	if (memcount) {
+	if (memcount && !fdt_overrides_atag_mem(fdt)) {
 		setprop(fdt, "/memory", "reg", mem_reg_property,
 			4 * memcount * memsize);
 	}
-- 
1.7.9.5
