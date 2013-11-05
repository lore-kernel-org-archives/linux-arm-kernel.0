From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Tue,  5 Nov 2013 14:15:45 +0530
Subject: [PATCH v4 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1383641146-27274-4-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Add KGDB software step debugging support for EL1 debug
in AArch64 mode.

KGDB registers step debug handler with debug monitor.
On receiving 'step' command from GDB tool, target enables
software step debugging and step address is updated.
If no step address is received from GDB tool, target assumes
next step address is current PC.

Software Step debugging is disabled when 'continue' command
is received

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 arch/arm64/kernel/kgdb.c |   67 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index ec624bc..f10f2ba 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -137,13 +137,26 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 
 static int compiled_break;
 
+static void kgdb_arch_update_addr(struct pt_regs *regs,
+				char *remcom_in_buffer)
+{
+	unsigned long addr;
+	char *ptr;
+
+	ptr = &remcom_in_buffer[1];
+	if (kgdb_hex2long(&ptr, &addr))
+		kgdb_arch_set_pc(regs, addr);
+	else if (compiled_break == 1)
+		kgdb_arch_set_pc(regs, regs->pc + 4);
+
+	compiled_break = 0;
+}
+
 int kgdb_arch_handle_exception(int exception_vector, int signo,
 			       int err_code, char *remcom_in_buffer,
 			       char *remcom_out_buffer,
 			       struct pt_regs *linux_regs)
 {
-	unsigned long addr;
-	char *ptr;
 	int err;
 
 	switch (remcom_in_buffer[0]) {
@@ -153,6 +166,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 * Packet D (Detach), k (kill). No special handling
 		 * is required here
 		 */
+		atomic_set(&kgdb_cpu_doing_single_step, -1);
+		kgdb_single_step =  0;
 		err = 0;
 		break;
 	case 'c':
@@ -164,16 +179,39 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 * to the next instruction else we will just breakpoint
 		 * over and over again.
 		 */
-		ptr = &remcom_in_buffer[1];
-		if (kgdb_hex2long(&ptr, &addr))
-			kgdb_arch_set_pc(linux_regs, addr);
-		else if (compiled_break == 1)
-			kgdb_arch_set_pc(linux_regs, linux_regs->pc + 4);
+		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
+		atomic_set(&kgdb_cpu_doing_single_step, -1);
+		kgdb_single_step =  0;
 
-		compiled_break = 0;
+		/*
+		 * Received continue command, disable single step
+		 */
+		if (kernel_active_single_step())
+			kernel_disable_single_step();
 
 		err = 0;
 		break;
+	case 's':
+		/*
+		 * Update step address value with address passed
+		 * with step packet.
+		 * On debug exception return PC is copied to ELR
+		 * So just update PC.
+		 * If no step address is passed, resume from the address
+		 * pointed by PC. Do not update PC
+		 */
+		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
+		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
+		kgdb_single_step =  1;
+
+		/*
+		 * Enable single step handling
+		 */
+		if (!kernel_active_single_step())
+			kernel_enable_single_step(linux_regs);
+		err = 0;
+		break;
+
 	default:
 		err = -1;
 	}
@@ -194,6 +232,12 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 	return 0;
 }
 
+static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
+{
+	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+	return 0;
+}
+
 static struct break_hook kgdb_brkpt_hook = {
 	.esr_mask	= 0xffffffff,
 	.esr_val	= DBG_ESR_VAL_BRK(KGDB_DYN_DGB_BRK_IMM),
@@ -206,6 +250,10 @@ static struct break_hook kgdb_compiled_brkpt_hook = {
 	.fn		= kgdb_compiled_brk_fn
 };
 
+static struct step_hook kgdb_step_hook = {
+	.fn		= kgdb_step_brk_fn
+};
+
 static void kgdb_call_nmi_hook(void *ignored)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
@@ -259,7 +307,7 @@ int kgdb_arch_init(void)
 
 	register_break_hook(&kgdb_brkpt_hook);
 	register_break_hook(&kgdb_compiled_brkpt_hook);
-
+	register_step_hook(&kgdb_step_hook);
 	return 0;
 }
 
@@ -272,6 +320,7 @@ void kgdb_arch_exit(void)
 {
 	unregister_break_hook(&kgdb_brkpt_hook);
 	unregister_break_hook(&kgdb_compiled_brkpt_hook);
+	unregister_step_hook(&kgdb_step_hook);
 	unregister_die_notifier(&kgdb_notifier);
 }
 
-- 
1.7.9.5
