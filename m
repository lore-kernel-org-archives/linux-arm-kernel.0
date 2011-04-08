From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Apr 2011 20:15:40 +0800
Subject: [PATCH 3/7] ARM: mmp: set correct uart according to board
In-Reply-To: <1302264944-2759-2-git-send-email-haojian.zhuang@marvell.com>
References: <2011040801>
	<1302264944-2759-1-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1302264944-2759-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART3 is the default console in jasper, brownstone and avengers lite.

Change-Id: Iacfe665cc0e20a47d50e0b2ad8724097f28e7d2c
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/debug-macro.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index 7e2ebd3..b353785 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -14,8 +14,14 @@
 		.macro	addruart, rp, rv
 		ldr	\rp, =APB_PHYS_BASE		@ physical
 		ldr	\rv, =APB_VIRT_BASE		@ virtual
+#if defined(CONFIG_MACH_BROWNSTONE) || defined(CONFIG_MACH_MARVELL_JASPER) \
+	|| defined(CONFIG_MACH_AVENGERS_LITE)
+		orr	\rp, \rp, #0x00018000
+		orr	\rv, \rv, #0x00018000
+#else
 		orr	\rp, \rp, #0x00017000
 		orr	\rv, \rv, #0x00017000
+#endif
 		.endm
 
 #define UART_SHIFT	2
-- 
1.5.6.5
