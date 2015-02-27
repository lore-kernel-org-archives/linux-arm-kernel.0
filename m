From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 15:09:17 -0500
Subject: [RFC PATCH] arm64: cmpxchg.h: Bring ldxr and stxr closer
Message-ID: <1425067776-2794-1-git-send-email-bobby.prani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 documentation recommends keeping exclusive loads and stores as close as
possible. Any instructions which do not depend on the value loaded should be
moved outside. 

In the current implementation of cmpxchg(), there is a mov instruction which can
be pulled before the load exclusive instruction without any change in
functionality. This patch does that change.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/arm64/include/asm/cmpxchg.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index cb95930..8057735 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -89,8 +89,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	case 1:
 		do {
 			asm volatile("// __cmpxchg1\n"
-			"	ldxrb	%w1, %2\n"
 			"	mov	%w0, #0\n"
+			"	ldxrb	%w1, %2\n"
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxrb	%w0, %w4, %2\n"
@@ -104,8 +104,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	case 2:
 		do {
 			asm volatile("// __cmpxchg2\n"
-			"	ldxrh	%w1, %2\n"
 			"	mov	%w0, #0\n"
+			"	ldxrh	%w1, %2\n"
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxrh	%w0, %w4, %2\n"
@@ -119,8 +119,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	case 4:
 		do {
 			asm volatile("// __cmpxchg4\n"
-			"	ldxr	%w1, %2\n"
 			"	mov	%w0, #0\n"
+			"	ldxr	%w1, %2\n"
 			"	cmp	%w1, %w3\n"
 			"	b.ne	1f\n"
 			"	stxr	%w0, %w4, %2\n"
@@ -134,8 +134,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	case 8:
 		do {
 			asm volatile("// __cmpxchg8\n"
-			"	ldxr	%1, %2\n"
 			"	mov	%w0, #0\n"
+			"	ldxr	%1, %2\n"
 			"	cmp	%1, %3\n"
 			"	b.ne	1f\n"
 			"	stxr	%w0, %4, %2\n"
@@ -166,11 +166,11 @@ static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
 		VM_BUG_ON((unsigned long *)ptr2 - (unsigned long *)ptr1 != 1);
 		do {
 			asm volatile("// __cmpxchg_double8\n"
+			"	mov	%w0, #0\n"
 			"	ldxp	%0, %1, %2\n"
 			"	eor	%0, %0, %3\n"
 			"	eor	%1, %1, %4\n"
 			"	orr	%1, %0, %1\n"
-			"	mov	%w0, #0\n"
 			"	cbnz	%1, 1f\n"
 			"	stxp	%w0, %5, %6, %2\n"
 			"1:\n"
-- 
1.9.1
