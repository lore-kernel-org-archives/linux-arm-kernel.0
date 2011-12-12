From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Dec 2011 16:38:07 -0500 (EST)
Subject: arm and patch phys offset
In-Reply-To: <201112122212.35506.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <alpine.LFD.2.02.1112111935590.2907@xanadu.home>
 <201112122212.35506.michael@walle.cc>
Message-ID: <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Dec 2011, Michael Walle wrote:

> Am Montag 12 Dezember 2011, 01:53:42 schrieb Nicolas Pitre:
> > On Sun, 11 Dec 2011, Michael Walle wrote:
> > > I have a marvell kirkwood based LS-CHLv2 board and running the latest
> > > HEAD of linus tree (with my dts patched for the kirkwood port, but
> > > hopefully this should be unrelated to this problem).
> > 
> > Did you try without those patches to be sure?
> clean linux tree with old fashioned setup code now (the one i sent long time 
> ago to this mailinglist ;).
> 
> > > The weird thing is that this output changes if i insert or move some
> > > debug prints. I even accomplished to make the board boot completely
> > > sometimes.
> > 
> > You must have some memory corrupting bug somewhere.  Please try calling
> > this code first thing in start_kernel() for comparison.
> 
> calling the dump function right at the beginning of start_kernel() won't 
> change anything, expect the addresses.
> 
> If it would be some memory corruption, shouldn't the table or the p2v/v2p 
> stubs be corrupt?

Not necessarily.  But when memory corruption occurs, anything may 
happen.

> But the non-patched entries always points to correct v2p/p2v 
> calls and in every case there is the unpatched add/sub instruction. 

Then, might it be possible that the cache is not properly turned off 
prior entering the kernel?

What bootloader do you use?

You could try instrumenting the patching code, although it is a bit 
tricky because of the non-standard register life rules in that file.  
But something like this should tell you if the expected amount of fixups 
were applied:

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 08c82fd844..7f43d1fe01 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -530,14 +530,23 @@ __fixup_a_pv_table:
 	bcc	1b
 	bx	lr
 #else
+	mov	r0, #0
 	b	2f
 1:	ldr	ip, [r7, r3]
 	bic	ip, ip, #0x000000ff
 	orr	ip, ip, r6	@ mask in offset bits 31-24
 	str	ip, [r7, r3]
+	add	r0, r0, #1
 2:	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
 	bcc	1b
+
+	mov	r6, r2
+	mov	r7, r3
+	bl	printhex8	@ display number of fixups done in r0
+	mov	r2, r6
+	mov	r3, r7
+
 	mov	pc, lr
 #endif
 ENDPROC(__fixup_a_pv_table)


Nicolas
