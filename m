From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 30 Aug 2012 17:10:08 -0400
Subject: [PATCH 2/2] ARM: allow for ATAGS to be configured out when DT support
 is selected
In-Reply-To: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
References: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ATAGS support is well contained, we can easily remove it from
the kernel build if so desired.  It has to explicitly be disabled, and
only when DT support is selected.

Note: disabling kernel ATAGS support does not prevent the usage of
CONFIG_ARM_ATAG_DTB_COMPAT.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/Kconfig         | 26 +++++++++++++++++++-------
 arch/arm/kernel/Makefile |  5 +++--
 arch/arm/kernel/atags.h  | 11 +++++++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5f9ae5dbd..5c7302e208 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1891,12 +1891,6 @@ config CC_STACKPROTECTOR
 	  neutralized via a kernel panic.
 	  This feature requires gcc version 4.2 or above.
 
-config DEPRECATED_PARAM_STRUCT
-	bool "Provide old way to pass kernel parameters"
-	help
-	  This was deprecated in 2001 and announced to live on for 5 years.
-	  Some old boot loaders still use this way.
-
 endmenu
 
 menu "Boot options"
@@ -1909,6 +1903,23 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ATAGS
+	bool "Support for the traditional ATAGS boot data passing" if USE_OF
+	default y
+	help
+	  This is the traditional way of passing data to the kernel at boot
+	  time. If you are solely relying on the flattened device tree (or
+	  the ARM_ATAG_DTB_COMPAT option) then you may unselect this option
+	  to remove ATAGS support from your kernel binary.  If unsure,
+	  leave this to y.
+
+config DEPRECATED_PARAM_STRUCT
+	bool "Provide old way to pass kernel parameters"
+	depends on ATAGS
+	help
+	  This was deprecated in 2001 and announced to live on for 5 years.
+	  Some old boot loaders still use this way.
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
@@ -2035,6 +2046,7 @@ config CMDLINE
 choice
 	prompt "Kernel command line type" if CMDLINE != ""
 	default CMDLINE_FROM_BOOTLOADER
+	depends on ATAGS
 
 config CMDLINE_FROM_BOOTLOADER
 	bool "Use bootloader kernel arguments if available"
@@ -2104,7 +2116,7 @@ config KEXEC
 
 config ATAGS_PROC
 	bool "Export atags in procfs"
-	depends on KEXEC
+	depends on ATAGS && KEXEC
 	default y
 	help
 	  Should the atags used to boot the kernel be exported in an "atags"
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 086c9d3bc3..79e346a5d7 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -15,10 +15,12 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= atags_parse.o elf.o entry-armv.o entry-common.o irq.o opcodes.o \
+obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o sched_clock.o \
 		   setup.o signal.o stacktrace.o sys_arm.o time.o traps.o
 
+obj-$(CONFIG_ATAGS)		+= atags_parse.o
+obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
 obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
 
 obj-$(CONFIG_LEDS)		+= leds.o
@@ -52,7 +54,6 @@ test-kprobes-objs		+= kprobes-test-thumb.o
 else
 test-kprobes-objs		+= kprobes-test-arm.o
 endif
-obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index a888fdd381..9edc969233 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,4 +5,15 @@ static inline void save_atags(struct tag *tags) { }
 #endif
 
 void convert_to_tag_list(struct tag *tags);
+
+#ifdef CONFIG_ATAGS
 struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr);
+#else
+static inline struct machine_desc *
+setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
+{
+	early_print("no ATAGS support: can't continue\n");
+	while (true);
+	unreachable();
+}
+#endif
-- 
1.7.12.84.gefa6462
