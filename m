From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 16 Oct 2015 20:19:59 -0700
Subject: [PATCH] KVM/arm: kernel low level debug suport for ARM32 virtual
 platforms
Message-ID: <1445051999-24360-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a VM using QEMU or Kvmtool there are no clear ways to 
enable low level debugging for these virtual platforms. some menu port 
choices are not supported by the virtual platforms at all. And there is no
help on the location of physical and virtual addresses for the ports.
This may lead to wrong debug port and a frozen VM with a blank screen.

This patch adds menu selections for QEMU and Kvmtool virtual platforms for low 
level kernel print debugging. Help section displays port physical and
virutal addresses.

ARM reference models use the MIDR register to run-time select UART port address 
(for ARCH_VEXPRESS) based on A9 or A15 part numbers. Looked for a same approach
but couldn't find a way to differentiate between virtual platforms, something
like a platform register.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/Kconfig.debug | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a2e16f9..d126bd4 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1155,6 +1155,28 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_VIRT_UART_QEMU
+		bool "Kernel low-level debugging on QEMU Virtual Platform"
+		depends on ARCH_VIRT
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to PL011 UART port on QEMU Virtual Platform.
+		  Appropriate address values are:
+			PHYS		VIRT
+			0x9000000	0xf8090000
+
+	config DEBUG_VIRT_UART_KVMTOOL
+		bool "Kernel low-level debugging on Kvmtool Virtual Platform"
+		depends on ARCH_VIRT
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to 8250 UART port on Kvmtool Virtual
+		  Platform. Appropriate address values are:
+			PHYS		VIRT
+			0x3f8		0xf80903f8
+
 	config DEBUG_ICEDCC
 		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 		help
-- 
1.9.1
