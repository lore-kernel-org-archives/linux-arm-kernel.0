From: msalter@redhat.com (Mark Salter)
Date: Fri, 24 Mar 2017 09:53:56 -0400
Subject: [PATCH] arm64: fix NULL dereference in have_cpu_die()
Message-ID: <20170324135356.25881-1-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5c492c3f5255 ("arm64: smp: Add function to determine if cpus are
stuck in the kernel") added a helper function to determine if die() is
supported in cpu_ops. This function assumes a cpu will have a valid
cpu_ops entry, but that may not be the case for cpu0 is spin-table or
parking protocol is used to boot secondary cpus. In that case, there
is a NULL dereference if have_cpu_die() is called by cpu0. So add a
check for a valid cpu_ops before dereferencing it.

Fixes: 5c492c3f5255 ("arm64: smp: Add function to determine if cpus are stuck in the kernel")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ef1caae..9b10365 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -944,7 +944,7 @@ static bool have_cpu_die(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	int any_cpu = raw_smp_processor_id();
 
-	if (cpu_ops[any_cpu]->cpu_die)
+	if (cpu_ops[any_cpu] && cpu_ops[any_cpu]->cpu_die)
 		return true;
 #endif
 	return false;
-- 
2.9.3
