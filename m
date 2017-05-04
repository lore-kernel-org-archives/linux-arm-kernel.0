From: gengdj.1984@gmail.com (gengdongjiu)
Date: Fri, 5 May 2017 00:44:33 +0800
Subject: No subject
In-Reply-To: <CAMj-D2DO_CfvD77izsGfggoKP45HSC9aD6auUPAYC9Yeq_aX7w@mail.gmail.com>
References: <CAMj-D2DO_CfvD77izsGfggoKP45HSC9aD6auUPAYC9Yeq_aX7w@mail.gmail.com>
Message-ID: <CAMj-D2BVerutQXg0AArBvWrB04x9jYF+ACMQCZu3FT92kReZBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear James,
   Thanks a lot for your review and comments. I am very sorry for the
late response.


2017-05-04 23:42 GMT+08:00 gengdongjiu <gengdj.1984@gmail.com>:
>  Hi Dongjiu Geng,
>
> On 30/04/17 06:37, Dongjiu Geng wrote:
>> when happen SEA, deliver signal bus and handle the ioctl that
>> inject SEA abort to guest, so that guest can handle the SEA error.
>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 105b6ab..a96594f 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -20,8 +20,10 @@
>> @@ -1238,6 +1240,36 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
>>   __coherent_cache_guest_page(vcpu, pfn, size);
>>  }
>>
>> +static void kvm_send_signal(unsigned long address, bool hugetlb, bool hwpoison)
>> +{
>> + siginfo_t info;
>> +
>> + info.si_signo   = SIGBUS;
>> + info.si_errno   = 0;
>> + if (hwpoison)
>> + info.si_code    = BUS_MCEERR_AR;
>> + else
>> + info.si_code    = 0;
>> +
>> + info.si_addr    = (void __user *)address;
>> + if (hugetlb)
>> + info.si_addr_lsb = PMD_SHIFT;
>> + else
>> + info.si_addr_lsb = PAGE_SHIFT;
>> +
>> + send_sig_info(SIGBUS, &info, current);
>> +}
>> +
> ?  [hide part of quote]
>
> Punit reviewed the other version of this patch, this PMD_SHIFT is not the right
> thing to do, it needs a more accurate set of calls and shifts as there may be
> hugetlbfs pages other than PMD_SIZE.
>
> https://www.spinics.net/lists/arm-kernel/msg568919.html
>
> I haven't posted a new version of that patch because I was still hunting a bug
> in the hugepage/hwpoison code, even with Punit's fixes series I see -EFAULT
> returned to userspace instead of this hwpoison code being invoked.

  Ok, got it, thanks for your information.
>
> Please avoid duplicating functionality between patches, it wastes reviewers
> time, especially when we know there are problems with this approach.
>
>
>> +static void kvm_handle_bad_page(unsigned long address,
>> + bool hugetlb, bool hwpoison)
>> +{
>> + /* handle both hwpoison and other synchronous external Abort */
>> + if (hwpoison)
>> + kvm_send_signal(address, hugetlb, true);
>> + else
>> + kvm_send_signal(address, hugetlb, false);
>> +}
>
> Why the extra level of indirection? We only want to signal userspace like this
> from KVM for hwpoison. Signals for RAS related reasons should come from the bits
> of the kernel that decoded the error.

For the SEA, the are maily two types:
0b010000 Synchronous External Abort on memory access.
0b0101xx Synchronous External Abort on page table walk. DFSC[1:0]
encode the level.

hwpoison should belong to the  "Synchronous External Abort on memory access"
if the SEA type is not hwpoison, such as page table walk, do you mean
KVM do not deliver the SIGBUS?
If so, how the KVM handle the SEA type other than hwpoison?

