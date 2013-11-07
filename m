From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 7 Nov 2013 09:43:46 -0800
Subject: [PATCH v3 1/2] arm/arm64: KVM: MMIO support for BE guest
In-Reply-To: <527BCB7A.6010800@arm.com>
References: <1383677895-3728-1-git-send-email-marc.zyngier@arm.com>
 <1383677895-3728-2-git-send-email-marc.zyngier@arm.com>
 <20131107051023.GA18387@cbox> <527BCB7A.6010800@arm.com>
Message-ID: <CAMJs5B-DV02qegxNvDQ37yzrjOBrP8Fzxpx7FeErGYxPA9T=ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2013 09:18, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 07/11/13 05:10, Christoffer Dall wrote:
>> On Tue, Nov 05, 2013 at 06:58:14PM +0000, Marc Zyngier wrote:
>>> Do the necessary byteswap when host and guest have different
>>> views of the universe. Actually, the only case we need to take
>>> care of is when the guest is BE. All the other cases are naturally
>>> handled.
>>>
>>> Also be careful about endianness when the data is being memcopy-ed
>>> from/to the run buffer.
>>>
>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm/include/asm/kvm_emulate.h   | 41 +++++++++++++++++
>>>  arch/arm/kvm/mmio.c                  | 87 +++++++++++++++++++++++++++++++-----
>>>  arch/arm64/include/asm/kvm_emulate.h | 48 ++++++++++++++++++++
>>>  3 files changed, 165 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
>>> index a464e8d..8a6be05 100644
>>> --- a/arch/arm/include/asm/kvm_emulate.h
>>> +++ b/arch/arm/include/asm/kvm_emulate.h
>>> @@ -157,4 +157,45 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
>>>      return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
>>>  }
>>>
>>> +static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
>>> +{
>>> +    return !!(*vcpu_cpsr(vcpu) & PSR_E_BIT);
>>> +}
>>> +
>>> +static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
>>> +                                                unsigned long data,
>>> +                                                unsigned int len)
>>> +{
>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>> +            switch (len) {
>>> +            case 1:
>>> +                    return data & 0xff;
>>
>> why are these masks necessary again?  For a writeb there should be no
>> byteswapping on the guest side right?
>
> They are not strictly mandatory, but I feel a lot more confident
> trimming what we found in the register to the bare minimum.
>
>>> +            case 2:
>>> +                    return be16_to_cpu(data & 0xffff);
>>> +            default:
>>> +                    return be32_to_cpu(data);
>>> +            }
>>> +    }
>>> +
>>> +    return data;            /* Leave LE untouched */
>>> +}
>>> +
>>> +static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>>> +                                                unsigned long data,
>>> +                                                unsigned int len)
>>> +{
>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>> +            switch (len) {
>>> +            case 1:
>>> +                    return data & 0xff;
>>> +            case 2:
>>> +                    return cpu_to_be16(data & 0xffff);
>>> +            default:
>>> +                    return cpu_to_be32(data);
>>> +            }
>>> +    }
>>> +
>>> +    return data;            /* Leave LE untouched */
>>> +}
>>> +
>>>  #endif /* __ARM_KVM_EMULATE_H__ */
>>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>>> index 0c25d94..54105f1b 100644
>>> --- a/arch/arm/kvm/mmio.c
>>> +++ b/arch/arm/kvm/mmio.c
>>> @@ -23,6 +23,69 @@
>>>
>>>  #include "trace.h"
>>>
>>> +static void mmio_write_data(struct kvm_exit_mmio *mmio, unsigned long data)
>>> +{
>>> +    void *datap = NULL;
>>> +    union {
>>> +            u8      byte;
>>> +            u16     hword;
>>> +            u32     word;
>>> +            u64     dword;
>>> +    } tmp;
>>> +
>>> +    switch (mmio->len) {
>>> +    case 1:
>>> +            tmp.byte        = data;
>>> +            datap           = &tmp.byte;
>>> +            break;
>>> +    case 2:
>>> +            tmp.hword       = data;
>>> +            datap           = &tmp.hword;
>>> +            break;
>>> +    case 4:
>>> +            tmp.word        = data;
>>> +            datap           = &tmp.word;
>>> +            break;
>>> +    case 8:
>>> +            tmp.dword       = data;
>>> +            datap           = &tmp.dword;
>>> +            break;
>>> +    }
>>> +
>>> +    memcpy(mmio->data, datap, mmio->len);
>>> +}
>>> +
>>> +static unsigned long mmio_read_data(struct kvm_run *run)
>>> +{
>>> +    unsigned long data = 0;
>>> +    unsigned int len = run->mmio.len;
>>> +    union {
>>> +            u16     hword;
>>> +            u32     word;
>>> +            u64     dword;
>>> +    } tmp;
>>> +
>>> +    switch (len) {
>>> +    case 1:
>>> +            data = run->mmio.data[0];
>>> +            break;
>>> +    case 2:
>>> +            memcpy(&tmp.hword, run->mmio.data, len);
>>> +            data = tmp.hword;
>>> +            break;
>>> +    case 4:
>>> +            memcpy(&tmp.word, run->mmio.data, len);
>>> +            data = tmp.word;
>>> +            break;
>>> +    case 8:
>>> +            memcpy(&tmp.dword, run->mmio.data, len);
>>> +            data = tmp.dword;
>>> +            break;
>>> +    }
>>> +
>>> +    return data;
>>> +}
>>> +
>>
>> don't we have similarly named functions for the vgic where we just
>> assume accesses are always 32 bits?  Could we reuse?
>
> Hmmm. The VGIC also deals with masks and stuff, and I'm not sure that's
> worth the complexity. I'll rename this for the time being, and look at
> unifying the two.
>
>>>  /**
>>>   * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
>>>   * @vcpu: The VCPU pointer
>>> @@ -33,28 +96,27 @@
>>>   */
>>>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>  {
>>> -    unsigned long *dest;
>>> +    unsigned long data;
>>>      unsigned int len;
>>>      int mask;
>>>
>>>      if (!run->mmio.is_write) {
>>> -            dest = vcpu_reg(vcpu, vcpu->arch.mmio_decode.rt);
>>> -            *dest = 0;
>>> -
>>>              len = run->mmio.len;
>>>              if (len > sizeof(unsigned long))
>>>                      return -EINVAL;
>>>
>>> -            memcpy(dest, run->mmio.data, len);
>>> -
>>> -            trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
>>> -                            *((u64 *)run->mmio.data));
>>> +            data = mmio_read_data(run);
>>>
>>>              if (vcpu->arch.mmio_decode.sign_extend &&
>>>                  len < sizeof(unsigned long)) {
>>>                      mask = 1U << ((len * 8) - 1);
>>> -                    *dest = (*dest ^ mask) - mask;
>>> +                    data = (data ^ mask) - mask;
>>>              }
>>> +
>>> +            trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
>>> +                           data);
>>> +            data = vcpu_data_host_to_guest(vcpu, data, len);
>>> +            *vcpu_reg(vcpu, vcpu->arch.mmio_decode.rt) = data;
>>>      }
>>>
>>>      return 0;
>>> @@ -105,6 +167,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>               phys_addr_t fault_ipa)
>>>  {
>>>      struct kvm_exit_mmio mmio;
>>> +    unsigned long data;
>>>      unsigned long rt;
>>>      int ret;
>>>
>>> @@ -125,13 +188,15 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>      }
>>>
>>>      rt = vcpu->arch.mmio_decode.rt;
>>> +    data = vcpu_data_guest_to_host(vcpu, *vcpu_reg(vcpu, rt), mmio.len);
>>> +
>>>      trace_kvm_mmio((mmio.is_write) ? KVM_TRACE_MMIO_WRITE :
>>>                                       KVM_TRACE_MMIO_READ_UNSATISFIED,
>>>                      mmio.len, fault_ipa,
>>> -                    (mmio.is_write) ? *vcpu_reg(vcpu, rt) : 0);
>>> +                    (mmio.is_write) ? data : 0);
>>>
>>>      if (mmio.is_write)
>>> -            memcpy(mmio.data, vcpu_reg(vcpu, rt), mmio.len);
>>> +            mmio_write_data(&mmio, data);
>>>
>>>      if (vgic_handle_mmio(vcpu, run, &mmio))
>>>              return 1;
>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>>> index eec0738..3a7d058 100644
>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>> @@ -177,4 +177,52 @@ static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>>>      return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
>>>  }
>>>
>>> +static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
>>> +{
>>> +    if (vcpu_mode_is_32bit(vcpu))
>>> +            return !!(*vcpu_cpsr(vcpu) & COMPAT_PSR_E_BIT);
>>> +
>>> +    return !!(vcpu_sys_reg(vcpu, SCTLR_EL1) & (1 << 25));
>>
>> do we have anywhere nice where we can stick a define for these bit
>> fields?
>
> Unfortunately not yet. But I can definitely see a need. Actually,
> arch/arm has it all defined in cp15.h, which is quite nice.
>
> I'll so something similar in a separate patch.
>

you actually replicate bit 25 in the next patch as well, so you can
gain immediate reuse of your define :)

