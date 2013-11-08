From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:10 +0000
Subject: [PATCH 7/9] ARM: kprobes-test: fix next_instruction()
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taras Kondratiuk <taras.kondratiuk@linaro.org>

Fix next_instruction() function to correctly swap the instruction
loaded from memory.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
[ben.dooks at codethink.co.uk: edited commit message as item already fixed]
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/kprobes-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index d39cd2e..96e3dbc 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -1329,7 +1329,8 @@ static void test_case_failed(const char *message)
 static unsigned long next_instruction(unsigned long pc)
 {
 #ifdef CONFIG_THUMB2_KERNEL
-	if ((pc & 1) && !is_wide_instruction(*(u16 *)(pc - 1)))
+	if ((pc & 1) &&
+	    !is_wide_instruction(__mem_to_opcode_thumb16(*(u16 *)(pc - 1))))
 		return pc + 2;
 	else
 #endif
-- 
1.8.4.rc3
