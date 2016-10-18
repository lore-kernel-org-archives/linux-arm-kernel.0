From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 16:42:00 -0700
Subject: [PATCH/RESEND] recordmcount: arm: Implement make_nop
Message-ID: <20161018234200.5804-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In similar spirit to x86 and arm64 support, add a make_nop_arm()
to replace calls to mcount with a nop in sections that aren't
traced.

Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 scripts/recordmcount.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 5423a58d1b06..aeb34223167c 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -213,6 +213,59 @@ static int make_nop_x86(void *map, size_t const offset)
 	return 0;
 }
 
+static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
+static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
+static unsigned char *ideal_nop4_arm;
+
+static unsigned char bl_mcount_arm_le[4] = { 0xfe, 0xff, 0xff, 0xeb }; /* bl */
+static unsigned char bl_mcount_arm_be[4] = { 0xeb, 0xff, 0xff, 0xfe }; /* bl */
+static unsigned char *bl_mcount_arm;
+
+static unsigned char push_arm_le[4] = { 0x04, 0xe0, 0x2d, 0xe5 }; /* push {lr} */
+static unsigned char push_arm_be[4] = { 0xe5, 0x2d, 0xe0, 0x04 }; /* push {lr} */
+static unsigned char *push_arm;
+
+static unsigned char ideal_nop2_thumb_le[2] = { 0x00, 0xbf }; /* nop */
+static unsigned char ideal_nop2_thumb_be[2] = { 0xbf, 0x00 }; /* nop */
+static unsigned char *ideal_nop2_thumb;
+
+static unsigned char push_bl_mcount_thumb_le[6] = { 0x00, 0xb5, 0xff, 0xf7, 0xfe, 0xff }; /* push {lr}, bl */
+static unsigned char push_bl_mcount_thumb_be[6] = { 0xb5, 0x00, 0xf7, 0xff, 0xff, 0xfe }; /* push {lr}, bl */
+static unsigned char *push_bl_mcount_thumb;
+
+static int make_nop_arm(void *map, size_t const offset)
+{
+	char *ptr;
+	int cnt = 1;
+	int nop_size;
+	size_t off = offset;
+
+	ptr = map + offset;
+	if (memcmp(ptr, bl_mcount_arm, 4) == 0) {
+		if (memcmp(ptr - 4, push_arm, 4) == 0) {
+			off -= 4;
+			cnt = 2;
+		}
+		ideal_nop = ideal_nop4_arm;
+		nop_size = 4;
+	} else if (memcmp(ptr - 2, push_bl_mcount_thumb, 6) == 0) {
+		cnt = 3;
+		nop_size = 2;
+		off -= 2;
+		ideal_nop = ideal_nop2_thumb;
+	} else
+		return -1;
+
+	/* Convert to nop */
+	ulseek(fd_map, off, SEEK_SET);
+
+	do {
+		uwrite(fd_map, ideal_nop, nop_size);
+	} while (--cnt > 0);
+
+	return 0;
+}
+
 static unsigned char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
 static int make_nop_arm64(void *map, size_t const offset)
 {
@@ -430,6 +483,11 @@ do_file(char const *const fname)
 			w2 = w2rev;
 			w8 = w8rev;
 		}
+		ideal_nop4_arm = ideal_nop4_arm_le;
+		bl_mcount_arm = bl_mcount_arm_le;
+		push_arm = push_arm_le;
+		ideal_nop2_thumb = ideal_nop2_thumb_le;
+		push_bl_mcount_thumb = push_bl_mcount_thumb_le;
 		break;
 	case ELFDATA2MSB:
 		if (*(unsigned char const *)&endian != 0) {
@@ -438,6 +496,11 @@ do_file(char const *const fname)
 			w2 = w2rev;
 			w8 = w8rev;
 		}
+		ideal_nop4_arm = ideal_nop4_arm_be;
+		bl_mcount_arm = bl_mcount_arm_be;
+		push_arm = push_arm_be;
+		ideal_nop2_thumb = ideal_nop2_thumb_be;
+		push_bl_mcount_thumb = push_bl_mcount_thumb_be;
 		break;
 	}  /* end switch */
 	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0
@@ -463,6 +526,8 @@ do_file(char const *const fname)
 		break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
+			 make_nop = make_nop_arm;
+			 rel_type_nop = R_ARM_NONE;
 			 break;
 	case EM_AARCH64:
 			reltype = R_AARCH64_ABS64;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
