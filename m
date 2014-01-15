From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 11:43:23 +0800
Subject: [PATCH V5 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <1389681315-10231-1-git-send-email-b20788@freescale.com>
References: <1389681315-10231-1-git-send-email-b20788@freescale.com>
Message-ID: <20140115034321.GD1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 02:35:13PM +0800, Anson Huang wrote:
> When system enter suspend, we can set the DDR IO to
> high-Z state to save DDR IOs' power consumption, this
> operation can save many power(from ~26mA at 1.5V to ~15mA at 1.5V,
> measured on i.MX6Q SabreSD board, R25) of DDR IOs. To
> achieve that, we need to copy the suspend code to ocram
> and run the low level hardware related code(set DDR IOs
> to high-Z state) in ocram.
> 
> If there is no ocram space available, then system will
> still do suspend in external DDR, hence no DDR IOs will
> be set to high-Z.
> 
> The OCRAM usage layout is as below,
> 
> ocram suspend region(4K currently):
> ======================== high address ======================
>                               .
>                               .
>                               .
>                               ^
>                               ^
>                               ^
>                       imx6_suspend code
>       reserved space(to make imx6_suspend aligned with 8)

We can remove this line now, right?  Same for the comment in code.

>              PM_INFO structure(imx6_cpu_pm_info)
> ======================== low address =======================
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

<snip>

> +ENTRY(imx6_suspend)
> +	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
> +	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
> +	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
> +	ldr	r4, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
> +
> +	/*
> +	 * counting the resume address in iram
> +	 * to set it in SRC register.
> +	 */
> +	ldr	r6, =imx6_suspend
> +	ldr	r7, =resume
> +	sub	r7, r7, r6
> +	add	r8, r1, r4
> +	add	r9, r8, r7
> +
> +	/*
> +	 * make sure TLB contain the addr we want,
> +	 * as we will access them after MMDC IO floated.
> +	 */
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_CCM_V_OFFSET]
> +	ldr	r6, [r11, #0x0]
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	ldr	r6, [r11, #0x0]
> +
> +	/* use r11 to store the IO address */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_V_OFFSET]
> +	/* store physical resume addr and pm_info address. */
> +	str	r9, [r11, #MX6Q_SRC_GPR1]
> +	str	r1, [r11, #MX6Q_SRC_GPR2]
> +
> +	/* need to sync L2 cache before DSM. */
> +	sync_l2_cache
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
> +	/*
> +	 * put DDR explicitly into self-refresh and
> +	 * disable automatic power savings.
> +	 */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	orr	r7, r7, #0x1
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +	/* make the DDR explicitly enter self-refresh. */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	orr	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_set_1:
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	ands	r7, r7, #(1 << 25)
> +	beq	poll_dvfs_set_1
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
> +	ldr	r6, =0x0
> +	ldr	r7, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
> +	ldr	r8, =PM_INFO_MMDC_IO_VAL_OFFSET

If we add the following instruction here

	add     r8, r0, r8

> +set_mmdc_io_lpm:
> +	ldr	r9, [r0, r8]

, it can be replaced by the following one
 
	ldr     r9, [r8], #0x8

> +	str	r6, [r11, r9]
> +	add	r8, r8, #0x8

, and then we can save this one in the loop, right?

> +	sub	r7, r7, #0x1
> +	cmp     r7, #0x0

The sequence of 'sub ...; cmp ..., #0' and 'and ...; cmp ..., #0' can
generally be replaced by 'subs ...' and 'ands' respectively to save one
instruction, right?

The above two comments apply to a few other places in the code.

> +	bne	set_mmdc_io_lpm
> +
> +	/*
> +	 * mask all GPC interrupts before
> +	 * enabling the RBC counters to
> +	 * avoid the counter starting too
> +	 * early if an interupt is already
> +	 * pending.
> +	 */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	ldr	r6, [r11, #MX6Q_GPC_IMR1]
> +	ldr	r7, [r11, #MX6Q_GPC_IMR2]
> +	ldr	r8, [r11, #MX6Q_GPC_IMR3]
> +	ldr	r9, [r11, #MX6Q_GPC_IMR4]
> +
> +	ldr	r10, =0xffffffff
> +	str	r10, [r11, #MX6Q_GPC_IMR1]
> +	str	r10, [r11, #MX6Q_GPC_IMR2]
> +	str	r10, [r11, #MX6Q_GPC_IMR3]
> +	str	r10, [r11, #MX6Q_GPC_IMR4]
> +
> +	/*
> +	 * enable the RBC bypass counter here
> +	 * to hold off the interrupts. RBC counter
> +	 * = 32 (1ms), Minimum RBC delay should be
> +	 * 400us for the analog LDOs to power down.
> +	 */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_CCM_V_OFFSET]
> +	ldr	r10, [r11, #MX6Q_CCM_CCR]
> +	bic	r10, r10, #(0x3f << 21)
> +	orr	r10, r10, #(0x20 << 21)
> +	str	r10, [r11, #MX6Q_CCM_CCR]
> +
> +	/* enable the counter. */
> +	ldr	r10, [r11, #MX6Q_CCM_CCR]
> +	orr	r10, r10, #(0x1 << 27)
> +	str	r10, [r11, #MX6Q_CCM_CCR]
> +
> +	/* unmask all the GPC interrupts. */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_GPC_V_OFFSET]
> +	str	r6, [r11, #MX6Q_GPC_IMR1]
> +	str	r7, [r11, #MX6Q_GPC_IMR2]
> +	str	r8, [r11, #MX6Q_GPC_IMR3]
> +	str	r9, [r11, #MX6Q_GPC_IMR4]
> +
> +	/*
> +	 * now delay for a short while (3usec)
> +	 * ARM is at 1GHz at this point
> +	 * so a short loop should be enough.
> +	 * this delay is required to ensure that
> +	 * the RBC counter can start counting in
> +	 * case an interrupt is already pending
> +	 * or in case an interrupt arrives just
> +	 * as ARM is about to assert DSM_request.
> +	 */
> +	ldr     r6, =2000
> +rbc_loop:
> +	sub     r6, r6, #0x1
> +	cmp     r6, #0x0
> +	bne     rbc_loop
> +
> +	/* Zzz, enter stop mode */
> +	wfi
> +	nop
> +	nop
> +	nop
> +	nop
> +
> +	/*
> +	 * run to here means there is pending
> +	 * wakeup source, system should auto
> +	 * resume, we need to restore MMDC IO first
> +	 */

The MMDC restoring code looks identical between the case of wakeup
source pending and the normal resume case, except that the former runs
at virtual address and the later runs at the physical.  Can we make
a macro for it to save some code duplication?

Shawn

> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
> +	ldr	r6, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
> +	ldr	r7, =PM_INFO_MMDC_IO_VAL_OFFSET
> +restore_mmdc_io:
> +	ldr	r8, [r0, r7]
> +	add	r7, r7, #0x4
> +	ldr	r9, [r0, r7]
> +	add	r7, r7, #0x4
> +	str	r9, [r11, r8]
> +	sub	r6, r6, #0x1
> +	cmp     r6, #0x0
> +	bne	restore_mmdc_io
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
> +	/* let DDR out of self-refresh. */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_clear_2:
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	ands	r7, r7, #(1 << 25)
> +	bne     poll_dvfs_clear_2
> +	/* enable DDR auto power saving */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #0x1
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	/* return to suspend finish */
> +	mov	pc, lr
> +
> +resume:
> +	/* invalidate L1 I-cache first */
> +	mov     r6, #0x0
> +	mcr     p15, 0, r6, c7, c5, 0
> +	mcr     p15, 0, r6, c7, c5, 0
> +	mcr     p15, 0, r6, c7, c5, 6
> +	/* enable the Icache and branch prediction */
> +	mov     r6, #0x1800
> +	mcr     p15, 0, r6, c1, c0, 0
> +	isb
> +
> +	/* get physical resume address from pm_info. */
> +	ldr	lr, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
> +	/* clear core0's entry and parameter */
> +	ldr	r11, [r0, #PM_INFO_MX6Q_SRC_P_OFFSET]
> +	mov	r7, #0
> +	str	r7, [r11, #MX6Q_SRC_GPR1]
> +	str	r7, [r11, #MX6Q_SRC_GPR2]
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_P_OFFSET]
> +	ldr	r6, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
> +	ldr	r7, =PM_INFO_MMDC_IO_VAL_OFFSET
> +dsm_restore_mmdc_io:
> +	ldr	r8, [r0, r7]
> +	add	r7, r7, #0x4
> +	ldr	r9, [r0, r7]
> +	add	r7, r7, #0x4
> +	str	r9, [r11, r8]
> +	sub	r6, r6, #0x1
> +	cmp     r6, #0x0
> +	bne	dsm_restore_mmdc_io
> +
> +	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
> +	/* let DDR out of self-refresh */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #(1 << 21)
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +
> +poll_dvfs_clear_1:
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	ands	r7, r7, #(1 << 25)
> +	bne	poll_dvfs_clear_1
> +	/* enable DDR auto power saving */
> +	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	bic	r7, r7, #0x1
> +	str	r7, [r11, #MX6Q_MMDC_MAPSR]
> +	mov	pc, lr
> +ENDPROC(imx6_suspend)
> -- 
> 1.7.9.5
> 
> 
