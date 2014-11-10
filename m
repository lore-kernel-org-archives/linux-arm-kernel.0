From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 10 Nov 2014 11:31:23 +0000
Subject: [PATCH v3 17/19] arm64: KVM: add SGI system register trapping
In-Reply-To: <20141107150722.GS16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-18-git-send-email-andre.przywara@arm.com>
 <20141107150722.GS16132@cbox>
Message-ID: <5460A20B.2010107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 07/11/14 15:07, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:52PM +0000, Andre Przywara wrote:
>> While the injection of a (virtual) inter-processor interrupt (SGI)
>> on a GICv2 works by writing to a MMIO register, GICv3 uses system
>> registers to trigger them.
>> Trap the appropriate registers on ARM64 hosts and call the SGI
>
> Are you actually enabling the trapping here or just putting the trap
> handler in place?  As I understood so far, we still configure the guest
> at this point to raise an unexpected exception in the guest if it tries
> to eaccess the system registers; did I get this wrong?

You are right, the changes in the patch series at this point are not yet
visible to userland (and hence the guest), so any guest access to any
kind of GICv3 registers (MMIO or sysreg) should still fail at this point.
So a guest Linux GICv3 driver will never issue those MSRs if there is no
DT node present, but any attempt should still fail nevertheless, since
the GICv3 structures are not properly initialized.

>> handler function in the vGICv3 emulation code.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c |   26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index dcc5867..cf0452e 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
>>      return true;
>>  }
>>
>> +/*
>> + * Trapping on the GICv3 SGI system register.
>
> Use the architecture name for the register here.
>
>> + * Forward the request to the VGIC emulation.
>> + * The cp15_64 code makes sure this automatically works
>> + * for both AArch64 and AArch32 accesses.
>> + */
>> +static bool access_gic_sgi(struct kvm_vcpu *vcpu,
>> +                       const struct sys_reg_params *p,
>> +                       const struct sys_reg_desc *r)
>> +{
>> +    u64 val;
>> +
>> +    if (!p->is_write)
>> +            return read_from_write_only(vcpu, p);
>> +
>> +    val = *vcpu_reg(vcpu, p->Rt);
>> +    vgic_v3_dispatch_sgi(vcpu, val);
>
> So do we guarantee somehow that we'll never get here if userspace didn't
> successfully create a virtual GICv3?

No :-( Nothing prevents a guest from writing to this architectural
sysreg, but it shouldn't do since nothing tells it yet about a GICv3 yet.

What about just introducing the handler functions in this patch and
wiring them up in the sys_reg_descs struct later with the final
enablement patch?
This would provoke a compile warning though due to the unused static
functions. Is it worth to declare them as non-static until there are
referenced in the later patch?

Is there any other trick to avoid this warning or to work around this issue?

Cheers,
Andre.

>
>> +
>> +    return true;
>> +}
>> +
>>  static bool trap_raz_wi(struct kvm_vcpu *vcpu,
>>                      const struct sys_reg_params *p,
>>                      const struct sys_reg_desc *r)
>> @@ -431,6 +452,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>      /* VBAR_EL1 */
>>      { Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
>>        NULL, reset_val, VBAR_EL1, 0 },
>> +    /* ICC_SGI1R_EL1 */
>> +    { Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
>> +      access_gic_sgi },
>>      /* CONTEXTIDR_EL1 */
>>      { Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
>>        access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
>> @@ -659,6 +683,8 @@ static const struct sys_reg_desc cp14_64_regs[] = {
>>   * register).
>>   */
>>  static const struct sys_reg_desc cp15_regs[] = {
>> +    { Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
>> +
>>      { Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
>>      { Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
>>      { Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
>> --
>> 1.7.9.5
>>
>

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
