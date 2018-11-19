From: sunrui26@huawei.com (Rui Sun)
Date: Mon, 19 Nov 2018 15:29:20 +0800
Subject: [PATCH] arm64:crc:accelerated-crc32-by-64bytes
Message-ID: <1542612560-10089-1-git-send-email-sunrui26@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add 64 bytes loop to acceleration calculation

Signed-off-by: Rui Sun <sunrui26@huawei.com>
---
 arch/arm64/lib/crc32.S | 54 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 5bc1e85..2b37009 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -15,15 +15,61 @@
 	.cpu		generic+crc
 
 	.macro		__crc32, c
-0:	subs		x2, x2, #16
-	b.mi		8f
+
+64: cmp     x2, #64
+    b.lt    32f
+
+    adds    x11, x1, #16
+    adds    x12, x1, #32
+    adds    x13, x1, #48
+
+0 : subs    x2, x2, #64
+    b.mi    32f
+
+    ldp     x3, x4, [x1], #64
+    ldp     x5, x6, [x11], #64
+    ldp     x7, x8, [x12], #64
+    ldp     x9, x10,[x13], #64
+
+ CPU_BE( rev     x3, x3      )
+ CPU_BE( rev     x4, x4      )
+ CPU_BE( rev     x5, x5      )
+ CPU_BE( rev     x6, x6      )
+ CPU_BE( rev     x7, x7      )
+ CPU_BE( rev     x8, x8      )
+ CPU_BE( rev     x9, x9      )
+ CPU_BE( rev     x10,x10     )
+
+    crc32\c\()x w0, w0, x3
+    crc32\c\()x w0, w0, x4
+    crc32\c\()x w0, w0, x5
+    crc32\c\()x w0, w0, x6
+    crc32\c\()x w0, w0, x7
+    crc32\c\()x w0, w0, x8
+    crc32\c\()x w0, w0, x9
+    crc32\c\()x w0, w0, x10
+
+    b.ne       0b
+    ret
+
+32: tbz     x2, #5, 16f
+    ldp     x3, x4, [x1], #16
+    ldp     x5, x6, [x1], #16
+CPU_BE( rev     x3, x3      )
+CPU_BE( rev     x4, x4      )
+CPU_BE( rev     x5, x5      )
+CPU_BE( rev     x6, x6      )
+    crc32\c\()x w0, w0, x3
+    crc32\c\()x w0, w0, x4
+    crc32\c\()x w0, w0, x5
+    crc32\c\()x w0, w0, x6
+
+16: tbz     x2, #4, 8f
 	ldp		x3, x4, [x1], #16
 CPU_BE(	rev		x3, x3		)
 CPU_BE(	rev		x4, x4		)
 	crc32\c\()x	w0, w0, x3
 	crc32\c\()x	w0, w0, x4
-	b.ne		0b
-	ret
 
 8:	tbz		x2, #3, 4f
 	ldr		x3, [x1], #8
-- 
1.8.3.1
