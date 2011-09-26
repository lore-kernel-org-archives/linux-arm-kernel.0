From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Sep 2011 19:24:26 +0200
Subject: [PATCH v3] mach-integrator: update defconfig
Message-ID: <1317057866-3995-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Integrator defconfig with some sensible defaults:
- Compile a combined image supporting Integrator/AP and
  Integrator/CP, with the core modules CM720, CM920, CM922,
  CM926, CM1020, CM1022 and CM1026 in a single image, this
  works just fine and gives some nice compilation coverage
- NOHZ (tickless) and HRTIMERS turned on
- Compile using EABI, let's assume recent compilers are used
  now (tested using GCC 4.4.1)
- Remove forced 32MiB at command line, the bootloader usually
  knows this better, and my U-Boot patches nowadays make that
  boot loader pass the correct adjusted value
- Enable the MTD Physmap flash driver, so that the changes done
  earlier by Marc Zyngier replacing integrator-flash takes
  effect
- Enable the PL030 RTC driver that has not been default-compiled
  with any config for a while

This has been tested on the real hardware Integrator AP with
both an ARM920T and ARM926EJ-S core module.

Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- None - by mistake
ChangeLog v2->v3:
- Actually commit and include the intended changes
---
 arch/arm/configs/integrator_defconfig |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 7196ade..1103f62 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -1,5 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_TINY_RCU=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -8,20 +9,29 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
+CONFIG_ARCH_INTEGRATOR_CP=y
 CONFIG_CPU_ARM720T=y
 CONFIG_CPU_ARM920T=y
+CONFIG_CPU_ARM922T=y
+CONFIG_CPU_ARM926T=y
+CONFIG_CPU_ARM1020=y
+CONFIG_CPU_ARM1022=y
+CONFIG_CPU_ARM1026=y
 CONFIG_PCI=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp mem=32M"
+CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_FPE_NWFPE=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -32,7 +42,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_AFS_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -40,6 +49,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -56,6 +66,8 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
 CONFIG_FB_MATROX_MYSTIQUE=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PL030=y
 CONFIG_EXT2_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
@@ -68,4 +80,3 @@ CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_ERRORS=y
-- 
1.7.6
