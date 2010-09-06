From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 6 Sep 2010 20:24:02 +0300
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <loom.20100906T103236-552@post.gmane.org>
References: <20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<20100902115206.GK25559@gw.healthdatacare.com>
	<20100902121838.GB26319@n2100.arm.linux.org.uk>
	<20100902134834.GL25559@gw.healthdatacare.com>
	<20100903060443.GM25559@gw.healthdatacare.com>
	<loom.20100906T103236-552@post.gmane.org>
Message-ID: <20100906172402.GW25559@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 08:58:25AM +0000, Per Fransson wrote:
> 
> How do you run it via a 1-1 mapping? Do you call the physical address of
> cpu_reset() from machine_kexec() after calling setup_mm_for_reboot()? I.e.
> 
> 	outer_inv_all();
> 	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
> 	(virt_to_phys(cpu_reset))(reboot_code_buffer_phys);

Yeah, I had something like that first but then I decided to isolate
this into proc-v7.S see [1]. I've tested that code on OMAP3430,
OMAP3530 and OMAP3630 and it works there. Unfortunately I don't
have any other v7 hardware except those :(

> In that case, we're relying on two pieces of code being identity mapped,
> cpu_v7_reset() and relocate_new_kernel(). I still promote limiting the scope of
> setup_mm_for_reboot() to the bare minimum, so as not to destroy the user-space
> mapping. If we set up a 1-1 around cpu_reset() for example, couldn't we idle
> away there until we are sure the MMU is off and *then* jump to the physical
> address of relocate_new_kernel() which wouldn't have to be 1-1 mapped?

I agree with you. Now that I've been playing with this kdump code,
it is indeed useful to be able to access memory of the panic'd
process.

> >         "After a CP15 c1 instruction disables the MMU, the processor
> >         flushes all following instructions in the pipeline. The
> >         processor then begins refetching instructions and uses flat
> >         address mapping. In flat address mapping, PA = VA."
> > 
> 
> If this is the case, the Qemu issue I mentioned here
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019678.html
> 
> wasn't so far off the mark after all =o)

This is exactly what is happening on Cortex-A8 (at least on those OMAPs which
I've been testing on).

Regards,
MW

[1] - cpu_v7_reset via 1:1 mappings

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6a8506d..66c12c0 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -63,10 +63,53 @@ ENDPROC(cpu_v7_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v7_reset)
-	mov	pc, r0
+	/*
+	 * ARM Cortex-A8 TRM chapter 6.4 says:
+	 *
+	 *    After a CP15 c1 instruction disables the MMU, the processor
+	 *    flushes all following instructions in the pipeline. The processor
+	 *    then begins refetching instructions and uses flat address mapping.
+	 *    In flat address mapping, PA = VA.
+	 *
+	 * This means that in Cortex-A8 we need to disable the MMU through the
+	 * identity mapped region.
+	 */
+	mrc	p15, 0, r5, c0, c0, 0		@ read main ID register
+	and	r6, r5, #0xff000000		@ ARM?
+	teq	r6, #0x41000000
+	bne	__disable_mmu
+
+	mov	r6, #0x0000ff00			@ check primary part number
+	orr	r6, r6, #0x00f0			@ bits [15:4]
+	and	r6, r6, r5
+
+	mov	r5, #0xc000			@ is it Cortex-A8 (0xc080)?
+	orr	r5, r5, #0x0080
+	teq	r5, r6
+	bne	__disable_mmu
+
+	/*
+	 * This is Cortex-A8 so call via identity mapping.
+	 */
+	ldr	pc, =__virt_to_phys(__disable_mmu)
 ENDPROC(cpu_v7_reset)
 
 /*
+ * Disables the MMU and jumps into address given in r0.
+ */
+__disable_mmu:
+	mov     ip, #0
+#ifdef CONFIG_MMU
+	mcr     p15, 0, ip, c8, c7, 0           @ invalidate I & D TLBs
+#endif
+	mrc     p15, 0, ip, c1, c0, 0           @ ctrl register
+	bic     ip, ip, #0x000f                 @ ............wcam
+	bic     ip, ip, #0x1100                 @ ...i...s........
+	mcr     p15, 0, ip, c1, c0, 0           @ ctrl register
+	mov     pc, r0
+ENDPROC(__disable_mmu)
+
+/*
  *	cpu_v7_do_idle()
  *
  *	Idle the processor (eg, wait for interrupt).
