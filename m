From: miguel.ojeda.sandonis@gmail.com (Miguel Ojeda)
Date: Sun, 9 Sep 2018 17:47:31 +0200
Subject: [PATCH] arch/arm64/include/asm/jump_label.h: use asm_volatile_goto
Message-ID: <20180909154731.GA20381@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other uses of "asm goto" go through asm_volatile_goto
(including the arm version of the same file). For consistency,
use it here as well.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 arch/arm64/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..7e2b3e360086 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1: nop\n\t"
+	asm_volatile_goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
@@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
+	asm_volatile_goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
-- 
2.17.1
