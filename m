From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 03 Mar 2015 10:56:34 +0000
Subject: [PATCH 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <CAFEAcA9oWeYGYcGtf8So6VrYLMXjWr4FiZ2tS+jBnDtv87jAKw@mail.gmail.com>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA9oWeYGYcGtf8So6VrYLMXjWr4FiZ2tS+jBnDtv87jAKw@mail.gmail.com>
Message-ID: <8761ai73j1.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 26 February 2015 at 01:02, Alex Benn?e <alex.bennee@linaro.org> wrote:
>> This adds the saving and restore of the current Multi-Processing state
>> of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
>> potential states for x86 we only use two for ARM. Either the process is
>> running or not.
>
> By this you mean "is the CPU in the PSCI powered down state or not",
> right?

>From the vcpu's perspective it is either running or not. However it is
the same mechanism that is used when PSCI_0_2_FN_CPU_OFF is passed the
VM, internally setting vcpu->arch.paused.

>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>>
>> diff --git a/target-arm/kvm.c b/target-arm/kvm.c
>> index 23cefe9..8732854 100644
>> --- a/target-arm/kvm.c
>> +++ b/target-arm/kvm.c
>> @@ -25,6 +25,7 @@
>>  #include "hw/arm/arm.h"
>>
>>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>> +    KVM_CAP_INFO(MP_STATE),
>
> Does this really want to be a required cap? I haven't checked,
> but assuming 'required' means what it says this presumably
> means we'll stop working on host kernels we previously ran
> fine on (even if migration didn't work there).

You are right, I'll move the CAP check to the kvm_enabled() leg of
get/set functions.

>
>>      KVM_CAP_LAST_INFO
>>  };
>>
>> diff --git a/target-arm/machine.c b/target-arm/machine.c
>> index 9446e5a..70b1bc4 100644
>> --- a/target-arm/machine.c
>> +++ b/target-arm/machine.c
>> @@ -161,6 +161,34 @@ static const VMStateInfo vmstate_cpsr = {
>>      .put = put_cpsr,
>>  };
>>
>> +#if defined CONFIG_KVM
>> +static int get_mpstate(QEMUFile *f, void *opaque, size_t size)
>> +{
>> +    ARMCPU *cpu = opaque;
>> +    struct kvm_mp_state mp_state = { .mp_state =  qemu_get_be32(f)};
>> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
>> +}
>
> Won't this break if you're running a QEMU built with KVM
> support in TCG mode on an aarch64 host?
>
> In any case, for that configuration we should be migrating the
> TCG cpu->powered_off flag, which is where we keep the PSCI
> power state for TCG.

Yeah, I'll make the access functions aware of the mode. In itself it
won't enable KVM<->TCG migration though!

>
>> +
>> +static void put_mpstate(QEMUFile *f, void *opaque, size_t size)
>> +{
>> +    ARMCPU *cpu = opaque;
>> +    struct kvm_mp_state mp_state;
>> +    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
>> +    if (ret) {
>> +        fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
>> +                __func__, ret, strerror(ret));
>> +        abort();
>> +    }
>> +    qemu_put_be32(f, mp_state.mp_state);
>> +}
>> +
>> +static const VMStateInfo vmstate_mpstate = {
>> +    .name = "mpstate",
>> +    .get = get_mpstate,
>> +    .put = put_mpstate,
>> +};
>> +#endif
>> +
>>  static void cpu_pre_save(void *opaque)
>>  {
>>      ARMCPU *cpu = opaque;
>> @@ -244,6 +272,16 @@ const VMStateDescription vmstate_arm_cpu = {
>>          VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
>>          VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),
>>          VMSTATE_UINT64(env.pc, ARMCPU),
>> +#if defined CONFIG_KVM
>> +        {
>> +            .name = "mp_state",
>> +            .version_id = 0,
>> +            .size = sizeof(uint32_t),
>> +            .info = &vmstate_mpstate,
>> +            .flags = VMS_SINGLE,
>> +            .offset = 0,
>> +        },
>> +#endif
>
> This means the migration format will be different on different
> build configurations, which seems like a really bad idea.
>
> Have you considered having the KVM state sync functions just
> sync the kernel's MP state into cpu->powered_off, and then
> migrating that flag here unconditionally?

I was looking at using:

  .field_exists = mpstate_valid

for the field. If we have the field in the migration stream and the
kernel doesn't have the capability to set the state we need to fail hard
right?


>
>>          {
>>              .name = "cpsr",
>>              .version_id = 0,
>> --
>> 2.3.0
>>
>
> -- PMM

-- 
Alex Benn?e
