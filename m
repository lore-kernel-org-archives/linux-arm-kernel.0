From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Fri, 15 May 2015 21:50:07 +0200
Subject: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
In-Reply-To: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1431719407-18230-3-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch stores existing ATAG structure into DT /atags field
and so previous patch exports it for userspace via /proc/atags.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index b23748e..4a4a70c 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -145,7 +145,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	 * address and size for each bank */
 	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
 	int memcount = 0;
-	int ret, memsize;
+	int ret, memsize, atag_size;
 
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
@@ -219,6 +219,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		}
 	}
 
+	/* include the terminating ATAG_NONE */
+	atag_size = (char *)atag - (char *)atag_list + sizeof(struct tag_header);
+	setprop(fdt, "/", "atags", atag_list, atag_size);
+
 	if (memcount) {
 		setprop(fdt, "/memory", "reg", mem_reg_property,
 			4 * memcount * memsize);
-- 
1.7.9.5
