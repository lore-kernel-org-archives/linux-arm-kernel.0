From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:17:56 +0530
Subject: [PATCH V2 2/6] arm64: kgdb_step_brk_fn: ignore other's exception
In-Reply-To: <cover.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
Message-ID: <60aa43dad279e0f35b91def7fb7a60562f3ebb50.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 step exception does not have any syndrome information. So, it is
responsibility of exception handler to take care that they handle it
only if exception was raised for them.

Since kgdb_step_brk_fn() always returns 0, therefore we might have problem
when we will have other step handler registered as well.

This patch fixes kgdb_step_brk_fn() to return error in case of step handler
was not meant for kgdb.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/kgdb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index e017a9493b92..d217c9e95b06 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -247,6 +247,9 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (!kgdb_single_step)
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
-- 
2.7.4
