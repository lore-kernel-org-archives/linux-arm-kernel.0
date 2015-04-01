From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:15 -0700
Subject: [PATCH 1/6] selftest/memfd: enable cross compilation
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-2-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CC variable instead of hard coding gcc. Also clean up the compiler
options by creating a CFLAGS variable.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/memfd/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 191dee9..69f08ab 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -1,17 +1,18 @@
+CC = $(CROSS_COMPILE)gcc
 CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 
 all:
-	gcc $(CFLAGS) memfd_test.c -o memfd_test
+	$(CC) $(CFLAGS) memfd_test.c -o memfd_test
 
 TEST_PROGS := memfd_test
 
 include ../lib.mk
 
 build_fuse:
-	gcc $(CFLAGS) fuse_mnt.c `pkg-config fuse --cflags --libs` -o fuse_mnt
-	gcc $(CFLAGS) fuse_test.c -o fuse_test
+	$(CC) $(CFLAGS) fuse_mnt.c `pkg-config fuse --cflags --libs` -o fuse_mnt
+	$(CC) $(CFLAGS) fuse_test.c -o fuse_test
 
 run_fuse: build_fuse
 	@./run_fuse_test.sh || echo "fuse_test: [FAIL]"
-- 
2.1.4
