From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sat, 13 Sep 2014 12:39:20 -0700
Subject: [PATCH] arm: add missing exports for asm functions required by
 get_user macro
Message-ID: <1410637161-4865-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Patch following this cover latter fixes issue that you reported [1]
with '[PATCH V3] arm: fix get_user BE behavior for target variable with 
size of 8 bytes' patch:

ERROR: "__get_user_64t_4" [fs/ext4/ext4.ko] undefined!
ERROR: "__get_user_64t_4" [fs/cifs/cifs.ko] undefined!

The issue is that newly introduced get_user macro helper asm
functions were not exported. So in case of ext4 and cifs compiled
as kernel modules in BE image the issue got exposed.

While looking at this I realized that __get_user_8 helper
function added by other commit is not exported too. It would
affect LE image as well but fortunately currently there is 
no module that use get_user in such combination.

The proposed patch adds export for all recently added
asm helper functions used by get_user macro.

I've tested all combinations of target variable types 
(1, 2, 4, 8 bytes), value pointer type (1, 2, 4, 8 bytes), 
kernel/module, and BE/LE with test patch provided below.
It all looks good now abd it addresses reported issue.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287167.html

Appendix 1
----------

Patch that was used for testing of get_user macro export fix.
It is provided just for reference only.

>From d34a035769fae6a6dff9f407daa7f0e65bfe55a9 Mon Sep 17 00:00:00 2001
From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Wed, 20 Aug 2014 19:31:28 -0700
Subject: [PATCH] arm: get_user tests

Test different combinations of value and pointers passed to
get_user macro.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/Makefile         |   3 +
 arch/arm/kernel/get_user_test.h  |  54 ++++++++++++++
 arch/arm/kernel/get_user_test1.c |  77 ++++++++++++++++++++
 arch/arm/kernel/get_user_test2.c | 151 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 arch/arm/kernel/get_user_test.h
 create mode 100644 arch/arm/kernel/get_user_test1.c
 create mode 100644 arch/arm/kernel/get_user_test2.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 38ddd9f..193e581 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -30,6 +30,9 @@ else
 obj-y		+= entry-armv.o
 endif
 
+obj-m		+= test-get_user.o
+test-get_user-objs += get_user_test1.o get_user_test2.o
+
 obj-$(CONFIG_OC_ETM)		+= etm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
