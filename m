From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 2 Dec 2011 13:39:11 +0000
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <20111202102418.GT26618@pengutronix.de>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
 <20111202102418.GT26618@pengutronix.de>
Message-ID: <20111202133911.GC2892@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 11:24:18AM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Dec 02, 2011 at 06:01:08PM +0800, Eric Miao wrote:
> > Hi Dave & Sascha,
> > 
> > I checked the log of this file, found a THUMB2 related changes, yet
> > I'm still having the failure below, can you help do a quick check?
> the problem is that in Thumb most commands don't work with r8-r15
> because there are only three bits used to encode them. This is
> unfortunate as the other registers are not banked for FIQ.

That really only applies to Thumb-1 (i.e., prior to ARMv6T2).  The
real problem here is that the code (ab)uses r13: this register is no
longer fully general purpose in the Thumb-2 instruction set.  Instead,
it can only be used as a base register in LDM/STM/PUSH/POP and the LDR/
STR family of instructions, and as a simple operand in ADD/SUB/MOV type
instructions.

It just so happens that the use of r11 in this file _does_ fit those
constraints.

I hit this issue some time ago, and worked around the build problem by
simply swapping the roles of r11 and r13, both of which are banked for
FIQ mode.  I was never able to test it though, and I remain unsure
whether this code applies to new platforms.

Is this code still used on ARMv7 and above?  FIQ is not normally
available for Linux interrupts on hardware which makes use of the
TrustZone security extensions.  Plus, on modern hardware with a deep
memory hierarchy, FIQ is may not be all that "fast" either, due to
cache/TLB effects.



Here's my original patch, which also tries to fixes some other issues
which cause problems with some tool versions.  If someone is in a
position to test it, that would be great.

Cheers
---Dave


>From 014db9cd2b542cd9331c79cff6f38dad3026a32a Mon Sep 17 00:00:00 2001
From: Dave Martin <dave.martin@linaro.org>
Date: Wed, 6 Apr 2011 16:25:25 +0100
Subject: [PATCH] ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible

References to locally-defined global symbols with adr and ldr
may not be accepted by the assembler in Thumb-2.  Local shadow
symbols are added to work around this.

The code contains use of r13 (sp) which isn't allowed in Thumb-2.
r11 and r13 have been swapped throughout the file to work around
this.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/plat-mxc/ssi-fiq.S |   89 ++++++++++++++++++++++++-------------------
 1 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/arch/arm/plat-mxc/ssi-fiq.S b/arch/arm/plat-mxc/ssi-fiq.S
index 8397a2d..a8b93c5 100644
--- a/arch/arm/plat-mxc/ssi-fiq.S
+++ b/arch/arm/plat-mxc/ssi-fiq.S
@@ -34,91 +34,98 @@
 		.global imx_ssi_fiq_rx_buffer
 		.global imx_ssi_fiq_tx_buffer
 
+/*
+ * imx_ssi_fiq_start is _intentionally_ not marked as a function symbol
+ * using ENDPROC().  imx_ssi_fiq_start and imx_ssi_fiq_end are used to
+ * mark the function body so that it can be copied to the FIQ vector in
+ * the vectors page.  imx_ssi_fiq_start should only be called as the result
+ * of an FIQ: calling it directly will not work.
+ */
 imx_ssi_fiq_start:
-		ldr r12, imx_ssi_fiq_base
+		ldr r12, .L_imx_ssi_fiq_base
 
 		/* TX */
-		ldr r11, imx_ssi_fiq_tx_buffer
+		ldr r13, .L_imx_ssi_fiq_tx_buffer
 
 		/* shall we send? */
