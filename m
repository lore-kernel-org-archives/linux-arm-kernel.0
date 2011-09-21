From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2011 18:23:27 -0700
Subject: [PATCHv2 1/2] ARM: debug: Add UART1 config choices
Message-ID: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM patch 7072/1 (debug: use kconfig choice for selecting
DEBUG_LL UART) didn't notice that the Kconfigs relied on being
unselected to configure a different serial port. Since there is
no NONE option in a choice menu, explicitly add the other option
so that both serial ports can be selected.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---

I plan to put these in the patch tracker if there are no further
comments.

 arch/arm/Kconfig.debug |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 60d1846..6dbcb00 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -81,14 +81,27 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
+
+	config DEBUG_FOOTBRIDGE_COM1
+		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
+		depends on FOOTBRIDGE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the 8250 at PCI COM1.
+
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
 		depends on FOOTBRIDGE
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port in the DC21285 (Footbridge).
-		  Saying N will cause the debug messages to appear on the first
-		  16550 serial port.
+
+	config DEBUG_CLPS711X_UART1
+		bool "Kernel low-level debugging messages via UART1"
+		depends on ARCH_CLPS711X
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the first serial port on these devices.
 
 	config DEBUG_CLPS711X_UART2
 		bool "Kernel low-level debugging messages via UART2"
@@ -96,8 +109,6 @@ choice
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
-		  Saying N will cause the debug messages to appear on the first
-		  serial port.
 
 endchoice
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
