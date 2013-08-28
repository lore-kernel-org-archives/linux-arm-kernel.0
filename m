From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 28 Aug 2013 12:45:59 +0100
Subject: [PATCH 19/19] ARM: atomic64: fix endian-ness in atomic.h
In-Reply-To: <1377690359-25397-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377690359-25397-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377690359-25397-20-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

Fix inline asm for atomic64_xxx functions in arm atomic.h. Instead of
%H operand specifiers code should use %Q for least significant part
of the value, and %R for the most significant part of the value. %H
always returns the higher of the two register numbers, and therefore
it is not endian neutral. %H should be used with ldrexd and strexd
instructions.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index da1c77d..6447a0b 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -301,8 +301,8 @@ static inline void atomic64_add(u64 i, atomic64_t *v)
 
 	__asm__ __volatile__("@ atomic64_add\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
-"	adds	%0, %0, %4\n"
-"	adc	%H0, %H0, %H4\n"
+"	adds	%Q0, %Q0, %Q4\n"
+"	adc	%R0, %R0, %R4\n"
 "	strexd	%1, %0, %H0, [%3]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
@@ -320,8 +320,8 @@ static inline u64 atomic64_add_return(u64 i, atomic64_t *v)
 
 	__asm__ __volatile__("@ atomic64_add_return\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
-"	adds	%0, %0, %4\n"
-"	adc	%H0, %H0, %H4\n"
+"	adds	%Q0, %Q0, %Q4\n"
+"	adc	%R0, %R0, %R4\n"
 "	strexd	%1, %0, %H0, [%3]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
@@ -341,8 +341,8 @@ static inline void atomic64_sub(u64 i, atomic64_t *v)
 
 	__asm__ __volatile__("@ atomic64_sub\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
-"	subs	%0, %0, %4\n"
-"	sbc	%H0, %H0, %H4\n"
+"	subs	%Q0, %Q0, %Q4\n"
+"	sbc	%R0, %R0, %R4\n"
 "	strexd	%1, %0, %H0, [%3]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
@@ -360,8 +360,8 @@ static inline u64 atomic64_sub_return(u64 i, atomic64_t *v)
 
 	__asm__ __volatile__("@ atomic64_sub_return\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
-"	subs	%0, %0, %4\n"
-"	sbc	%H0, %H0, %H4\n"
+"	subs	%Q0, %Q0, %Q4\n"
+"	sbc	%R0, %R0, %R4\n"
 "	strexd	%1, %0, %H0, [%3]\n"
 "	teq	%1, #0\n"
 "	bne	1b"
@@ -428,9 +428,9 @@ static inline u64 atomic64_dec_if_positive(atomic64_t *v)
 
 	__asm__ __volatile__("@ atomic64_dec_if_positive\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
-"	subs	%0, %0, #1\n"
-"	sbc	%H0, %H0, #0\n"
-"	teq	%H0, #0\n"
+"	subs	%Q0, %Q0, #1\n"
+"	sbc	%R0, %R0, #0\n"
+"	teq	%R0, #0\n"
 "	bmi	2f\n"
 "	strexd	%1, %0, %H0, [%3]\n"
 "	teq	%1, #0\n"
@@ -459,8 +459,8 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
 "	teqeq	%H0, %H5\n"
 "	moveq	%1, #0\n"
 "	beq	2f\n"
-"	adds	%0, %0, %6\n"
-"	adc	%H0, %H0, %H6\n"
+"	adds	%Q0, %Q0, %Q6\n"
+"	adc	%R0, %R0, %R6\n"
 "	strexd	%2, %0, %H0, [%4]\n"
 "	teq	%2, #0\n"
 "	bne	1b\n"
-- 
1.7.10.4
