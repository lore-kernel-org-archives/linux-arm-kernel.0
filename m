From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 19 Feb 2010 12:28:00 -0700
Subject: [PATCH 5/7] arm-dt: unflatten device tree
In-Reply-To: <20100219185953.15318.4850.stgit@angua>
References: <20100219185953.15318.4850.stgit@angua>
Message-ID: <20100219192750.15318.21298.stgit@angua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

If we've found a device tree, unflatten it.

Also, allow the unflattened tree to be exposed at /proc/device-tree.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/Kconfig        |    8 ++++++++
 arch/arm/kernel/setup.c |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5a8edc2..50eea35 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1264,6 +1264,14 @@ config OF
 	help
 	  Support for OpenFirmware-style device trees
 
+config PROC_DEVICETREE
+	bool "Support for device tree in /proc"
+	depends on PROC_FS
+	help
+	  This option adds a device-tree directory under /proc which contains
+	  an image of the device tree that the kernel copies from Open
+	  Firmware or other boot firmware. If unsure, say Y here.
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84fd876..dc057ad 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/fs.h>
+#include <linux/of_fdt.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -715,6 +716,8 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
+	unflatten_device_tree();
+
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 #endif
