From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Feb 2015 15:29:26 -0600
Subject: [PATCH 4/4] firmware: qcom: scm: Move the scm driver to
 drivers/firmware
Message-ID: <1425072566-6397-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architectural changes in the ARM Linux kernel tree mandate the eventual
removal of the mach-* directories. Move the scm driver to
drivers/firmware and the scm header to include/linux to support that
removal.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
v2:
* Moved to -M style diff output
* Added in missing include of drivers/firmware/Kconfig into arch/arm/Kconfig

 MAINTAINERS                                             | 1 +
 arch/arm/Kconfig                                        | 2 ++
 arch/arm/mach-qcom/Kconfig                              | 3 ---
 arch/arm/mach-qcom/Makefile                             | 3 ---
 arch/arm/mach-qcom/platsmp.c                            | 2 +-
 drivers/firmware/Kconfig                                | 4 ++++
 drivers/firmware/Makefile                               | 2 ++
 arch/arm/mach-qcom/scm.c => drivers/firmware/qcom_scm.c | 2 +-
 arch/arm/mach-qcom/scm.h => include/linux/qcom_scm.h    | 0
 9 files changed, 11 insertions(+), 8 deletions(-)
 rename arch/arm/mach-qcom/scm.c => drivers/firmware/qcom_scm.c (99%)
 rename arch/arm/mach-qcom/scm.h => include/linux/qcom_scm.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..beb8aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1317,6 +1317,7 @@ L:	linux-soc at vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-qcom/
 F:	drivers/soc/qcom/
+F:	drivers/firmware/qcom_scm.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..7ffd151 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2160,6 +2160,8 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
+source "drivers/firmware/Kconfig"
+
 source "fs/Kconfig"
 
 source "arch/arm/Kconfig.debug"
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 48003ea..2256cd1 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -22,7 +22,4 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
-config QCOM_SCM
-	bool
-
 endif
diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
index 10b6841..e324375 100644
--- a/arch/arm/mach-qcom/Makefile
+++ b/arch/arm/mach-qcom/Makefile
@@ -1,5 +1,2 @@
 obj-y			:= board.o
 obj-$(CONFIG_SMP)	+= platsmp.o
-obj-$(CONFIG_QCOM_SCM)	+= scm.o
-
-CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 596e623..4b67e56 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -17,10 +17,10 @@
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/qcom_scm.h>
 
 #include <asm/smp_plat.h>
 
-#include "scm.h"
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL	0x35a0
 #define SCSS_CPU1CORE_RESET		0x2d80
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 41983883..6517132 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -132,6 +132,10 @@ config ISCSI_IBFT
 	  detect iSCSI boot parameters dynamically during system boot, say Y.
 	  Otherwise, say N.
 
+config QCOM_SCM
+	bool
+	depends on ARM || ARM64
+
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5373dc5..3fdd391 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_DMIID)		+= dmi-id.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
+obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
+CFLAGS_qcom_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
diff --git a/arch/arm/mach-qcom/scm.c b/drivers/firmware/qcom_scm.c
similarity index 99%
rename from arch/arm/mach-qcom/scm.c
rename to drivers/firmware/qcom_scm.c
index 3e0e334..6e7a72b 100644
--- a/arch/arm/mach-qcom/scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -21,11 +21,11 @@
 #include <linux/mutex.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/qcom_scm.h>
 
 #include <asm/outercache.h>
 #include <asm/cacheflush.h>
 
-#include "scm.h"
 
 #define QCOM_SCM_ENOMEM		-5
 #define QCOM_SCM_EOPNOTSUPP	-4
diff --git a/arch/arm/mach-qcom/scm.h b/include/linux/qcom_scm.h
similarity index 100%
rename from arch/arm/mach-qcom/scm.h
rename to include/linux/qcom_scm.h
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
