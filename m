From: al.stone@linaro.org (al.stone at linaro.org)
Date: Thu, 16 Jan 2014 11:44:17 -0700
Subject: [PATCH v2] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
Message-ID: <1389897857-1790-1-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Hardware reduced mode, despite the name, exists primarily to allow
newer platforms to use a much simpler form of ACPI that does not
require supporting the legacy of previous versions of the specification.
This mode was first introduced in the ACPI 5.0 specification, but because
it is so much simpler and reduces the size of the object code needed to
support ACPI, it is likely to be used more often in the near future.

To enable the hardware reduced mode of ACPI on some platforms (such as
ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWARE
to TRUE in the ACPICA source.  For ARM/ARM64, hardware reduced ACPI
should be the only mode used; legacy mode would require modifications
to SoCs in order to provide several x86-specific hardware features (e.g.,
an NMI and SMI support).

We set ACPI_REDUCED_HARDWARE to TRUE in the ACPICA source by introducing
a kernel config item to enable/disable ACPI_REDUCED_HARDWARE.  We can then
change the kernel config instead of having to modify the kernel source
directly to enable the reduced hardware mode of ACPI.

Lv Zheng suggested that this configuration item does not belong in ACPICA,
the upstream source for much of the ACPI internals, but rather to the
Linux kernel itself.  Hence, we introduce this flag so that we can make
ACPI_REDUCED_HARDWARE configurable.  For the details of the discussion,
please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.html

Even though support for X86 in hardware reduced mode is possible, it
is NOT enabled.  Extensive effort has gone into the Linux kernel so that
there is a single kernel image than can run on all x86 hardware; the kernel
changes run-time behavior to adapt to the hardware being used.  This is not
currently possible with the existing ACPICA infrastructure but only presents
a problem on achitectures supporting both hardware-reduced and legacy modes
of ACPI -- i.e., on x86 only.

The problem with the current ACPICA code base is that if one builds legacy
ACPI (a proper superset of hardware-reduced), the kernel can run in hardware-
reduced with the proper ACPI tables, but there is still ACPICA code that could
be executed even though it is not allowed by the specification.  If one builds
a hardware-reduced only ACPI, the kernel cannot run with ACPI tables that are
for legacy mode.  To ensure compliance with ACPI, one must therefore build
two separate kernels.  Once this problem has been properly fixed, we can then
enable x86 hardware-reduced mode and use a single kernel.

Changes for v2:
   -- Changed test for EXPERT to avoid reported Kconfig warning

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 13 +++++++++++++
 include/acpi/platform/aclinux.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4770de5..9fd6a7a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -343,6 +343,19 @@ config ACPI_BGRT
 	  data from the firmware boot splash. It will appear under
 	  /sys/firmware/acpi/bgrt/ .
 
+config ACPI_REDUCED_HARDWARE_ONLY
+	bool "Hardware-reduced ACPI support only" if EXPERT
+	def_bool n
+	depends on ACPI
+	help
+	This config item changes the way the ACPI code is built.  When this
+	option is selected, the kernel will use a specialized version of
+	ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
+	resulting kernel will be smaller but it will also be restricted to
+	running in ACPI reduced hardware mode ONLY.
+
+	If you are unsure what to do, do not enable this option.
+
 source "drivers/acpi/apei/Kconfig"
 
 config ACPI_EXTLOG
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 28f4f4d..7d71f08 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -52,6 +52,12 @@
 
 #ifdef __KERNEL__
 
+/* Compile for reduced hardware mode only with this kernel config */
+
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE_ONLY
+#define ACPI_REDUCED_HARDWARE 1
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.8.4.2
