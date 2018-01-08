From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jan 2018 14:26:57 +0000
Subject: [PATCH v2 07/11] arm64: Add skeleton to harden the branch
 predictor against aliasing attacks
In-Reply-To: <5A53611C.5030003@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-8-git-send-email-will.deacon@arm.com>
 <5A53611C.5030003@arm.com>
Message-ID: <20180108142657.GE25869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thanks for having a look.

On Mon, Jan 08, 2018 at 12:16:28PM +0000, James Morse wrote:
> On 05/01/18 13:12, Will Deacon wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 22168cd0dde7..5203b6040cb6 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -318,6 +318,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >  		lsb = PAGE_SHIFT;
> >  	si.si_addr_lsb = lsb;
> >  
> > +	arm64_apply_bp_hardening();
> 
> Due to the this_cpu_ptr() call:
> 
> | BUG: using smp_processor_id() in preemptible [00000000] code: print_my_pa/2093
> | caller is debug_smp_processor_id+0x1c/0x24
> | CPU: 0 PID: 2093 Comm: print_my_pa Tainted: G        W
> 4.15.0-rc3-00044-g7f0aaec94f27-dirty #8950
> | Call trace:
> |  dump_backtrace+0x0/0x164
> |  show_stack+0x14/0x1c
> |  dump_stack+0xa4/0xdc
> |  check_preemption_disabled+0xfc/0x100
> |  debug_smp_processor_id+0x1c/0x24
> |  __do_user_fault+0xcc/0x180
> |  do_page_fault+0x14c/0x364
> |  do_translation_fault+0x40/0x48
> |  do_mem_abort+0x40/0xb8
> |  el0_da+0x20/0x24

Ah bugger, yes, we re-enabled interrupts in the entry code when we took the
fault initially.

> Make it a TIF flag?
> 
> (Seen with arm64's kpti-base tag and this series)

A TIF flag is still a bit fiddly, because we need to track that the
predictor could be dirty on this CPU. Instead, I'll postpone the re-enabling
of IRQs on el0_ia until we're in C code -- we can quickly a check on the
address before doing that. See below.

Will

--->8

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 80b539845da6..07a7d4db8ec4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -721,12 +721,15 @@ el0_ia:
 	 * Instruction abort handling
 	 */
 	mrs	x26, far_el1
-	enable_daif
+	enable_da_f
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
-	bl	do_mem_abort
+	bl	do_el0_ia_bp_hardening
 	b	ret_to_user
 el0_fpsimd_acc:
 	/*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5203b6040cb6..0e671ddf4855 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -318,7 +318,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		lsb = PAGE_SHIFT;
 	si.si_addr_lsb = lsb;
 
-	arm64_apply_bp_hardening();
 	force_sig_info(sig, &si, tsk);
 }
 
@@ -709,6 +708,23 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	arm64_notify_die("", regs, &info, esr);
 }
 
+asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
+						   unsigned int esr,
+						   struct pt_regs *regs)
+{
+	/*
+	 * We've taken an instruction abort from userspace and not yet
+	 * re-enabled IRQs. If the address is a kernel address, apply
+	 * BP hardening prior to enabling IRQs and pre-emption.
+	 */
+	if (addr > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
+	local_irq_enable();
+	do_mem_abort(addr, esr, regs);
+}
+
+
 asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   unsigned int esr,
 					   struct pt_regs *regs)
