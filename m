From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Nov 2018 18:08:29 +0000
Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
In-Reply-To: <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
 <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
Message-ID: <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:01:20PM +0000, Mark Rutland wrote:
> On Wed, Nov 07, 2018 at 05:10:31PM +0000, Alex Benn?e wrote:
> > Not all faults handled by handle_exit are instruction emulations. For
> > example a ESR_ELx_EC_IABT will result in the page tables being updated
> > but the instruction that triggered the fault hasn't actually executed
> > yet. We use the simple heuristic of checking for a changed PC before
> > seeing if kvm_arm_handle_step_debug wants to claim we stepped an
> > instruction.
> > 
> > Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> > ---
> >  arch/arm64/kvm/handle_exit.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index e5e741bfffe1..b8252e72f882 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -214,6 +214,7 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
> >  static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  {
> >  	int handled;
> > +        unsigned long old_pc = *vcpu_pc(vcpu);
> >  
> >  	/*
> >  	 * See ARM ARM B1.14.1: "Hyp traps on instructions
> > @@ -233,7 +234,8 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  	 * kvm_arm_handle_step_debug() sets the exit_reason on the kvm_run
> >  	 * structure if we need to return to userspace.
> >  	 */
> > -	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
> > +	if (handled > 0 && *vcpu_pc(vcpu) != old_pc &&
> 
> This doesn't work if the emulation is equivalent to a branch-to-self, so
> I don't think that we want to do this.
> 
> When are we failing to advance the single-step state machine correctly?

I don't understand how this is intended to work currently.

Surely kvm_skip_instr() should advance the state machine as necessary,
so that we can rely on the HW to generate any necessary single-step
exception when we next return to the guest?

... and if userspace decides to emulate something, it's up to it to
advance the state machine consistently.

Thanks,
Mark.
