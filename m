From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 10:39:08 +0100
Subject: [PATCH v10 03/11] remoteproc: Update Kconfig setup to 'depends on
 REMOTEPROC'
In-Reply-To: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1476783556-2501-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make REMOTEPROC core a selectable kconfig option, and update
remoteproc client drivers to 'depends on' the core. This avoids
some nasty Kconfig recursive dependency issues. Also when using
menuconfig client drivers will be hidden until the core has been
enabled.

Documentation/kbuild/kconfig-language.txt:

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/remoteproc/Kconfig | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 9270c8e..14d5d2d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -1,20 +1,21 @@
 menu "Remoteproc drivers"
 
-# REMOTEPROC gets selected by whoever wants it
 config REMOTEPROC
-	tristate
+	tristate "Support for Remote Processor subsystem"
 	depends on HAS_DMA
 	select CRC32
 	select FW_LOADER
 	select VIRTIO
 	select VIRTUALIZATION
 
+if REMOTEPROC
+
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
 	depends on HAS_DMA
 	depends on ARCH_OMAP4 || SOC_OMAP5
 	depends on OMAP_IOMMU
-	select REMOTEPROC
+	depends on REMOTEPROC
 	select MAILBOX
 	select OMAP2PLUS_MBOX
 	select RPMSG_VIRTIO
@@ -34,7 +35,7 @@ config OMAP_REMOTEPROC
 config STE_MODEM_RPROC
 	tristate "STE-Modem remoteproc support"
 	depends on HAS_DMA
-	select REMOTEPROC
+	depends on REMOTEPROC
 	default n
 	help
 	  Say y or m here to support STE-Modem shared memory driver.
@@ -44,7 +45,7 @@ config STE_MODEM_RPROC
 config WKUP_M3_RPROC
 	tristate "AMx3xx Wakeup M3 remoteproc support"
 	depends on SOC_AM33XX || SOC_AM43XX
-	select REMOTEPROC
+	depends on REMOTEPROC
 	help
 	  Say y here to support Wakeup M3 remote processor on TI AM33xx
 	  and AM43xx family of SoCs.
@@ -57,6 +58,7 @@ config WKUP_M3_RPROC
 config DA8XX_REMOTEPROC
 	tristate "DA8xx/OMAP-L13x remoteproc support"
 	depends on ARCH_DAVINCI_DA8XX
+	depends on REMOTEPROC
 	select CMA if MMU
 	select RPMSG_VIRTIO
 	help
@@ -83,9 +85,9 @@ config QCOM_Q6V5_PIL
 	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on REMOTEPROC
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
-	select REMOTEPROC
 	help
 	  Say y here to support the Qualcomm Peripherial Image Loader for the
 	  Hexagon V5 based remote processors.
@@ -109,7 +111,7 @@ config QCOM_WCNSS_PIL
 config ST_REMOTEPROC
 	tristate "ST remoteproc support"
 	depends on ARCH_STI
-	select REMOTEPROC
+	depends on REMOTEPROC
 	help
 	  Say y here to support ST's adjunct processors via the remote
 	  processor framework.
@@ -117,6 +119,8 @@ config ST_REMOTEPROC
 
 config ST_SLIM_REMOTEPROC
 	tristate
-	select REMOTEPROC
+	depends on REMOTEPROC
+
+endif # REMOTEPROC
 
 endmenu
-- 
1.9.1
