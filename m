From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  2 May 2014 17:10:01 +0100
Subject: [PATCH v2 3/3] arm64: Expose ESR_EL1 information to user when
 SIGSEGV/SIGBUS
In-Reply-To: <1399047001-6475-1-git-send-email-catalin.marinas@arm.com>
References: <1399047001-6475-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1399047001-6475-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This information is useful for instruction emulators to detect
read/write and access size without having to decode the faulting
instruction. The current patch exports it via sigcontext (struct
esr_context) and is only valid for SIGSEGV and SIGBUS.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  7 +++++++
 arch/arm64/kernel/signal.c               | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 690ad51cc901..b72cf405b3fe 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -53,5 +53,12 @@ struct fpsimd_context {
 	__uint128_t vregs[32];
 };
 
+/* ESR_EL1 context */
+#define ESR_MAGIC	0x45535201
+
+struct esr_context {
+	struct _aarch64_ctx head;
+	u64 esr;
+};
 
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 7ff2eee96c6b..dc2ab1b0ac0d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -194,6 +194,16 @@ static int setup_sigframe(struct rt_sigframe __user *sf,
 		aux += sizeof(*fpsimd_ctx);
 	}
 
+	/* fault information, if valid */
+	if (current->thread.fault_code) {
+		struct esr_context *esr_ctx =
+			container_of(aux, struct esr_context, head);
+		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
+		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
+		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
+		aux += sizeof(*esr_ctx);
+	}
+
 	/* set the "end" magic */
 	end = aux;
 	__put_user_error(0, &end->magic, err);
