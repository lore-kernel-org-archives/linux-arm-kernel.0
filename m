From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Jul 2011 13:40:02 +0100
Subject: [PATCH] [RFC PATCH] ARM: kprobes: Make breakpoint setting/clearing
	SMP safe
Message-ID: <1310474402-5398-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

On SMP systems, kprobes has two different issues when manipulating
breakpoints.

When disarming probes, with two CPUs (A and B) we can get:

- A takes undef exception due to hitting a probe breakpoint.
- B disarms probe, replacing the breakpoint with original instruction.
- A's undef handler reads instruction at PC, doesn't see kprobe
  breakpoint, therefore doesn't call kprobe_handler and the process
  takes a fatal exception.

The second issue occurs when both arming and disarming probes on a
32-bit Thumb instruction which straddles two memory words. In this case
it's possible that another CPU will read 16 bits from the new
instruction and 16 from the old.

Both these issues are known and the kprobe implementation uses
stop_machine() to avoid them, however, this is not sufficient.
stop_machine() does not perform any kind on synchronisation between CPUs
so it it still possible for one CPU to call the breakpoint changing
function before another CPU has been interrupted to do likewise.

To fix this problem, this patch creates a new function
sync_stop_machine() which ensures that all online CPUs execute the
specified function at the same time.

I am looking for feedback:
- Have I got my understanding of stop_machine() right?
- Are there other APIs to do what we need?
- Is my patch robust.
- Do I have the correct barriers?

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.c |   55 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 129c116..c6b7f2a 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -103,6 +103,57 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
+struct sync_stop_machine_data {
+	atomic_t begin;
+	atomic_t end;
+	int	 (*fn)(void *);
+	void	 *data;
+};
+
+static int __kprobes __sync_stop_machine(void *data)
+{
+	struct sync_stop_machine_data *ssmd;
+	int ret;
+
+	ssmd = (struct sync_stop_machine_data *)data;
+
+	/* Wait until all CPUs are ready before calling the function */
+	atomic_dec(&ssmd->begin);
+	smp_mb__after_atomic_dec();
+	while (atomic_read(&ssmd->begin)) {}
+
+	ret = ssmd->fn(ssmd->data);
+
+	/* Wait for all CPUs to finish 'fn' before returning */
+	smp_mb__before_atomic_dec();
+	atomic_dec(&ssmd->end);
+	while (atomic_read(&ssmd->end)) {}
+
+	return ret;
+}
+
+static int __kprobes sync_stop_machine(int (*fn)(void *), void *data)
+{
+	struct sync_stop_machine_data ssmd = {
+		.fn	= fn,
+		.data	= data
+	};
+	int num_cpus;
+	int ret;
+
+	get_online_cpus(); /* So number of CPUs can't change */
+
+	num_cpus = num_online_cpus();
+	atomic_set(&ssmd.begin, num_cpus);
+	atomic_set(&ssmd.end, num_cpus);
+	smp_wmb();
+
+	ret = stop_machine(__sync_stop_machine, &ssmd, &cpu_online_map);
+
+	put_online_cpus();
+	return ret;
+}
+
 #ifdef CONFIG_THUMB2_KERNEL
 
 /*
@@ -127,7 +178,7 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
 		flush_insns(addr, sizeof(u16));
 	} else if (addr & 2) {
 		/* A 32-bit instruction spanning two words needs special care */
-		stop_machine(set_t32_breakpoint, (void *)addr, &cpu_online_map);
+		sync_stop_machine(set_t32_breakpoint, (void *)addr);
 	} else {
 		/* Word aligned 32-bit instruction can be written atomically */
 		u32 bkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
@@ -190,7 +241,7 @@ int __kprobes __arch_disarm_kprobe(void *p)
 
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
-	stop_machine(__arch_disarm_kprobe, p, &cpu_online_map);
+	sync_stop_machine(__arch_disarm_kprobe, p);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
-- 
1.7.2.5
