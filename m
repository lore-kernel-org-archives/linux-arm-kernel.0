From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Nov 2010 13:38:41 +0000
Subject: [PATCH] ARM: thumb2: fix incorrect optimisation in usracc
Message-ID: <1289828321-31554-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8b592783 added a Thumb-2 variant of usracc which, when it is
called with \rept=2, calls usraccoff once with an offset of 0 and
secondly with a hard-coded offset of 4 in order to avoid incrementing
the pointer again. If \inc != 4 then we will store the data to the wrong
offset from \ptr. Luckily, the only caller that passes \rept=2 to this
function is __clear_user so we haven't been actively corrupting user data.

This patch fixes usracc to pass \inc instead of #4 to usraccoff
when it is called a second time.

Reported-by: Tony Thompson <tony.thompson@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/assembler.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 062b58c..749bb66 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -238,7 +238,7 @@
 	@ Slightly optimised to avoid incrementing the pointer twice
 	usraccoff \instr, \reg, \ptr, \inc, 0, \cond, \abort
 	.if	\rept == 2
-	usraccoff \instr, \reg, \ptr, \inc, 4, \cond, \abort
+	usraccoff \instr, \reg, \ptr, \inc, \inc, \cond, \abort
 	.endif
 
 	add\cond \ptr, #\rept * \inc
-- 
1.7.0.4