>>> +}
>>> +
>>> +static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
>>> +                                                unsigned long data,
>>> +                                                unsigned int len)
>>> +{
>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>> +            switch (len) {
>>> +            case 1:
>>> +                    return data & 0xff;
>>> +            case 2:
>>> +                    return be16_to_cpu(data & 0xffff);
>>> +            case 4:
>>> +                    return be32_to_cpu(data & ((1UL << 32) - 1));
>>
>> why break the consistency here? wouldn't 0xffffffff be cleaner?
>>
>
> Fair enough.
>
>>> +            default:
>>> +                    return be64_to_cpu(data);
>>> +            }
>>> +    }
>>> +
>>> +    return data;            /* Leave LE untouched */
>>> +}
>>> +
>>> +static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>>> +                                                unsigned long data,
>>> +                                                unsigned int len)
>>> +{
>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>> +            switch (len) {
>>> +            case 1:
>>> +                    return data & 0xff;
>>> +            case 2:
>>> +                    return cpu_to_be16(data & 0xffff);
>>> +            case 4:
>>> +                    return cpu_to_be32(data & ((1UL << 32) - 1));
>>> +            default:
>>> +                    return cpu_to_be64(data);
>>> +            }
>>> +    }
>>> +
>>> +    return data;            /* Leave LE untouched */
>>> +}
>>> +
>>>  #endif /* __ARM64_KVM_EMULATE_H__ */
>>> --
>>> 1.8.2.3
>>>
>>>
>>
>> Functionally it still looks good:
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Thanks. I'll do the above rework, and prepare an additional set of
> patches to address some of the issues you noted.
>
> Cheers,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
