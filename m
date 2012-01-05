From: jason.chen@freescale.com (Jason Chen)
Date: Thu, 5 Jan 2012 15:53:31 +0800
Subject: [PATCH 2/2] ARM: imx6q: add cpu suspend/resume support in IRAM
In-Reply-To: <20120105075802.GG14741@S2100-06.ap.freescale.net>
References: <1325312624-22980-1-git-send-email-jason.chen@linaro.org>
 <CACRpkdYu5jz0H_KnEq7JJ5PWJ35R=znjQeYCDcn+KM54zNY6Nw@mail.gmail.com>
 <20120105075802.GG14741@S2100-06.ap.freescale.net>
Message-ID: <20120105075331.GD2687@weitway>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 03:58:03PM +0800, Shawn Guo wrote:
> On Wed, Jan 04, 2012 at 12:02:51PM +0100, Linus Walleij wrote:
> > On Sat, Dec 31, 2011 at 7:23 AM, Jason Chen <jason.chen@linaro.org> wrote:
> > 
> > > ?void __init imx6q_pm_init(void)
> > > ?{
> > > ? ? ? ?/*
> > > @@ -67,4 +153,38 @@ void __init imx6q_pm_init(void)
> > > ? ? ? ?phys_l2x0_saved_regs = __pa(&l2x0_saved_regs);
> > >
> > > ? ? ? ?suspend_set_ops(&imx6q_pm_ops);
> > > +
> > > + ? ? ? /* Move suspend routine into iRAM */
> > (...)
> > > diff --git a/arch/arm/mach-imx/suspend-imx6q.S b/arch/arm/mach-imx/suspend-imx6q.S
> > (...)
> > > +.macro ddr_io_save
> > > + ? ? ? ldr ? ? r4, [r9, #0x5ac] /* DRAM_DQM0 */
> > > + ? ? ? ldr ? ? r5, [r9, #0x5b4] /* DRAM_DQM1 */
> > > + ? ? ? ldr ? ? r6, [r9, #0x528] /* DRAM_DQM2 */
> > > + ? ? ? ldr ? ? r7, [r9, #0x520] /* DRAM_DQM3 */
> > > + ? ? ? stmfd ? sp!, {r4-r7}
> > (etc)
> > 
> > This is not an elegant solution. I know other platforms have
> > done similar things but it's still not elegant.
> > 
> > What we need it real handling of the on-chip memory pool
> > and possibility to compile and link directly into the
> > on-chip memory areas.
> > 
> > Compare to what we have for TCM:
> > Documentation/arm/tcm.txt
> > Implemented in:
> > arch/arm/kernel/tcm.c
> > Linker trickery in:
> > arch/arm/kernel/vmlinux.lds.S
> > 
> > An approach similar to this would make it possible to:
> > 
> > - Manage the on-chip heap in a structured way
> > 
> > - Write the above assembler code in C and compile it directly
> >   into on-chip RAM
> > 
> > - Share the same code with other archs and possibly merge
> >   it with some of the TCM handling code top create common
> >   onchip RAM handling
> > 
> > - Optionally free up the .TEXT memory pages used by this
> >   code after copying it to on-chip RAM (if that RAM is
> >   persistent, as it seems to be)
> > 
> > - Make it possible to define MT_MEMORY_ONCHIP (if
> >   MT_MEMORY_ITCM isn't good enough) in
> >   arch/arm/include/asm/mach/map.h so everybody can
> >   use this.
> > 
> > It is also a bit more work and patch iteration involved.
> > But the end solution is very appealing IMO. Also,
> > multi-platform binaries will complicate the above a bit
> > (especially if, say, two platforms have their on-chip
> > RAM in the same location...) but I am sure it can be
> > solved with proper cleverness and step-by-step measures.
> > 
> It looks really interesting and appealing.  We absolutely should
> take a deep look into the suggestion.  Thanks, Linus.
> 
Agree, thanks, Linus.
> -- 
> Regards,
> Shawn
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
