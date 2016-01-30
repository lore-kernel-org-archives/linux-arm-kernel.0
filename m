From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 17:18:06 -0800
Subject: [PATCH] recordmcount: arm: Implement make_nop
Message-ID: <1454116686-30190-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In similar spirit to x86 and arm64 support, add a make_nop_arm()
to replace calls to mcount with a "nop" in sections that aren't
traced.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 scripts/recordmcount.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 scripts/recordmcount.h |  3 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e167592793a7..0b16d14c54fb 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -206,6 +206,52 @@ static int make_nop_x86(void *map, size_t const offset)
 	return 0;
 }
 
+/*
+ * Indicates if ARM is using __gnu_mcount_nc or mcount style and if
+ * we should replace it with a pop or a nop respectively.
+ */
+static int uses_altmcount;
+
+static unsigned char ideal_nop4_arm_arm[4] = { 0x00, 0x40, 0xbd, 0xe8 };
+static unsigned char ideal_nop4_arm_thumb[4] = { 0x5d, 0xf8, 0x04, 0xeb };
+static unsigned char ideal_nop4_arm_arm_be[4] = { 0xe8, 0xbd, 0x40, 0x00 };
+static unsigned char ideal_nop4_arm_thumb_be[4] = { 0xf8, 0x5d, 0xeb, 0x04 };
+static unsigned char ideal_nop4_arm_old[4] = { 0x00, 0x00, 0xa0, 0xe1 };
+static unsigned char ideal_nop4_arm_old_be[4] = { 0xe1, 0xa0, 0x00, 0x00 };
+
+static unsigned char bl_gnu_mcount_nc_arm[4] = { 0xfe, 0xff, 0xff, 0xeb };
+static unsigned char bl_gnu_mcount_nc_thumb[4] = { 0xff, 0xf7, 0xfe, 0xff };
+static unsigned char bl_gnu_mcount_nc_arm_be[4] = { 0xeb, 0xff, 0xff, 0xfe };
+static unsigned char bl_gnu_mcount_nc_thumb_be[4] = { 0xf7, 0xff, 0xff, 0xfe };
+
+static int make_nop_arm(void *map, size_t const offset)
+{
+	uint32_t *ptr;
+
+	ptr = map + offset;
+	if (memcmp(ptr, bl_gnu_mcount_nc_arm, 4) == 0) {
+		if (uses_altmcount)
+			ideal_nop = ideal_nop4_arm_arm;
+		else
+			ideal_nop = ideal_nop4_arm_old;
+	} else if (memcmp(ptr, bl_gnu_mcount_nc_arm_be, 4) == 0) {
+		if (uses_altmcount)
+			ideal_nop = ideal_nop4_arm_arm_be;
+		else
+			ideal_nop = ideal_nop4_arm_old_be;
+	} else if (memcmp(ptr, bl_gnu_mcount_nc_thumb, 4) == 0)
+		ideal_nop = ideal_nop4_arm_thumb;
+	else if (memcmp(ptr, bl_gnu_mcount_nc_thumb_be, 4) == 0)
+		ideal_nop = ideal_nop4_arm_thumb_be;
+	else
+		return -1;
+
+	/* Convert to nop */
+	ulseek(fd_map, offset, SEEK_SET);
+	uwrite(fd_map, ideal_nop, 4);
+	return 0;
+}
+
 static unsigned char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
 static int make_nop_arm64(void *map, size_t const offset)
 {
@@ -454,6 +500,9 @@ do_file(char const *const fname)
 		break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
+			 make_nop = make_nop_arm;
+			 rel_type_nop = R_ARM_NONE;
+			 ideal_nop = ideal_nop4_arm_arm;
 			 break;
 	case EM_AARCH64:
 			reltype = R_AARCH64_ABS64;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index b9897e2be404..890f5211745f 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -266,7 +266,8 @@ static unsigned get_mcountsym(Elf_Sym const *const sym0,
 	if (symname[0] == '.')
 		++symname;  /* ppc64 hack */
 	if (strcmp(mcount, symname) == 0 ||
-	    (altmcount && strcmp(altmcount, symname) == 0) ||
+	    (altmcount && strcmp(altmcount, symname) == 0 &&
+	     (uses_altmcount = 1)) ||
 	    (strcmp(fentry, symname) == 0))
 		mcountsym = Elf_r_sym(relp);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
