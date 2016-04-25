From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:35:29 +0200
Subject: [PATCH 3/5] gcov: disable for COMPILE_TEST
In-Reply-To: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
References: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
Message-ID: <1461598531-2190169-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling gcov is counterproductive to compile testing: it significantly
increases the kernel image size, compile time, and it produces lots
of false positive "may be used uninitialized" warnings as the result
of missed optimizations.

This is in line with how UBSAN_SANITIZE_ALL and PROFILE_ALL_BRANCHES
work, both of which have similar problems.

With an ARM allmodconfig kernel, I see the build time drop from
283 minutes CPU time to 225 minutes, and the vmlinux size drops
from 43MB to 26MB.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
---
 kernel/gcov/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index c92e44855ddd..1276aabaab55 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -37,6 +37,7 @@ config ARCH_HAS_GCOV_PROFILE_ALL
 
 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
+	depends on !COMPILE_TEST
 	depends on GCOV_KERNEL
 	depends on ARCH_HAS_GCOV_PROFILE_ALL
 	default n
-- 
2.7.0
