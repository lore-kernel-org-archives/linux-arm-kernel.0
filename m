From: acolin@isi.edu (Alexei Colin)
Date: Tue, 24 Jul 2018 09:45:14 -0400
Subject: [PATCH] arm64: enable RapidIO config options in Kconfig
Message-ID: <20180724134513.86796-1-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 SoCs with a PCI bus present the RapiodIO options; SoCs with
RapidIO IP blocks but without a PCI bus, need to select HAS_RAPIDIO in
Kconfig.platforms.

HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
other architectures which already define this flag (powerpc).

Signed-off-by: Alexei Colin <acolin@isi.edu>
---

Tested that kernel builds with RapidIO subsystem and switch drivers and that
modules insert successfully in a custom Qemu hardware model.
Maintainers for RapidIO subsystem CCed.
Similar patch for ARM has been submitted.

 arch/arm64/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..8dceaa5b674c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -293,6 +293,22 @@ config PCI_SYSCALL
 
 source "drivers/pci/Kconfig"
 
+config HAS_RAPIDIO
+	bool
+	default n
+
+config RAPIDIO
+	tristate "RapidIO support"
+	depends on HAS_RAPIDIO || PCI
+	help
+	  This feature enables support for RapidIO high-performance
+	  packet-switched interconnect.
+
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Kernel Features"
-- 
2.18.0
