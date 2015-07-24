From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jul 2015 12:02:55 -0500
Subject: [PATCH] ARM: config: Switch PXA27x platforms to use PXA RTC driver
Message-ID: <1437757375-9113-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the SA1100 and PXA RTC drivers be mutually exclusive and no
longer sharing hardware, PXA27x/PXA3xx platforms must use the PXA RTC
driver as the SA1100 platform device is no longer registered.

This change should be almost transparent to userspace. Former users of
pxa-rtc should be aware that 2 RTCs will be available on their kernels,
rtc0 being sa1100-rtc and rtc1 being pxa-rtc. Any userspace relying on
the fact that rtc0 was pxa-rtc should be fixed.

As a consequence:
 - the first reboot after the switch will have the wrong time,
 - on dual boot platform where the other OS programs some logic into the
   sa1100 rtc IP, a lack of fix in userspace, ie. a kernel changing
   sa1100-rtc thinking it is pxa-rtc could have dire consequence, such
   as wiping the other OS data partition.

(Thanks to Robert Jarmik for help on the above commit text.)

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
PXA Maintainers,

This is dependent on my SA1100 RTC cleanup series[1]. Please comment on 
this patch and that series. The full series is available from a git 
branch here[2]. I've rebased it to 4.2-rc3, but otherwise there is no 
change from v4.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/349262.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git marvell/rtc

 arch/arm/configs/cm_x2xx_defconfig  | 2 +-
 arch/arm/configs/em_x270_defconfig  | 2 +-
 arch/arm/configs/magician_defconfig | 2 +-
 arch/arm/configs/palmz72_defconfig  | 2 +-
 arch/arm/configs/pcm027_defconfig   | 2 +-
 arch/arm/configs/trizeps4_defconfig | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index dc01c04..3b32d5f 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -157,7 +157,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_V3020=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_INOTIFY=y
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index 4560c9c..8e10df7 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -157,7 +157,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_V3020=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_INOTIFY=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 557dd29..a5b4920 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -150,7 +150,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DEBUG=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index 4baa83c..83c135e 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -67,7 +67,7 @@ CONFIG_MMC=y
 CONFIG_MMC_DEBUG=y
 CONFIG_MMC_PXA=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 0a847d0..b5624e3 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -82,7 +82,7 @@ CONFIG_MMC=y
 CONFIG_MMC_PXA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=m
-CONFIG_RTC_DRV_SA1100=m
+CONFIG_RTC_DRV_PXA=m
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 932ee4e..4bc8700 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -177,7 +177,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_RTC_DRV_PCF8583=m
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.1.0
