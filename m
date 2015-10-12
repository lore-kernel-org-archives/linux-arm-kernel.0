From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 16:56:19 +0200
Subject: [PATCH] firmware: qcom-scm: build for correct architecture level
Message-ID: <8346311.PtPZJEII3N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ".arch_extension sec" directive is only available on ARMv6 or higher,
so if we enable the SCM driver while building a kernel for an older CPU,
we get a build error:

/tmp/ccUyhMOY.s:130: Error: selected processor does not support ARM mode `smc #0'
/tmp/ccUyhMOY.s:216: Error: selected processor does not support ARM mode `smc #0'
/tmp/ccUyhMOY.s:373: Error: selected processor does not support ARM mode `smc #0'
make[4]: *** [drivers/firmware/qcom_scm-32.o] Error 1

This changes the Makefile so we pass the ARMv7 architecture level both
for the check and for the actual compilation of the scm driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 2ee83474a3c1..f0066373b170 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
 obj-$(CONFIG_QCOM_SCM_64)	+= qcom_scm-64.o
 obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
-CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
+CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQUIRES_SEC=1) -march=armv7-a
 
 obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
