From: oss@buserror.net (Scott Wood)
Date: Thu, 08 Sep 2016 20:08:56 -0500
Subject: [PATCH v4 3/4] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160826134004.7e86e798@arm.com>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
 <1467877572-10817-3-git-send-email-oss@buserror.net>
 <20160826134004.7e86e798@arm.com>
Message-ID: <1473383336.30217.96.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 13:40 +0100, Marc Zyngier wrote:
> On Thu, 7 Jul 2016 02:46:11 -0500
> Scott Wood <oss@buserror.net> wrote:
> 
> (+Mark)
> 
> > 
> > ?static __always_inline
> > ?u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
> > ?{
> > @@ -66,19 +102,19 @@ u32 arch_timer_reg_read_cp15(int access, enum
> > arch_timer_reg reg)
> > ?	if (access == ARCH_TIMER_PHYS_ACCESS) {
> > ?		switch (reg) {
> > ?		case ARCH_TIMER_REG_CTRL:
> > -			asm volatile("mrs %0,??cntp_ctl_el0" : "=r"
> > (val));
> > +			asm volatile("mrs %0, cntp_ctl_el0" : "=r"
> > (val));
> Spurious change?
> 
> > 
> > ?			break;
> > ?		case ARCH_TIMER_REG_TVAL:
> > -			asm volatile("mrs %0, cntp_tval_el0" : "=r"
> > (val));
> > +			val = _arch_timer_get_ptval();
> > ?			break;
> > ?		}
> > ?	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
> > ?		switch (reg) {
> > ?		case ARCH_TIMER_REG_CTRL:
> > -			asm volatile("mrs %0,??cntv_ctl_el0" : "=r"
> > (val));
> > +			asm volatile("mrs %0, cntv_ctl_el0" : "=r"
> > (val));
> Here too?

No, it's not spurious.

I answered this in?http://lists.infradead.org/pipermail/linux-arm-kernel/2016-
June/438310.html

The extra spacing seemed to be an attempt to get things to line up between the
CTRL and TVAL asm statements.??When the TVAL case was converted to a function
call, there was nothing for the above to line up with, so I moved it back to
normal spacing.

> I'm still worried that this series doesn't address Xen or KVM guests
> that need to be made aware of the broken timers.
> 
> At the very least, I'd like a kernel command line option that'd let the
> user reliably run its VMs. You can do something along the lines of
> 46fd5c6b, and have a command line argument like
> "clocksource.arm_arch_timer.fsl-a008585=1", which would enable the
> workaround.

OK, I'll respin with a command line argument to use for now. ?Mike Caraman has
said he plans to do a better solution for KVM -- Mike, have you had a chance
to look at this?

-Scott
