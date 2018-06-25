From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jun 2018 17:19:31 +0100
Subject: [PATCH 3/7] arm64: compat: map SPSR_ELx<->PSR for signals
In-Reply-To: <334274ca-dd77-4c8a-7608-550534adae97@arm.com>
References: <20180625144421.11511-1-mark.rutland@arm.com>
 <20180625144421.11511-4-mark.rutland@arm.com>
 <334274ca-dd77-4c8a-7608-550534adae97@arm.com>
Message-ID: <20180625161931.rqk4hctwvjbn5mcv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:15:06PM +0100, Suzuki K Poulose wrote:
> On 25/06/18 15:44, Mark Rutland wrote:
> > The SPSR_ELx format for exceptions taken from AArch32 differs from the
> > AArch32 PSR format. Thus, we must translate between the two when setting
> > up a compat sigframe, or restoring context from a compat sigframe.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Fixes: 7206dc93a58fb764 ("arm64: Expose Arm v8.4 features")
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >   arch/arm64/kernel/signal32.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> > index 77b91f478995..fa9fb782f077 100644
> > --- a/arch/arm64/kernel/signal32.c
> > +++ b/arch/arm64/kernel/signal32.c
> > @@ -243,6 +243,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
> >   	int err;
> >   	sigset_t set;
> >   	struct compat_aux_sigframe __user *aux;
> > +	unsigned long psr;
> >   	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
> >   	if (err == 0) {
> > @@ -266,7 +267,9 @@ static int compat_restore_sigframe(struct pt_regs *regs,
> >   	__get_user_error(regs->compat_sp, &sf->uc.uc_mcontext.arm_sp, err);
> >   	__get_user_error(regs->compat_lr, &sf->uc.uc_mcontext.arm_lr, err);
> >   	__get_user_error(regs->pc, &sf->uc.uc_mcontext.arm_pc, err);
> > -	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
> > +	__get_user_error(psr, &sf->uc.uc_mcontext.arm_cpsr, err);
> > +
> > +	regs->pstate = compat_psr_to_pstate(regs->pstate);
> 
> Did you mean
> 	regs->pstate = compat_psr_to_pstate(psr)
> above ?

Yes!

Thanks for spotting that; I've fixed that up locally.

Mark.
