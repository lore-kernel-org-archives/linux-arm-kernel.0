From: huawei.libin@huawei.com (Li Bin)
Date: Wed, 28 Oct 2015 16:04:05 +0800
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call into nop
Message-ID: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By now, the recordmcount only records the function that in
following sections:
.text/.ref.text/.sched.text/.spinlock.text/.irqentry.text/
.kprobes.text/.text.unlikely

For the function that not in these sections, the call mcount
will be in place and not be replaced when kernel boot up. And
it will bring performance overhead, such as do_mem_abort (in
.exception.text section). This patch make the call mcount to
nop for this case in recordmcount.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 scripts/recordmcount.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 3d1984e..f697226 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -42,6 +42,7 @@
 
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
+#define R_AARCH64_NONE		0
 #define R_AARCH64_ABS64	257
 #endif
 
@@ -160,6 +161,21 @@ static int make_nop_x86(void *map, size_t const offset)
 	return 0;
 }
 
+static unsigned char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
+static int make_nop_arm64(void *map, size_t const offset)
+{
+	uint32_t *ptr;
+
+	ptr = map + offset;
+	if (*ptr != 0x94000000)
+		return -1;
+
+	/* Convert to nop */
+	ulseek(fd_map, offset, SEEK_SET);
+	uwrite(fd_map, ideal_nop, 4);
+	return 0;
+}
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
@@ -353,7 +369,12 @@ do_file(char const *const fname)
 			 altmcount = "__gnu_mcount_nc";
 			 break;
 	case EM_AARCH64:
-			 reltype = R_AARCH64_ABS64; gpfx = '_'; break;
+			reltype = R_AARCH64_ABS64;
+			make_nop = make_nop_arm64;
+			rel_type_nop = R_AARCH64_NONE;
+			ideal_nop = ideal_nop4_arm64;
+			gpfx = '_';
+			break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
 	case EM_METAG:	 reltype = R_METAG_ADDR32;
 			 altmcount = "_mcount_wrapper";
-- 
1.7.12.4
