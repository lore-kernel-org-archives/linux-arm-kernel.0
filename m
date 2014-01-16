From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Jan 2014 15:36:56 +0800
Subject: [PATCH V6 3/3] ARM: imx: add suspend in ocram support for i.mx6sl
In-Reply-To: <1389840105-17625-3-git-send-email-b20788@freescale.com>
References: <1389840105-17625-1-git-send-email-b20788@freescale.com>
 <1389840105-17625-3-git-send-email-b20788@freescale.com>
Message-ID: <20140116073655.GC4049@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:41:45AM +0800, Anson Huang wrote:
> @@ -119,6 +120,31 @@
>  
>  	.endm
>  
> +	.macro reset_mmdc_read_fifo
> +
> +	/* reset read FIFO, RST_RD_FIFO */
> +	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
> +	ldr	r6, [r11, r7]
> +	orr     r6, r6, #(1 << 31)
> +	str	r6, [r11, r7]
> +1:
> +	ldr	r6, [r11, r7]
> +	and	r6, r6, #(1 << 31)
> +	cmp	r6, #0

Use 'ands' to save the 'cmp'.

> +	bne	1b
> +
> +	/* reset FIFO a second time */
> +	ldr	r6, [r11, r7]
> +	orr     r6, r6, #(1 << 31)
> +	str	r6, [r11, r7]
> +2:
> +	ldr	r6, [r11, r7]
> +	and	r6, r6, #(1 << 31)
> +	cmp	r6, #0

Ditto

> +	bne	2b
> +
> +	.endm
> +
>  ENTRY(imx6_suspend)
>  	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
>  	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]

<snip>

> @@ -286,6 +335,14 @@ resume:
>  	restore_mmdc_io
>  
>  	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
> +
> +	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
> +	cmp 	r3, #MXC_CPU_IMX6SL
> +	bne	dsm_restore_mmdc_io_done
> +
> +	reset_mmdc_read_fifo
> +dsm_restore_mmdc_io_done:
> +
>  	enable_mmdc_access
>  
>  	mov	pc, lr

Instead of creating 3 macros, restore_mmdc_io, reset_mmdc_read_fifo and
enable_mmdc_access, I was actually suggesting to do all the mmdc resume
work in one macro.  We will need to tell the macro whether we're running
at virtual or physical space.  For you reference, the following changes
are what I made on top of yours.

Shawn

---8<-------

diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 570fede..1ba8fc8 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -18,8 +18,8 @@
  *
  * Better to follow below rules to use ARM registers:
  * r0: pm_info structure address;
- * r1 ~ r5: for saving pm_info members;
- * r6 ~ r10: free registers;
+ * r1 ~ r4: for saving pm_info members;
+ * r5 ~ r10: free registers;
  * r11: io base address.
  *
  * suspend ocram space layout:
@@ -87,9 +87,13 @@
 
 	.endm
 
-	.macro	restore_mmdc_io
+	.macro	resume_mmdc
+
+	/* restore MMDC IO */
+	cmp	r5, #0
+	ldreq	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
+	ldrne	r11, [r0, #PM_INFO_MX6Q_IOMUXC_P_OFFSET]
 
-	/* r11 must be the MMDC IO address before calling it */
 	ldr	r6, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
 	ldr	r7, =PM_INFO_MMDC_IO_VAL_OFFSET
 	add	r7, r7, r0
@@ -100,48 +104,45 @@
 	subs	r6, r6, #0x1
 	bne	1b
 
-	.endm
-
-	.macro	enable_mmdc_access
+	cmp	r5, #0
+	ldreq	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
+	ldrne	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
 
-	/* let DDR out of self-refresh */
-	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
-	bic	r7, r7, #(1 << 21)
-	str	r7, [r11, #MX6Q_MMDC_MAPSR]
-
-1:
-	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
-	ands	r7, r7, #(1 << 25)
-	bne	1b
-	/* enable DDR auto power saving */
-	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
-	bic	r7, r7, #0x1
-	str	r7, [r11, #MX6Q_MMDC_MAPSR]
-
-	.endm
-
-	.macro reset_mmdc_read_fifo
+	cmp 	r3, #MXC_CPU_IMX6SL
+	bne	4f
 
 	/* reset read FIFO, RST_RD_FIFO */
 	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
 	ldr	r6, [r11, r7]
 	orr     r6, r6, #(1 << 31)
 	str	r6, [r11, r7]
-1:
+2:
 	ldr	r6, [r11, r7]
-	and	r6, r6, #(1 << 31)
-	cmp	r6, #0
-	bne	1b
+	ands	r6, r6, #(1 << 31)
+	bne	2b
 
 	/* reset FIFO a second time */
 	ldr	r6, [r11, r7]
 	orr     r6, r6, #(1 << 31)
 	str	r6, [r11, r7]
-2:
+3:
 	ldr	r6, [r11, r7]
-	and	r6, r6, #(1 << 31)
-	cmp	r6, #0
-	bne	2b
+	ands	r6, r6, #(1 << 31)
+	bne	3b
+
+4:
+	/* let DDR out of self-refresh */
+	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #(1 << 21)
+	str	r7, [r11, #MX6Q_MMDC_MAPSR]
+5:
+	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
+	ands	r7, r7, #(1 << 25)
+	bne	5b
+	/* enable DDR auto power saving */
+	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #0x1
+	str	r7, [r11, #MX6Q_MMDC_MAPSR]
 
 	.endm
 
@@ -281,8 +282,7 @@ set_mmdc_io_lpm_done:
 	 */
 	ldr     r6, =2000
 rbc_loop:
-	sub     r6, r6, #0x1
-	cmp     r6, #0x0
+	subs	r6, r6, #0x1
 	bne     rbc_loop
 
 	/* Zzz, enter stop mode */
@@ -297,18 +297,8 @@ rbc_loop:
 	 * wakeup source, system should auto
 	 * resume, we need to restore MMDC IO first
 	 */
-	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
-	restore_mmdc_io
-
-	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
-
-	cmp 	r3, #MXC_CPU_IMX6SL
-	bne	restore_mmdc_io_done
-
-	reset_mmdc_read_fifo
-restore_mmdc_io_done:
-
-	enable_mmdc_access
+	mov	r5, #0
+	resume_mmdc
 
 	/* return to suspend finish */
 	mov	pc, lr
@@ -331,19 +321,9 @@ resume:
 	str	r7, [r11, #MX6Q_SRC_GPR1]
 	str	r7, [r11, #MX6Q_SRC_GPR2]
 
-	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_P_OFFSET]
-	restore_mmdc_io
-
-	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
-
 	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
-	cmp 	r3, #MXC_CPU_IMX6SL
-	bne	dsm_restore_mmdc_io_done
-
-	reset_mmdc_read_fifo
-dsm_restore_mmdc_io_done:
-
-	enable_mmdc_access
+	mov	r5, #1
+	resume_mmdc
 
 	mov	pc, lr
 ENDPROC(imx6_suspend)
