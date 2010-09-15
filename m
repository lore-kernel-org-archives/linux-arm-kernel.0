From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Sep 2010 23:35:27 -0400 (EDT)
Subject: [PATCH] ARM: plug a race with the alignment trap handler
Message-ID: <alpine.LFD.2.00.1009142332070.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When the policy for user space is to ignore misaligned accesses from user
space, the processor then performs a documented rotation on the accessed
data.  This is the result of the access being trapped, and the kernel
disabling the alignment trap before returning to user space again.

In kernel space we always want misaligned accesses to be fixed up.  This
is enforced by always re-enabling the alignment trap on every entry into
kernel space from user space.  No such re-enabling is performed when an
exception occurs while already in kernel space as the alignment trap is
always supposed to be enabled in that case.

There is however a small race window when a misaligned access in user
space is trapped and the alignment trap disabled, but the CPU didn't
return to user space just yet.  Any exception would be entered from kernel
space at that point and the kernel would then execute with the alignment
trap disabled.

Thanks to Maxime Bizon <mbizon@freebox.fr> for providing a test module
that made this issue reproducible.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index d073b64..724ba3b 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -885,8 +885,23 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	if (ai_usermode & UM_SIGNAL)
 		force_sig(SIGBUS, current);
-	else
-		set_cr(cr_no_alignment);
+	else {
+		/*
+		 * We're about to disable the alignment trap and return to
+		 * user space.  But if an interrupt occurs before actually
+		 * reaching user space, then the IRQ vector entry code will
+		 * notice that we were still in kernel space and therefore
+		 * the alignment trap won't be re-enabled in that case as it
+		 * is presumed to be always on from kernel space.
+		 * Let's prevent that race by disabling interrupts here (they
+		 * are disabled on the way back to user space anyway in
+		 * entry-common.S) and disable the alignment trap only if
+		 * there is no work pending for this thread.
+		 */
+		raw_local_irq_disable();
+		if (!(current_thread_info()->flags & _TIF_WORK_MASK))
+			set_cr(cr_no_alignment);
+	}
 
 	return 0;
 }
