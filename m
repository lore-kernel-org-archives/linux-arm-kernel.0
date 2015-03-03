From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 3 Mar 2015 13:09:05 +0800
Subject: [PATCH 3/3] early kprobes: x86: don't try to recover ftraced
 instruction before ftrace get ready.
In-Reply-To: <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425359345-38714-4-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before ftrace convertin instruction to nop, if an early kprobe is
registered then unregistered, without this patch its first bytes will
be replaced by head of NOP, which may confuse ftrace.

Actually, since we have a patch which convert ftrace entry to nop
when probing, this problem should never be triggered. Provide it for
safety.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 87beb64..c7d304d 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -225,6 +225,9 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 	struct kprobe *kp;
 	unsigned long faddr;
 
+	if (!kprobes_on_ftrace_initialized)
+		return addr;
+
 	kp = get_kprobe((void *)addr);
 	faddr = ftrace_location(addr);
 	/*
-- 
1.8.4
