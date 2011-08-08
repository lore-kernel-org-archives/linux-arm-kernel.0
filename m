From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:10:23 +0100
Subject: [PATCH 5/6] ARM: cache: detect VIPT aliasing I-cache on ARMv6
In-Reply-To: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823424-9654-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current cache detection code does not check for an aliasing
I-cache if the D-cache is found to be VIPT aliasing.

This patch fixes the problem by always checking for an aliasing
I-cache on v6 and later.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/setup.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d95de69..2cdba13 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -280,18 +280,19 @@ static void __init cacheid_init(void)
 	if (arch >= CPU_ARCH_ARMv6) {
 		if ((cachetype & (7 << 29)) == 4 << 29) {
 			/* ARMv7 register format */
+			arch = CPU_ARCH_ARMv7;
 			cacheid = CACHEID_VIPT_NONALIASING;
 			if ((cachetype & (3 << 14)) == 1 << 14)
 				cacheid |= CACHEID_ASID_TAGGED;
-			else if (cpu_has_aliasing_icache(CPU_ARCH_ARMv7))
-				cacheid |= CACHEID_VIPT_I_ALIASING;
-		} else if (cachetype & (1 << 23)) {
-			cacheid = CACHEID_VIPT_ALIASING;
 		} else {
-			cacheid = CACHEID_VIPT_NONALIASING;
-			if (cpu_has_aliasing_icache(CPU_ARCH_ARMv6))
-				cacheid |= CACHEID_VIPT_I_ALIASING;
+			arch = CPU_ARCH_ARMv6;
+			if (cachetype & (1 << 23))
+				cacheid = CACHEID_VIPT_ALIASING;
+			else
+				cacheid = CACHEID_VIPT_NONALIASING;
 		}
+		if (cpu_has_aliasing_icache(arch))
+			cacheid |= CACHEID_VIPT_I_ALIASING;
 	} else {
 		cacheid = CACHEID_VIVT;
 	}
-- 
1.7.0.4
