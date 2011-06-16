From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jun 2011 22:31:28 +0100
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
Message-ID: <20110616213128.GC32629@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 02:35:26PM +0100, Frank Hofmann wrote:
> this change is perfect; with this, the hibernation support code turns 
> into the attached.

Should I assume that's an ack for all the patches?

> That's both better and simpler to perform a full suspend/resume cycle 
> (via resetting in the cpu_suspend "finisher") after the snapshot image 
> has been created, instead of shoehorning a return into this.

It's now not soo difficult to have an error code returned from the
finisher function - the only thing we have to make sure is that
the cpu_do_suspend helper just saves state and does not make any
state changes.

We can then do this, which makes it possible for the finisher to
return, and we propagate its return value.  We also ensure that a
path through from cpu_resume will result in a zero return value
from cpu_suspend.

This isn't an invitation for people to make the S2RAM path return
after they time out waiting for suspend to happen - that's potentially
dangerous because in that case the suspend may happen while we're
resuming devices which wouldn't be nice.

diff -u b/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
--- b/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -12,7 +12,6 @@
  *  r1 = v:p offset
  *  r2 = suspend function arg0
  *  r3 = suspend function
- * Note: does not return until system resumes
  */
 ENTRY(cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}
@@ -26,7 +25,7 @@
 #endif
 	mov	r6, sp			@ current virtual SP
 	sub	sp, sp, r5		@ allocate CPU state on stack
-	mov	r0, sp			@ save pointer
+	mov	r0, sp			@ save pointer to CPU save block
 	add	ip, ip, r1		@ convert resume fn to phys
 	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
 	ldr	r5, =sleep_save_sp
@@ -55,10 +54,17 @@
 #else
 	bl	__cpuc_flush_kern_all
 #endif
+	adr	lr, BSYM(cpu_suspend_abort)
 	ldmfd	sp!, {r0, pc}		@ call suspend fn
 ENDPROC(cpu_suspend)
 	.ltorg
 
+cpu_suspend_abort:
+	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
+	mov	sp, r2
+	ldmfd	sp!, {r4 - r11, pc}
+ENDPROC(cpu_suspend_abort)
+
 /*
  * r0 = control register value
  * r1 = v:p offset (preserved by cpu_do_resume)
@@ -88,6 +94,7 @@
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
+	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
 
