From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 21 Aug 2012 20:59:34 +0400
Subject: [PATCH 3/4] ARM: clps711x: Fix lowlevel debug-macro
In-Reply-To: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
Message-ID: <1345568375-28516-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CTS signal can not be used for the port and tied to any logic state.
In this case we have an infinite loop waiting for the signal. For fix
this problem, checking CTS removed, waiting for the signal "busy" was
postponed after the byte write to the port.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/debug-macro.S |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 118b3d9..cb3684f 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -28,17 +28,11 @@
 		.endm
 
 		.macro	waituart,rd,rx
-1001:		ldr	\rd, [\rx, #0x0140]	@ SYSFLGx
-		tst	\rd, #1 << 11		@ UBUSYx
-		bne	1001b
 		.endm
 
 		.macro	busyuart,rd,rx
-		tst	\rx, #0x1000		@ UART2 does not have CTS here
-		bne	1002f
 1001:		ldr	\rd, [\rx, #0x0140]	@ SYSFLGx
-		tst	\rd, #1 << 8		@ CTS
+		tst	\rd, #1 << 11		@ UBUSYx
 		bne	1001b
-1002:
 		.endm
 
-- 
1.7.8.6
