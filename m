From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2016 16:42:18 +0000
Subject: [PATCHv2] arm64: Rework valid_user_regs
In-Reply-To: <CAFEAcA_XGrPB=2GnQwW4Jr8eE9UqbTAgRb86qCkX+rw25u4yNg@mail.gmail.com>
References: <1455285858-11757-1-git-send-email-mark.rutland@arm.com>
 <CAFEAcA_XGrPB=2GnQwW4Jr8eE9UqbTAgRb86qCkX+rw25u4yNg@mail.gmail.com>
Message-ID: <20160212164218.GC17901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 02:53:51PM +0000, Peter Maydell wrote:
> On 12 February 2016 at 14:04, Mark Rutland <mark.rutland@arm.com> wrote:
> > We validate pstate using PSR_MODE32_BIT, which is part of the
> > user-provided pstate (and cannot be trusted). Also, we conflate
> > validation of AArch32 and AArch64 pstate values, making the code
> > difficult to reason about.
> >
> > Instead, validate the pstate value based on the associated task. The
> > task may or may not be current (e.g. when using ptrace), so this must be
> > passed explicitly by callers. To avoid circular header dependencies via
> > sched.h, is_compat_task is pulled out of asm/ptrace.h.
> >
> > To make the code possible to reason about, the AArch64 and AArch32
> > validation is split into separate functions. Software must respect the
> > RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
> > policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
> > architected meaning writes may be permitted (potentially with additional
> > validation).
> 
> > +       /* Force PSR to a valid 32-bit EL0t */
> > +       regs->pstate |= PSR_MODE32_BIT;
> > +       regs->pstate &= PSR_f | PSR_s | (PSR_x & ~COMPAT_PSR_A_BIT) | \
> > +                       COMPAT_PSR_T_BIT;
> > +
> 
> I think the consensus from the v1 review was to drop these PSR_[fsx] masks?

Yup. Mark, if you respin with that change then I can take this as a fix.

Thanks,

Will
