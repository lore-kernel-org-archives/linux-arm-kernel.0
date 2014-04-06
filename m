From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Apr 2014 12:46:52 +0100
Subject: L2 cache suspend/resume
In-Reply-To: <20140406114033.GC24260@dragon>
References: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
 <20140406114033.GC24260@dragon>
Message-ID: <20140406114652.GQ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 07:40:35PM +0800, Shawn Guo wrote:
> On Sat, Apr 05, 2014 at 12:27:00PM +0100, Russell King - ARM Linux wrote:
> > While looking through the L2 resume code paths, I notice that:
> > 
> >  * exynos
> >  * imx
> >  * tegra
> > 
> > all resume their L2 caches from assembly code, rather than using
> > outer_disable() before cpu_suspend(), and outer_resume() afterwards.
> > From what I can see, these are all running in the secure world, so that
> > isn't the reason.
> > 
> > What is the reason for this difference?  Can these three be converted to
> > the outer_disable()...outer_resume() method?
> 
> For imx, the L2 power and therefore the memory array is retained in
> suspend.  We do not want to call outer_disable() to have these data
> flushed, and need to restore L2 controller before MMU is enabled.

Okay, any objection then to separating out the L2 resume code into an
early L2 resume helper in arch/arm/mm ?  I currently have this
prototyped:

ENTRY(l2c310_early_resume)
        adr     r0, 1f
        ldr     r2, [r0]
        add     r0, r2, r0

        ldmia   r0, {r1, r2, r3, r4, r5, r6, r7, r8}
        @ r1 = phys address of L2C-310 controller
        @ r2 = aux_ctrl
        @ r3 = tag_latency
        @ r4 = data_latency
        @ r5 = filter_start
        @ r6 = filter_end
        @ r7 = prefetch_ctrl
        @ r8 = pwr_ctrl

        @ Check that the address has been initialised
        teq     r1, #0
        moveq   pc, lr

        @ The prefetch and power control registers are revision dependent
        @ and can be written whether or not the L2 cache is enabled
        ldr     r0, [r1, #L2X0_CACHE_ID]
        and     r0, r0, #L2X0_CACHE_ID_RTL_MASK
        cmp     r0, #L310_CACHE_ID_RTL_R2P0
        strcs   r7, [r1, #L310_PREFETCH_CTRL]
        cmp     r0, #L310_CACHE_ID_RTL_R3P0
        strcs   r8, [r1, #L310_POWER_CTRL]

        @ Don't setup the L2 cache if it is already enabled
        ldr     r0, [r1, #L2X0_CTRL]
        tst     r0, #L2X0_CTRL_EN
        movne   pc, lr

        str     r3, [r1, #L310_TAG_LATENCY_CTRL]
        str     r4, [r1, #L310_DATA_LATENCY_CTRL]
        str     r6, [r1, #L310_ADDR_FILTER_END]
        str     r5, [r1, #L310_ADDR_FILTER_START]

        str     r2, [r1, #L2X0_AUX_CTRL]
        mov     r9, #L2X0_CTRL_EN
        str     r9, [r1, #L2X0_CTRL]
        mov     pc, lr
ENDPROC(l2c310_early_resume)

        .align
1:      .long   l2x0_saved_regs - .

and suspend-imx6.S becomes:

ENTRY(v7_cpu_resume)
        bl      v7_invalidate_l1
#ifdef CONFIG_CACHE_L2X0
        bl      l2c310_early_resume
#endif
        b       cpu_resume
ENDPROC(v7_cpu_resume)

and similar for the other two SoCs.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
