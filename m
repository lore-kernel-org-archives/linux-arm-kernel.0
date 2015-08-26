From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 26 Aug 2015 19:15:07 +0300
Subject: [PATCH 4/4] libfdt, kasan: don't instrument libfdt.
In-Reply-To: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1440605707-8325-5-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

libfdt is used by EFI code and it runs before we setup early
shadow, so it has to be not instrumented to prevent boot crash.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 6897b52..44e1d81 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -165,7 +165,8 @@ obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
 	       fdt_empty_tree.o
 $(foreach file, $(libfdt_files), \
-	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
+	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt) \
+	$(eval KASAN_SANITIZE_$(file) := n))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
-- 
2.4.6
