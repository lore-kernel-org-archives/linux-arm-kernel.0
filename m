From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 08 Mar 2013 04:29:48 +0100
Subject: [kvmarm] [PATCH 09/29] arm64: KVM: system register handling
In-Reply-To: <2CF940F9-4643-4C32-8A71-23DAD18EE9FA@suse.de>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-10-git-send-email-marc.zyngier@arm.com>
 <2CF940F9-4643-4C32-8A71-23DAD18EE9FA@suse.de>
Message-ID: <6c8dff0e7f9f9dde4702017737f4c1b7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013 11:30:20 +0100, Alexander Graf <agraf@suse.de> wrote:
> On 05.03.2013, at 04:47, Marc Zyngier wrote:
> 
>> Provide 64bit system register handling, modeled after the cp15
>> handling for ARM.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> arch/arm64/include/asm/kvm_coproc.h |  51 ++
>> arch/arm64/include/uapi/asm/kvm.h   |  56 +++
>> arch/arm64/kvm/sys_regs.c           | 962
>> ++++++++++++++++++++++++++++++++++++
>> arch/arm64/kvm/sys_regs.h           | 141 ++++++
>> include/uapi/linux/kvm.h            |   1 +
>> 5 files changed, 1211 insertions(+)
>> create mode 100644 arch/arm64/include/asm/kvm_coproc.h
>> create mode 100644 arch/arm64/kvm/sys_regs.c
>> create mode 100644 arch/arm64/kvm/sys_regs.h
>> 

[..]

>> +/*
>> + * Architected system registers.
>> + * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
>> + */
>> +static const struct sys_reg_desc sys_reg_descs[] = {
>> +	/* DC ISW */
>> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b0110), Op2(0b010),
>> +	  access_dcsw },
>> +	/* DC CSW */
>> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1010), Op2(0b010),
>> +	  access_dcsw },
>> +	/* DC CISW */
>> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
>> +	  access_dcsw },
>> +
>> +	/* TTBR0_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b000),
>> +	  NULL, reset_unknown, TTBR0_EL1 },
>> +	/* TTBR1_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b001),
>> +	  NULL, reset_unknown, TTBR1_EL1 },
>> +	/* TCR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b010),
>> +	  NULL, reset_val, TCR_EL1, 0 },
>> +
>> +	/* AFSR0_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b000),
>> +	  NULL, reset_unknown, AFSR0_EL1 },
>> +	/* AFSR1_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b001),
>> +	  NULL, reset_unknown, AFSR1_EL1 },
>> +	/* ESR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0010), Op2(0b000),
>> +	  NULL, reset_unknown, ESR_EL1 },
>> +	/* FAR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b0110), CRm(0b0000), Op2(0b000),
>> +	  NULL, reset_unknown, FAR_EL1 },
>> +
>> +	/* PMINTENSET_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
>> +	  pm_fake },
>> +	/* PMINTENCLR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
>> +	  pm_fake },
>> +
>> +	/* MAIR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
>> +	  NULL, reset_unknown, MAIR_EL1 },
>> +	/* AMAIR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0011), Op2(0b000),
>> +	  NULL, reset_amair_el1, AMAIR_EL1 },
>> +
>> +	/* VBAR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
>> +	  NULL, reset_val, VBAR_EL1, 0 },
>> +	/* CONTEXTIDR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
>> +	  NULL, reset_val, CONTEXTIDR_EL1, 0 },
>> +	/* TPIDR_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b100),
>> +	  NULL, reset_unknown, TPIDR_EL1 },
>> +
>> +	/* CNTKCTL_EL1 */
>> +	{ Op0(0b11), Op1(0b000), CRn(0b1110), CRm(0b0001), Op2(0b000),
>> +	  NULL, reset_val, CNTKCTL_EL1, 0},
>> +
>> +	/* CSSELR_EL1 */
>> +	{ Op0(0b11), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
>> +	  NULL, reset_unknown, CSSELR_EL1 },
>> +
>> +	/* PMCR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b000),
>> +	  pm_fake },
>> +	/* PMCNTENSET_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b001),
>> +	  pm_fake },
>> +	/* PMCNTENCLR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b010),
>> +	  pm_fake },
>> +	/* PMOVSCLR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
>> +	  pm_fake },
>> +	/* PMSWINC_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
>> +	  pm_fake },
>> +	/* PMSELR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
>> +	  pm_fake },
>> +	/* PMCEID0_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b110),
>> +	  pm_fake },
>> +	/* PMCEID1_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b111),
>> +	  pm_fake },
>> +	/* PMCCNTR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
>> +	  pm_fake },
>> +	/* PMXEVTYPER_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
>> +	  pm_fake },
>> +	/* PMXEVCNTR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
>> +	  pm_fake },
>> +	/* PMUSERENR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
>> +	  pm_fake },
>> +	/* PMOVSSET_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
>> +	  pm_fake },
>> +
>> +	/* TPIDR_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
>> +	  NULL, reset_unknown, TPIDR_EL0 },
>> +	/* TPIDRRO_EL0 */
>> +	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
>> +	  NULL, reset_unknown, TPIDRRO_EL0 },
>> +};
>> +
>> +/* Target specific emulation tables */
>> +static struct kvm_sys_reg_target_table
>> *target_tables[KVM_ARM_NUM_TARGETS];
>> +
>> +void kvm_register_target_sys_reg_table(struct kvm_sys_reg_target_table
>> *table)
>> +{
>> +	target_tables[table->target] = table;
>> +}
>> +
>> +/* Get specific register table for this target. */
>> +static const struct sys_reg_desc *get_target_table(unsigned target,
>> size_t *num)
>> +{
>> +	struct kvm_sys_reg_target_table *table;
>> +
>> +	table = target_tables[target];
>> +	*num = table->table64.num;
>> +	return table->table64.table;
>> +}
>> +
>> +static const struct sys_reg_desc *find_reg(const struct sys_reg_params
>> *params,
>> +					 const struct sys_reg_desc table[],
>> +					 unsigned int num)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		const struct sys_reg_desc *r = &table[i];
>> +
>> +		if (params->Op0 != r->Op0)
>> +			continue;
>> +		if (params->Op1 != r->Op1)
>> +			continue;
>> +		if (params->CRn != r->CRn)
>> +			continue;
>> +		if (params->CRm != r->CRm)
>> +			continue;
>> +		if (params->Op2 != r->Op2)
>> +			continue;
>> +
>> +		return r;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static int emulate_sys_reg(struct kvm_vcpu *vcpu,
>> +			   const struct sys_reg_params *params)
>> +{
>> +	size_t num;
>> +	const struct sys_reg_desc *table, *r;
>> +
>> +	table = get_target_table(vcpu->arch.target, &num);
>> +
>> +	/* Search target-specific then generic table. */
>> +	r = find_reg(params, table, num);
>> +	if (!r)
>> +		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
> 
> Searching through the whole list sounds quite slow. Especially since the
> TLS register is at the very bottom of it.

Slow, yes. Though not as bad as it sounds as only the first entries are
used on a trap path at the moment. For all the other entries, this is only
used when userspace tries to read/write a VM system register.

But overall I agree, this is not very efficient.

> Can't you make this a simple switch() statement through a bit of #define
> and maybe #include magic? After all, the sysreg target encoding is all
part
> of the opcode. And from my experience in the PPC instruction emulator,
> switch()es are _a lot_ faster than any other way of lookup I've tried.

There is definitely something like this to be done, and for the 32bit part
as well.

I'll have a look.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
