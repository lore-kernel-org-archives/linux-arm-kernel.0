From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 17:24:44 +0100
Subject: [PATCH] ARM: io: avoid GCC's offsettable addressing modes for
 halfword accesses
Message-ID: <1351268684-20559-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the 'o' memory constraint in inline assembly can result in GCC
generating invalid immediate offsets for memory access instructions with
reduced addressing capabilities (i.e. smaller than 12-bit immediate
offsets):

  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=54983

As there is no constraint to specify the exact addressing mode we need,
fallback to using 'Q' exclusively for halfword I/O accesses. This may
emit an additional add instruction (using an extra register) in order
to construct the address but it will always be accepted by GAS.

Reported-by: Bastian Hecht <hechtb@googlemail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 35c1ed8..42f042e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -64,7 +64,7 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
 	asm volatile("strh %1, %0"
-		     : "+Qo" (*(volatile u16 __force *)addr)
+		     : "+Q" (*(volatile u16 __force *)addr)
 		     : "r" (val));
 }
 
@@ -72,7 +72,7 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
 	asm volatile("ldrh %1, %0"
-		     : "+Qo" (*(volatile u16 __force *)addr),
+		     : "+Q" (*(volatile u16 __force *)addr),
 		       "=r" (val));
 	return val;
 }
-- 
1.7.4.1
