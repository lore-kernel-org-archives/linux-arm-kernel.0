From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Jul 2014 23:27:04 -0400 (EDT)
Subject: [RFC] [PATCH] ARM: save/restore power control register on
 Cortex-A9 suspend/resume
In-Reply-To: <CADWw7Oi1Lj76yxU6KUrdAc3X0AAabjOJRM+3Xr4UgTiJqWjC-Q@mail.gmail.com>
References: <1404218750-5025-1-git-send-email-k.chander@samsung.com>
 <20140701124851.GM32514@n2100.arm.linux.org.uk>
 <CADWw7Oi1Lj76yxU6KUrdAc3X0AAabjOJRM+3Xr4UgTiJqWjC-Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407012324310.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jul 2014, Chander Kashyap wrote:

> On Tue, Jul 1, 2014 at 6:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jul 01, 2014 at 06:15:49PM +0530, Chander Kashyap wrote:
> >> The CP15 power register holds clock latency and dynamic clock gating settings
> >> for Cortex-A9 processor, which lost during the suspend/resume. So it needs to
> >> be saved/restored on suspend/resume.
> >>
> >> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> >> ---
> >>  It is depedent on: ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
> >>  http://www.spinics.net/lists/arm-kernel/msg340506.html
> >>
> >>  arch/arm/mm/proc-v7.S |    6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> >> index e26bfaa..9905df5 100644
> >> --- a/arch/arm/mm/proc-v7.S
> >> +++ b/arch/arm/mm/proc-v7.S
> >> @@ -163,12 +163,14 @@ ENDPROC(cpu_v7_do_resume)
> >>       globl_equ       cpu_ca9mp_switch_mm,    cpu_v7_switch_mm
> >>       globl_equ       cpu_ca9mp_set_pte_ext,  cpu_v7_set_pte_ext
> >>  .globl       cpu_ca9mp_suspend_size
> >> -.equ cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 1 * 4
> >> +.equ cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 2 * 4
> >>  #ifdef CONFIG_ARM_CPU_SUSPEND
> >>  ENTRY(cpu_ca9mp_do_suspend)
> >>       stmfd   sp!, {r4}
> >>       mrc     p15, 0, r4, c15, c0, 1  @ Diagnostic register
> >>       stmia   r0!, {r4}
> >> +     mrc     p15, 0, r4, c15, c0, 0  @ Power register
> >> +     stmia   r0!, {r4}
> >>       ldmfd   sp!, {r4}
> >
> > Please combine these - yes, it'll be a larger change, but it'll be much
> > better.
> 
> Are asking me to squash this patch with Shawn's patch?
> If so i will do that.

I'm not sure that's what RMK ment.

You should at least merge the loads and stores into a combined ldmia and 
stmia instructions as illustrated.

> 
> >
> >         stmfd   sp!, {r4-r5}
> >         mrc     p15, 0, r4, c15, c0, 1  @ Diagnostic register
> >         mrc     p15, 0, r5, c15, c0, 0  @ Power register
> >         stmia   r0!, {r4-r5}
> >         ldmfd   sp!, {r4-r5}
> >
> >
> >>       b       cpu_v7_do_suspend
> >>  ENDPROC(cpu_ca9mp_do_suspend)
> >> @@ -176,6 +178,8 @@ ENDPROC(cpu_ca9mp_do_suspend)
> >>  ENTRY(cpu_ca9mp_do_resume)
> >>       ldmia   r0!, {r4}
> >>       mcr     p15, 0, r4, c15, c0, 1  @ Diagnostic register
> >> +     ldmia   r0!, {r4}
> >> +     mcr     p15, 0, r4, c15, c0, 0  @ Power register
> >
> >         ldmia   r0!, {r4-r5}
> >         mcr     p15, 0, r4, c15, c0, 1  @ Diagnostic register
> >         mcr     p15, 0, r5, c15, c0, 0  @ Power register
> 
> I will do these changes
> 
> 
> Thanks for the review.
> 
> >
> >>       b       cpu_v7_do_resume
> >>  ENDPROC(cpu_ca9mp_do_resume)
> >>  #endif
> >
> > Thanks.
> >
> > --
> > FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> > improving, and getting towards what was expected from it.
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
