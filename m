From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:32 +0200
Subject: [RESEND PATCH 09/12] ARM: integrator: move VGA base assignment
Message-ID: <1366466192-15608-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global vga_base is used for things like getting an early
console on a PCI-based VGA adapter. Move this assignment into
the probe function for the PCI bridge.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 2 --
 arch/arm/mach-integrator/pci_v3.c        | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 9b2d28b..fe1ee7c0 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -41,7 +41,6 @@
 #include <linux/stat.h>
 #include <linux/sys_soc.h>
 #include <linux/termios.h>
-#include <video/vga.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -145,7 +144,6 @@ static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 static void __init ap_map_io(void)
 {
 	iotable_init(ap_io_desc, ARRAY_SIZE(ap_io_desc));
-	vga_base = (unsigned long)PCI_MEMORY_VADDR;
 	pci_map_io_early(__phys_to_pfn(PHYS_PCI_IO_BASE));
 }
 
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 9dd7125..059ac4e 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <video/vga.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -850,6 +851,7 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	vga_base = (unsigned long)PCI_MEMORY_VADDR;
 	pci_common_init(&pci_v3);
 
 	return 0;
-- 
1.8.1.4
