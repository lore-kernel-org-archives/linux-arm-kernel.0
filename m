From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:36 +0300
Subject: [PATCH v6 10/20] arm64:ilp32 use the native LP64 'start_thread' for
 ILP32 threads
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-11-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

If we have both ILP32 and AARCH32 compiled in, we need use the non compat start
thread for ILP32.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
---
 arch/arm64/include/asm/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f1ba514..e365280 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -124,6 +124,13 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
+#ifdef CONFIG_ARM64_ILP32
+	/* ILP32 threads are started the same way as LP64 threads. */
+	if (is_ilp32_compat_task()) {
+		start_thread(regs, pc, sp);
+		return;
+	}
+#endif
 	start_thread_common(regs, pc);
 	regs->pstate = COMPAT_PSR_MODE_USR;
 	if (pc & 1)
-- 
2.5.0
