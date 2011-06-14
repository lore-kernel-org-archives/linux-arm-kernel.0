From: davidb@codeaurora.org (David Brown)
Date: Tue, 14 Jun 2011 16:27:54 -0700
Subject: [PATCH] Support multiple MEM tags with atags->fdt conversion
In-Reply-To: <alpine.LFD.2.00.1106140300500.2142@xanadu.home>
Message-ID: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some targets have multiple memory regions.  Parse up to 8 of these
when converting the atags to fdt.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
With this change, I am able to boot MSM8x60 combining ATAGS and my DT.
It seems to work as long as my device tree has placeholders for all of
the properties I need.

It still seems rather clunky, especially that it requires bootimg from
a zImage.

David

 arch/arm/boot/compressed/atags_to_fdt.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 11c1a88..ac93e28 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -31,6 +31,8 @@ static int setprop_cell(void *fdt, const char *node_path,
 int atags_to_fdt(void *dt,  void *atag_list)
 {
 	struct tag *atag = atag_list;
+	uint32_t mem_reg_property[16];
+	int memcount = 0;
 
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
@@ -51,11 +53,10 @@ int atags_to_fdt(void *dt,  void *atag_list)
 			setprop_string(dt, "/chosen", "bootargs",
 			                  atag->u.cmdline.cmdline);
 		} else if (atag->hdr.tag == ATAG_MEM) {
-			uint32_t mem_reg_property[2];
-			mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
-			mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
-			setprop(dt, "/memory", "reg", mem_reg_property,
-			           sizeof(mem_reg_property));
+			if (memcount >= sizeof(mem_reg_property)/sizeof(uint32_t))
+				continue;
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.start);
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.size);
 		} else if (atag->hdr.tag == ATAG_INITRD2) {
 			uint32_t initrd_start, initrd_size;
 			initrd_start = atag->u.initrd.start;
@@ -67,5 +68,10 @@ int atags_to_fdt(void *dt,  void *atag_list)
 		}
 	}
 
+	if (memcount) {
+		setprop(dt, "/memory", "reg", mem_reg_property,
+				4*memcount);
+	}
+
 	return 0;
 }
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
