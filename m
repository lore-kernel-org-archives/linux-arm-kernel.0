From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 05 May 2014 11:11:13 +0400
Subject: [PATCH] arm: memset: zero out upper bytes in r1
Message-ID: <1399273875-8403-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memset doesn't work right for following example:

	signed char c = 0xF0;
	memset(addr, c, size);

Variable c is signed, so after typcasting to int the value will be 0xFFFFFFF0.
This value will be passed through r1 regitster to memset function.
memset doesn't zero out upper bytes in r1, so memory will be filled
with 0xFFFFFFF0 instead of expected 0xF0F0F0F0.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/lib/memset.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 94b0650..a010f76 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -22,7 +22,8 @@ ENTRY(memset)
 /*
  * we know that the pointer in ip is aligned to a word boundary.
  */
-1:	orr	r1, r1, r1, lsl #8
+1:	and	r1, r1, #0xff
+	orr	r1, r1, r1, lsl #8
 	orr	r1, r1, r1, lsl #16
 	mov	r3, r1
 	cmp	r2, #16
-- 
1.8.3.2