>
> (hwpoison for KVM is a corner case as Qemu's memory effectively has two users,
> Qemu and KVM. This isn't the example of how user-space gets signalled.)
>
>
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index b37446a..780e3c4 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -277,6 +277,13 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>>   return -EINVAL;
>>  }
>>
>> +int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu)
>> +{
>> + kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>> +
>> + return 0;
>> +}
>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index bb02909..1d2e2e7 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1306,6 +1306,7 @@ struct kvm_s390_ucas_mapping {
>>  #define KVM_S390_GET_IRQ_STATE  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
>>  /* Available with KVM_CAP_X86_SMM */
>>  #define KVM_SMI                   _IO(KVMIO,   0xb7)
>> +#define KVM_ARM_SEA               _IO(KVMIO,   0xb8)
>>
>>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU (1 << 0)
>>  #define KVM_DEV_ASSIGN_PCI_2_3 (1 << 1)
>>
>
> Why do we need a userspace API for SEA? It can also be done by using
> KVM_{G,S}ET_ONE_REG to change the vcpu registers. The advantage of doing it this
> way is you can choose which ESR value to use.
>
> Adding a new API call to do something you could do with an old one doesn't look
> right.

James, I considered your suggestion before that use the
KVM_{G,S}ET_ONE_REG to change the vcpu registers. but I found it does
not have difference to use the alread existed KVM API.  so may be
changing the vcpu registers in qemu will duplicate with the KVM APIs.

injection a SEA is no more than setting some registers: elr_el1, PC,
PSTATE, SPSR_el1, far_el1, esr_el1
I seen this KVM API do the same thing as Qemu.  do you found call this
API will have issue and necessary to choose another ESR value?

I pasted the alread existed KVM API code:

static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned
long addr)
{
 unsigned long cpsr = *vcpu_cpsr(vcpu);
 bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
 u32 esr = 0;
 *vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
 *vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
 *vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
 *vcpu_spsr(vcpu) = cpsr;
 vcpu_sys_reg(vcpu, FAR_EL1) = addr;
 /*
  * Build an {i,d}abort, depending on the level and the
  * instruction set. Report an external synchronous abort.
  */
 if (kvm_vcpu_trap_il_is32bit(vcpu))
  esr |= ESR_ELx_IL;
 /*
  * Here, the guest runs in AArch64 mode when in EL1. If we get
  * an AArch32 fault, it means we managed to trap an EL0 fault.
  */
 if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
  esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
 else
  esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
 if (!is_iabt)
  esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 vcpu_sys_reg(vcpu, ESR_EL1) = esr | ESR_ELx_FSC_EXTABT;
}

static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
    unsigned long addr)
{
 u32 vect_offset;
 u32 *far, *fsr;
 bool is_lpae;
 if (is_pabt) {
  vect_offset = 12;
  far = &vcpu_cp15(vcpu, c6_IFAR);
  fsr = &vcpu_cp15(vcpu, c5_IFSR);
 } else { /* !iabt */
  vect_offset = 16;
  far = &vcpu_cp15(vcpu, c6_DFAR);
  fsr = &vcpu_cp15(vcpu, c5_DFSR);
 }
 prepare_fault32(vcpu, COMPAT_PSR_MODE_ABT | COMPAT_PSR_A_BIT, vect_offset);
 *far = addr;
 /* Give the guest an IMPLEMENTATION DEFINED exception */
 is_lpae = (vcpu_cp15(vcpu, c2_TTBCR) >> 31);
 if (is_lpae)
  *fsr = 1 << 9 | 0x34;
 else
  *fsr = 0x14;
}


/**
 * kvm_inject_dabt - inject a data abort into the guest
 * @vcpu: The VCPU to receive the undefined exception
 * @addr: The address to report in the DFAR
 *
 * It is assumed that this code is called from the VCPU thread and that the
 * VCPU therefore is not currently executing guest code.
 */
void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
{
 if (!(vcpu->arch.hcr_el2 & HCR_RW))
  inject_abt32(vcpu, false, addr);
 else
  inject_abt64(vcpu, false, addr);
}


>
>
> Thanks,
>
> James
