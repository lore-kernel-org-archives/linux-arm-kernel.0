From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Nov 2014 20:17:36 +0000
Subject: [PATCH v3 10/19] arm/arm64: KVM: make the value of ICC_SRE_EL1
 a per-VM variable
In-Reply-To: <20141103200455.GI16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-11-git-send-email-andre.przywara@arm.com>
 <20141103200455.GI16132@cbox>
Message-ID: <5457E2E0.4080305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 03/11/14 20:04, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:45PM +0000, Andre Przywara wrote:
>> ICC_SRE_EL1 is a system register allowing msr/mrs accesses to the
>> GIC CPU interface for EL1 (guests). Currently we force it to 0, but
>> for proper GICv3 support we have to allow guests to use it (depending
>> on their selected virtual GIC model).
>> So add ICC_SRE_EL1 to the list of saved/restored registers on a
>> world switch, but actually disallow a guest to change it by only
>> restoring a fixed, once-initialized value.
>> This value depends on the GIC model userland has chosen for a guest.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> ---
>>  arch/arm64/kernel/asm-offsets.c |    1 +
>>  arch/arm64/kvm/vgic-v3-switch.S |   14 +++++++++-----
>>  include/kvm/arm_vgic.h          |    1 +
>>  virt/kvm/arm/vgic-v3.c          |    9 +++++++--
>>  4 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 9a9fce0..9d34486 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -140,6 +140,7 @@ int main(void)
>>    DEFINE(VGIC_V2_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_v2.vgic_elrsr));
>>    DEFINE(VGIC_V2_CPU_APR,	offsetof(struct vgic_cpu, vgic_v2.vgic_apr));
>>    DEFINE(VGIC_V2_CPU_LR,	offsetof(struct vgic_cpu, vgic_v2.vgic_lr));
>> +  DEFINE(VGIC_V3_CPU_SRE,	offsetof(struct vgic_cpu, vgic_v3.vgic_sre));
>>    DEFINE(VGIC_V3_CPU_HCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_hcr));
>>    DEFINE(VGIC_V3_CPU_VMCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_vmcr));
>>    DEFINE(VGIC_V3_CPU_MISR,	offsetof(struct vgic_cpu, vgic_v3.vgic_misr));
>> diff --git a/arch/arm64/kvm/vgic-v3-switch.S b/arch/arm64/kvm/vgic-v3-switch.S
>> index d160469..617a012 100644
>> --- a/arch/arm64/kvm/vgic-v3-switch.S
>> +++ b/arch/arm64/kvm/vgic-v3-switch.S
>> @@ -148,17 +148,18 @@
>>   * x0: Register pointing to VCPU struct
>>   */
>>  .macro	restore_vgic_v3_state
>> -	// Disable SRE_EL1 access. Necessary, otherwise
>> -	// ICH_VMCR_EL2.VFIQEn becomes one, and FIQ happens...
>> -	msr_s	ICC_SRE_EL1, xzr
>> -	isb
>> -
> 
> I know I reviewed this once, but now I'm forgetting how it works with
> this comment above.  First, I don't fully understand the comment.

If you write to ICH_VMCR_EL2 with SRE==1, the architecture forces VFIQEn
to 1, which causes interesting effects when you inject an Group0
interrupt (as we do for GICv2 emulation).

You end-up spending days debugging this, mostly blaming the model for
all these FIQs appearing in your guest, until you read that small gem
hidden in the architecture spec. Bad memories, let's not go there.

That's why we must make sure to set ICC_SRE_EL1 *before* writing to
ICH_VMCR_EL2.

> Second, now we're restoring a value that may potentially have SRE_EL1
> access enabled, but FIQ doesn't happen.  Can you clarify this for me?

That's a side effect of how we inject interrupts with GICv3. They are
Group1, always. A Group0 interrupt would definitely be delivered as a
FIQ, but we currently don't offer a way to support that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
