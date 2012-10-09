From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:59 +0200
Subject: [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* The XEN_BALLOON code requires the balloon infrastructure that is not
  getting built on ARM.

* The tmem hypercall is not available on ARM

* ARMv6 does not support cmpxchg on 16-bit words that are used in the

* sys-hypervisor.c needs to include linux/err.h in order to use the
  IS_ERR/PTR_ERR/ERR_PTR family of functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel at lists.xensource.com
---
 arch/arm/Kconfig             |    1 +
 drivers/xen/Kconfig          |    2 ++
 drivers/xen/sys-hypervisor.c |    1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d2f7f5..85eaac3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1846,6 +1846,7 @@ config XEN_DOM0
 config XEN
 	bool "Xen guest support on ARM (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ARM && OF
+	depends on !CPU_V6
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d4dffcd..126d8ce 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -3,6 +3,7 @@ menu "Xen driver support"
 
 config XEN_BALLOON
 	bool "Xen memory balloon driver"
+	depends on !ARM
 	default y
 	help
 	  The balloon driver allows the Xen domain to request more memory from
@@ -145,6 +146,7 @@ config SWIOTLB_XEN
 
 config XEN_TMEM
 	bool
+	depends on !ARM
 	default y if (CLEANCACHE || FRONTSWAP)
 	help
 	  Shim to interface in-kernel Transcendent Memory hooks
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 5e5ad7e..66a0a14 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kobject.h>
+#include <linux/err.h>
 
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
-- 
1.7.10
