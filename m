From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:52 +0100
Subject: [PATCH 16/20] ARM: net: fix arm instruction endian-ness in
 bpf_jit_32.c
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-17-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use <asm/opcodes.h> to correctly transform instruction byte ordering
into in-memory ordering.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/net/bpf_jit_32.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f50d223..510d923 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -19,6 +19,7 @@
 #include <linux/if_vlan.h>
 #include <asm/cacheflush.h>
 #include <asm/hwcap.h>
+#include <asm/opcodes.h>
 
 #include "bpf_jit_32.h"
 
@@ -113,8 +114,11 @@ static u32 jit_udiv(u32 dividend, u32 divisor)
 
 static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
 {
+	inst |= (cond << 28);
+	inst = __opcode_to_mem_arm(inst);
+
 	if (ctx->target != NULL)
-		ctx->target[ctx->idx] = inst | (cond << 28);
+		ctx->target[ctx->idx] = inst;
 
 	ctx->idx++;
 }
-- 
1.7.10.4
