From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:36:56 +0000
Subject: [PATCH v7 3/5] ARM: soft_restart: disable the outer L2 when the last
 CPU is going down
In-Reply-To: <1322505418-24854-1-git-send-email-will.deacon@arm.com>
References: <1322505418-24854-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322505418-24854-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Soft-restarting a system with an outer, shared L2 requires us to disable
it when no other CPUs are running.

This patch adds an outer_disable call to soft_restart so that the last
CPU going down will disable the L2 cache.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/process.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 66e0982..041794c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -136,6 +136,10 @@ void soft_restart(unsigned long addr)
 	local_irq_disable();
 	local_fiq_disable();
 
+	/* Disable the L2 if we're the last man standing. */
+	if (num_online_cpus() == 1)
+		outer_disable();
+
 	/* Change to the new stack and continue with the reset. */
 	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
 
-- 
1.7.4.1
