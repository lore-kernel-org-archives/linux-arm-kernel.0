From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 25 Mar 2013 09:19:41 +0100
Subject: [kvmarm] [PATCH 09/29] arm64: KVM: system register handling
In-Reply-To: <2CF940F9-4643-4C32-8A71-23DAD18EE9FA@suse.de>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-10-git-send-email-marc.zyngier@arm.com>
 <2CF940F9-4643-4C32-8A71-23DAD18EE9FA@suse.de>
Message-ID: <40f45d8ddae65e29a6145bbe5c96d0bb@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Thu, 7 Mar 2013 11:30:20 +0100, Alexander Graf <agraf@suse.de> wrote:
> On 05.03.2013, at 04:47, Marc Zyngier wrote:
> 
>> Provide 64bit system register handling, modeled after the cp15
>> handling for ARM.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---

[...]

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
> 
> Can't you make this a simple switch() statement through a bit of #define
> and maybe #include magic? After all, the sysreg target encoding is all
part
> of the opcode. And from my experience in the PPC instruction emulator,
> switch()es are _a lot_ faster than any other way of lookup I've tried.

So I've had a go at implementing this, and decided it is not worth the
effort if we want to preserve the same level of functionality (ONE_REG
discovery, sanity checking at VM startup...).

Granted, we would gain a faster trap handling. But look at what we're
actually trapping, and how often this happens. Almost nothing, almost
never. So, until shown that we spend too much time iterating over the
sys_reg_desc array, I'll keep it simple.

This is not to say that there's no optimization to be made. Quite the
opposite! Just that this particular one seems a bit overkill.

Anyway, thanks for pushing me into pondering this! :-)

        M.
-- 
Fast, cheap, reliable. Pick two.
