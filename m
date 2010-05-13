From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 May 2010 16:11:17 +0900
Subject: [PATCH] ARM: CONFG_FORCE_MAX_ZONEORDER update for SH-Mobile ARM
Message-ID: <20100513071117.27899.94230.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Allow SH-Mobile ARM users to adjust FORCE_MAX_ZONEORDER.

The Kconfig entry is taken from SH and non-4K page size
stuff has been trimmed away. For now only SH-Mobile ARM is
allowed to change this variable, SA1111 configs are kept at
"9" and the rest at "11".

CONFIG_FORCE_MAX_ZONEORDER lets the user tweak the maximum
amount of physically contiguous memory that can be alloced by
the kernel.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 A previous version that modified arch/arm/mach-shmobile/Kconfig
 was yesterday posted to linux-sh at vger.kernel.org as

 "[PATCH 02/05] ARM: mach-shmobile: Add CONFIG_FORCE_MAX_ZONEORDER"

 I did however receive feedback that this change is more suitable
 for general consumption in arch/arm/Kconfig. Hopefully this change
 is acceptable as-is by the ARM community.

 Let me know if you want me to rework things. Thank you!

 Built on top of linux-next 20100512.

 arch/arm/Kconfig |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2010-05-13 15:57:19.000000000 +0900
@@ -1076,11 +1076,6 @@ endmenu
 
 source "arch/arm/common/Kconfig"
 
-config FORCE_MAX_ZONEORDER
-	int
-	depends on SA1111
-	default "9"
-
 menu "Bus support"
 
 config ARM_AMBA
@@ -1337,6 +1332,22 @@ config HW_PERF_EVENTS
 
 source "mm/Kconfig"
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order" if ARCH_SHMOBILE
+	range 11 64 if ARCH_SHMOBILE
+	default "9" if SA1111
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
 config LEDS
 	bool "Timer and CPU usage LEDs"
 	depends on ARCH_CDB89712 || ARCH_EBSA110 || \
