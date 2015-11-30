From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Nov 2015 10:40:27 +0000
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <20151130052843.GG23908@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
 <20151130052843.GG23908@dhcppc13.redhat.com>
Message-ID: <20151130104027.7eeaa273@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2015 10:58:43 +0530
Pratyush Anand <panand@redhat.com> wrote:

> On 27/11/2015:02:19:37 PM, Marc Zyngier wrote:
> > On 24/11/15 22:25, Geoff Levand wrote:
> > > +ENTRY(cpu_soft_restart)
> > > +	mov	x18, x0				// cpu_reset
> > > +	mov	x0, x1				// el2_switch
> > > +	mov	x1, x2				// entry
> > > +	mov	x2, x3				// arg0
> > > +	mov	x3, x4				// arg1
> > > +	ret	x18
> > > +ENDPROC(cpu_soft_restart)
> > 
> > Grepping through the tree, I can only find a single use of
> > cpu_soft_restart, with cpu_reset as its first parameter.
> > 
> > Why do we need this indirection? Having
> 
> It is needed because we need to execute cpu_reset() in physical address space.
> 
> > 
> > void cpu_soft_restart(el2_switch, entry, arg0, arg1);
> > 
> > should be enough...
> 
> We can do with only cpu_soft_restart(), but then a function pointer to __pa() of
> it need to be called. May  be current approach is more cleaner.

All that can be solved in C, and mostly at compile time. Using an
assembler trampoline is complicating things for no good reason:

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 0423f27..099f6f2 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -28,27 +28,7 @@
 .align 5
 
 /*
- * cpu_soft_restart(cpu_reset, el2_switch, entry, arg0, arg1) - Perform a cpu
- * soft reset.
- *
- * @cpu_reset: Physical address of the cpu_reset routine.
- * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_reset.
- * @entry: Location to jump to for soft reset, passed to cpu_reset.
- * arg0: First argument passed to @entry.
- * arg1: Second argument passed to @entry.
- */
-
-ENTRY(cpu_soft_restart)
-	mov	x18, x0				// cpu_reset
-	mov	x0, x1				// el2_switch
-	mov	x1, x2				// entry
-	mov	x2, x3				// arg0
-	mov	x3, x4				// arg1
-	ret	x18
-ENDPROC(cpu_soft_restart)
-
-/*
- * cpu_reset(el2_switch, entry, arg0, arg1) - Helper for cpu_soft_restart.
+ * __cpu_soft_restart(el2_switch, entry, arg0, arg1) - Helper for cpu_soft_restart.
  *
  * @el2_switch: Flag to indicate a swich to EL2 is needed.
  * @entry: Location to jump to for soft reset.
@@ -60,7 +40,7 @@ ENDPROC(cpu_soft_restart)
  * flat identity mapping.
  */
 
-ENTRY(cpu_reset)
+ENTRY(__cpu_soft_restart)
 	/* Clear sctlr_el1 flags. */
 	mrs	x12, sctlr_el1
 	ldr	x13, =SCTLR_ELx_FLAGS
@@ -79,6 +59,6 @@ ENTRY(cpu_reset)
 	mov	x0, x2				// arg0
 	mov	x1, x3				// arg1
 	ret	x18
-ENDPROC(cpu_reset)
+ENDPROC(__cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 79816b6..df88892 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -13,10 +13,17 @@
 
 #include <asm/virt.h>
 
-void __attribute__((noreturn)) cpu_reset(unsigned long el2_switch,
-	unsigned long entry, unsigned long arg0, unsigned long arg1);
-void __attribute__((noreturn)) cpu_soft_restart(phys_addr_t cpu_reset,
-	unsigned long el2_switch, unsigned long entry, unsigned long arg0,
-	unsigned long arg1);
+void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
+			unsigned long arg0, unsigned long arg1);
+
+static inline
+void __noreturn cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
+				 unsigned long arg0, unsigned long arg1)
+{
+	typeof(__cpu_soft_restart) *restart;
+	restart = (void *)virt_to_phys(__cpu_soft_restart);
+	restart(el2_switch, entry, arg0, arg1);
+	unreachable();
+}
 
 #endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 482aae7..ecdf822 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -210,8 +210,7 @@ void machine_kexec(struct kimage *kimage)
 	 * relocation is complete.
 	 */
 
-	cpu_soft_restart(virt_to_phys(cpu_reset),
-		in_crash_kexec ? 0 : is_hyp_mode_available(),
+	cpu_soft_restart(in_crash_kexec ? 0 : is_hyp_mode_available(),
 		reboot_code_buffer_phys, kimage->head, kimage_start);
 
 	BUG(); /* Should never get here. */


Simpler, more readable, no pointless register shifting, smaller idmap
footprint.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
