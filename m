From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 10:28:47 +0100
Subject: [PATCH] ARM: debug: provide dummy default option for DEBUG_LL UART
	choice
Message-ID: <1317374927-4997-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defaulting to DEBUG_ICEDCC will cause systems to hang during boot unless
a hardware debugger is listening to the debug comms. channel.

This patch adds a dummy UART option as the default DEBUG_LL choice which
requires the platform to do the right thing.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This came out of discussion on the list yesterday but I thought I'd better
post a patch before sending to Russell.

Will


 arch/arm/Kconfig.debug |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 32b1be4..5bc7814 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -81,6 +81,14 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
+	config DEBUG_LL_UART_NONE
+		bool "No low-level debugging UART"
+		help
+		  Say Y here if your platform doesn't provide a UART option
+		  below. This relies on your platform choosing the right UART
+		  definition internally in order for low-level debugging to
+		  work.
+
 	config DEBUG_ICEDCC
 		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 		help
@@ -89,8 +97,8 @@ choice
 		  co-processor 14. This is known to work on the ARM9 style ICE
 		  channel and on the XScale with the PEEDI.
 
-		  It does include a timeout to ensure that the system does not
-		  totally freeze when there is nothing connected to read.
+		  Note that the system will appear to hang during boot if there
+		  is nothing connected to read from the DCC.
 
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
-- 
1.7.0.4
