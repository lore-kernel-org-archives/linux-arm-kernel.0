From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:13 +0200
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,
 atags" entry
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy bootloaders can pass additional information for kernel or legacy
userspace applications. When booting DT kernel then ATAGs structure is not
more visible after running kernel uncompress code. This patch stores full
ATAGs structure into DT "/chosen/linux,atags" entry, so kernel can later
reuse it and export via /proc/atags to userspace.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index e7e1cc9..ae93973 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -112,7 +112,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	 * address and size for each bank */
 	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
 	int memcount = 0;
-	int ret, memsize;
+	int ret, memsize, atag_size;
 
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
@@ -189,5 +189,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 			4 * memcount * memsize);
 	}
 
+	/* include the terminating ATAG_NONE */
+	atag_size = (char *)atag - (char *)atag_list + sizeof(struct tag_header);
+	setprop(fdt, "/chosen", "linux,atags", atag_list, atag_size);
+
 	return fdt_pack(fdt);
 }
-- 
1.7.9.5
