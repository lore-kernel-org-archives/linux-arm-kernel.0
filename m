From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 7 Jan 2015 15:35:33 +0800
Subject: [RFC PATCH 03/11] x86: kprobes: directly modify code if kprobe is not
 initialized.
In-Reply-To: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
References: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1420616133-42855-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When registering early kprobes, SMP should has not been enabled, so
doesn't require synchronization in text_poke_bp(). Simply memcpy is
enough.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 0dd8d08..dc5fccb 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -397,8 +397,11 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buf[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buf[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
-			     op->optinsn.insn);
+		if (unlikely(!kprobes_initialized))
+			memcpy(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE);
+		else
+			text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
+				     op->optinsn.insn);
 
 		list_del_init(&op->list);
 	}
-- 
1.8.4
