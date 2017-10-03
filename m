From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 3 Oct 2017 18:08:43 +0100
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <873770yz1o.fsf@linaro.org>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
 <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
 <3c249a68-45e3-a3a5-7d05-4cfc2d97713b@arm.com>
 <CAMJs5B8hYTJBxKa8Wu3Bw7EjaG4UZ56QQyVYx1E_4kJzkPhN+Q@mail.gmail.com>
 <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
 <CAMJs5B-i4h63Hx68b6z-DxDphXieoNGJcLTfi2zLuq0CnU_S3g@mail.gmail.com>
 <3d7d2b36-da2f-04dc-611e-d7aab7666c29@arm.com>
 <CAMJs5B8F9VffM3pDQxbk-qfUmvvqdvbVOt8WZgFX2Q4Ud3eJrA@mail.gmail.com>
 <9bc5abc2-ab03-3137-82bd-e8afa62624eb@arm.com>
 <CAMJs5B9iVYGE2mODE1raHzGQ+Mz7V_kT+bJiWm0zUHfmLN1-DQ@mail.gmail.com>
 <861b4e4f-0fbe-cbc6-39ad-4660065449de@arm.com> <877ewcz3bv.fsf@linaro.org>
 <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com> <873770yz1o.fsf@linaro.org>
Message-ID: <5a4f0493-6d3d-85de-fc45-030d4b03b5a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/17 17:30, Alex Benn?e wrote:
> 
> Julien Thierry <julien.thierry@arm.com> writes:
> 
>> On 03/10/17 15:57, Alex Benn?e wrote:
>>>
>>> Julien Thierry <julien.thierry@arm.com> writes:
>>>
>>>> On 31/08/17 15:01, Christoffer Dall wrote:
> <snip>
>>>>>>>>
>>>>>>>> Does that sound like what you had in mind? Or does it seem better than
>>>>>>>> the
>>>>>>>> current patch?
>>>>>>>>
>>>>>>> I was thinking to change the skip_instruction function to return an
>>>>>>> int, and then call kvm_handle_debug_ss() from skip_instruction, which
>>>>>>> would update the kvm_run structure and exit here and then.
>>>>>>>
>>>>>>
>>>>>> Setting up the debug exception from within kvm_skip_instruction seem to
>>>>>> change a bit too much its semantic from arm to arm64. I would find this
>>>>>> easily confusing.
>>>>>>
>>>>>>> However, I'm now thinking that this doesn't really work either,
>>>>>>> because we could have to emulate a trapped MMIO instruction in user
>>>>>>> space, and then it's not clear how to exit with a debug exception at
>>>>>>> the same time.
>>>
>>> A debug exception at guest exit point is (IIRC) just having the
>>> appropriate status in the run->exit_reason (KVM_EXIT_DEBUG). If you need
>>> to exit for MMIO emulation (i.e. the instruction has not run yet) you
>>> shouldn't do that. Exit, emulate and return. We could handle the ioctl
>>> to clear SS in userspace but I guess that gets just as messy.
>>>
>>>>>>>
>>>>>>> So perhaps we should stick with your original approach.
>>>>>>>
>>>>>>
>>>>>> I had not realized that was possible. This makes things more complicated for
>>>>>> avoiding a back and forth with the guest for trapped exceptions. Out of
>>>>>> luck, having the debug flag does look like single stepping would work as
>>>>>> expected for userland MMIOs.
> 
> <snip>
> 
> This is my currently untested but otherwise simpler solution:
> 
>  From 46ea80d7dc9b98661fcd51c41090f8ad74a6690f Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
> Date: Tue, 3 Oct 2017 17:17:15 +0100
> Subject: [PATCH] KVM: arm64: handle single-stepping trapped instructions
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> If we are using guest debug to single-step the guest we need to ensure
> we exit after emulating the instruction. This only affects
> instructions emulated by the kernel. If we exit to userspace anyway we
> leave it to userspace to work out what to do.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>   arch/arm64/kvm/handle_exit.c | 51 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 7debb74843a0..b197ffb10e96 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -178,6 +178,42 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>   	return arm_exit_handlers[hsr_ec];
>   }
> 
> +/*
> + * When handling traps we need to ensure exit the guest if we
> + * successfully emulated the instruction while single-stepping. If we
> + * have to exit anyway for userspace emulation then it's up to
> + * userspace to handle the "while SSing case".
> + */
> +

I have not tested the code but if it work we also need to do something 
similar for MMIOs that are handled by the kernel (without returning to 
userland). But it should be pretty similar.

> +static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +{
> +	int handled;
> +
> +	/*
> +	 * See ARM ARM B1.14.1: "Hyp traps on instructions
> +	 * that fail their condition code check"
> +	 */
> +	if (!kvm_condition_valid(vcpu)) {
> +		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +		handled = 1;
> +	} else {
> +		exit_handle_fn exit_handler;
> +
> +		exit_handler = kvm_get_exit_handler(vcpu);
> +		handled = exit_handler(vcpu, run);
> +	}
> +
> +	if (handled && (vcpu->debug_flags & KVM_GUESTDBG_SINGLESTEP)) {
> +		u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +
> +		handled = 0;
> +		run->exit_reason = KVM_EXIT_DEBUG;
> +		run->debug.arch.hsr = hsr;
> +	}
> +
> +	return handled;
> +}
> +
>   /*
>    * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
>    * proper exit to userspace.
> @@ -185,8 +221,6 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>   int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   		       int exception_index)
>   {
> -	exit_handle_fn exit_handler;
> -
>   	if (ARM_SERROR_PENDING(exception_index)) {
>   		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
> 
> @@ -214,18 +248,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   		kvm_inject_vabt(vcpu);
>   		return 1;
>   	case ARM_EXCEPTION_TRAP:
> -		/*
> -		 * See ARM ARM B1.14.1: "Hyp traps on instructions
> -		 * that fail their condition code check"
> -		 */
> -		if (!kvm_condition_valid(vcpu)) {
> -			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> -			return 1;
> -		}
> -
> -		exit_handler = kvm_get_exit_handler(vcpu);
> -
> -		return exit_handler(vcpu, run);
> +		return handle_trap_exceptions(vcpu, run);
>   	case ARM_EXCEPTION_HYP_GONE:
>   		/*
>   		 * EL2 has been reset to the hyp-stub. This happens when a guest
> --
> 2.14.1
> 

-- 
Julien Thierry
