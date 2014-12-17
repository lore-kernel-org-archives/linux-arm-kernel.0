From: h.huangqiang@huawei.com (Qiang Huang)
Date: Tue, 16 Dec 2014 18:30:55 -0800
Subject: [PATCH boot-wrapper-aarch64] configure: Fix for --with-initrd=no
Message-ID: <5490EADF.7080906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our configure.ac script wasn't handle --with-initrd=no, when this was passed,
we got error:
...
aarch64-linux-gnu-ld -o linux-system.axf --script=model.lds
aarch64-linux-gnu-ld: cannot find no
make: *** [linux-system.axf] Error 1

Fix this by adding a line to check this.
And this also fixed --without-initrd.

Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
Cc: Geoff Levand <geoff@infradead.org>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 929da13..553013b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,7 @@ AC_SUBST([CPU_IDS], [$C_CPU_IDS])
 AC_ARG_WITH([initrd],
 	AS_HELP_STRING([--with-initrd], [embed an initrd in the kernel image]),
 	USE_INITRD=$withval)
+AS_IF([test "x$USE_INITRD" = "xno"], [USE_INITRD=], [])
 AC_SUBST([FILESYSTEM], [$USE_INITRD])
 AM_CONDITIONAL([INITRD], [test "x$USE_INITRD" != "x"])

-- 
