From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 17 Jan 2013 12:07:40 -0500
Subject: [PATCH v6 13/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <50F828AC.2050307@arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175911.29147.40578.stgit@ubuntu>
 <50F828AC.2050307@arm.com>
Message-ID: <CANM98qJDMoRAvQb94eHppWbsPQYnBbSDw+GPg5+dRoCLyj_tjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 11:37 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/01/13 17:59, Christoffer Dall wrote:
>> When the guest accesses I/O memory this will create data abort
>> exceptions and they are handled by decoding the HSR information
>> (physical address, read/write, length, register) and forwarding reads
>> and writes to QEMU which performs the device emulation.
>>
>> Certain classes of load/store operations do not support the syndrome
>> information provided in the HSR.  We don't support decoding these (patches
>> are available elsewhere), so we report an error to user space in this case.
>>
>> This requires changing the general flow somewhat since new calls to run
>> the VCPU must check if there's a pending MMIO load and perform the write
>> after userspace has made the data available.
>>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 04a9705..702743e 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -192,6 +192,44 @@ after_vfp_restore:
>>         mov     r0, r1                  @ Return the return code
>>         bx      lr                      @ return to IOCTL
>>
>> +
>> +/********************************************************************
>> + * Translate VA to PA
>> + *
>> + * u64 __kvm_va_to_pa(struct kvm_vcpu *vcpu, u32 va, bool priv)
>> + *
>> + * Arguments:
>> + *  r0: pointer to vcpu struct
>> + *  r1: virtual address to map (rounded to page)
>> + *  r2: 1 = P1 (read) mapping, 0 = P0 (read) mapping.
>> + * Returns 64 bit PAR value.
>> + */
>> +ENTRY(__kvm_va_to_pa)
>> +       push    {r4-r12}
>> +
>> +       @ Fold flag into r1, easier than using stack.
>> +       cmp     r2, #0
>> +       movne   r2, #1
>> +       orr     r1, r1, r2
>> +
>> +       @ This swaps too many registers, but we're in the slow path anyway.
>> +       read_cp15_state store_to_vcpu = 0
>> +       write_cp15_state read_from_vcpu = 1
>> +
>> +       ands    r2, r1, #1
>> +       bic     r1, r1, r2
>> +       mcrne   p15, 0, r1, c7, c8, 0   @ VA to PA, ATS1CPR
>> +       mcreq   p15, 0, r1, c7, c8, 2   @ VA to PA, ATS1CUR
>> +       isb
>> +
>> +       @ Restore host state.
>> +       read_cp15_state store_to_vcpu = 1
>> +       write_cp15_state read_from_vcpu = 0
>> +
>> +       mrrc    p15, 0, r0, r1, c7      @ PAR
>> +       pop     {r4-r12}
>> +       bx      lr
>> +
>
> Do we still need this function? Now that the MMIO emulation is gone,
> there should be no need to perform a manual translation.
>
> I can't even find a caller for it either.
>
I'm trying to leave bits and pieces of the emulation code in here in
hope that it will spawn itself into a glorious unified solution that
decodes everything and that everybody will be happy with :)

I'll remove it. Thanks.
-Christoffer
