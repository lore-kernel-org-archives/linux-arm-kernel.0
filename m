From: cov@codeaurora.org (Christopher Covington)
Date: Fri,  1 Jul 2016 10:12:07 -0400
Subject: [PATCH] arm64: defconfig: Enable QDF2432 config options
Message-ID: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ACPI is on in the defconfig, the time seems right to enable
drivers for the SD/MMC, DMA, and pin control hardware described in the ACPI
tables of the QDF2432 server platform.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/configs/defconfig |  4 ++++
 scripts/patch-details.sh     | 21 ++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..c138425 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -186,6 +186,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_QDF2XXX=m
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
@@ -245,6 +246,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ACPI=m
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_TEGRA=y
@@ -272,6 +274,8 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_QCOM_BAM_DMA=y
+CONFIG_QCOM_HIDMA_MGMT=m
+CONFIG_QCOM_HIDMA=m
 CONFIG_RCAR_DMAC=y
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
diff --git a/scripts/patch-details.sh b/scripts/patch-details.sh
index ec7d163..4069855 100755
--- a/scripts/patch-details.sh
+++ b/scripts/patch-details.sh
@@ -35,7 +35,7 @@ submaint() {
             N; s/THE REST,//; s/,THE REST//; s/\n/	/'
 }
 
-echo "URL	RPK Style Tag	Version	Checkpatch Errors	Checkpatch Warnings	Rebases	Builds	Last Updated	Author	Subject	File Updates	Lines Added	Lines Removed	Maintainer(s)	Subsystem(s)"
+echo "URL	RPK Style Tag	Version	Checkpatch Errors	Checkpatch Warnings	Rebases	Builds	Boots	Last Updated	Author	Subject	File Updates	Lines Added	Lines Removed	Maintainer(s)	Subsystem(s)"
 while read u; do
   echo -n "$u	"
   p=
@@ -121,12 +121,27 @@ while read u; do
     if $build; then
       if (make defconfig && make) &> buildlog; then
         echo -n 'yes	'
+        if [ "$QEMU" ]; then
+          timeout 10 \
+            $QEMU \
+            -nodefaults \
+            -nographic \
+            -M virt \
+            -cpu cortex-a57 \
+            -m 512 \
+            -serial stdio \
+            -kernel arch/arm64/boot/Image \
+            -append "debug earlycon=pl011,0x9000000 rdinit=/bin/busybox poweroff -f" \
+            -initrd ../fs/busybox64.cpio.gz
+        else
+          echo -n '	'
+        fi
       else
         git reset --hard HEAD~1 &> /dev/null
-        echo -n 'no	'
+        echo -n 'no		'
       fi
     else
-      echo -n '	'
+      echo -n '		'
     fi
     awk -f scripts/parsepatch.awk /tmp/patch.mbox || diffstat -s /tmp/patch.mbox | awk -f scripts/parsepatch.awk
     submaint /tmp/patch.mbox
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
