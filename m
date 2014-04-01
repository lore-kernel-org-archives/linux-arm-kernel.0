From: holler@ahsoftware.de (Alexander Holler)
Date: Tue,  1 Apr 2014 12:04:17 +0200
Subject: [PATCH] arm: don't allow CONFIG_DEBUG_SET_MODULE_RONX if
 CONFIG_JUMP_LABEL is enabled
Message-ID: <1396346657-7166-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_DEBUG_SET_MODULE_RONX sounds like a nice security feature, but
things might fail late (and unexpected) if module code is set to read-only
while CONFIG_JUMP_LABEL is enabled (e.g. modprobe bridge).

Avoid this.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8..6627b9e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1197,7 +1197,7 @@ config PID_IN_CONTEXTIDR
 
 config DEBUG_SET_MODULE_RONX
 	bool "Set loadable kernel module data as NX and text as RO"
-	depends on MODULES
+	depends on MODULES && !JUMP_LABEL
 	---help---
 	  This option helps catch unintended modifications to loadable
 	  kernel module's text and read-only data. It also prevents execution
-- 
1.8.3.1
