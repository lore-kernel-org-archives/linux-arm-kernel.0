From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:05 +0000
Subject: [PATCH 08/13] arm64: Use cpu_ops for smp_stop
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <36ad9302497338a34cc7174a72a2ac99ceb16fdb.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of ipi_cpu_stop() is just a tight infinite loop
around cpu_relax().  This infinite loop implementation is OK if the machine
will soon do a poweroff, but it doesn't have any mechanism to allow a CPU
to be brought back on-line, nor is it compatible with kexec re-boot.

Add a check for a valid cpu_die method of the appropriate cpu_ops structure,
and if a valid method is found, transfer control to that method.  It is
expected that the cpu_die method puts the CPU into a state such that they can
be brought back on-line or progress through a kexec re-boot.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4743397..002aa8a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -555,6 +555,15 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_irq_disable();
 
+	/* If we have the cpu ops use them. */
+
+	if (cpu_ops[cpu]->cpu_disable &&
+	    cpu_ops[cpu]->cpu_die &&
+	    !cpu_ops[cpu]->cpu_disable(cpu))
+		cpu_ops[cpu]->cpu_die(cpu);
+
+	/* Otherwise spin here. */
+
 	while (1)
 		cpu_relax();
 }
-- 
1.9.1
