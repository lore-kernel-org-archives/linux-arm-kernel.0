From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:49 +0530
Subject: [RFC PATCH V2 02/10] arm64: fix kgdb_step_brk_fn to ignore other's
 exception
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <203b320f540c4b348a289c57633fcc13684ac74e.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 step exception does not have any syndrome information. So, it is
responsibility of exception handler to take care that they handle it
only if exception was raised for them.
After kprobe support, both kprobe and kgdb uses register_step_hook
mechanism to register its step handler. So, if call_step_hook calls kgdb
handler first, it was always returning 0 and in that case if an
exception was raised for kprobe, it would never be handled.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/kgdb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a0d10c55f307..9469465a5e03 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -229,6 +229,9 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (!kgdb_single_step)
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
-- 
2.1.0
