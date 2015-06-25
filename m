From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 25 Jun 2015 11:42:25 +0100
Subject: [PATCH v6 10/12] KVM: arm64: guest debug,
 HW assisted debug support
In-Reply-To: <20150625074934.GB28244@cbox>
References: <1434716630-18260-1-git-send-email-alex.bennee@linaro.org>
 <1434716630-18260-11-git-send-email-alex.bennee@linaro.org>
 <20150624202216.GE22785@cbox> <87mvzoxpg6.fsf@linaro.org>
 <20150625074934.GB28244@cbox>
Message-ID: <87k2usxe5q.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Thu, Jun 25, 2015 at 07:38:33AM +0100, Alex Benn?e wrote:
>> 
>> Christoffer Dall <christoffer.dall@linaro.org> writes:
>> 
>> > On Fri, Jun 19, 2015 at 01:23:48PM +0100, Alex Benn?e wrote:
>> >> This adds support for userspace to control the HW debug registers for
>> >> guest debug. In the debug ioctl we copy the IMPDEF defined number of
<snip>
>> >>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
>> >>  {
>> >> -	if (vcpu->guest_debug)
>> >> +	if (vcpu->guest_debug) {
>> >>  		restore_guest_debug_regs(vcpu);
>> >> +
>> >> +		/*
>> >> +		 * If we were using HW debug we need to restore the
>> >> +		 * debug_ptr to the guest debug state.
>> >> +		 */
>> >> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW)
>> >> +			vcpu->arch.debug_ptr = &vcpu->arch.vcpu_debug_state;
>> >
>> > I still think this would be more cleanly done in the setup_debug
>> > function, but ok:
>> 
>> I don't follow, setup_debug is called before we enter KVM. It's pretty
>> light when no debugging is being done so this ensure we leave state how
>> we would like it when we stop debugging.
>> 
>> I can move it to an else leg in setup if you really want.
>> 
> I just feel like whenever you enter the guest you setup the state you
> want for your guest and then when reading the code you never have to
> worry about "did I set the pointer back correctly last time it exited",
> but thinking about your response, I guess that's an extra store on each
> world-switch, so theoretically that may be a bit more overhead (on top
> of the hundreds other stores and spinlocks we take and stuff).

The setup/clear() calls are tightly paired around the KVM_RUN ioctl code
without any obvious exit points.

Are there any cases you can escape the ioctl code flow? I notice irq's
are re-enabled so I guess a suitably determined irq function could
change the return address or mess around with guest_debug.

> If you prefer, leave it like this, but consider adding a
> BUG_ON(!guest_debugging && debug_ptr != &vcpu->arch.vcpu_debug_state) in
> the setup function...

The clear_debug() code would end up being a fairly sparse piece of code
without it ;-)

> I'm probably being paranoid.

A little paranoia goes a long way in kernel mode ;-)

>
> -Christoffer

-- 
Alex Benn?e
