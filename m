From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Nov 2016 15:09:16 +0000
Subject: [PATCH v2 3/4] Xen: Select correct dom0 console
In-Reply-To: <20161122150917.16524-1-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
Message-ID: <20161122150917.16524-4-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ian Campbell <ian.campbell@citrix.com>

If Xen is enabled, tell Dom0 to use the 'hvc0' console, and fall back to
the usual ttyAMA0 otherwise.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Julien Grall <julien.grall@arm.com>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index aff4aad..c959ab8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,7 +92,8 @@ AC_ARG_WITH([initrd],
 AC_SUBST([FILESYSTEM], [$USE_INITRD])
 AM_CONDITIONAL([INITRD], [test "x$USE_INITRD" != "x"])
 
-C_CMDLINE="console=ttyAMA0 earlyprintk=pl011,0x1c090000"
+AS_IF([test "x$X_IMAGE" = "x"],[C_CONSOLE="ttyAMA0"],[C_CONSOLE="hvc0"])
+C_CMDLINE="console=$C_CONSOLE earlyprintk=pl011,0x1c090000"
 AC_ARG_WITH([cmdline],
 	AS_HELP_STRING([--with-cmdline], [set a command line for the kernel]),
 	[C_CMDLINE=$withval])
-- 
2.9.0
