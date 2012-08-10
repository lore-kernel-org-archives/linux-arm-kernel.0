From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 10 Aug 2012 12:53:24 +0100
Subject: [PATCH] ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible
Message-ID: <1344599604-9623-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because FIQ handlers get copied straight into the vectors page to
the FIQ vector entry point, FIQ handlers in a Thumb-2 kernel must
start in Thumb-2.  A Thumb-2 kernel enters all exception vectors in
Thumb-2.

This patch adapts the mxc SSI FIQ code suitable for a Thumb-2
kernel.

The code contained use of r13 (sp) which isn't allowed in Thumb-2.
r11 and r13 have been swapped throughout the file to work around
this.

Currently, the way that the function to be copied is located using
labels is a bit ugly: we cannot annotate the FIQ handler properly
as a Thumb-2 function, because this would set bit 0 of the label
address seen by the linker, causing off-by-one errors when copying
the function.  Ideally, the copy would be done with fncpy(), but
this would require changes to the common set_fiq_handler()
function.  For now, we don't touch this.

References to locally-defined global symbols with adr and ldr may
not be accepted by the assembler in Thumb-2.  Local shadow symbols
are added to work around this.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

Note that while this code builds, I don't know the hardware well enough 
to be confident testing it.  Review and testing from anyone with
experience of imx SoC audio would be appreciated.

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
