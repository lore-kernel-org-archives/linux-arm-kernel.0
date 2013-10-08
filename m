From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  9 Oct 2013 00:34:21 +0200
Subject: [PATCH 05/23] ARM: pl01x debug code endian fix
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1381271679-27804-6-git-send-email-ben.dooks@codethink.co.uk>
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
 arch/arm/include/debug/pl01x.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index 37c6895b..92ef808 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -25,12 +25,14 @@
 
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
1.8.4.rc3
