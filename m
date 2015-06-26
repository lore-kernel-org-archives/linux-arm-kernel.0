From: jan.kiszka@web.de (Jan Kiszka)
Date: Fri, 26 Jun 2015 06:49:34 +0200
Subject: [RFC PATCH] KVM: arm/arm64: Don't let userspace update CNTVOFF
 once guest is running
In-Reply-To: <558BC90B.4060806@huawei.com>
References: <1435157697-28579-1-git-send-email-marc.zyngier@arm.com>
 <20150625080457.GD28244@cbox> <558BC2F5.9010303@huawei.com>
 <CAFEAcA_RzWSppaYA9vuAaL-MO6sQV1SgpXf3w-LScUdaarpOEQ@mail.gmail.com>
 <558BC90B.4060806@huawei.com>
Message-ID: <558CD9DE.3010609@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-25 11:25, Claudio Fontana wrote:
> On 25.06.2015 11:10, Peter Maydell wrote:
>> On 25 June 2015 at 09:59, Claudio Fontana <claudio.fontana@huawei.com> wrote:
>>> Once the VM is created, I think QEMU should not request kvm to
>>> change the virtual offset of the VM anymore: maybe an unexpected
>>> consequence of QEMU's target-arm/kvm64.c::kvm_arch_put_registers ?
>>
>> Hmm. In general we assume that we can:
>>  * stop the VM
>>  * read all the guest system registers
>>  * write those values back again
>>  * restart the VM
>>
>> if we need to. Is that what's happening here, or are we doing
>> something odder?
>>
>> -- PMM
>>
> 
> What I guess could be happening by looking at the code in linux
> 
> virt/kvm/arm/arch_timer.c::kvm_arm_timer_set_reg
> 
> is that QEMU tries to set the KVM_REG_ARM_TIMER_CNT register from exactly the previous value,
> but just because of the fact that the set function is called, cntvoff is updated,
> since the value provided by the user is apparently assumed to be _relative_ to the physical timer.
> 
> This is apparent to me in the code in that function which says:
> 
> case KVM_REG_ARM_TIMER_CNT: {
> /* ... */
>     u64 cntvoff = kvm_phys_timer_read() - value;
> /* ... */
> }
> 
> And this is matched by the corresponding get function kvm_arm_timer_get_reg where it says:
> 
> case KVM_REG_ARM_TIMER_CNT:
>    return kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> 
> The time difference between when the GET is issued by QEMU and when the PUT is issued then would account for the difference.

QEMU has the concept of write-back levels: KVM_PUT_RUNTIME_STATE,
KVM_PUT_RESET_STATE and KVM_PUT_FULL_STATE. I suspect this registers is
just sorted into the wrong category, thus written as part of the
RUNTIME_STATE. We had such bug patterns during the x86 maturing phase as
well.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150626/50b303fc/attachment.sig>
