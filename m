From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:41 +0100
Subject: [PATCH 05/20] ARM: pl01x debug code endian fix
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL01X debug code needs to take into account which endian mode the
processor is running in. If it is big-endian, ensure the data is swapped
appropriately.

Note, we could do this slightly more efficiently if we have an macro to
do the necessary swap for the bits used by test.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/hardware/debug-pl01x.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/hardware/debug-pl01x.S b/arch/arm/include/asm/hardware/debug-pl01x.S
index f9fd083..6489d1f 100644
--- a/arch/arm/include/asm/hardware/debug-pl01x.S
+++ b/arch/arm/include/asm/hardware/debug-pl01x.S
@@ -18,12 +18,14 @@
 
 		.macro	waituart,rd,rx
 1001:		ldr	\rd, [\rx, #UART01x_FR]
+ ARM_BE8(	rev	\rd, \rd )
 		tst	\rd, #UART01x_FR_TXFF
 		bne	1001b
 		.endm
 
 		.macro	busyuart,rd,rx
 1001:		ldr	\rd, [\rx, #UART01x_FR]
+ ARM_BE8(	rev	\rd, \rd )
 		tst	\rd, #UART01x_FR_BUSY
 		bne	1001b
 		.endm
-- 
1.7.10.4