-		ldr r13, [r12, #SSI_SIER]
-		tst r13, #SSI_SIER_TFE0_EN
+		ldr r11, [r12, #SSI_SIER]
+		tst r11, #SSI_SIER_TFE0_EN
 		beq 1f
 
 		/* TX FIFO empty? */
-		ldr r13, [r12, #SSI_SISR]
-		tst r13, #SSI_SISR_TFE0
+		ldr r11, [r12, #SSI_SISR]
+		tst r11, #SSI_SISR_TFE0
 		beq 1f
 
 		mov r10, #0x10000
 		sub r10, #1
 		and r10, r10, r8	/* r10: current buffer offset */
 
-		add r11, r11, r10
+		add r13, r13, r10
 
-		ldrh r13, [r11]
-		strh r13, [r12, #SSI_STX0]
+		ldrh r11, [r13]
+		strh r11, [r12, #SSI_STX0]
 
-		ldrh r13, [r11, #2]
-		strh r13, [r12, #SSI_STX0]
+		ldrh r11, [r13, #2]
+		strh r11, [r12, #SSI_STX0]
 
-		ldrh r13, [r11, #4]
-		strh r13, [r12, #SSI_STX0]
+		ldrh r11, [r13, #4]
+		strh r11, [r12, #SSI_STX0]
 
-		ldrh r13, [r11, #6]
-		strh r13, [r12, #SSI_STX0]
+		ldrh r11, [r13, #6]
+		strh r11, [r12, #SSI_STX0]
 
 		add r10, #8
-		lsr r13, r8, #16	/* r13: buffer size */
-		cmp r10, r13
-		lslgt r8, r13, #16
+		lsr r11, r8, #16	/* r11: buffer size */
+		cmp r10, r11
+		lslgt r8, r11, #16
 		addle r8, #8
 1:
 		/* RX */
 
 		/* shall we receive? */
-		ldr r13, [r12, #SSI_SIER]
-		tst r13, #SSI_SIER_RFF0_EN
+		ldr r11, [r12, #SSI_SIER]
+		tst r11, #SSI_SIER_RFF0_EN
 		beq 1f
 
 		/* RX FIFO full? */
-		ldr r13, [r12, #SSI_SISR]
-		tst r13, #SSI_SISR_RFF0
+		ldr r11, [r12, #SSI_SISR]
+		tst r11, #SSI_SISR_RFF0
 		beq 1f
 
-		ldr r11, imx_ssi_fiq_rx_buffer
+		ldr r13, .L_imx_ssi_fiq_rx_buffer
 
 		mov r10, #0x10000
 		sub r10, #1
 		and r10, r10, r9	/* r10: current buffer offset */
 
-		add r11, r11, r10
+		add r13, r13, r10
 
-		ldr r13, [r12, #SSI_SACNT]
-		tst r13, #SSI_SACNT_AC97EN
+		ldr r11, [r12, #SSI_SACNT]
+		tst r11, #SSI_SACNT_AC97EN
 
-		ldr r13, [r12, #SSI_SRX0]
-		strh r13, [r11]
+		ldr r11, [r12, #SSI_SRX0]
+		strh r11, [r13]
 
-		ldr r13, [r12, #SSI_SRX0]
-		strh r13, [r11, #2]
+		ldr r11, [r12, #SSI_SRX0]
+		strh r11, [r13, #2]
 
 		/* dummy read to skip slot 12 */
-		ldrne r13, [r12, #SSI_SRX0]
+		ldrne r11, [r12, #SSI_SRX0]
 
-		ldr r13, [r12, #SSI_SRX0]
-		strh r13, [r11, #4]
+		ldr r11, [r12, #SSI_SRX0]
+		strh r11, [r13, #4]
 
-		ldr r13, [r12, #SSI_SRX0]
-		strh r13, [r11, #6]
+		ldr r11, [r12, #SSI_SRX0]
+		strh r11, [r13, #6]
 
 		/* dummy read to skip slot 12 */
-		ldrne r13, [r12, #SSI_SRX0]
+		ldrne r11, [r12, #SSI_SRX0]
 
 		add r10, #8
-		lsr r13, r9, #16	/* r13: buffer size */
-		cmp r10, r13
-		lslgt r9, r13, #16
+		lsr r11, r9, #16	/* r11: buffer size */
+		cmp r10, r11
+		lslgt r9, r11, #16
 		addle r9, #8
 
 1:
@@ -126,11 +133,15 @@ imx_ssi_fiq_start:
 		subs	pc, lr, #4
 
 		.align
+.L_imx_ssi_fiq_base:
 imx_ssi_fiq_base:
 		.word 0x0
+.L_imx_ssi_fiq_rx_buffer:
 imx_ssi_fiq_rx_buffer:
 		.word 0x0
+.L_imx_ssi_fiq_tx_buffer:
 imx_ssi_fiq_tx_buffer:
 		.word 0x0
+.L_imx_ssi_fiq_end:
 imx_ssi_fiq_end:
 
-- 
1.7.4.1
