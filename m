From: cdall@linaro.org (Christoffer Dall)
Date: Sat, 14 Oct 2017 07:16:00 -0700
Subject: [PATCH v1 1/2] KVM: arm64: handle single-stepping trapped
 instructions
In-Reply-To: <87r2u79zoi.fsf@linaro.org>
References: <20171006113921.24880-1-alex.bennee@linaro.org>
 <20171006113921.24880-2-alex.bennee@linaro.org>
 <20171013082615.GC8927@cbox> <87r2u79zoi.fsf@linaro.org>
Message-ID: <20171014141529.GA5886@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 10:15:09AM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall <cdall@linaro.org> writes:
> 
> > On Fri, Oct 06, 2017 at 12:39:20PM +0100, Alex Benn?e wrote:
> >> If we are using guest debug to single-step the guest we need to ensure
> >> we exit after emulating the instruction. This only affects
> >> instructions completely emulated by the kernel. For userspace emulated
> >> instructions we need to exit and return to complete the emulation.
> >>
> >> We fake debug.arch.hsr to contain ESR_ELx_EC_SOFTSTP_LOW so QEMU knows
> >> it was a single-step event (and without altering the userspace ABI).
> >>
> >> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> >> ---
> >>  arch/arm64/kvm/handle_exit.c | 48 +++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 34 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> >> index 7debb74843a0..c918d291cb58 100644
> >> --- a/arch/arm64/kvm/handle_exit.c
> >> +++ b/arch/arm64/kvm/handle_exit.c
> >> @@ -178,6 +178,39 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
> >>  	return arm_exit_handlers[hsr_ec];
> >>  }
> >>
> >> +/*
> >> + * When handling traps we need to ensure exit the guest if we
> >> + * completely emulated the instruction while single-stepping. Stuff to
> >> + * be emulated in userspace needs to complete that first.
> >> + */
> >
> > I really don't understand the first sentence here.  We are already out
> > of the guest, so do you mean a return to userspace?
> > I think the second sentence could be more clear as well.  Is 'stuff' not
> > actually 'MMIO emulation' or 'emulation' more broadly?
> 
> Your right - it's sloppily worded how about:
> 
>  /*
>   * We may be single-stepping an emulated instruction. If the emulation
>   * has been completed in-kernel we can return to userspace with a
>   * KVM_EXIT_DEBUG, otherwise the userspace needs to complete it's

s/it's/its/

>   * emulation first.
>   */

Otherwise looks much better, thanks.

> 
> For x86 there is also IO emulation but in principle anything that might
> be passed off to userspace to be completed should be done first.
> 
> >
> >> +
> >> +static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >> +{
> >> +	int handled;
> >> +
> >> +	/*
> >> +	 * See ARM ARM B1.14.1: "Hyp traps on instructions
> >> +	 * that fail their condition code check"
> >> +	 */
> >> +	if (!kvm_condition_valid(vcpu)) {
> >> +		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> >> +		handled = 1;
> >> +	} else {
> >> +		exit_handle_fn exit_handler;
> >> +
> >> +		exit_handler = kvm_get_exit_handler(vcpu);
> >> +		handled = exit_handler(vcpu, run);
> >> +	}
> >> +
> >> +	if (handled && (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)) {
> >
> > Don't you want if (handled == 1) or if (handled > 0) ?
> >
> > If there was an error I think we want to just return that to userspace
> > and not override it and present single-stepping.
> 
> Yes, I'll fix it.
> 

Thanks,
-Christoffer
