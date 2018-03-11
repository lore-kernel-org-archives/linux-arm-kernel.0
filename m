From: lgonzalez@gezedo.com (Laurent GONZALEZ)
Date: Sun, 11 Mar 2018 15:09:26 +0100
Subject: [PATCH] arm: ensure consistent behaviour of ADR with thumb code
Message-ID: <703f0040-7902-0da2-0f76-5e771b561d13@gezedo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

binutils 2.29 changed ADR behaviour setting the LSB for thumb symbols.
Using the .eqv directive creates an untagged symbol, so that we can safely
add the LSB using an offseted relocation of the untagged symbol.

Signed-off-by: Laurent GONZALEZ <lgonzalez@gezedo.com>
---
 arch/arm/include/asm/assembler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bc8d4bbd8..ed45451bc 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,7 +195,8 @@
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
+	.eqv	untagged_\sym, \sym
+	adr\c	\rd, untagged_\sym + 1
 #else
 	adr\c	\rd, \sym
 #endif
-- 
2.11.0
