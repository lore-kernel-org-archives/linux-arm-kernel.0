From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  7 Aug 2017 19:36:01 +0100
Subject: [PATCH 10/14] arm64: assembler: allow adr_this_cpu to use the stack
 pointer
In-Reply-To: <1502130965-18710-1-git-send-email-mark.rutland@arm.com>
References: <1502130965-18710-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1502130965-18710-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Given that adr_this_cpu already requires a temp register in addition
to the destination register, tweak the instruction sequence so that sp
may be used as well.

This will simplify switching to per-cpu stacks in subsequent patches. While
this limits the range of adr_this_cpu, to +/-4GiB, we don't currently use
adr_this_cpu in modules, and this is not problematic for the main kernel image.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Mark: add more commit text]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 610a420..4775af5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -235,7 +235,8 @@
 	 * @tmp: scratch register
 	 */
 	.macro adr_this_cpu, dst, sym, tmp
-	adr_l	\dst, \sym
+	adrp	\tmp, \sym
+	add	\dst, \tmp, #:lo12:\sym
 	mrs	\tmp, tpidr_el1
 	add	\dst, \dst, \tmp
 	.endm
-- 
1.9.1
