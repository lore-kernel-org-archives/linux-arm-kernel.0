From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Nov 2015 15:25:32 +0000
Subject: [PATCH] arm64: compat: fix stxr failure case in SWP emulation
Message-ID: <1446823532-11572-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 589cb22bbedacf325951014c07a35a2b01ca57f6 upstream.

If the STXR instruction fails in the SWP emulation code, we leave *data
overwritten with the loaded value, therefore corrupting the data written
by a subsequent, successful attempt.

This patch re-jigs the code so that we only write back to *data once we
know that the update has happened.

Cc: <stable@vger.kernel.org> # 4.1, 4.2
Fixes: bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
Reported-by: Shengjiu Wang <shengjiu.wang@freescale.com>
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 7922c2e710ca..7ac3920b1356 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -279,22 +279,24 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
  */
 #define __user_swpX_asm(data, addr, res, temp, B)		\
 	__asm__ __volatile__(					\
-	"	mov		%w2, %w1\n"			\
-	"0:	ldxr"B"		%w1, [%3]\n"			\
-	"1:	stxr"B"		%w0, %w2, [%3]\n"		\
+	"0:	ldxr"B"		%w2, [%3]\n"			\
+	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
 	"	cbz		%w0, 2f\n"			\
 	"	mov		%w0, %w4\n"			\
+	"	b		3f\n"				\
 	"2:\n"							\
+	"	mov		%w1, %w2\n"			\
+	"3:\n"							\
 	"	.pushsection	 .fixup,\"ax\"\n"		\
 	"	.align		2\n"				\
-	"3:	mov		%w0, %w5\n"			\
-	"	b		2b\n"				\
+	"4:	mov		%w0, %w5\n"			\
+	"	b		3b\n"				\
 	"	.popsection"					\
 	"	.pushsection	 __ex_table,\"a\"\n"		\
 	"	.align		3\n"				\
-	"	.quad		0b, 3b\n"			\
-	"	.quad		1b, 3b\n"			\
-	"	.popsection"					\
+	"	.quad		0b, 4b\n"			\
+	"	.quad		1b, 4b\n"			\
+	"	.popsection\n"					\
 	: "=&r" (res), "+r" (data), "=&r" (temp)		\
 	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
 	: "memory")
-- 
2.5.0
