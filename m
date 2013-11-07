From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Nov 2013 17:58:50 +0000
Subject: [PATCH v3 1/2] arm/arm64: KVM: MMIO support for BE guest
In-Reply-To: <CAMJs5B9VpR0=JHoasoKcZHumQ-NxG_d2VrsHo3FHgtk-8w5t1A@mail.gmail.com>
References: <1383677895-3728-1-git-send-email-marc.zyngier@arm.com>
 <1383677895-3728-2-git-send-email-marc.zyngier@arm.com>
 <20131107051023.GA18387@cbox>	<527BCB7A.6010800@arm.com>
 <CAMJs5B9VpR0=JHoasoKcZHumQ-NxG_d2VrsHo3FHgtk-8w5t1A@mail.gmail.com>
Message-ID: <527BD4DA.9020205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/13 17:42, Christoffer Dall wrote:
> On 7 November 2013 09:18, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 07/11/13 05:10, Christoffer Dall wrote:
>>> On Tue, Nov 05, 2013 at 06:58:14PM +0000, Marc Zyngier wrote:
>>>> Do the necessary byteswap when host and guest have different
>>>> views of the universe. Actually, the only case we need to take
>>>> care of is when the guest is BE. All the other cases are naturally
>>>> handled.
>>>>
>>>> Also be careful about endianness when the data is being memcopy-ed
>>>> from/to the run buffer.
>>>>
>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm/include/asm/kvm_emulate.h   | 41 +++++++++++++++++
>>>>  arch/arm/kvm/mmio.c                  | 87 +++++++++++++++++++++++++++++++-----
>>>>  arch/arm64/include/asm/kvm_emulate.h | 48 ++++++++++++++++++++
>>>>  3 files changed, 165 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
>>>> index a464e8d..8a6be05 100644
>>>> --- a/arch/arm/include/asm/kvm_emulate.h
>>>> +++ b/arch/arm/include/asm/kvm_emulate.h
>>>> @@ -157,4 +157,45 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
>>>>      return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
>>>>  }
>>>>
>>>> +static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    return !!(*vcpu_cpsr(vcpu) & PSR_E_BIT);
>>>> +}
>>>> +
>>>> +static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
>>>> +                                                unsigned long data,
>>>> +                                                unsigned int len)
>>>> +{
>>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>>> +            switch (len) {
>>>> +            case 1:
>>>> +                    return data & 0xff;
>>>
>>> why are these masks necessary again?  For a writeb there should be no
>>> byteswapping on the guest side right?
>>
>> They are not strictly mandatory, but I feel a lot more confident
>> trimming what we found in the register to the bare minimum.
>>
> 
> hmm, yeah, I guess a strb would trim anything above the first 8 bits
> anyhow.  But I believe this is done through your typed assignments of
> mmio_write_data and mmio_write_read.  But ok, I can live with a bit of
> OCD here, as long as I know the reason.
> 
>>>> +            case 2:
>>>> +                    return be16_to_cpu(data & 0xffff);
>>>> +            default:
>>>> +                    return be32_to_cpu(data);
>>>> +            }
>>>> +    }
>>>> +
>>>> +    return data;            /* Leave LE untouched */
>>>> +}
>>>> +
>>>> +static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>>>> +                                                unsigned long data,
>>>> +                                                unsigned int len)
>>>> +{
>>>> +    if (kvm_vcpu_is_be(vcpu)) {
>>>> +            switch (len) {
>>>> +            case 1:
>>>> +                    return data & 0xff;
>>>> +            case 2:
>>>> +                    return cpu_to_be16(data & 0xffff);
>>>> +            default:
>>>> +                    return cpu_to_be32(data);
>>>> +            }
>>>> +    }
>>>> +
>>>> +    return data;            /* Leave LE untouched */
>>>> +}
>>>> +
>>>>  #endif /* __ARM_KVM_EMULATE_H__ */
>>>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>>>> index 0c25d94..54105f1b 100644
>>>> --- a/arch/arm/kvm/mmio.c
>>>> +++ b/arch/arm/kvm/mmio.c
>>>> @@ -23,6 +23,69 @@
>>>>
>>>>  #include "trace.h"
>>>>
>>>> +static void mmio_write_data(struct kvm_exit_mmio *mmio, unsigned long data)
>>>> +{
>>>> +    void *datap = NULL;
>>>> +    union {
>>>> +            u8      byte;
>>>> +            u16     hword;
>>>> +            u32     word;
>>>> +            u64     dword;
>>>> +    } tmp;
>>>> +
>>>> +    switch (mmio->len) {
>>>> +    case 1:
>>>> +            tmp.byte        = data;
>>>> +            datap           = &tmp.byte;
>>>> +            break;
>>>> +    case 2:
>>>> +            tmp.hword       = data;
>>>> +            datap           = &tmp.hword;
>>>> +            break;
>>>> +    case 4:
>>>> +            tmp.word        = data;
>>>> +            datap           = &tmp.word;
>>>> +            break;
>>>> +    case 8:
>>>> +            tmp.dword       = data;
>>>> +            datap           = &tmp.dword;
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    memcpy(mmio->data, datap, mmio->len);
>>>> +}
>>>> +
>>>> +static unsigned long mmio_read_data(struct kvm_run *run)
>>>> +{
>>>> +    unsigned long data = 0;
>>>> +    unsigned int len = run->mmio.len;
>>>> +    union {
>>>> +            u16     hword;
>>>> +            u32     word;
>>>> +            u64     dword;
>>>> +    } tmp;
>>>> +
>>>> +    switch (len) {
>>>> +    case 1:
>>>> +            data = run->mmio.data[0];
>>>> +            break;
>>>> +    case 2:
>>>> +            memcpy(&tmp.hword, run->mmio.data, len);
>>>> +            data = tmp.hword;
>>>> +            break;
>>>> +    case 4:
>>>> +            memcpy(&tmp.word, run->mmio.data, len);
>>>> +            data = tmp.word;
>>>> +            break;
>>>> +    case 8:
>>>> +            memcpy(&tmp.dword, run->mmio.data, len);
>>>> +            data = tmp.dword;
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    return data;
>>>> +}
>>>> +
>>>
>>> don't we have similarly named functions for the vgic where we just
>>> assume accesses are always 32 bits?  Could we reuse?
>>
>> Hmmm. The VGIC also deals with masks and stuff, and I'm not sure that's
>> worth the complexity. I'll rename this for the time being, and look at
>> unifying the two.
>>
> 
> If I'm not mistaken the mmio_{read,write} in the vgic code is
> basically just casting the data pointer to a u32* and assigning it a
> value.

Yup. I can probably hand the data pointer directly (as we deal with a
mixture of kvm_run and kvm_exit_mmio structs). The mask stuff is only a
by-product of the length of the access, and it can be easily cleaned up.

	M.
-- 
Jazz is not dead. It just smells funny...
