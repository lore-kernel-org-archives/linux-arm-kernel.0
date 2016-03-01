From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Mar 2016 14:01:36 +0000
Subject: [PATCHv3] arm64: Rework valid_user_regs
In-Reply-To: <20160301134043.GA14022@arm.com>
References: <1455646517-22903-1-git-send-email-mark.rutland@arm.com>
 <20160216182005.GN14509@arm.com>
 <20160301124701.GC30602@leverpostej>
 <CAFEAcA9PmQYFYBw0GstA88MGHwGivB+VJdowBf6T1ggneZKihg@mail.gmail.com>
 <20160301134043.GA14022@arm.com>
Message-ID: <20160301140136.GD30602@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 01:40:44PM +0000, Will Deacon wrote:
> On Tue, Mar 01, 2016 at 01:08:33PM +0000, Peter Maydell wrote:
> > On 1 March 2016 at 12:47, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, Feb 16, 2016 at 06:20:05PM +0000, Will Deacon wrote:
> > >> > +static int valid_native_regs(struct user_pt_regs *regs)
> > >> > +{
> > >> > +   regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
> > >> > +
> > >> > +   if (user_mode(regs) && !(regs->pstate & PSR_MODE32_BIT) &&
> > >> > +       (regs->pstate & PSR_D_BIT) == 0 &&
> > >> > +       (regs->pstate & PSR_A_BIT) == 0 &&
> > >> > +       (regs->pstate & PSR_I_BIT) == 0 &&
> > >> > +       (regs->pstate & PSR_F_BIT) == 0) {
> > >> > +           return 1;
> > >> > +   }
> > >> > +
> > >> > +   /* Force PSR to a valid 64-bit EL0t */
> > >> > +   regs->pstate &= PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT;
> > >>
> > >> Can we not just zap the pstate to PSR_MODE_EL0t and be done with it?
> > >
> > > I'm worried that some userspace might be relying on these being
> > > preserved.
> > 
> > This function is called as part of signal-return, right?
> > You clearly can't just zap the flag registers in that code
> > path, because you'd then be corrupting the flags of the
> > bit of userspace code that was interrupted by the signal.
> > (Or am I missing something?)
> 
> Well, it would only occur if the signal handler had tried to set pstate
> to an invalid value. That said, it is a change in behaviour, so we can
> leave it as Mark has suggested.

Ok. Assuming you're happy with that I'll post a v4 shortly with the
AArch32 comment, and the forced AArch64 state left as in v3.

Thanks,
Mark.
