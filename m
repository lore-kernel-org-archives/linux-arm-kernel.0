From: james.morse@arm.com (James Morse)
Date: Mon, 25 Apr 2016 10:16:39 +0100
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <20160425084111.GA19515@linaro.org>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
 <571656E9.5050402@arm.com> <57166CC9.4030804@arm.com>
 <57175BD7.30902@arm.com> <571765D1.9070207@arm.com>
 <20160425084111.GA19515@linaro.org>
Message-ID: <571DE077.8060601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/04/16 09:41, AKASHI Takahiro wrote:
> On Wed, Apr 20, 2016 at 12:19:45PM +0100, James Morse wrote:
>> On 20/04/16 11:37, Marc Zyngier wrote:
>>> On 19/04/16 18:37, James Morse wrote:
>>>> It looks like x86 uses the extable to work around this, their vmx_vcpu_run() has:
>>>>> 		__ex(ASM_VMX_VMLAUNCH) "\n\t"
>>>> Where __ex ends up calling ____kvm_handle_fault_on_reboot(), with a nearby comment:
>>>>> * Hardware virtualization extension instructions may fault if a
>>>>> * reboot turns off virtualization while processes are running.
>>>>> * Trap the fault and ignore the instruction if that happens.
>>>
>>> I very much like that approach, to be honest. Tearing down a CPU is
>>> something exceptional, so let's make it an actual exception.
>>>
>>> It is now pretty easy to discriminate between KVM functions and stub
>>> functions thanks to your earlier patch, so if we end up calling the
>>> hyp-stub because we've torn down KVM's EL2, let's just return an
>>> appropriate error code (ARM_EXCEPTION_HYP_GONE), and handle it at EL1.
>>
>> Okay. kexec uses kvm_call_hyp() against the hyp-stub to do the kernel-copy and
>> hand over to purgatory, but we could change that to a new 'special' builtin
>> call, something like HVC_KEXEC_CALL_HYP. It never calls it with kvm loaded, so
>> there is no reason the calls have to be same.
>>
>> Given hibernate doesn't hit this issue, I will drop this hunk from this version
>> of the patch, and repost hibernate incorporating the feedback so far. I will
>> provide a patch for kexec to do the above.
> 
> Thanks, but you don' have to.

I was wrong with the 'hibernate doesn't hit this issue', with this patch we
re-install the hyp-stub during system reboot, and race with the scheduler.
('reboot -f' while running a guest).


> If the fix below is acceptable, we will merge it to our next kexec/kdump
> patch series.

I'm testing something that looks very similar at the moment.


> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index eba89e4..31b5224 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -186,6 +186,10 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		exit_handler = kvm_get_exit_handler(vcpu);
>  
>  		return exit_handler(vcpu, run);
> +	case ARM_EXCEPTION_HYP_GONE:
> +		/* due to kexec reboot */
> +		run->exit_reason = KVM_EXIT_SHUTDOWN;
> +		return 0;

Is it fair to throw this back out to user space? While the hypervisor doesn't
have long to live, it may not be expecting this exit_reason. I couldn't see a
value for 'suprise cpu removal', and it looks like the x86 code causes the vcpu
to spin round enter guest...


Thanks,

James
