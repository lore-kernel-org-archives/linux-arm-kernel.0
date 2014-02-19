From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 19 Feb 2014 21:29:01 +0100
Subject: [PATCH v2] ARM: make isa_mode macro more robust and fix for v7-M
In-Reply-To: <1387186673-7439-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1387186673-7439-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1392841741-16438-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of isa_mode hardcodes the values to shift PSR_J_BIT and
PSR_T_BIT to move them to bits 1 and 0 respectively. Instead use __ffs to
calculate the shift from the #define already used for masking.

This is relevant on v7-M as there PSR_T_BIT is 0x01000000 instead of
0x00000020 for V7-[AR] and earlier. Because of that isa_mode produced
values >= 0x80000 which are unsuitable to index into isa_modes[4] there
and so made __show_regs read from undefined memory which resulted in
hangs and crashes.

Moreover isa_mode is wrong for v7-M even after this robustness fix as
there is no J-bit in the PSR register. So hardcode isa_mode to "Thumb"
for v7-M.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with Message-Id:
1387186673-7439-1-git-send-email-u.kleine-koenig at pengutronix.de:

 - fix !CONFIG_CPU_V7M compilation because of a missing ')'
 
 arch/arm/include/asm/ptrace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 04c99f36ff7f..627a03ebb987 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -27,9 +27,13 @@ struct pt_regs {
 #define thumb_mode(regs) (0)
 #endif
 
+#ifndef CONFIG_CPU_V7M
 #define isa_mode(regs) \
-	((((regs)->ARM_cpsr & PSR_J_BIT) >> 23) | \
-	 (((regs)->ARM_cpsr & PSR_T_BIT) >> 5))
+	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
+	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
+#else
+#define isa_mode(regs) 1 /* Thumb */
+#endif
 
 #define processor_mode(regs) \
 	((regs)->ARM_cpsr & MODE_MASK)
-- 
1.8.5.2
