From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  4 Nov 2013 18:16:04 -0800
Subject: [PATCH 2/3] ARM: mm: fix __phys_to_virt to work with 64 bit
 phys_addr_t in BE case
In-Reply-To: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1383617765-28052-3-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that inline assembler that expects 'r' operand
receives 32 bit value.

Before this fix in case of CONFIG_ARCH_PHYS_ADDR_T_64BIT and
CONFIG_ARM_PATCH_PHYS_VIRT __phys_to_virt function passed 64 bit
value to __pv_stub inline assembler where 'r' operand is
expected. Compiler behavior in such case is not well specified.
It worked in little endian case, but in big endian case
incorrect code was generated, where compiler confused which
part of 64 bit value it needed to modify. For example BE
snippet looked like this:

N:0x80904E08 : MOV      r2,#0
N:0x80904E0C : SUB      r2,r2,#0x81000000

when LE similar code looked like this

N:0x808FCE2C : MOV      r2,r0
N:0x808FCE30 : SUB      r2,r2,#0xc0, 8 ; #0xc0000000

Note 'r0' register is va that have to be translated into phys

To avoid this situation use explicit cast to 'unsigned long',
which explicitly discard upper part of phys address and convert
value to 32 bit. Also add comment so such cast will not be
removed in the future.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/include/asm/memory.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4dd2145..7a8599c 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -226,7 +226,13 @@ static inline phys_addr_t __virt_to_phys(unsigned long x)
 static inline unsigned long __phys_to_virt(phys_addr_t x)
 {
 	unsigned long t;
-	__pv_stub(x, t, "sub", __PV_BITS_31_24);
+        /*
+         * 'unsigned long' cast discard upper word when
+         * phys_addr_t is 64 bit, and makes sure that inline
+         * assembler expression receives 32 bit argument
+         * in place where 'r' 32 bit operand is expected.
+         */
+	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
 	return t;
 }
 
-- 
1.8.1.4
