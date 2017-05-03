From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  3 May 2017 16:09:33 +0100
Subject: [PATCH 1/6] arm64: xchg: hazard against entire exchange variable
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493824178-7399-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inline assembly in __XCHG_CASE() uses a +Q constraint to hazard
against other accesses to the memory location being exchanged. However,
the pointer passed to the constraint is a u8 pointer, and thus the
hazard only applies to the first byte of the location.

GCC can take advantage of this, assuming that other portions of the
location are unchanged, as demonstrated with the following test case:

union u {
	unsigned long l;
	unsigned int i[2];
};

unsigned long update_char_hazard(union u *u)
{
	unsigned int a, b;

	a = u->i[1];
	asm ("str %1, %0" : "+Q" (*(char *)&u->l) : "r" (0UL));
	b = u->i[1];

	return a ^ b;
}

unsigned long update_long_hazard(union u *u)
{
	unsigned int a, b;

	a = u->i[1];
	asm ("str %1, %0" : "+Q" (*(long *)&u->l) : "r" (0UL));
	b = u->i[1];

	return a ^ b;
}

The linaro 15.08 GCC 5.1.1 toolchain compiles the above as follows when
using -O2 or above:

0000000000000000 <update_char_hazard>:
   0:	d2800001 	mov	x1, #0x0                   	// #0
   4:	f9000001 	str	x1, [x0]
   8:	d2800000 	mov	x0, #0x0                   	// #0
   c:	d65f03c0 	ret

0000000000000010 <update_long_hazard>:
  10:	b9400401 	ldr	w1, [x0,#4]
  14:	d2800002 	mov	x2, #0x0                   	// #0
  18:	f9000002 	str	x2, [x0]
  1c:	b9400400 	ldr	w0, [x0,#4]
  20:	4a000020 	eor	w0, w1, w0
  24:	d65f03c0 	ret

This patch fixes the issue by passing an unsigned long pointer into the
+Q constraint, as we do for our cmpxchg code. This may hazard against
more than is necessary, but this is better than missing a necessary
hazard.

Fixes: 305d454aaa292be3 ("arm64: atomics: implement native {relaxed, acquire, release} atomics")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 91b26d2..ae852ad 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -46,7 +46,7 @@
 	"	swp" #acq_lse #rel #sz "\t%" #w "3, %" #w "0, %2\n"	\
 		__nops(3)						\
 	"	" #nop_lse)						\
-	: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)			\
+	: "=&r" (ret), "=&r" (tmp), "+Q" (*(unsigned long *)ptr)	\
 	: "r" (x)							\
 	: cl);								\
 									\
-- 
1.9.1
