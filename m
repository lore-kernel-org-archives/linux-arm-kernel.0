From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 08 Dec 2015 11:49:49 +0000
Subject: [PATCH v9 3/6] target-arm: kvm - support for single step
In-Reply-To: <CAFEAcA-YQ384sY1OWLaV9YAjzTZSyWqVLHx2moH-sCa+O6FvOw@mail.gmail.com>
References: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
 <1447345251-22625-4-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA-YQ384sY1OWLaV9YAjzTZSyWqVLHx2moH-sCa+O6FvOw@mail.gmail.com>
Message-ID: <87r3ixp3c2.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 November 2015 at 16:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
>> This adds support for single-step. There isn't much to do on the QEMU
>> side as after we set-up the request for single step via the debug ioctl
>> it is all handled within the kernel.
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - convert to using HSR_EC
>> v3
>>   - use internals.h definitions
>> ---
>>  target-arm/kvm.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/target-arm/kvm.c b/target-arm/kvm.c
>> index 50f70ef..d505a7e 100644
>> --- a/target-arm/kvm.c
>> +++ b/target-arm/kvm.c
>> @@ -535,6 +535,13 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
>>      kvm_cpu_synchronize_state(cs);
>>
>>      switch (hsr_ec) {
>> +    case EC_SOFTWARESTEP:
>> +        if (cs->singlestep_enabled) {
>> +            return true;
>> +        } else {
>> +            error_report("Came out of SINGLE STEP when not enabled");
>> +        }
>> +        break;
>>      case EC_AA64_BKPT:
>>          if (kvm_find_sw_breakpoint(cs, env->pc)) {
>>              return true;
>> @@ -595,6 +602,9 @@ int kvm_arch_on_sigbus(int code, void *addr)
>>
>>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>>  {
>> +    if (cs->singlestep_enabled) {
>> +        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
>> +    }
>
> Doesn't kvm_update_guest_debug() already set these bits, or am
> I misreading it?

Yeah. This raises an interesting problem about what to do when we don't
have the capability. I could suppress those bits in the update function
but that seems a bit hacky.

Looking at the GDB capability code there doesn't seem to report
breakpoint capability short of just failing when you try to set one.

>
>>      if (kvm_sw_breakpoints_active(cs)) {
>>          dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
>>      }
>> --
>> 2.6.3
>
> thanks
> -- PMM


--
Alex Benn?e
