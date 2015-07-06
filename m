From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:10 +0200
Subject: [PATCH 2/5] arm: boot: convert ATAG_REVISION to DT "/revision" entry
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1436214373-12969-3-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When uncompressing kernel image this patch convert ATAG_REVISION structure
into DT "/revision" entry. For legacy bootloaders which do not support DT
booting there is no other option how to pass ATAG_REVISION into kernel.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 9448aa0..e7e1cc9 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -171,6 +171,8 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 					cpu_to_fdt32(atag->u.mem.size);
 			}
 
+		} else if (atag->hdr.tag == ATAG_REVISION) {
+			setprop_cell(fdt, "/", "revision", atag->u.revision.rev);
 		} else if (atag->hdr.tag == ATAG_INITRD2) {
 			uint32_t initrd_start, initrd_size;
 			initrd_start = atag->u.initrd.start;
-- 
1.7.9.5
