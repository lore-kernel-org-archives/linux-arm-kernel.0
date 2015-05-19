From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 00:03:50 +0200
Subject: [PATCH soc v8 1/3] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <1432073032-26561-1-git-send-email-stefan@agner.ch>
References: <1432073032-26561-1-git-send-email-stefan@agner.ch>
Message-ID: <1432073032-26561-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the needless differences between MMU/!MMU addruart calls.
This allows to use the same addruart macro on SoC level. Useful
for SoC consisting of multiple CPUs with and without MMU such as
Freescale Vybrid.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/include/debug/efm32.S | 2 +-
 arch/arm/kernel/debug.S        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/debug/efm32.S b/arch/arm/include/debug/efm32.S
index 2265a19..660fa1e 100644
--- a/arch/arm/include/debug/efm32.S
+++ b/arch/arm/include/debug/efm32.S
@@ -16,7 +16,7 @@
 
 #define	UARTn_TXDATA		0x0034
 
-		.macro	addruart, rx, tmp
+		.macro	addruart, rx, tmp, tmp2
 		ldr	\rx, =(CONFIG_DEBUG_UART_PHYS)
 
 		/*
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 78c91b5..ea9646c 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -35,7 +35,7 @@
 
 #else /* !CONFIG_MMU */
 		.macro	addruart_current, rx, tmp1, tmp2
-		addruart	\rx, \tmp1
+		addruart	\rx, \tmp1, \tmp2
 		.endm
 
 #endif /* CONFIG_MMU */
-- 
2.4.1
