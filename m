From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon,  7 Jul 2014 15:45:08 +0200
Subject: [PATCH 1/3] ARM: perf: Check that current->mm is alive before getting
 user callchain
In-Reply-To: <1404740710-14691-1-git-send-email-jean.pihet@linaro.org>
References: <1404740710-14691-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <1404740710-14691-2-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An event may occur when an mm is already released.

As per commit 20afc60f892d285fde179ead4b24e6a7938c2f1b
 'x86, perf: Check that current->mm is alive before getting user callchain'

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 4238bcb..6493c4c 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -590,6 +590,10 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 	}
 
 	perf_callchain_store(entry, regs->ARM_pc);
+
+	if (!current->mm)
+		return;
+
 	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
 
 	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-- 
1.8.1.2
