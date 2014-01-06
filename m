From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 6 Jan 2014 09:44:48 -0800
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
Message-ID: <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thank you for looking into this.

On 6 January 2014 04:37, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, Dec 20 2013 at 04:48:45 PM, Victor Kamensky <victor.kamensky@linaro.org> wrote:
>> In case of status register E bit is not set (LE mode) and host runs in
>> BE mode we need byteswap data, so read/write is emulated correctly.
>
> I don't think this is correct.
>
> The only reason we byteswap the value in the BE guest case is because it
> has byteswapped the data the first place.
>
> With a LE guest, the value we get in the register is the right one, no
> need for further processing. I think your additional byteswap only
> hides bugs somewhere else in the stack.

First, do we agree that this patch has effect only in BE host case
(CONFIG_CPU_BIG_ENDIAN=y), because in LE host case cpu_to_leXX
function does nothing only simple copy, just the same we  had before?

In BE host case, we have emulator (qemu, kvm-tool), host kernel, and
hypervisor part of code, all, operating in BE mode; and guest could be either
LE or BE (i.e E bit not set or set). That is opposite to LE host case,
where we have emulator (qemu, kvm-tool), host kernel, and hypervisor part
of code, all, operating in LE mode. Your changes introduced byteswap when
host is LE and access is happening with E bit set. I don't see why symmetry
should break for case when host is BE and access is happening with E bit
cleared.

In another words, regardless of E bit setting of guest access operation rest
of the stack should bring/see the same value before/after
vcpu_data_host_to_guest/vcpu_data_guest_to_host functions are applied. I.e
the rest of stack should be agnostic to E bit setting of access operation.
Do we agree on that? Now, depending on E bit setting of guest access operation
result should differ in its endianity - so in one of two cases byteswap must
happen. But it will not happen in case of BE host and LE access, unless my diff
is applied. Previously added byteswap code for E bit set case will not
have effect
because in BE host case cpu_to_beXX functions don't do anything just copy, and
in another branch of if statement again it just copies the data. So regardless
of E bit setting guest access resulting value is the same in case of
BE host - it
cannot be that way. Note, just only with your changes, in LE host case
byteswap will happen if E bit is set and no byteswap if E bit is clear - so
guest access resulting value does depend on E setting.

Also please note that vcpu_data_host_to_guest/vcpu_data_guest_to_host functions
effectively transfer data between host kernel and memory of saved guest CPU
registers. Those saved registers will be will be put back to CPU registers,
or saved from CPU registers to memory by hypervisor part of code. In BE host
case this hypervisor part of code operates in BE mode as well, so register set
shared between host and hypervisor part of code holds guest registers values in
memory in BE order. vcpu_data_host_to_guest/vcpu_data_guest_to_host function are
not interacting with CPU registers directly. I am not sure, but may this
point was missed.

Thanks,
Victor

>         M.
>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_emulate.h | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
>> index 0fa90c9..69b7469 100644
>> --- a/arch/arm/include/asm/kvm_emulate.h
>> +++ b/arch/arm/include/asm/kvm_emulate.h
>> @@ -185,9 +185,16 @@ static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
>>               default:
>>                       return be32_to_cpu(data);
>>               }
>> +     } else {
>> +             switch (len) {
>> +             case 1:
>> +                     return data & 0xff;
>> +             case 2:
>> +                     return le16_to_cpu(data & 0xffff);
>> +             default:
>> +                     return le32_to_cpu(data);
>> +             }
>>       }
>> -
>> -     return data;            /* Leave LE untouched */
>>  }
>>
>>  static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>> @@ -203,9 +210,16 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>>               default:
>>                       return cpu_to_be32(data);
>>               }
>> +     } else {
>> +             switch (len) {
>> +             case 1:
>> +                     return data & 0xff;
>> +             case 2:
>> +                     return cpu_to_le16(data & 0xffff);
>> +             default:
>> +                     return cpu_to_le32(data);
>> +             }
>>       }
>> -
>> -     return data;            /* Leave LE untouched */
>>  }
>>
>>  #endif /* __ARM_KVM_EMULATE_H__ */
>
> --
> Jazz is not dead. It just smells funny.
