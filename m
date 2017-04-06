From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  6 Apr 2017 20:07:25 +0100
Subject: [RFC kvm-unit-tests PATCH 6/8] Makefiles: handle linking of scripts
 into build-tree
In-Reply-To: <20170406190727.5624-1-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
Message-ID: <20170406190727.5624-7-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing an out-of-src-tree build we still want access to the
various bits of common script machinery to run. This is handled by the
scripts-common list which sub-builds can add explicit extra stuff to.

The final rule is conditional so we don't attempt to link files when
we are doing an in-src-tree build.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 Makefile            | 13 +++++++++++++
 x86/Makefile.common |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index 56598df..c9fea88 100644
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,10 @@ cflatobjs := \
 	lib/report.o \
 	lib/stack.o
 
+# These are scripts we want linked from the source tree
+scripts-common := run_tests.sh \
+	scripts
+
 # libfdt paths
 LIBFDT_objdir = $(SRCDIR)/lib/libfdt
 LIBFDT_srcdir = $(SRCDIR)/lib/libfdt
@@ -86,8 +90,17 @@ $(LIBFDT_archive): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 	mkdir -p $(dir $@)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
+$(scripts-common): $(SRCDIR)/$@
+	ln -sf $<$@ $@
+
 -include */.*.d */*/.*.d
 
+
+# We only need to link common scripts for out-of-src-tree builds
+ifneq ($(CURDIR), $(SRCDIR))
+all: $(scripts-common)
+endif
+
 all: $(shell git -C $(SRCDIR) rev-parse --verify --short=8 HEAD >build-head 2>/dev/null)
 
 standalone: all
diff --git a/x86/Makefile.common b/x86/Makefile.common
index fbab82c..ef6e543 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -54,8 +54,12 @@ tests-common += api/dirty-log
 tests-common += api/dirty-log-perf
 endif
 
+scripts-common += $(TEST_DIR)/run
+scripts-common += $(TEST_DIR)/unittests.cfg
+
 test_cases: $(tests-common) $(tests)
 
+
 $(TEST_DIR)/%.o: CFLAGS += -std=gnu99 -ffreestanding -I lib -I lib/x86
 
 $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o
-- 
2.11.0
