From: olof@lixom.net (Olof Johansson)
Date: Mon, 6 Dec 2010 19:36:32 -0600
Subject: [PATCH] [2.6.37] ARM: tegra: fix regression from addruart rewrite
Message-ID: <20101207013632.GA9379@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0ea1293009826da45e1019f45dfde1e557bb30df took out the test for
MMU on/off but didn't switch the ldr instructions to no longer be
conditionals based on said test.

Fix that.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/include/mach/debug-macro.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
index 8ea3bff..a0e7c12 100644
--- a/arch/arm/mach-tegra/include/mach/debug-macro.S
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -21,8 +21,8 @@
 #include <mach/io.h>
 
 	.macro  addruart, rp, rv
-        ldreq   \rp, =IO_APB_PHYS       @ physical
-        ldrne   \rv, =IO_APB_VIRT        @ virtual
+        ldr     \rp, =IO_APB_PHYS       @ physical
+        ldr     \rv, =IO_APB_VIRT        @ virtual
 #if defined(CONFIG_TEGRA_DEBUG_UART_NONE)
 #error "A debug UART must be selected in the kernel config to use DEBUG_LL"
 #elif defined(CONFIG_TEGRA_DEBUG_UARTA)
-- 
1.7.3.1