diff --git a/arch/arm/kernel/get_user_test.h b/arch/arm/kernel/get_user_test.h
new file mode 100644
index 0000000..723f03a
--- /dev/null
+++ b/arch/arm/kernel/get_user_test.h
@@ -0,0 +1,54 @@
+typedef char	   tint8_t;
+typedef short	  tint16_t;
+typedef int	  tint32_t;
+typedef long long tint64_t;
+
+#define GUT_LOWER_TEST_DECLARE(vs, ps)			\
+	tint8_t gut_lower_v ## vs ## _p ## ps		\
+	(tint ## ps ## _t *ptr);
+
+GUT_LOWER_TEST_DECLARE(64, 8)
+GUT_LOWER_TEST_DECLARE(64, 16)
+GUT_LOWER_TEST_DECLARE(64, 32)
+GUT_LOWER_TEST_DECLARE(64, 64)
+
+GUT_LOWER_TEST_DECLARE(32, 8)
+GUT_LOWER_TEST_DECLARE(32, 16)
+GUT_LOWER_TEST_DECLARE(32, 32)
+GUT_LOWER_TEST_DECLARE(32, 64)
+
+GUT_LOWER_TEST_DECLARE(16, 8)
+GUT_LOWER_TEST_DECLARE(16, 16)
+GUT_LOWER_TEST_DECLARE(16, 32)
+GUT_LOWER_TEST_DECLARE(16, 64)
+
+GUT_LOWER_TEST_DECLARE(8, 8)
+GUT_LOWER_TEST_DECLARE(8, 16)
+GUT_LOWER_TEST_DECLARE(8, 32)
+GUT_LOWER_TEST_DECLARE(8, 64)
+
+
+#define GUT_UPPER_TEST_DECLARE(vs, ps)			\
+	tint8_t gut_upper_v ## vs ## _p ## ps		\
+	(tint ## ps ## _t *ptr);
+
+GUT_UPPER_TEST_DECLARE(64, 8)
+GUT_UPPER_TEST_DECLARE(64, 16)
+GUT_UPPER_TEST_DECLARE(64, 32)
+GUT_UPPER_TEST_DECLARE(64, 64)
+
+GUT_UPPER_TEST_DECLARE(32, 8)
+GUT_UPPER_TEST_DECLARE(32, 16)
+GUT_UPPER_TEST_DECLARE(32, 32)
+GUT_UPPER_TEST_DECLARE(32, 64)
+
+GUT_UPPER_TEST_DECLARE(16, 8)
+GUT_UPPER_TEST_DECLARE(16, 16)
+GUT_UPPER_TEST_DECLARE(16, 32)
+GUT_UPPER_TEST_DECLARE(16, 64)
+
+GUT_UPPER_TEST_DECLARE(8, 8)
+GUT_UPPER_TEST_DECLARE(8, 16)
+GUT_UPPER_TEST_DECLARE(8, 32)
+GUT_UPPER_TEST_DECLARE(8, 64)
+
diff --git a/arch/arm/kernel/get_user_test1.c b/arch/arm/kernel/get_user_test1.c
new file mode 100644
index 0000000..e34b168
--- /dev/null
+++ b/arch/arm/kernel/get_user_test1.c
@@ -0,0 +1,77 @@
+#include <asm/uaccess.h>
+
+#include "get_user_test.h"
+
+#define GUT_LOWER_TEST(vs, ps)				\
+	tint8_t gut_lower_v ## vs ## _p ## ps		\
+	(tint ## ps ## _t *ptr)				\
+{							\
+	tint ## vs ## _t value = 0;			\
+							\
+	mm_segment_t fs;				\
+	fs = get_fs();					\
+	set_fs(KERNEL_DS);				\
+							\
+	get_user(value, ptr);				\
+							\
+	set_fs(fs);					\
+	return 0xff & value;				\
+}							\
+
+GUT_LOWER_TEST(64, 8)
+GUT_LOWER_TEST(64, 16)
+GUT_LOWER_TEST(64, 32)
+GUT_LOWER_TEST(64, 64)
+
+GUT_LOWER_TEST(32, 8)
+GUT_LOWER_TEST(32, 16)
+GUT_LOWER_TEST(32, 32)
+GUT_LOWER_TEST(32, 64)
+
+GUT_LOWER_TEST(16, 8)
+GUT_LOWER_TEST(16, 16)
+GUT_LOWER_TEST(16, 32)
+GUT_LOWER_TEST(16, 64)
+
+GUT_LOWER_TEST(8, 8)
+GUT_LOWER_TEST(8, 16)
+GUT_LOWER_TEST(8, 32)
+GUT_LOWER_TEST(8, 64)
+
+
+#define GUT_UPPER_TEST(vs, ps)				\
+	tint8_t gut_upper_v ## vs ## _p ## ps		\
+	(tint ## ps ## _t *ptr)				\
+{							\
+	tint ## vs ## _t value = 0;			\
+							\
+	mm_segment_t fs;				\
+	fs = get_fs();					\
+	set_fs(KERNEL_DS);				\
+							\
+	get_user(value, ptr);				\
+							\
+	set_fs(fs);					\
+	return 0xff & (value >> ((vs > ps) ? (ps - 8) : (vs - 8)));	\
+}							\
+
+
+GUT_UPPER_TEST(64, 8)
+GUT_UPPER_TEST(64, 16)
+GUT_UPPER_TEST(64, 32)
+GUT_UPPER_TEST(64, 64)
+
+GUT_UPPER_TEST(32, 8)
+GUT_UPPER_TEST(32, 16)
+GUT_UPPER_TEST(32, 32)
+GUT_UPPER_TEST(32, 64)
+
+GUT_UPPER_TEST(16, 8)
+GUT_UPPER_TEST(16, 16)
+GUT_UPPER_TEST(16, 32)
+GUT_UPPER_TEST(16, 64)
+
+GUT_UPPER_TEST(8, 8)
+GUT_UPPER_TEST(8, 16)
+GUT_UPPER_TEST(8, 32)
+GUT_UPPER_TEST(8, 64)
diff --git a/arch/arm/kernel/get_user_test2.c b/arch/arm/kernel/get_user_test2.c
new file mode 100644
index 0000000..e483464
--- /dev/null
+++ b/arch/arm/kernel/get_user_test2.c
@@ -0,0 +1,151 @@
+#include <linux/module.h>
+#include "get_user_test.h"
+
+tint8_t gut_data8 = 0x12;
+tint16_t gut_data16 = 0x1234;
+tint32_t gut_data32 = 0x12345678;
+tint64_t gut_data64 = 0x1234567890abcdef;
+
+#define GUT_RUN_LOWER_TEST(vs, ps, expect)				\
+	void gut_run_lower_v ## vs ## _p ## ps				\
+	(void)								\
+{									\
+	tint8_t ret = gut_lower_v ## vs ## _p ## ps (&gut_data ## ps);	\
+	if (ret == expect) {						\
+		printk("GUT_TEST: lower v" #vs "_" #ps ": PASS\n");	\
+	} else {							\
+		printk("GUT_TEST: lower v" #vs "_" #ps			\
+		       ": FAILED: expected 0x%x got 0x%x\n",		\
+		       expect, ret);					\
+	}								\
+}
+
+
+GUT_RUN_LOWER_TEST(64, 8, 0x12)
+GUT_RUN_LOWER_TEST(64, 16, 0x34)
+GUT_RUN_LOWER_TEST(64, 32, 0x78)
+GUT_RUN_LOWER_TEST(64, 64, 0xef)
+
+GUT_RUN_LOWER_TEST(32, 8, 0x12)
+GUT_RUN_LOWER_TEST(32, 16, 0x34)
+GUT_RUN_LOWER_TEST(32, 32, 0x78)
+GUT_RUN_LOWER_TEST(32, 64, 0xef)
+
+GUT_RUN_LOWER_TEST(16, 8, 0x12)
+GUT_RUN_LOWER_TEST(16, 16, 0x34)
+GUT_RUN_LOWER_TEST(16, 32, 0x78)
+GUT_RUN_LOWER_TEST(16, 64, 0xef)
+
+GUT_RUN_LOWER_TEST(8, 8, 0x12)
+GUT_RUN_LOWER_TEST(8, 16, 0x34)
+GUT_RUN_LOWER_TEST(8, 32, 0x78)
+GUT_RUN_LOWER_TEST(8, 64, 0xef)
+
+#define GUT_RUN_UPPER_TEST(vs, ps, expect)				\
+	void gut_run_upper_v ## vs ## _p ## ps				\
+	(void)								\
+{									\
+	tint8_t ret = gut_upper_v ## vs ## _p ## ps (&gut_data ## ps);	\
+	if (ret == expect) {						\
+		printk("GUT_TEST: upper v" #vs "_" #ps ": PASS\n");	\
+	} else {							\
+		printk("GUT_TEST: upper v" #vs "_" #ps			\
+		       ": FAILED: expected 0x%x got 0x%x\n",		\
+		       expect, ret);					\
+	}								\
+}
+
+GUT_RUN_UPPER_TEST(64, 8, 0x12)
+GUT_RUN_UPPER_TEST(64, 16, 0x12)
+GUT_RUN_UPPER_TEST(64, 32, 0x12)
+GUT_RUN_UPPER_TEST(64, 64, 0x12)
+
+GUT_RUN_UPPER_TEST(32, 8, 0x12)
+GUT_RUN_UPPER_TEST(32, 16, 0x12)
+GUT_RUN_UPPER_TEST(32, 32, 0x12)
+GUT_RUN_UPPER_TEST(32, 64, 0x90)
+
+GUT_RUN_UPPER_TEST(16, 8, 0x12)
+GUT_RUN_UPPER_TEST(16, 16, 0x12)
+GUT_RUN_UPPER_TEST(16, 32, 0x56)
+GUT_RUN_UPPER_TEST(16, 64, 0xcd)
+
+GUT_RUN_UPPER_TEST(8, 8, 0x12)
+GUT_RUN_UPPER_TEST(8, 16, 0x34)
+GUT_RUN_UPPER_TEST(8, 32, 0x78)
+GUT_RUN_UPPER_TEST(8, 64, 0xef)
+
+
+#define GUT_RUN_LOWER_TEST_CALL(vs, ps) gut_run_lower_v ## vs ## _p ## ps ()
+#define GUT_RUN_UPPER_TEST_CALL(vs, ps) gut_run_upper_v ## vs ## _p ## ps ()
+
+static int
+run_all_tests (void)
+{
+	printk("GUT_TEST: start\n");
+
+	GUT_RUN_LOWER_TEST_CALL(64, 8);
+	GUT_RUN_LOWER_TEST_CALL(64, 16);
+	GUT_RUN_LOWER_TEST_CALL(64, 32);
+	GUT_RUN_LOWER_TEST_CALL(64, 64);
+
+	GUT_RUN_LOWER_TEST_CALL(32, 8);
+	GUT_RUN_LOWER_TEST_CALL(32, 16);
+	GUT_RUN_LOWER_TEST_CALL(32, 32);
+	GUT_RUN_LOWER_TEST_CALL(32, 64);
+
+	GUT_RUN_LOWER_TEST_CALL(16, 8);
+	GUT_RUN_LOWER_TEST_CALL(16, 16);
+	GUT_RUN_LOWER_TEST_CALL(16, 32);
+	GUT_RUN_LOWER_TEST_CALL(16, 64);
+
+	GUT_RUN_LOWER_TEST_CALL(8, 8);
+	GUT_RUN_LOWER_TEST_CALL(8, 16);
+	GUT_RUN_LOWER_TEST_CALL(8, 32);
+	GUT_RUN_LOWER_TEST_CALL(8, 64);
+
+
+	GUT_RUN_UPPER_TEST_CALL(64, 8);
+	GUT_RUN_UPPER_TEST_CALL(64, 16);
+	GUT_RUN_UPPER_TEST_CALL(64, 32);
+	GUT_RUN_UPPER_TEST_CALL(64, 64);
+
+	GUT_RUN_UPPER_TEST_CALL(32, 8);
+	GUT_RUN_UPPER_TEST_CALL(32, 16);
+	GUT_RUN_UPPER_TEST_CALL(32, 32);
+	GUT_RUN_UPPER_TEST_CALL(32, 64);
+
+	GUT_RUN_UPPER_TEST_CALL(16, 8);
+	GUT_RUN_UPPER_TEST_CALL(16, 16);
+	GUT_RUN_UPPER_TEST_CALL(16, 32);
+	GUT_RUN_UPPER_TEST_CALL(16, 64);
+
+	GUT_RUN_UPPER_TEST_CALL(8, 8);
+	GUT_RUN_UPPER_TEST_CALL(8, 16);
+	GUT_RUN_UPPER_TEST_CALL(8, 32);
+	GUT_RUN_UPPER_TEST_CALL(8, 64);
+
+	printk("GUT_TEST: finished\n");
+	return 0;
+}
+
+/*
+ * Module setup
+ */
+
+#ifdef MODULE
+
+static void
+test_exit(void)
+{
+}
+
+module_init(run_all_tests)
+module_exit(test_exit)
+MODULE_LICENSE("GPL");
+
+#else /* !MODULE */
+
+late_initcall(run_all_tests);
+
+#endif
-- 
1.8.1.4


Victor Kamensky (1):
  arm: add missing exports for asm functions required by get_user macro

 arch/arm/kernel/armksyms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
1.8.1.4
