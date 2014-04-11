From: luxiangyu@huawei.com (Lu Xiangyu)
Date: Fri, 11 Apr 2014 18:16:24 +0800
Subject: [PATCH] ARM: fix do_div() bug in big-endian systems
Message-ID: <1397211384-2962-1-git-send-email-luxiangyu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiangyu Lu <luxiangyu@huawei.com>

In big-endian systems, "%1" get the most significant part of the value, cause
the instruction to get the wrong result.

When viewing ftrace record in big-endian ARM systems, we found that
the timestamp errors:

swapper-0     [001]  1325.970000:      0:120:R ==> [001]    16:120:R events/1
events/1-16   [001]  1325.970000:      16:120:S ==> [001]    0:120:R swapper
swapper-0     [000]  1325.1000000:     0:120:R   + [000]    15:120:R events/0
swapper-0     [000]  1325.1000000:     0:120:R ==> [000]    15:120:R events/0
swapper-0     [000]  1326.030000:      0:120:R   + [000]  1150:120:R sshd
swapper-0     [000]  1326.030000:      0:120:R ==> [000]  1150:120:R sshd

When viewed ftrace records, it will call the do_div(n, base) function, which
achieved arch/arm/include/asm/div64.h in. When n = 10000000, base = 1000000, in
do_div(n, base) will execute "umull %Q0, %R0, %1, %Q2".

Cc: <stable@vger.kernel.org> # 2.6.20+
Signed-off-by: Alex Wu <wuquanming@huawei.com>
Signed-off-by: Xiangyu Lu <luxiangyu@huawei.com>
---
 arch/arm/include/asm/div64.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 191ada6..662c7bd 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -156,7 +156,7 @@
 		/* Select the best insn combination to perform the   */	\
 		/* actual __m * __n / (__p << 64) operation.         */	\
 		if (!__c) {						\
-			asm (	"umull	%Q0, %R0, %1, %Q2\n\t"		\
+			asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"		\
 				"mov	%Q0, #0"			\
 				: "=&r" (__res)				\
 				: "r" (__m), "r" (__n)			\
-- 
1.7.9.5
