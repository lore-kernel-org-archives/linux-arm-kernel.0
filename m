From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:08:01 +0530
Subject: [PATCH 9/9] ux500: allow 5500 and 8500 to be built together
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-9-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/configs/u8500_defconfig |    4 ++++
 arch/arm/mach-ux500/Kconfig      |   26 ++++++++++++++------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index be80f03..52d86c4 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -9,6 +9,10 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_U8500=y
+CONFIG_UX500_SOC_DB5500=y
+CONFIG_UX500_SOC_DB8500=y
+CONFIG_MACH_U8500=y
+CONFIG_MACH_U5500=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 2dd44a0..247caa3 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -7,28 +7,30 @@ config UX500_SOC_COMMON
 	select HAS_MTU
 	select NOMADIK_GPIO
 
-config UX500_SOC_DB8500
-	bool
+menu "Ux500 SoC"
 
 config UX500_SOC_DB5500
-	bool
+	bool "DB5500"
+
+config UX500_SOC_DB8500
+	bool "DB8500"
+
+endmenu
 
-choice
-	prompt "Ux500 target platform"
-	default MACH_U8500_MOP
+menu "Ux500 target platform"
 
-config MACH_U8500_MOP
+config MACH_U8500
 	bool "U8500 Development platform"
-	select UX500_SOC_DB8500
+	depends on UX500_SOC_DB8500
 	help
 	  Include support for the mop500 development platform.
 
 config MACH_U5500
 	bool "U5500 Development platform"
-	select UX500_SOC_DB5500
+	depends on UX500_SOC_DB5500
 	help
 	  Include support for the U5500 development platform.
-endchoice
+endmenu
 
 config UX500_DEBUG_UART
 	int "Ux500 UART to use for low-level debug"
@@ -39,14 +41,14 @@ config UX500_DEBUG_UART
 
 config U5500_MODEM_IRQ
 	bool "Modem IRQ support"
-	depends on MACH_U5500
+	depends on UX500_SOC_DB5500
 	default y
 	help
 	  Add support for handling IRQ:s from modem side
 
 config U5500_MBOX
 	bool "Mailbox support"
-	depends on MACH_U5500 && U5500_MODEM_IRQ
+	depends on U5500_MODEM_IRQ
 	default y
 	help
 	  Add support for U5500 mailbox communication with modem side
-- 
1.7.2.dirty
