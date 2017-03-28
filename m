From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 28 Mar 2017 14:21:15 +0100
Subject: [PATCH v2 1/9] arm64: KVM: PMU: Refactor pmu_*_el0_disabled
In-Reply-To: <20170328124623.GJ31156@cbox>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-2-marc.zyngier@arm.com> <20170328124623.GJ31156@cbox>
Message-ID: <0505d0e7-bfb6-903a-5c24-53b375e58332@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/17 13:46, Christoffer Dall wrote:
> On Mon, Mar 27, 2017 at 05:03:37PM +0100, Marc Zyngier wrote:
>> There is a lot of duplication in the pmu_*_el0_disabled helpers,
>> and as we're going to modify them shortly, let's move all the
>> common stuff in a single function.
>>
>> No functionnal change.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 25 +++++++++++--------------
>>  1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 0e26f8c2b56f..7e1d673304d5 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -460,35 +460,32 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>  	vcpu_sys_reg(vcpu, PMCR_EL0) = val;
>>  }
>>  
>> -static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
>> +static bool check_disabled(struct kvm_vcpu *vcpu, u64 flags)
>>  {
>>  	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
>> +	bool cond = (reg & flags) || vcpu_mode_priv(vcpu);
> 
> nit: I would call this variable 'enabled' and then return !enabled to
> make it clear what's going on.
> 
> (If you agree, I can fix this up when applying along with the typo and
> rename pointed out by Suzuki).

Yup, that'd be absolutely fine.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
